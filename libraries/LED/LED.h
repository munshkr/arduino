/*
  LED.h - Library for LEDs
  Created by Damián Silvani, November 2, 2011.
  Released into the public domain.
*/
#ifndef __LED_H__
#define __LED_H__

#include <WProgram.h>
#include <QueueList.h>

class Animation {};

class FlashAnimation : Animation {
  public:
    int onTime;
    int offTime;
};

class LED {
  public:
    LED(int pin);
    void on();
    void off();
    void flash(int onTime, int offTime);

    void update();

  private:
    int  _pin;
    long _lastMs;
    QueueList<Animation> _queue;
};

#endif
