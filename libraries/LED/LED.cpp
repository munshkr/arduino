#include "LED.h"

LED::LED(int pin) {
  pinMode(pin, OUTPUT);
  _pin = pin;
}

void LED::on() {
  digitalWrite(_pin, HIGH);
}

void LED::off() {
  digitalWrite(_pin, LOW);
}

void LED::flash(int onTime, int offTime) {

}

void LED::update() {

}
