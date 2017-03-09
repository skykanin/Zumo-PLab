/*
Drive forward and turn left or right when border is detected
  - Only reflectionsensor 0 and 5 are used.
*/
#include <ZumoMotors.h>
#include <Pushbutton.h>
#include <QTRSensors.h>
#include <ZumoReflectanceSensorArray.h>
#include <NewPing.h>

const int echoPin = 6;
const int triggerPin = 5;
const int maxDistance = 10;
 
NewPing sonar(triggerPin, echoPin, maxDistance);
 
#define LED 13
 
// this might need to be tuned for different lighting conditions, surfaces, etc.
#define QTR_THRESHOLD  1800 // 
  
// these might need to be tuned for different motor types
#define REVERSE_SPEED     250 // 0 is stopped, 400 is full speed
#define TURN_SPEED        300
#define FORWARD_SPEED     150
#define REVERSE_DURATION  200 // ms
#define TURN_DURATION     400 // ms
 
ZumoMotors motors;
Pushbutton button(ZUMO_BUTTON); // pushbutton on pin 12
 
#define NUM_SENSORS 6
unsigned int sensor_values[NUM_SENSORS];
 
ZumoReflectanceSensorArray sensors;


 
void setup()
{
   Serial.begin(9600);
   sensors.init();
   button.waitForButton();
}

void loop()
{
  unsigned int time = sonar.ping();
  float distance = sonar.convert_cm(time);
  sensors.read(sensor_values);

  Serial.println(distance);
  delay(50);

  if(!distance == 0.00){
    motors.setSpeeds(0, 0);
    } else {
        Serial.println("UNDER 10 DISTANCE");
        if (sensor_values[0] > QTR_THRESHOLD)
      {
        // if leftmost sensor detects line, reverse and turn to the right
        motors.setSpeeds(-REVERSE_SPEED, -REVERSE_SPEED);
        delay(REVERSE_DURATION);
        motors.setSpeeds(TURN_SPEED, -TURN_SPEED);
        delay(TURN_DURATION);
        motors.setSpeeds(FORWARD_SPEED, FORWARD_SPEED);
      }
      else if (sensor_values[5] > QTR_THRESHOLD)
      {
        // if rightmost sensor detects line, reverse and turn to the left
        motors.setSpeeds(-REVERSE_SPEED, -REVERSE_SPEED);
        delay(REVERSE_DURATION);
        motors.setSpeeds(-TURN_SPEED, TURN_SPEED);
        delay(TURN_DURATION);
        motors.setSpeeds(FORWARD_SPEED, FORWARD_SPEED);
      }
      else
      {
        // otherwise, go straight
        motors.setSpeeds(FORWARD_SPEED, FORWARD_SPEED);
      }
  }
  }
  
