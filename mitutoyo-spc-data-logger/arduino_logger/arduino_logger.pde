#include <EEPROM.h>
#include <SD.h>
#include <stdio.h>

//the various different modes available.
#define SAMPLE_MODE 1
#define TRIGGER_MODE 2
#define LOGGING_MODE 3
#define SDCARD_MODE 4
#define SERIAL_MODE 5

//default to manual sampling.
byte dataMode = 1;

//EEPROM address for mode storage
#define MODE_ADDRESS 0

//6 channel datalogger.  :)
#define NUM_INPUTS 6

// these are the I/Os and interrupts for each channel.
const byte clock_interrupts[NUM_INPUTS] = { 1,  0,  5,  4,  3,  2  }; 
const byte clock_pins[NUM_INPUTS] =       { 3,  2,  18, 19, 20, 21 };
const byte data_pins[NUM_INPUTS] =        { 4,  15, 17, 23, 27, 29 };
const byte request_pins[NUM_INPUTS] =     { 35, 36, 37, 38, 39, 40 };

//which channels do we want to enable?
byte channelEnabled[NUM_INPUTS] = { 1,1,1,1,1,1 };

//led status pins.
const byte error_pin = 12;
const byte read_pin = 11;
const byte status_pin = 10;
const byte mode_pin = 9;

//button / interface pins
const byte sample_pin = 46;
const byte trigger_pin = 41;
const byte chmod_pin = 45;

//sdcard stuff.
const byte chipSelect = 49;
File dataFile;
boolean sd_initialized = false;
boolean sd_logging_enabled = false;

//temporary storage for the interrupt routine.
volatile byte myNibbles[NUM_INPUTS][13];
volatile byte bitIndex[NUM_INPUTS] = {0,0,0,0,0,0};

//these are our output storage arrays
byte numberSign[NUM_INPUTS] = {0,0,0,0,0,0};
byte digits[NUM_INPUTS][6];
byte decimalPoint[NUM_INPUTS] = {0,0,0,0,0,0};
byte units[NUM_INPUTS] = {0,0,0,0,0,0};
byte ready[NUM_INPUTS] = {0,0,0,0,0,0};

//how many samples have we taken?
unsigned int readings[NUM_INPUTS] = {0,0,0,0,0,0};

unsigned long lastPrint = 0;

void setup()
{
	//start serial comms.
  Serial.begin(57600);

	//manual sample button... input w/ internal pullup
  pinMode(sample_pin, INPUT);
	digitalWrite(sample_pin, HIGH);
	
	//external trigger pin... input w/ internal pullup
  pinMode(trigger_pin, INPUT);
	digitalWrite(trigger_pin, HIGH);
	
	//external trigger pin... input w/ internal pullup.
  pinMode(chmod_pin, INPUT);
	digitalWrite(chmod_pin, HIGH);
	
	//show some pretty lights to let the world know you're alive.
  fade_led(error_pin, 128);
  fade_led(read_pin, 128);
  fade_led(status_pin, 128);
  fade_led(mode_pin, 128);

	//initialize all the pins for all the channels
  for (byte i=0; i<NUM_INPUTS; i++)
  {
		//make sure our data is cleared
		resetSPCData(i);

		//input pin, internal pullup enabled.
		pinMode(clock_pins[i], INPUT);
		digitalWrite(clock_pins[i], HIGH);

		//input pin, internal pullup enabled.
		pinMode(data_pins[i], INPUT);
		digitalWrite(data_pins[i], HIGH);
		
		//output pins, disabled initially.
		pinMode(request_pins[i], OUTPUT);
		digitalWrite(request_pins[i], LOW);
  }

	//print header and scan gauges.
  Serial.println("MakerBot Mitutoyo SPC Logger v3");
	detectGauges();

	//what is our current mode?
  dataMode = EEPROM.read(MODE_ADDRESS);
  update_data_mode();
  SerialPrintCSVHeader();
}

