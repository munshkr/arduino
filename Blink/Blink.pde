/*
  Blink
  Turns on and off 3 LEDs in order, repeatedly.
 */

const int ledPins[3] = {9, 10, 11};

void setup() {
  for (int i = 0; i < 3; i++) {
    pinMode(ledPins[i], OUTPUT);
  }
}

void loop() {
  for (int i = 0; i < 3; i++) {
    blinkLED(ledPins[i], 100);
  }
}

void blinkLED(int pin, int delayMs) {
  digitalWrite(pin, HIGH);
  delay(delayMs);
  digitalWrite(pin, LOW);
  delay(delayMs);
}
