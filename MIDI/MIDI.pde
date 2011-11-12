const int POT1_PIN = A0;
const int NUM_READINGS = 100;

int lastMidiValue = 0;
int readings[NUM_READINGS] = {};
int idx, total;


void ctrlChange(byte control, byte value) {
  Serial.write(0xB0);
  Serial.write(control);
  Serial.write(value);
}


void setup() {
  Serial.begin(31250);
}

void loop() {
  total -= readings[idx];
  readings[idx] = analogRead(POT1_PIN);
  total += readings[idx];
  idx = (idx + 1) % NUM_READINGS;
  int avg = total / NUM_READINGS;

  int midiValue = map(avg, 0, 1023, 0, 127);

  if (midiValue != lastMidiValue) {
    ctrlChange(0, midiValue);
    lastMidiValue = midiValue;
  }
}
