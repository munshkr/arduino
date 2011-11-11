const int POT1_PIN = A0;
const int NUM_READINGS = 100;

int lastMidiValue = 0;
int readings[NUM_READINGS] = {};
int idx, total;


void setup() {
  pinMode(13, OUTPUT);
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
    digitalWrite(13, HIGH);
    delay(50);
    digitalWrite(13, LOW);
    //ctrlChange(0, midiValue);
    lastMidiValue = midiValue;
  }
}

void ctrlChange(unsigned int control, unsigned int value) {
  if (control > 0x65 || value > 0x7F) return;
  Serial.write(0xB0);
  Serial.write(control);
  Serial.write(value);
}
