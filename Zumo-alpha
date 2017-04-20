#include <NewServo.h>

//#include <PLab_ZumoMotors.h>
#include <Pushbutton.h>

#include <ZumoMotors.h>


NewServo myservo;
ZumoMotors motor;
Pushbutton button(ZUMO_BUTTON);


#define trigPin 3
#define echoPin 6
#define servoPin 2

int buttonState = 0;
long target_state = -1;
int sweep_direction = 1;
int sweep_distance = 30; //How far each way it sweeps
int target_pos = 90 ;
int turn_speed = 0 ;

long duration = 0 ;
long distance = 0;

void turn_right (){
  motor.setSpeeds(400,0) ;
}


void turn_left (){
  motor.setSpeeds(0,400) ;
}

void turn_straight (){
  motor.setSpeeds(400,400) ;
}

long target_check (){

  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2); 
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10); 
  digitalWrite(trigPin, LOW);
  
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) / 29.1;
  
  //MAX viewing distance --------------------------------------------------------------
  if (distance > 30) {
    distance = -1 ;
  }
  return distance;
}

void pos_check(){
        
      if ((target_pos >= (180) && (sweep_direction == 1))) {
       target_pos = 180 ;
       sweep_direction = -1;
       
      }else if ((target_pos <= 0) && (sweep_direction == -1)){
        
        target_pos = 0 ;
        sweep_direction = 1;
      }
}

int sweeper(){

  target_pos += sweep_distance*sweep_direction ;
  pos_check() ;
  myservo.write(target_pos);
  target_state = target_check();
  if (target_state != -1){
    sweep_direction = 1;
    return target_state ;
  }

  
  target_pos -= sweep_distance*2*sweep_direction ;
  pos_check() ;
  myservo.write(target_pos);
  target_state = target_check();
  if (target_state != -1){
    sweep_direction = -1;
    return target_state ;
  }
  return -1;
}


void target_find () {
  myservo.write(60);
  target_pos = 60;
  motor.setSpeeds(300,-300) ;
  
  while (target_state < 0){
   target_state = target_check();
  }
  
  motor.setSpeeds(400,400) ;
}
int radar(){
  delay(100);
  target_state = target_check();
  Serial.println(target_pos);

  if (target_state == -1){
    target_state = sweeper() ;
  }
  
  if (target_state == -1){
     target_find();
 
  }else if (target_state >= 0) {
    Serial.println("Target lock");

    if (target_pos < 60){
        Serial.println("wut??");
        turn_right();
    }else if (target_pos > 60){
        Serial.println("wut??");
        turn_left();
  
    }else {
      Serial.println("wut??");
        turn_straight(); 
    }  
  }else {
    Serial.println("wut??");
  }
  
   
}




void setup() {
  myservo.attach(servoPin);

  Serial.begin (9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
  Serial.println("Starting");
  myservo.write(90); 
  
  button.waitForButton();
  delay(100);
}


 
void loop() {
 radar() ;

}

