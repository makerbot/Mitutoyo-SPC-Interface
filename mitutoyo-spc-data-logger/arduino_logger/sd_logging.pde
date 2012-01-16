//sdcard stuff.
const byte chipSelect      = 49;
File dataFile;
boolean initialized     = false;
boolean loggingEnabled = false;

// Reset the sdcard system
void resetSdcard()
{
  initialized = false;
  loggingEnabled = false;
}


//get our SD card ready for logging.
void initializeSdcard()
{
  // make sure that the default chip select pin is set to
  // output, even if you don't use it:
  pinMode(53, OUTPUT);

  if (!initialized)
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
    initialized = true;		
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

void sdLoop()
{
  if (loggingEnabled)
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
      initializeSdcard();

      if (!dataFile)
        delay(250);
    }			
  }

  //sample pin will turn logging on or off.
  if (!digitalRead(sample_pin))
  {
    loggingEnabled = !loggingEnabled;

    if (loggingEnabled)
      activateSdLogging();
    else
      deactivateSdLogging();

    while (!digitalRead(sample_pin))
      delay(100);
  }
}

void activateSdLogging()
{
  Serial.print("SD: logging activated @ ");
  Serial.println(millis(), DEC);

  initializeSdcard();
  SDPrintCSVHeader();	

  loggingEnabled = true;
}

void deactivateSdLogging()
{
  if (dataFile)
  {
    Serial.print("SD: logging deactivated @ ");
    Serial.println(millis(), DEC);

    dataFile.close();
  }
  else
  {
    Serial.print("SD: cannot deactivate, not yet activated. ");			
  }

  loggingEnabled = false;
}

//output the header to SD Card
void SDPrintCSVHeader()
{
  String line = getCSVHeader();
  dataFile.println(line);
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
