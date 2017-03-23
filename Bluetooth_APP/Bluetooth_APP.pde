import controlP5.*;
import processing.serial.*;

Serial s;
ControlP5 cp5;

int button1X, button1Y, button2X, button2Y;
int button1W, button1H;
color buttonColor, baseColor;

void setup(){
  s=new Serial(this, Serial.list()[0], 9900);
  
  size(400, 500);
  
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("Send")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
  cp5.addTextfield("Motta")
     .setPosition(20,170)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;

     
  textFont(font);
     
  buttonColor = (51);
  baseColor = (255);
  button1W = 100;
  button1H = 50;
  button1X = this.width/2 - (button1W/2) - 100;
  button1Y = this.height/2 - (button1H/2) + 50;
  button2X = this.width/2 - (button1W/2) + 100;
  button2Y = this.height/2 - (button1H/2) + 50;
  
}

void draw(){
  fill(buttonColor);
  stroke(255);
  rect(button1X, button1Y, button1W, button1H);
  rect(button2X, button2Y, button1W, button1H);
  
  textSize(26);
  fill(255, 102, 153);
  text("Set", button1X+30, button1Y+35);
  text("Get", button2X+30, button2Y+35); 
  
  text(cp5.get(Textfield.class,"Send").getText(), 100, 200);
  text(cp5.get(Textfield.class,"Motta").getText(), 360,130);
}

public void clear() {
  cp5.get(Textfield.class,"Send").clear();
  cp5.get(Textfield.class,"Motta").clear();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}

public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+ theText);
}