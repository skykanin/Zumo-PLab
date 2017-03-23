import controlP5.*;
import processing.serial.*;

Serial s;
ControlP5 cp5;

int button1X, button1Y, button2X, button2Y;
int button1W, button1H;
color buttonColor, baseColor;
Textfield myTextfield;

private PLabBridge pBridge;

private String received = null;

void bindPLabBridge (PLabBridge bridge) {

  pBridge = bridge;
  
  bridge.subscribeMessages (new PLabRecv() {
    public void receive (String string) {
      // code on BT receive goes here.
    }
  });
  size(bridge.getWidth(), bridge.getHeight());
}

void btWrite(String string) {
  if (pBridge != null) {
    pBridge.send(string);
  }
}

void setup(){
  s=new Serial(this, Serial.list()[0], 9900);
  
  size(400, 500);
 
  
  cp5 = new ControlP5(this);
  
 PFont font = createFont("arial", 30);
  textFont(font);
  cp5 = new ControlP5(this);
  myTextfield = cp5.addTextfield("Send or receive")
  .setPosition(50,50).setSize(300,50)
  .setFocus(true).setFont(font);
     
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
  
  //text(cp5.get(Textfield.class,"Send").getText(), 100, 200);
  //text(cp5.get(Textfield.class,"Motta").getText(), 360,130);
  
  if (mouseX > (button1X+30) && mouseX < (button1X+30)+100 && 
      mouseY > (button1Y+30) && mouseY < (button1Y+30)-50){
        String myText = myTextfield.getText();
        controlEvent(myText, "Set");
        println("GOTEM");
      }
      
  if (mouseX > (button2X+30) && mouseX < (button2X+30)+100 && 
      mouseY > (button2Y+30) && mouseY < (button2Y+30)-50){
        String myText = myTextfield.getText();
        controlEvent(myText, "Get");
        println("GOTEM");
      }
}

public void clear() {
  cp5.get(Textfield.class,"Send").clear();
  cp5.get(Textfield.class,"Motta").clear();
}

void controlEvent(String text, String info) {
  s.write(info + " " + text);
}