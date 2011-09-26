#include <EEPROM.h>
#include <SD.h>
#include <stdio.h>

#define SAMPLE_MODE 1
#define TRIGGER_MODE 2
#define LOGGING_MODE 3
#define SDCARD_MODE 4

byte dataMode = 1;

#define MODE_ADDRESS 0

#define NUM_INPUTS 6

const byte clock_interrupts[NUM_INPUTS] = {
  1, 0, 5, 4, 3, 2}; // these are the interrupt ids.  actual pin #s are: 3, 2, 18, 19, 20, 21
const byte data_pins[NUM_INPUTS] = {
  4, 15, 17, 23, 27, 29};
const byte request_pins[NUM_INPUTS] = {
  35, 36, 37, 38, 39, 40};

const byte error_pin = 12;
const byte read_pin = 11;
const byte status_pin = 10;
const byte mode_pin = 9;

const byte sample_pin = 46;
const byte trigger_pin = 41;
const byte chmod_pin = 45;

//sdcard stuff.
const byte chipSelect = 49;
File dataFile;
boolean sd_initialized = false;
boolean sd_logging_enabled = false;

unsigned long lastPrint = 0;

//data from the input
volatile byte myNibbles[NUM_INPUTS][13];
volatile byte bitIndex[NUM_INPUTS] = {
  0,0,0,0,0,0};

volatile byte myBits[NUM_INPUTS][52];

byte channelEnabled[NUM_INPUTS] = {
  1,0,0,0,0,0};
byte numberSign[NUM_INPUTS] = {
  0,0,0,0,0,0};
byte digits[NUM_INPUTS][6];
byte decimalPoint[NUM_INPUTS] = {
  0,0,0,0,0,0};
byte units[NUM_INPUTS] = {
  0,0,0,0,0,0};

unsigned int readings[NUM_INPUTS] = {
  0,0,0,0,0,0};

volatile unsigned long lastClock[NUM_INPUTS] = {
  0,0,0,0,0,0
};

volatile boolean sampleFlag = false;

void setup()
{
  Serial.begin(115200);
  Serial.println("MakerBot Mitutoyo SPC Logger v2.0");

  dataMode = EEPROM.read(MODE_ADDRESS);
	//Serial.print("EEPROM Read: ");
	//Serial.print(MODE_ADDRESS, DEC);
	//Serial.print(", ");
	//Serial.println(dataMode, DEC);

  update_data_mode();

  pinMode(sample_pin, INPUT);
  pinMode(trigger_pin, INPUT);
  pinMode(chmod_pin, INPUT);

  if (channelEnabled[0])
    attachInterrupt(clock_interrupts[0], read_spc_0, FALLING);
  if (channelEnabled[1])
    attachInterrupt(clock_interrupts[1], read_spc_1, FALLING);
  if (channelEnabled[2])
    attachInterrupt(clock_interrupts[2], read_spc_2, FALLING);
  if (channelEnabled[3])
    attachInterrupt(clock_interrupts[3], read_spc_3, FALLING);
  if (channelEnabled[4])
    attachInterrupt(clock_interrupts[4], read_spc_4, FALLING);
  if (channelEnabled[5])
    attachInterrupt(clock_interrupts[5], read_spc_5, FALLING);

  fade_led(error_pin, 512);
  fade_led(read_pin, 512);
  fade_led(status_pin, 512);
  fade_led(mode_pin, 512);

	if (dataMode != SDCARD_MODE)
  	printCSVHeader();

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
      resetSPCData(i);

      pinMode(data_pins[i], INPUT);
      pinMode(request_pins[i], OUTPUT);
      digitalWrite(request_pins[i], HIGH);		
    }
  }
}

void fade_led(byte pin, int milliseconds)
{
  int delayTime = milliseconds / (512);

  for (byte i=0; i<255; i++)
  {
    analogWrite(pin, i);
    delay(delayTime);
  }

  for (byte i=255; i>0; i--)
  {
    analogWrite(pin, i);
    delay(delayTime);
  }
  analogWrite(pin, 0);
}

