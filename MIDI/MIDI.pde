/*
 * Potty ~ MIDI controller with 4 potentiometers
 *
 */

//#define DEBUG

const int NUM_POTS = 4;
const int POT_PINS[NUM_POTS] = {A0, A1, A2, A3};
const byte CC_NUMBERS[NUM_POTS] = {0x10, 0x11, 0x12, 0x13};

// *smooth factor* (how smooth you are, keep it down for quick response)
const int NUM_READINGS = 32;


int lastValues[NUM_POTS] = {};
int readings[NUM_POTS][NUM_READINGS] = {};
int total[NUM_POTS] = {};
int idx = 0;

void ctrlChange(byte control, byte value);


void setup() {
  for (int i = 0; i < NUM_POTS; i++) {
    pinMode(POT_PINS[i], INPUT);
  }

  #ifdef DEBUG
    Serial.begin(9600);
  #else
    Serial.begin(31250);
  #endif
}

void loop() {
  #ifdef DEBUG
  Serial.print("| ");
  #endif

  for (int i = 0; i < NUM_POTS; i++) {
    total[i] -= readings[i][idx];
    readings[i][idx] = analogRead(POT_PINS[i]);
    #ifdef DEBUG
    Serial.print(readings[i][idx], DEC);
    Serial.print(' ');
    #endif

    total[i] += readings[i][idx];
    int avg = total[i] / NUM_READINGS;
    #ifdef DEBUG
    Serial.print(avg, DEC);
    Serial.print(' ');
    #endif

    int midiValue = constrain(avg / 8, 0, 127);
    #ifdef DEBUG
    Serial.print(midiValue, DEC);
    Serial.print(' ');
    #endif

    if (midiValue != lastValues[i]) {
      #ifndef DEBUG
      ctrlChange(CC_NUMBERS[i], midiValue);
      #endif
      lastValues[i] = midiValue;
    }

    #ifdef DEBUG
    Serial.print(" | ");
    #endif
  }

  idx = (idx + 1) % NUM_READINGS;

  #ifdef DEBUG
  Serial.println();
  #endif
}


void ctrlChange(byte control, byte value) {
  Serial.write(0xb0);
  Serial.write(control);
  Serial.write(value);
}
