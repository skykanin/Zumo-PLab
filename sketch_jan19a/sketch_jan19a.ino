/*
 */

#include <SoftwareSerial.h>
#include <PLabBTSerial.h>

#define txPin 2  // Tx pin on Bluetooth unit
#define rxPin 3  // Rx pin on Bluetooth unit


PLabBTSerial btSerial(txPin, rxPin);
void setup()
{
    Serial.begin(9600);
    btSerial.begin(9600);
}

void loop() {
  int availableCount = btSerial.available();
  if (availableCount > 0) {
    char text[availableCount + 1];
    text[availableCount] = '\0';
    btSerial.read(text, availableCount);
    int index;
    int textSize = sizeof(text) - 1;
    for (int i = 0; i < textSize; i++){
      if (text[i] == ' '){
        index = i;
        break;
      }
    }
    char commandType[index + 1];
    commandType[index] = '\0';
    for (int i = 0; i < index; i++){
      commandType[i] = text[i];
    }
    int commandSize = sizeof(commandType) - 1;
    char commandContent[textSize - commandSize - 1];
    for (int i = 0; i < textSize - 1 - commandSize; i++){
      commandContent[i] = text[i + commandSize + 1];
    }
    commandContent[sizeof(commandContent) - 1] = '\0';
    readCommand(commandType, commandContent);
  };
}

void readCommand(char *type, char *content){
  int contentSize = 0;
  for (int i = 0; i < 20; i++){
    if (content[i] == '\0'){
      contentSize = i;
      break;
    }
  }
  if (0 == strcmp("set\0", type)){
    int index;
    for (int i = 0; i < contentSize; i++){
      if (content[i] == ' '){
          index = i;
          break;
        }
    }
    char var[index + 1];
    var[index] = '\0';
    for (int i = 0; i < index; i++){
      var[i] = content[i];
    }
    int varSize = sizeof(var) - 1;
    char val[contentSize - varSize];
    for (int i = 0; i < contentSize - 1 - varSize; i++){
      val[i] = content[i + varSize + 1];
    }
    val[sizeof(val) - 1] = '\0';
    int num = atoi(val);
    Serial.println(type);
    Serial.println(var);
    Serial.println(num);
  }
  else if(0 == strcmp("get\0", type)){
    Serial.println(2);
  }
}
