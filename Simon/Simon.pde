/*
 * Cheap "Simon" clone, with 3 pushbuttons and 3 LEDs
 *
 */

#include <LED.h>


const int NUM_LEDS = 3;
const int buttonPins[NUM_LEDS] = {2, 3, 4};
const int ledPins[NUM_LEDS] = {9, 10, 11};

enum GameState { INIT, SAYING, LISTENING, GAMEOVER };


enum GameState gameState;
int pinStates[NUM_LEDS] = {};


// TODO use LED object
// ...


void setup() {
  // initialize input/output pins
  for (int i = 0; i < NUM_LEDS; i++) {
    pinMode(buttonPins[i], INPUT);
    pinMode(ledPins[i], OUTPUT);
  }

  gameState = INIT;
}

void loop() {
  // update the state of the pushbuttons
  for (int i = 0; i < NUM_LEDS; i++) {
    pinStates[i] = digitalRead(buttonPins[i]);
  }

  // turn on/off LEDs depending on the state read
  for (int i = 0; i < NUM_LEDS; i++) {
    if (pinStates[i] == HIGH) {
      digitalWrite(ledPins[i], HIGH);
    }  else {
      digitalWrite(ledPins[i], LOW);
    }
  }
}