void loop()
{
  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
      parseSPCData(0);
  }

  if (dataMode == LOGGING_MODE)
  {
    if ((millis() - lastPrint) > 100)
    {
			String line = getCSVLine();
		  Serial.println(line);

      lastPrint = millis();
    }
  }
  else if(dataMode == SAMPLE_MODE)
  {
    if (!digitalRead(sample_pin))
    {
			String line = getCSVLine();
		  Serial.println(line);

      while (!digitalRead(sample_pin))
        delay(100);
    }
  }
  else if (dataMode == TRIGGER_MODE)
  {
    if (!digitalRead(trigger_pin))
    {
			String line = getCSVLine();
		  Serial.println(line);

      while (!digitalRead(trigger_pin))
        delay(10);
    }
  }
  else if (dataMode == SDCARD_MODE)
  {
    if (sd_logging_enabled)
    {
      // if the file is available, write to it:
      if (dataFile)
      {
        if ((millis() - lastPrint) > 100)
        {
          dataFile.println(getCSVLine());
          lastPrint = millis();
        }

        digitalWrite(status_pin, HIGH);
        delay(1);
        digitalWrite(status_pin, LOW);
      }
      else
      {
        initialize_sdcard();

        if (!dataFile)
          delay(250);
      }			
    }

    //sample pin will turn logging on or off.
    if (!digitalRead(sample_pin))
    {
      sd_logging_enabled = !sd_logging_enabled;

      if (sd_logging_enabled)
        initialize_sdcard();
      else if (dataFile)
        dataFile.close();

      while (!digitalRead(sample_pin))
        delay(100);
    }
  }

  if (!digitalRead(chmod_pin))
  {
    dataMode++;

    update_data_mode();

		//Serial.print("EEPROM Write: ");
		//Serial.print(MODE_ADDRESS, DEC);
		//Serial.print(", ");
		//Serial.println(dataMode, DEC);
    EEPROM.write(MODE_ADDRESS, dataMode);

		sd_initialized = false;
		sd_logging_enabled = false;

    for (int i=0; i<dataMode; i++)
      fade_led(mode_pin, 1000);

    while (!digitalRead(chmod_pin))
      delay(100);
  }
}

void update_data_mode()
{
  if (dataMode > 4)
    dataMode = 1;

  if (dataMode == SAMPLE_MODE)
    Serial.println("Manual Sampling Mode");
  else if (dataMode == TRIGGER_MODE)
    Serial.println("External Trigger Mode");
  else if (dataMode == LOGGING_MODE)
    Serial.println("Continuous Logging Mode");
  else if (dataMode == SDCARD_MODE)
    Serial.println("SD Card Logging Mode");
}

String getCSVHeader()
{
  String out = "Milliseconds, ";

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
      out += String("CH");
      out += String(i+1, DEC);
      out += String(", SAMPLE#, ");
    }
  }

  return out;
}

void printCSVHeader()
{
	String line = getCSVHeader();
  Serial.println(line);
}

String getCSVLine()
{
	long milliTime = millis();
  String out = String(milliTime, DEC);
  out += String(", ");

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
			String spcOut = getSPCDataString(i);
      out += spcOut;
      out += String(", ");
    }
  }

  return out;
}

String getSPCDataString(byte i)
{
  String out;

  if (numberSign[i] == 8)
    out += String("-");
  else
    out += String("+");

  for (int j=0; j<6; j++)
  {
    if (6-j == decimalPoint[i])
      out += String(".");
    out += String(digits[i][j], DEC);
  }
  out += String(", ");
  out += String(readings[i], DEC);

  return out;
}

void read_spc_0()
{
  readSPCData(0);
}

void read_spc_1()
{
  readSPCData(1);
}

void read_spc_2()
{
  readSPCData(2);
}

void read_spc_3()
{
  readSPCData(3);
}

void read_spc_4()
{
  readSPCData(4);
}

void read_spc_5()
{
  readSPCData(5);
}

void readSPCData(byte channel)
{
  byte dataBit = digitalRead(data_pins[channel]);

  myBits[channel][bitIndex[channel]] = dataBit;

  byte myNibble = bitIndex[channel] / 4;
  byte myBit = (bitIndex[channel] % 4);

  myNibbles[channel][myNibble] |= (dataBit << myBit);

  bitIndex[channel]++;

  lastClock[channel] = millis();

  if (bitIndex[channel] == 52)
    digitalWrite(request_pins[channel], LOW);
}