void detectGauges()
{
  //get all our interrupts going. 
	attachInterrupt(clock_interrupts[0], read_spc_0, FALLING);
	attachInterrupt(clock_interrupts[1], read_spc_1, FALLING);
	attachInterrupt(clock_interrupts[2], read_spc_2, FALLING);
	attachInterrupt(clock_interrupts[3], read_spc_3, FALLING);
	attachInterrupt(clock_interrupts[4], read_spc_4, FALLING);
	attachInterrupt(clock_interrupts[5], read_spc_5, FALLING);

	//start a reading on each channel.
	triggerAllReadings();
	
	//give time for results to come back.
	delay(250);
	
	//check for results.
	for (byte i=0; i<NUM_INPUTS; i++)
		parseSPCData(i);

	//loop through and find out what we got.  disable any failures.
	Serial.print("Detected Channels: ");
	for (byte i=0; i<NUM_INPUTS; i++)
	{
		if (ready[i])
		{
			Serial.print(i+1, DEC);
			Serial.print(',');
		}
		else
		{
			channelEnabled[i] = 0;
			detachInterrupt(clock_interrupts[i]);
		}
		
		readings[i] = 0; // reset our readings counter.
	}
	
	Serial.println();
}

unsigned long lastTrigger = 0;
int lastReading = 0;
	
void loop()
{	
  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
      parseSPCData(i);
  }

  if (dataMode == LOGGING_MODE)
		loggingLoop();
  else if(dataMode == SAMPLE_MODE)
		triggerLoop(sample_pin);
  else if (dataMode == TRIGGER_MODE)
		triggerLoop(trigger_pin);
  else if (dataMode == SDCARD_MODE)
		sdLoop();
		
	checkModeButton();
}

void loggingLoop()
{
	if (allReady())
	{
		SerialPrintCSVLine();

		triggerAllReadings();
	}
}

void triggerLoop(byte my_pin)
{
	if (!digitalRead(my_pin))
	{
		lastTrigger = millis();
		lastReading = readings[0];
		
		triggerAllReadings();

		while (!allReady())
		{
			for (byte i=0; i<NUM_INPUTS; i++)
			{
				if (!ready[i])
					parseSPCData(i);
			}
			delay(10);

			if ((millis() - lastTrigger) > 1000)
			{
//				Serial.print("TRG: No data. ");
//				Serial.println(bitIndex[0]);
				break;
			}
		}

		if (allReady())
			SerialPrintCSVLine();

     while (!digitalRead(my_pin))
       delay(100);
   }
}

void sdLoop()
{
	if (sd_logging_enabled)
	{
		// if the file is available, write to it:
		if (dataFile)
		{
			if (allReady())
			{
				SDPrintCSVLine();

				triggerAllReadings();
			}
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
		{
			Serial.print("SD: logging activated @ ");
			Serial.println(millis(), DEC);

			initialize_sdcard();
			SDPrintCSVHeader();
		}
		else if (dataFile)
		{
			Serial.print("SD: logging deactivated @ ");
			Serial.println(millis(), DEC);

			dataFile.close();
		}

		while (!digitalRead(sample_pin))
			delay(100);
	}
}

void checkModeButton()
{
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
      fade_led(mode_pin, 250);

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
	{
    Serial.println("Continuous Logging Mode");

	  for (byte i=0; i<NUM_INPUTS; i++)
  	{
    	if (channelEnabled[i])
				triggerReading(i);
		}
	}
  else if (dataMode == SDCARD_MODE)
	{
    Serial.println("SD Card Logging Mode");

	  for (byte i=0; i<NUM_INPUTS; i++)
  	{
    	if (channelEnabled[i])
				triggerReading(i);
		}
	}
}

//format a header for printing.
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

//output the header to Serial
void SerialPrintCSVHeader()
{
	String line = getCSVHeader();
  Serial.println(line);
}

//output the header to SD Card
void SDPrintCSVHeader()
{
	String line = getCSVHeader();
  dataFile.println(line);
}

//output a CSV line to Serial.
void SerialPrintCSVLine()
{
	long milliTime = millis();
  Serial.print(milliTime, DEC);
  Serial.print(", ");

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
			SerialPrintSPCDataString(i);
      Serial.print(", ");
    }
  }

	Serial.println();
}

