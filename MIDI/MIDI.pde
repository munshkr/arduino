//#define DEBUG

const unsigned int POT1_PIN = A0;
const unsigned int NUM_READINGS = 8;

int lastMidiValue = 0;
int readings[NUM_READINGS] = {};
int idx, total;


void ctrlChange(byte control, byte value) {
  Serial.write(0xB0);
  Serial.write(control);
  Serial.write(value);
}


void setup() {
  pinMode(POT1_PIN, INPUT);
  #ifndef DEBUG
  Serial.begin(31250);
  #else
  Serial.begin(9600);
  #endif
  Serial.flush();
}

void loop() {
  total -= readings[idx];
  readings[idx] = analogRead(POT1_PIN);
  #ifdef DEBUG
  Serial.print(readings[idx], DEC);
  Serial.print(' ');
  #endif

  total += readings[idx];
  idx = (idx + 1) % NUM_READINGS;
  int avg = total / NUM_READINGS;
  #ifdef DEBUG
  Serial.print(avg, DEC);
  Serial.print(' ');
  #endif

  int midiValue = constrain(avg / 8, 0, 127);
  #ifdef DEBUG
  Serial.print(midiValue, DEC);
  Serial.println(' ');
  #endif

  if (midiValue != lastMidiValue) {
    #ifdef DEBUG
    Serial.println(midiValue, DEC);
    #else
    ctrlChange(0, midiValue);
    #endif
    lastMidiValue = midiValue;
  }
}