byte parseSPCData(byte channel)
{
  if (channelEnabled[channel] && bitIndex[channel] == 52)
  {
    //    if (millis() - lastClock[channel] > 500)
    //    {
    //      resetSPCData(channel);
    //	digitalWrite(status_pin, HIGH);
    //	delay(1);
    //  	digitalWrite(status_pin, LOW);
    //    }

    //  Serial.println("Raw:");
    for (byte i=0; i<52; i++)
    {
      //if (i % 8 == 0 && i != 0)
      // Serial.println();
      // Serial.print(myBits[channel][i], BIN); 

      byte myNibble = i / 4;
      byte myBit = (i % 4);

      //Serial.print(" - ");
      // Serial.print(myNibble, DEC);
      // Serial.print(",");
      // Serial.print(myBit, DEC);
      // Serial.println();

      myNibbles[channel][myNibble] |= (myBits[channel][i] << myBit);
    }
    //  Serial.println();

    /*
  Serial.println("Nibbles:");
     for (byte i=0; i<13; i++)
     {
     if (i % 2 == 0 && i != 0)
     Serial.println();
     
     Serial.print(myNibbles[channel][i], BIN); 
     }
     Serial.println();
     */
    /*
  if (bitIndex[channel] != 52)
     {
     Serial.print("Incorrect # of bits received (");
     Serial.print(bitIndex[channel], DEC);
     Serial.println(").");
     
     resetSPCData(channel);
     return 1;
     }
     */

    //  Serial.print("Preamble: ");
    if (bitIndex[channel] > 16)
    {
      for (byte i=0; i<4; i++)
      {
        //  Serial.print(myNibbles[channel][i], HEX);

        if (myNibbles[channel][i] != 0x0f)
        {
          //Serial.print("Incorrect preamble (");
          //Serial.print(myNibbles[channel][i], BIN);
          //Serial.println(").");

          resetSPCData(channel);

          digitalWrite(error_pin, HIGH);
          delay(1);
          digitalWrite(error_pin, LOW);

					triggerReading(channel);
					
          return 2;
        }
      }
      //Serial.println();
    }

    if (bitIndex[channel] == 52)
    {
      //check the decimal point... its always a 3 and if we got bunk data, it will be wrong.
      if (myNibbles[channel][11] == 3)
      {
        numberSign[channel] = myNibbles[channel][4];

        digits[channel][0] = myNibbles[channel][5];
        digits[channel][1] = myNibbles[channel][6];
        digits[channel][2] = myNibbles[channel][7];
        digits[channel][3] = myNibbles[channel][8];
        digits[channel][4] = myNibbles[channel][9];
        digits[channel][5] = myNibbles[channel][10];

        decimalPoint[channel] = myNibbles[channel][11];
        units[channel] = myNibbles[channel][12];

        readings[channel]++;

        digitalWrite(read_pin, HIGH);
        delay(1);
        digitalWrite(read_pin, LOW);
      }

      resetSPCData(channel);
    }

		triggerReading(channel);
  }

  return 0;
}

void resetSPCData(byte channel)
{
  bitIndex[channel] = 0;
  for (byte i=0; i<13; i++)
    myNibbles[channel][i] = 0;
  for (byte i=0; i<52; i++)
    myBits[channel][i] = 0;
}

void triggerReading(byte channel)
{
	digitalWrite(request_pins[channel], HIGH);
}

void initialize_sdcard()
{
  // make sure that the default chip select pin is set to
  // output, even if you don't use it:
  pinMode(53, OUTPUT);

  if (!sd_initialized)
  {
    // see if the card is present and can be initialized:
    if (!SD.begin(chipSelect))
    {
      Serial.println("Card failed, or not present");

			digitalWrite(error_pin, HIGH);
			delay(1);
			digitalWrite(error_pin, LOW);

      // don't do anything more:
      return;
    }
    Serial.println("SD card initialized.");
    sd_initialized = true;		
  }

  if (dataFile)
    dataFile.close();
	
	/*
	//TOTALLY BUSTED.
  String myFile = generate_sd_filename();
	char charFileName[12];
	myFile.toCharArray(charFileName, 12);
  dataFile = SD.open(charFileName, FILE_WRITE);
	*/
	
  dataFile = SD.open("mitutoyo.log", FILE_WRITE);
  if (!dataFile)
	{
    Serial.print("SD error opening ");
		//Serial.println(myFile);

		digitalWrite(error_pin, HIGH);
		delay(1);
		digitalWrite(error_pin, LOW);
	}
}

//THIS IS COMPLETELY FUCKED.
/*
String generate_sd_filename()
{
	String fname;
	
  for (long i=10000; i<20000; i++)
  {
		fname = String("mt");
		fname += String(i, DEC);
		fname += String(".log");

		char charFileName[12];
		fname.toCharArray(charFileName, 12);

    if (!SD.exists(charFileName))
      return fname;
  }

  return fname;
}
*/

