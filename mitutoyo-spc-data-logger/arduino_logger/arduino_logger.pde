#include <EEPROM.h>
#include <SD.h>
#include <stdio.h>

//the various different modes available.
#define SAMPLE_MODE 1
#define TRIGGER_MODE 2
#define LOGGING_MODE 3
#define SDCARD_MODE 4
#define SERIAL_MODE 5

//do we want debugging on or not?
const byte debuggingEnabled = false;

//default to manual sampling.
byte dataMode = 1;

//EEPROM address for mode storage
#define MODE_ADDRESS 0

//6 channel datalogger.  :)
const byte NUM_INPUTS = 6;

// these are the I/Os and interrupts for each channel.
const byte clock_interrupts[NUM_INPUTS] = { 
  1,  0,  5,  4,  3,  2  }; 
const byte clock_pins[NUM_INPUTS] =       { 
  3,  2,  18, 19, 20, 21 };
const byte data_pins[NUM_INPUTS] =        { 
  4,  15, 17, 23, 27, 29 };
const byte request_pins[NUM_INPUTS] =     { 
  35, 36, 37, 38, 39, 40 };

//which channels do we want to enable?
byte channelEnabled[NUM_INPUTS] = { 
  1,1,1,1,1,1 };

//led status pins.
const byte error_pin   = 12;
const byte read_pin    = 11;
const byte status_pin  = 10;
const byte mode_pin     = 9;

//button / interface pins
const byte sample_pin   = 46;
const byte trigger_pin  = 41;
const byte chmod_pin    = 45;


unsigned long lastPrint = 0;

//temporary storage for the interrupt routine.
volatile byte myNibbles[NUM_INPUTS][13];
volatile byte bitIndex[NUM_INPUTS] = {
  0,0,0,0,0,0};


//these are our output storage arrays
byte numberSign[NUM_INPUTS] = {
  0,0,0,0,0,0};
byte digits[NUM_INPUTS][6];
byte decimalPoint[NUM_INPUTS] = {
  0,0,0,0,0,0};
byte units[NUM_INPUTS] = {
  0,0,0,0,0,0};
byte ready[NUM_INPUTS] = {
  0,0,0,0,0,0};

//how many samples have we taken?
unsigned int readings[NUM_INPUTS] = {
  0,0,0,0,0,0};

void setup()
{
  // Start serial comms.
  Serial.begin(57600);

  // Manual sample button... input w/ internal pullup
  pinMode(sample_pin, INPUT);
  digitalWrite(sample_pin, HIGH);

  // External trigger pin... input w/ internal pullup
  pinMode(trigger_pin, INPUT);
  digitalWrite(trigger_pin, HIGH);

  // Mode pin... input w/ internal pullup.
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
  Serial.println("MakerBot Mitutoyo SPC Logger v4");

  detectGauges();

  //what is our current mode?
  dataMode = EEPROM.read(MODE_ADDRESS);
  updateDataMode(dataMode);

  SerialPrintCSVHeader();
}


void loop()
{
  //every time through, check to see if we're got new data.
  for (byte i=0; i<NUM_INPUTS; i++) {
    if (channelEnabled[i]) {
      parseSPCData(i);
    }
  }

  //each different sampling mode has its own subroutine.
  switch (dataMode) {
  case LOGGING_MODE:
    loggingLoop();
    break;
  case SAMPLE_MODE:
    triggerLoop(sample_pin);
    break;
  case TRIGGER_MODE:
    triggerLoop(trigger_pin);
    break;
  case SDCARD_MODE:
    sdLoop();
    break;
  case SERIAL_MODE:
    // Serial control is always available, so don't do anything special here.
    break;
  }

  // keep serial available at all times... so we can control the device.
  if (dataMode == SERIAL_MODE || Serial.available() > 0) {
    handleSerial();
  }

  //any request to switch modes?
  checkModeButton();
}

//this is continuous mode... so every time all the gauges are ready, lets show them and do a new loop.
void loggingLoop()
{
  if (allReady())
  {
    SerialPrintCSVLine();

    triggerAllReadings();
  }
}

