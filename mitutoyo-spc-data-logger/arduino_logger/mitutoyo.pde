
extern const byte NUM_INPUTS;

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
