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
const byte clock_pins[NUM_INPUTS] = {
  3, 2, 18, 19, 20, 21};
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

volatile boolean sampleFlag = false;

void setup()
{
  Serial.begin(57600);
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

      pinMode(clock_pins[i], INPUT);
      pinMode(data_pins[i], INPUT);
      pinMode(request_pins[i], OUTPUT);
      digitalWrite(request_pins[i], LOW);
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
	unsigned long lastTrigger = 0;
	int lastReading = 0;
	
  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
      parseSPCData(i);
  }

  if (dataMode == LOGGING_MODE)
  {
    if ((millis() - lastPrint) > 100)
    {
			//String line = getCSVLine();
		  //Serial.println(line);
			printCSVLine();

      lastPrint = millis();
    }
  }
  else if(dataMode == SAMPLE_MODE)
  {
    if (!digitalRead(sample_pin))
    {
			lastTrigger = millis();
			lastReading = readings[0];
			
			triggerReading(0);
			
			while (lastReading == readings[0])
			{
				parseSPCData(0);
				delay(10);

				if ((millis() - lastTrigger) > 1000)
				{
//					Serial.print("TRG: No data. ");
//					Serial.println(bitIndex[0]);
					break;
				}
			}
			
			//String line = getCSVLine();
		  //Serial.println(line);
			printCSVLine();

      while (!digitalRead(sample_pin))
        delay(100);
    }
  }
  else if (dataMode == TRIGGER_MODE)
  {
    if (!digitalRead(trigger_pin))
    {
			lastTrigger = millis();
			lastReading = readings[0];
			
			triggerReading(0);
			
			while (lastReading == readings[0])
			{
				parseSPCData(0);
				delay(10);

				if ((millis() - lastTrigger) > 1000)
				{
					Serial.print("TRG: No data. ");
					Serial.println(bitIndex[0]);
					break;
				}
			}
			
			//String line = getCSVLine();
		  //Serial.println(line);
			printCSVLine();

      while (!digitalRead(trigger_pin))
        delay(1);
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

void printCSVLine()
{
	long milliTime = millis();
  Serial.print(milliTime, DEC);
  Serial.print(", ");

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
			printSPCDataString(i);
      Serial.print(", ");
    }
  }

	Serial.println();
}

void printSPCDataString(byte i)
{
  if (numberSign[i] == 8)
    Serial.print("-");
  else
    Serial.print("+");

  for (int j=0; j<6; j++)
  {
    if (6-j == decimalPoint[i])
      Serial.print(".");
    Serial.print(digits[i][j], DEC);
  }
  Serial.print(", ");
	Serial.print(readings[i], DEC);
}


//this function seems to be killing our sketch.
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

//this function seems to be killing our sketch
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
	if (!digitalRead(clock_pins[channel]))
	{
 	  byte dataBit = digitalRead(data_pins[channel]);

	  byte myNibble = (bitIndex[channel] >> 2);
	  byte myBit = (bitIndex[channel] % 4);
	
	  myNibbles[channel][myNibble] |= (dataBit << myBit);

	  bitIndex[channel]++;
	
		if (bitIndex[channel] == 1)
			digitalWrite(request_pins[channel], LOW);
	}
}

byte parseSPCData(byte channel)
{
  if (channelEnabled[channel])
 	{
    if (bitIndex[channel] == 52)
    {
	    //  Serial.print("Preamble: ");
	    if (bitIndex[channel] > 16)
	    {
	      for (byte i=0; i<4; i++)
	      {
	        //  Serial.print(myNibbles[channel][i], HEX);

	        if (myNibbles[channel][i] != 0x0f)
	        {
	          Serial.print("Incorrect preamble (");
	          Serial.print(myNibbles[channel][i], BIN);
	          Serial.println(").");

	          digitalWrite(error_pin, HIGH);
	          delay(1);
	          digitalWrite(error_pin, LOW);

	          resetSPCData(channel);
						triggerReading(channel);

	          return 2;
	        }
	      }
	      //Serial.println();
	    }

//			for (byte i=0; i<13; i++)
//			{
//				Serial.print(myNibbles[channel][i], HEX);
//				Serial.print("-");
//			}
//			Serial.println();

      //check the decimal point... it needs to be 3
      if (myNibbles[channel][11] >= 2 && myNibbles[channel][11] <= 4)
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

				//Serial.println("Success.");

        digitalWrite(read_pin, HIGH);
        delay(1);
        digitalWrite(read_pin, LOW);
      }
			else
			{
				Serial.print("Bad DP: ");
				Serial.println(myNibbles[channel][11], DEC);
			}

      resetSPCData(channel);

			if (dataMode == LOGGING_MODE || dataMode == SDCARD_MODE)
			{
				triggerReading(channel);
			}
    }
		else if (bitIndex[channel] > 52)
		{
			Serial.print("TMI: ");
			Serial.println(bitIndex[channel], DEC);

			for (byte i=0; i<13; i++)
			{
				Serial.print(myNibbles[channel][i], HEX);
				Serial.print("-");
			}
			Serial.println();
			
			resetSPCData(channel);
		}
/*
	  else if ((millis() - lastClock[channel]) > 50 && bitIndex[channel] > 0)
	  {
			Serial.print("No data: ");
			Serial.println(bitIndex[channel], DEC);

			resetSPCData(channel);

			digitalWrite(error_pin, HIGH);
			delay(1);
			digitalWrite(error_pin, LOW);

			if (dataMode == LOGGING_MODE || dataMode == SDCARD_MODE)
			{
				triggerReading(channel);
			}
		}
*/
  }	
  return 0;
}

void resetSPCData(byte channel)
{
  bitIndex[channel] = 0;
  for (byte i=0; i<13; i++)
    myNibbles[channel][i] = 0;
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