//output a CSV line to SD Card
void SDPrintCSVLine()
{
	long milliTime = millis();
  dataFile.print(milliTime, DEC);
  dataFile.print(", ");

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
			SDPrintSPCDataString(i);
      dataFile.print(", ");
    }
  }

	dataFile.println();
}


//output a single channel reading to Serial.
void SerialPrintSPCDataString(byte i)
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

//output a single channel reading to SD Card.
void SDPrintSPCDataString(byte i)
{
  if (numberSign[i] == 8)
    dataFile.print("-");
  else
    dataFile.print("+");

  for (int j=0; j<6; j++)
  {
    if (6-j == decimalPoint[i])
      dataFile.print(".");
    dataFile.print(digits[i][j], DEC);
  }
  dataFile.print(", ");
	dataFile.print(readings[i], DEC);
}

//redirect interrupt function for channel 1.
void read_spc_0()
{
  readSPCData(0);
}

//redirect interrupt function for channel 2.
void read_spc_1()
{
  readSPCData(1);
}

//redirect interrupt function for channel 3.
void read_spc_2()
{
  readSPCData(2);
}

//redirect interrupt function for channel 4.
void read_spc_3()
{
  readSPCData(3);
}

//redirect interrupt function for channel 5.
void read_spc_4()
{
  readSPCData(4);
}

//redirect interrupt function for channel 6.
void read_spc_5()
{
  readSPCData(5);
}

//main interrupt function for reading data from gauge.
void readSPCData(byte channel)
{
	//this digital read is critical!  without it, you will sometimes get extra clocks.  BAD!
	if (!digitalRead(clock_pins[channel]))
	{
		//turn off our request if this is the first time through.
		if (bitIndex[channel] == 1)
			digitalWrite(request_pins[channel], LOW);

		//pulls in teh actual data bit.
 	  byte dataBit = digitalRead(data_pins[channel]);

		//what bit and what nibble does this go into?
	  byte myNibble = (bitIndex[channel] >> 2);
	  byte myBit = (bitIndex[channel] % 4);
	
		//store it to the right bit/nibble.
	  myNibbles[channel][myNibble] |= (dataBit << myBit);

		//okay, we go ta new one!
	  bitIndex[channel]++;
	}
}

