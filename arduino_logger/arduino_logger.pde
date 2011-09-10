#define LOGGING_MODE 1
#define SAMPLE_MODE 2
#define TRIGGER_MODE 3

//byte dataMode = LOGGING_MODE; //continuous sampling every 200ms, output in CSV format
//byte dataMode = SAMPLE_MODE; //output sampled and logged every time the sample button is pressed
byte dataMode = TRIGGER_MODE; //output sampled and logged every time the 12v input is triggered.

#define NUM_INPUTS 4

const byte clock_interrupts[NUM_INPUTS] = {
  1, 0, 5, 4};
const byte data_pins[NUM_INPUTS] = {
  4, 15, 17, 21};
const byte request_pins[NUM_INPUTS] = {
  5, 14, 16, 22};
const byte sense_pins[NUM_INPUTS] = {
  0, 1, 2, 3};

//data from the input
volatile byte myNibbles[NUM_INPUTS][13];
volatile byte bitIndex[NUM_INPUTS] = {
  0,0,0,0};

volatile byte myBits[NUM_INPUTS][52];

byte channelEnabled[NUM_INPUTS] = {
  1,0,0,0};
byte numberSign[NUM_INPUTS] = {
  0,0,0,0};
byte digits[NUM_INPUTS][6];
byte decimalPoint[NUM_INPUTS] = {
  0,0,0,0};
byte units[NUM_INPUTS] = {
  0,0,0,0};

unsigned int readings[NUM_INPUTS] = {
  0,0,0,0};

volatile unsigned long lastClock[NUM_INPUTS] = {
  0,0,0,0 
};

volatile boolean sampleFlag = false;

void setup()
{
  delay(1000);
  Serial.begin(115200);
  Serial.println("MakerBot Mitutoyo SPC Logger v1.0");

  for (byte i=0; i<NUM_INPUTS; i++)
  {
    resetSPCData(i);

    pinMode(data_pins[i], INPUT);

    pinMode(request_pins[i], OUTPUT);
    digitalWrite(request_pins[i], HIGH);
  }

  attachInterrupt(clock_interrupts[0], read_spc_0, FALLING);
  attachInterrupt(clock_interrupts[1], read_spc_1, FALLING);
  attachInterrupt(clock_interrupts[2], read_spc_2, FALLING);
  attachInterrupt(clock_interrupts[3], read_spc_3, FALLING);

  if (dataMode == SAMPLE_MODE)
    attachInterrupt(2, triggerSample, FALLING);
  if (dataMode == TRIGGER_MODE)
    attachInterrupt(3, triggerSample, FALLING);

  printCSVHeader();
}

unsigned long lastPrint = 0;

void loop()
{
  parseSPCData(0);
  parseSPCData(1);
  parseSPCData(2);
  parseSPCData(3);

  if (dataMode == LOGGING_MODE)
  {
    if ((millis() - lastPrint) > 200)
    {
      printCSVLine();
    }
  }
  else if(dataMode == SAMPLE_MODE || dataMode == TRIGGER_MODE)
  {
    if (sampleFlag)
    {
      printCSVLine();
      delay(200);
      sampleFlag = false;
    } 
  }
}

void printCSVHeader()
{
  Serial.print("Milliseconds");
  Serial.print(", ");

  if (channelEnabled[0])
    Serial.print("CH1, SAMPLE#, ");

  if (channelEnabled[1])
    Serial.print("CH2, SAMPLE#, ");

  if (channelEnabled[2])
    Serial.print("CH3, SAMPLE#, ");
  if (channelEnabled[3])
  {
    Serial.print("CH4, SAMPLE#");
  }

  Serial.println();  
}

void printCSVLine()
{
  Serial.print(millis(), DEC);
  Serial.print(", ");

  if (channelEnabled[0])
  {
    printSPCData(0);
    Serial.print(", ");
  }
  if (channelEnabled[1])
  {
    printSPCData(1);
    Serial.print(", ");
  }
  if (channelEnabled[2])
  {
    printSPCData(2);
    Serial.print(", ");
  }
  if (channelEnabled[3])
  {
    printSPCData(3);
  }

  Serial.println();

  lastPrint = millis();
}

void printSPCData(byte i)
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

void readSPCData(byte channel)
{
  byte dataBit = digitalRead(data_pins[channel]);

  myBits[channel][bitIndex[channel]] = dataBit;

  byte myNibble = bitIndex[channel] / 4;
  byte myBit = (bitIndex[channel] % 4);

  myNibbles[channel][myNibble] |= (dataBit << myBit);

  bitIndex[channel]++;

  lastClock[channel] = millis();

  //  if (bitIndex[channel] == 52)
  //    digitalWrite(request_pins[channel], LOW);
}

byte parseSPCData(byte channel)
{
  if (channelEnabled[channel])
  {
    if (millis() - lastClock[channel] > 100)
      resetSPCData(channel);    

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
      }
      resetSPCData(channel);
    }
  }
  return 0;
}

void resetSPCData(byte channel)
{
  digitalWrite(request_pins[channel], HIGH);

  bitIndex[channel] = 0;
  for (byte i=0; i<13; i++)
    myNibbles[channel][i] = 0;
  for (byte i=0; i<52; i++)
    myBits[channel][i] = 0;

  digitalWrite(request_pins[channel], LOW);
}

void triggerSample()
{
  sampleFlag = true;
}