void handleSerial()
{
  int input_byte = Serial.read();

  switch (input_byte) {
  case '1':
    updateDataMode(SAMPLE_MODE);
    break;
  case '2':
    updateDataMode(TRIGGER_MODE);
    break;
  case '3':
    updateDataMode(LOGGING_MODE);
    break;
  case '4':
    updateDataMode(SDCARD_MODE);
    break;
  case 'T':
    MeasureAllChannels();
    break;
  case 'A':
    activateSdLogging();
    break;
  case 'D':
    deactivateSdLogging();
    break;
  }
}

void checkModeButton()
{
  if (!digitalRead(chmod_pin))
  {
    incrementDataMode();

    //Serial.print("EEPROM Write: ");
    //Serial.print(MODE_ADDRESS, DEC);
    //Serial.print(", ");
    //Serial.println(dataMode, DEC);
    EEPROM.write(MODE_ADDRESS, dataMode);

    resetSdcard();

    for (int i=0; i<dataMode; i++)
      fade_led(mode_pin, 250);

    while (!digitalRead(chmod_pin))
      delay(100);
  }
}

// Increment to the next data mode. If this is the last data mode,
// then wrap to the first.
void incrementDataMode()
{
  byte newDataMode = dataMode + 1;
  
  // We have 5 data modes, 1-5 (this is hardcoded behavior)
  if (newDataMode > 5) {
    newDataMode = 1;
  }
  
  updateDataMode(newDataMode);
}

void updateDataMode(byte new_mode)
{
  dataMode = new_mode;

  if (dataMode > 5)
    dataMode = 1;

  switch (dataMode) {
    case SAMPLE_MODE:
      Serial.println("Mode: Manual Sampling");
      break;
    case TRIGGER_MODE:
      Serial.println("Mode: External Trigger");
      break;
    case LOGGING_MODE:
      Serial.println("Mode: Continuous Logging");
      triggerAllReadings();
      break;
    case SDCARD_MODE:
      Serial.println("Mode: SD Card Logging");
      triggerAllReadings();
      break;
    case SERIAL_MODE:
      Serial.println("Mode: Serial Interface");
      break;
  }
}

//format a header for printing.
String getCSVHeader()
{
  String out = "Milliseconds";

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
      out += String(", CH");
      out += String(i+1, DEC);
      out += String(", SAMPLE#");
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



//output a CSV line to Serial.
void SerialPrintCSVLine()
{
  long milliTime = millis();
  Serial.print(milliTime, DEC);

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    if (channelEnabled[i])
    {
      Serial.print(", ");
      SerialPrintSPCDataString(i);
    }
  }

  Serial.println();
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

void flash_led(byte pin) 
{
  digitalWrite(pin, HIGH);
  delay(1);
  digitalWrite(pin, LOW);  
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


unsigned long lastTrigger = 0;
int lastReading = 0;

//this is trigger mode.  we only sample every time the trigger pin itself is taken low.
void triggerLoop(byte my_pin)
{
  if (!digitalRead(my_pin))
  {
    MeasureAllChannels();

    // Debounce routine.
    while (!digitalRead(my_pin))
      delay(100);
  }
}

// Trigger all active channels, wait for them to finish, then report the results.
void MeasureAllChannels()
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

  if (allReady()) {
    SerialPrintCSVLine();
  }
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
          if (debuggingEnabled)
          {
            Serial.print("ERR: Preamble (");
            Serial.print(myNibbles[channel][i], BIN);
            Serial.println(").");
          }

          flash_led(error_pin);

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

        flash_led(read_pin); //show we have a winner.
      }
      else
      {
        if (debuggingEnabled)
        {
          //show the error.
          Serial.print("ERR: Bad DP: ");
          Serial.println(myNibbles[channel][11], DEC);
        }

        flash_led(error_pin);

        //start fresh.
        triggerReading(channel);
      }
    }
    else if (bitIndex[channel] > 52)
    {
      if(debuggingEnabled)
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
      }

      flash_led(error_pin);

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

