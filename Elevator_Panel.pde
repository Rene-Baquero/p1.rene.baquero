/* @pjs preload="ArrivedAt.wav","BasementFloor.wav","BellButton.wav","CallButton.wav","CloseButton.wav","DoorsClosing.wav","DoorsOpening.wav","Elevator Image.png", "Floor1.wav","Floor2.wav","Floor3.wav","OpenButton.wav","Pressed.wav","Selected.wav"; */
import processing.sound.*;
PImage bkg;
int buttonSize = 61;
int previousFloor = 2;
int currentfloor = 2;
int floorsToMove = 0;
int timeToMove = 0;
String floorDisplay = "0";
boolean moving = false;
boolean newFloor = false;
boolean up = false;
int destFloor = 123;


//Over Button Bools
boolean callButton = false;
boolean bellButton = false;
boolean threeButton = false;
boolean twoButton = false;
boolean oneButton = false;
boolean basementButton = false;
boolean openButton = false;
boolean closeButton = false;

// Timers
int moveStart;
int movePassed;
int startTime;
int passedTime;

// Colors
color selectedColor, unselectedColor;
color callColor, bellColor, threeColor, twoColor;
color oneColor, basementColor, openColor, closeColor;

//Sound Files
SoundFile arrivedAt, pressed, selected;
SoundFile floorOne, floorTwo, floorThree, floorBase;
SoundFile call, close, open, bell;
SoundFile doorsOpening, doorsClosing;

void setup() {
  bkg = loadImage("Elevator Image.png");
  size(680, 946);
  selectedColor = color(255, 0, 0);
  unselectedColor = color(194);
  callColor = bellColor = threeColor = twoColor = unselectedColor;
  oneColor = basementColor = openColor = closeColor = unselectedColor;
  
  //Sound Setup
  arrivedAt = new SoundFile(this,"ArrivedAt.wav");
  pressed = new SoundFile(this,"Pressed.wav");
  selected = new SoundFile(this,"Selected.wav");
  floorOne = new SoundFile(this,"Floor1.wav");
  floorTwo = new SoundFile(this,"Floor2.wav");
  floorThree = new SoundFile(this,"Floor3.wav");
  floorBase = new SoundFile(this,"BasementFloor.wav");
  call = new SoundFile(this,"CallButton.wav");
  close = new SoundFile(this,"CloseButton.wav");
  open = new SoundFile(this,"OpenButton.wav");
  bell = new SoundFile(this,"BellButton.wav");
  doorsOpening = new SoundFile(this,"DoorsOpening.wav");
  doorsClosing = new SoundFile(this,"DoorsClosing.wav");
}

void draw() {
  
  // Background
  background(152,190,100);
  bkg.resize(680,0);
  image(bkg,0,0);
  
  //Update
  update(mouseX, mouseY);
  
  // Floor Number
  textSize(126);
  fill(255,0,0);
  if(currentfloor-1 == 0)
    floorDisplay = "0B";
  else
    floorDisplay = "0" + Integer.toString(currentfloor-1);
  text(floorDisplay, 278, 124);
  if(previousFloor!=currentfloor && currentfloor == destFloor) newFloor = true;
  previousFloor = currentfloor;
  
  //Buttons
  strokeWeight(2);
  noFill();
  stroke(callColor);
  circle(239, 331, buttonSize); // Call
  stroke(bellColor);
  circle(439, 331, buttonSize); // Bell
  stroke(threeColor);
  circle(157, 448, buttonSize); // 3
  stroke(twoColor);
  circle(157, 547, buttonSize); // 2
  stroke(oneColor);
  circle(157, 647, buttonSize); // 1
  stroke(basementColor);
  circle(158, 748, buttonSize); // B
  stroke(openColor);
  circle(273, 865, buttonSize); // Open
  stroke(closeColor);
  circle(406, 863, buttonSize); // Close
}