//this looks through the data and pulls out relevant information.
void parseSPCData(byte channel)
{
	//only look at channels that are enabled.
  if (channelEnabled[channel])
 	{
		//did we get the appropriate # of bits?
    if (bitIndex[channel] == 52)
    {
			//look at the first 4 nibbles:  they must all be 0xf or fail.
      for (byte i=0; i<4; i++)
      {
        if (myNibbles[channel][i] != 0x0f)
        {
          Serial.print("ERR: Preamble (");
          Serial.print(myNibbles[channel][i], BIN);
          Serial.println(").");

					flash_error_led();

					//start over and do a new reading.
					triggerReading(channel);

					return;
        }
      }

//DEBUG OUTPUT FOR LOOKING AT RAW DATA.
//			for (byte i=0; i<13; i++)
//			{
//				Serial.print(myNibbles[channel][i], HEX);
//				Serial.print("-");
//			}
//			Serial.println();

      //check the decimal point... it can really only be between 2 and 4.  (eg: xxxx.yy, xxx.yyy, or xx.yyyy)
      if (myNibbles[channel][11] >= 2 && myNibbles[channel][11] <= 4)
      {
        numberSign[channel] = myNibbles[channel][4]; // 0 is positive, 8 is negative

				//these are all just the actual digits as single numbers.  strange but true.
        digits[channel][0] = myNibbles[channel][5];
        digits[channel][1] = myNibbles[channel][6];
        digits[channel][2] = myNibbles[channel][7];
        digits[channel][3] = myNibbles[channel][8];
        digits[channel][4] = myNibbles[channel][9];
        digits[channel][5] = myNibbles[channel][10];

        decimalPoint[channel] = myNibbles[channel][11]; // (2 = xxxx.yy, 3 = xxx.yyy, 4 = xx.yyyy)
        units[channel] = myNibbles[channel][12]; // 0 = mm, 1 = inches

        readings[channel]++; //counter for # of successful readings.
				ready[channel] = 1; //we have a new reading ready for use.
				
				resetSPCData(channel); //clear out our data so we stop parsing it.
				
				flash_read_led(); //show we have a winner.
      }
			else
			{
				//show the error.
				Serial.print("ERR: Bad DP: ");
				Serial.println(myNibbles[channel][11], DEC);
			}
    }
		else if (bitIndex[channel] > 52)
		{
			//we got too much information.  crap.
			Serial.print("ERR: TMI: ");
			Serial.println(bitIndex[channel], DEC);

			//dump our input for debugging.
			for (byte i=0; i<13; i++)
			{
				Serial.print(myNibbles[channel][i], HEX);
				Serial.print("-");
			}
			Serial.println();
			
			//start fresh.
			triggerReading(channel);
		}
/*
		//TODO: add a started millis() variable and check when the sample was started vs when it was finished.  if too long, we can time out.
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
}

//get us back to a fresh slate for a new reading.
void resetSPCData(byte channel)
{
	//reset our data buffers.
  bitIndex[channel] = 0;
  for (byte i=0; i<13; i++)
    myNibbles[channel][i] = 0;
}

//get our SD card ready for logging.
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
      Serial.println("SD: Card failed, or not present");

			digitalWrite(error_pin, HIGH);
			delay(1);
			digitalWrite(error_pin, LOW);

      // don't do anything more:
      return;
    }
    Serial.println("SD: Card initialized.");
    sd_initialized = true;		
  }

	//if we already have a file open, close it first.
  if (dataFile)
    dataFile.close();
	
  dataFile = SD.open("mitutoyo.log", FILE_WRITE);
  if (!dataFile)
	{
    Serial.print("SD: error opening mitutoyo.log");
		//Serial.println(myFile);

		digitalWrite(error_pin, HIGH);
		delay(1);
		digitalWrite(error_pin, LOW);
	}
}

//THIS IS COMPLETELY FUCKED.  TODO: fixme.
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

boolean allReady()
{
	boolean allReady = true;
	
  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i] && !ready[i])
		{
			allReady = false;
			break;
		}
  }

	return allReady;
}

void triggerAllReadings()
{
  for (byte i=0; i<NUM_INPUTS; i++)
	{
  	if (channelEnabled[i])
			triggerReading(i);
	}
}

void triggerReading(byte channel)
{
	resetSPCData(channel);
	
	//clear our ready flag
	ready[channel] = 0;

	digitalWrite(request_pins[channel], HIGH);
}

void flash_read_led()
{
	digitalWrite(read_pin, HIGH);
	delay(1);
	digitalWrite(read_pin, LOW);
}

void flash_error_led()
{
	digitalWrite(error_pin, HIGH);
	delay(1);
	digitalWrite(error_pin, LOW);
}

//simple function to blink the LED.
void fade_led(byte pin, int milliseconds)
{
	int top = milliseconds/2;
	
  for (int i=0; i<top; i++)
  {
		analogWrite(pin, map(i, 0, top, 0, 255));
    delay(1);
  }

  for (int i=top; i>0; i--)
  {
		analogWrite(pin, map(i, 0, top, 0, 255));
    delay(1);
  }

  analogWrite(pin, 0);
}