void update(int x, int y) {
  if ( overCircle(239, 331, buttonSize) ) {
    if(!callButton) call.play();
    callButton = true;
  } else if ( overCircle(439, 331, buttonSize) ){
    if(!bellButton) bell.play();
    bellButton = true;
  } else if ( overCircle(157, 448, buttonSize) ){
    if(!threeButton) floorThree.play();
    threeButton = true;
  } else if ( overCircle(157, 547, buttonSize) ){
    if(!twoButton) floorTwo.play();
    twoButton = true;
  } else if ( overCircle(157, 647, buttonSize) ){
    if(!oneButton) floorOne.play();
    oneButton = true;
  } else if ( overCircle(158, 748, buttonSize) ){
    if(!basementButton) floorBase.play();
    basementButton = true;
  } else if ( overCircle(273, 865, buttonSize) ){
    if(!openButton) open.play();
    openButton = true;
  } else if ( overCircle(406, 863, buttonSize) ){
    if(!closeButton) close.play();
    closeButton = true;
  } else {
      callButton = false;
      bellButton = false;
      threeButton = false;
      twoButton = false;
      oneButton = false;
      basementButton = false;
      openButton = false;
      closeButton = false;
  }
  
  // Open and close
  passedTime = millis() - startTime;
  if(passedTime > 800){
    closeColor = unselectedColor;
    openColor = unselectedColor;
    passedTime = 0;
  }
  
  // Move Floors
  if(threeColor == selectedColor && currentfloor != 4 ){
    destFloor = 4;
    timeToMove = 2000;
    if(!moving){
      floorsToMove = 4 - currentfloor;
      moveStart = millis();
      moving = true;
    }
    movePassed = millis()-moveStart;
    if(movePassed > timeToMove && floorsToMove != 0){
      timeToMove = 0;
      movePassed = 0;
      moveStart = millis();
      floorsToMove = floorsToMove - 1;
      currentfloor = currentfloor+1;
    }
  }
  
  if(oneColor == selectedColor && currentfloor != 2 ){
    destFloor = 2;
    timeToMove = 2000;
    if(!moving){
      if(currentfloor > 2){
        floorsToMove = currentfloor - 2;
        up = false;
      }else if (currentfloor < 2){
        floorsToMove = 2 - currentfloor;
        up = true;
      }
      moveStart = millis();
      moving = true;
    }
    movePassed = millis()-moveStart;
    if(movePassed > timeToMove && floorsToMove != 0){
      timeToMove = 0;
      movePassed = 0;
      moveStart = millis();
      floorsToMove = floorsToMove - 1;
      if(up)
        currentfloor = currentfloor+1;
      else if(!up)
        currentfloor = currentfloor-1;
    }
  }
  
  if(twoColor == selectedColor && currentfloor != 3 ){
    destFloor = 3;
    timeToMove = 2000;
    if(!moving){
      if(currentfloor > 3){
        floorsToMove = currentfloor - 3;
        up = false;
      }else if (currentfloor < 3){
        floorsToMove = 3 - currentfloor;
        up = true;
      }
      moveStart = millis();
      moving = true;
    }
    movePassed = millis()-moveStart;
    if(movePassed > timeToMove && floorsToMove != 0){
      timeToMove = 0;
      movePassed = 0;
      moveStart = millis();
      floorsToMove = floorsToMove - 1;
      if(up)
        currentfloor = currentfloor+1;
      else if(!up)
        currentfloor = currentfloor-1;
    }
  }
  
  if(basementColor == selectedColor && currentfloor != 1 ){
    destFloor = 1;
    timeToMove = 2000;
    if(!moving){
      floorsToMove = currentfloor - 1;
      moveStart = millis();
      moving = true;
    }
    movePassed = millis()-moveStart;
    if(movePassed > timeToMove && floorsToMove != 0){
      timeToMove = 0;
      movePassed = 0;
      moveStart = millis();
      floorsToMove = floorsToMove - 1;
      if(up)
        currentfloor = currentfloor+1;
      else if(!up)
        currentfloor = currentfloor-1;
    }
  }
  
  if(newFloor){
    arrivedAt.play();
    delay(500);
    if(destFloor == 4)
      floorThree.play();
    else if(destFloor == 3)
      floorTwo.play();
    else if(destFloor == 2)
      floorOne.play();
    else if(destFloor == 1)
      floorBase.play();
    delay(500);
    doorsOpening.play();
    delay(1000);
    doorsClosing.play();
    delay(500);
    destFloor = 123;
    newFloor = false;
    moving = false;
    timeToMove = 0;
    floorsToMove = 0;
    threeColor = oneColor = twoColor = basementColor = unselectedColor;
  }
}

void mousePressed() {
  if (callButton & (callColor == unselectedColor)) {
    callColor = selectedColor;
    call.play();
    delay(600);
    pressed.play();
    delay(1000);
  } else if (bellButton & (bellColor == unselectedColor)){
    bellColor = selectedColor;
    bell.play();
    delay(600);
    pressed.play();
  } else if (threeButton & (threeColor == unselectedColor)){
    threeColor = selectedColor;
    floorThree.play();
    delay(600);
    selected.play();
  } else if (twoButton & (twoColor == unselectedColor)){
    twoColor = selectedColor;
    floorTwo.play();
    delay(600);
    selected.play();
  } else if (oneButton & (oneColor == unselectedColor)){
    oneColor = selectedColor;
    floorOne.play();
    delay(600);
    selected.play();
  } else if (basementButton & (basementColor == unselectedColor)){
    basementColor = selectedColor;
    floorBase.play();
    delay(600);
    selected.play();
  } else if (openButton & (openColor == unselectedColor)){
    openColor = selectedColor;
    open.play();
    delay(600);
    pressed.play();
    startTime = millis();
  } else if (closeButton & (closeColor == unselectedColor)){
    closeColor = selectedColor;
    close.play();
    delay(600);
    pressed.play();
    startTime = millis();
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
