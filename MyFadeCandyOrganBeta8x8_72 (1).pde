OPC opc;
PFont f1, f2;
PImage flames;
float theta = 0.0;
int cols = 8; // Anzhal der Lampen in einer Reihe
float wScale;  // Die Lampen in der Breite anpassen
float hScale; //Die Lampen in der Höhe anpassen

Lampe[] meineLampe = new Lampe[8];
TopShutter[] myTopShutter = new TopShutter[8];
BottomShutter[] myBottomShutter = new BottomShutter[8];
RadioButton[][] myRadioButton; 
//RadioButtonTextField[] myRadioButtonTextField = new RadioButtonTextField[12];
String[] radioButtonGroupTitel = new String[12];
String[] message = new String[8];
Timer timer;
boolean topShutterEnable = false;
boolean bottomShutterEnable = false;
boolean fadeEnable = true;
boolean directOffEnable = false; 
boolean showGridDisable = true;
boolean blackOutEnable =  false;
boolean shrinkEnable; //vertical fadeout
boolean shrinkTopEnable; //vertical fadeout
boolean shrinkBottomEnable; //vertical fadeout
boolean imageEnable = false;
boolean secondMemberEnable = false;
boolean isNeverActive = false;
boolean messageEnable = false;

color[] col = new color[9];
color[] uiColor = new color[7]; // Die Farben für das User Interface

String[] cName = new String [9];
int step0 = 0;
int step1 = 1;
int step2 = 2;
int step7 = 7;

int charNumber =0;


int brightness; 

int bpm;
int speed;
float fade;
float shrinkSpeed;
float shutterOpeningSpeed;
float shutterClosingSpeed;
//------------------------------------------------------------
//-----------  Positionierung der Lampen (Grid) im Display
int LampeGridX;
int LampeGridY;
int LampeGridW;
int LampeGridH;

float LampeGridScaleW; // Teilt die einezelnen Lampen auf die Zugewiesene Fläche auf
float LampeGridScaleH;

int offset = 10;

int uiBackgroundY;
int radioButtonH;

float buttonGridX;
float buttonGridY;
float buttonGridW;
float buttonGridH;


int buttonCols = 4;
int buttonRows = 7;
float buttonX;
float buttonY;
float buttonW;
float buttonH;
boolean mouseIsOver = false;
int buttonFunktionI;
int buttonFunktionJ;
//------------------------------------------------------------

int colorCount;
int chaserCount;
int messageCount =0;
int chaser;
int cc; // Hauptfarbe
int backgCol; // Hintergrundfarbe 
int lBright = 80; // Helligkeit Hauptfarbe
int bBright; // Helligkeit Hintergrundfarbe
int brightPercent;

//------------------------------------------------------
//------------------------------------------------------


void setup() {
  size(900, 600, P3D);
  f1 = createFont("Courier", 16);
  f2 = createFont("Lightdot-8x8.ttf", 64);
  flames = loadImage("flamesKl.jpeg");
  
  message[0] ="Get into it";
  message[1] ="Get the Kick of it";
  message[2] ="Get the taste of it";
  message[3] ="Get the smell of it";
  message[4] ="Get right on it";
  message[5] ="Ernie Ernie Berta Tango Foxtrot";
  message[6] ="The Quick Brown Fox jumps over the lazy Dog";
  message[7] ="TRACK ID PLZ";



  wScale = width / cols;
  hScale = height/ 3 ;


  bpm = 128;
  speed = round(60000 / bpm);
  shutterOpeningSpeed = 2;


  fade = 3.0;
  shrinkSpeed = 0.5; //vertical fade

  colorCount = 0;
  cc = 0;
  backgCol = 0;
  chaserCount = 0;
  chaser = 0;
  //------------- Farben -----------

  uiColor[0] = color(#FFD700); // Gold
  uiColor[1] = color(#DAA520); // GoldenRod
  uiColor[2] = color(#B8860B); // DarkGoldenRod
  uiColor[3] = color(#003B4D); // Dunkelblau
  uiColor[4] = color(#003B4D)/60; // Dunkelblau

  uiColor[5] = color(#E81005); // Rot
  uiColor[6] = color(#04B22A); // Grün

  col[0] = color(#00BFFF); // DeepSkyBlue
  col[1] = color(#FFD700); // Gold
  col[2] = color(#FF453B); // SpringGreen
  col[3] = color(#DC143C); // Crimson
  col[4] = color(#6A5ACD); //   SlateBlue
  col[5] = color(#FF8C00);  // dark Orange
  col[6] = color(#00FFFF); // Aqua
  col[7] = color(#EE82EE); // Violet
  col[8] = color(#FFDAB9); // PeachPuff

  cName[0] = "DeepSkyBlue";
  cName[1] = "Gold";
  cName[2] = "SpringGreen";
  cName[3] = "Crimson";
  cName[4] = "SlateBlue";
  cName[5] = "dark Orange";
  cName[6] = "Aqua";
  cName[7] = "Violet";
  cName[8] = "PeachPuff";

  bBright = 30;
  brightPercent = round(lBright/255*100);

  //------------- Positionen -----------

  LampeGridX = offset;
  LampeGridY = offset;
  LampeGridW = height/3;
  LampeGridH = height/3;

  LampeGridScaleW = LampeGridW/cols;
  // LampeGridScaleH = height/3;

  uiBackgroundY = 2* offset + LampeGridH;
  opc = new OPC(this, "127.0.0.1", 7890);

  buttonGridX = width/2 + 2*offset;
  buttonGridY = height/3 + 2*offset;
  buttonGridW = (width/2)- 3*offset;
  buttonGridH = ((height/3)*2) - 3*offset;

  buttonX = buttonGridX;
  buttonY = buttonGridY;
  buttonW = buttonGridW / buttonCols;
  buttonH = buttonGridH / buttonRows;

  //-------------------------------------------------


  myRadioButton = new RadioButton[buttonCols][buttonRows];

  for (int i = 0; i < cols; i++) {
    meineLampe[i] = new Lampe(i*LampeGridScaleW +LampeGridX, LampeGridY, LampeGridScaleW, LampeGridH);
    opc.ledStrip(i*8, 8, i*LampeGridScaleW+LampeGridScaleW/2+LampeGridX, LampeGridY +(LampeGridH/2), LampeGridH / 8.0, HALF_PI, true);
    myTopShutter[i] = new TopShutter(i*LampeGridScaleW +LampeGridX, LampeGridY, LampeGridScaleW, LampeGridH/2);
    myBottomShutter[i] = new BottomShutter(i*LampeGridScaleW +LampeGridX, LampeGridY+LampeGridH, LampeGridScaleW, LampeGridH/2);
  }
  for (int i = 0; i < buttonCols; i++) {
    for (int j = 0; j < buttonRows; j++) {
      myRadioButton[i][j] = new RadioButton(buttonX + buttonW*i, buttonY + buttonH*j, buttonW, buttonH,i,j);
    }
  }

  timer = new Timer();
  timer.start(speed);
  buttonText();
  
    println("ButtonGrid Width & Height: " +buttonGridW + " " + buttonGridH);
    println("Button Width & Height: " +buttonW + " " + buttonH);


}
//----------------------------------------------------------------------
//----------------------------------------------------------------------
void buttonText(){
  myRadioButton[0][0].header("BPM +", isNeverActive, uiColor[2]);
  myRadioButton[0][1].header("BPM -", isNeverActive, uiColor[2]);
  myRadioButton[0][3].header("Message", messageEnable, uiColor[6]);

  myRadioButton[0][4].header("Picture", imageEnable, uiColor[6]);

  
  myRadioButton[1][0].header("Fade +", isNeverActive, uiColor[2]);
  myRadioButton[1][1].header("Fade -", isNeverActive, uiColor[2]);
  myRadioButton[1][2].header("FadeOn/Off", fadeEnable, uiColor[6]);
 

   
  myRadioButton[2][0].header("Bright.+",isNeverActive, uiColor[2]);
  myRadioButton[2][1].header("Bright.-", isNeverActive, uiColor[2]);
  myRadioButton[2][2].header("DirectOff", directOffEnable, uiColor[6]);
  myRadioButton[2][4].header("Blackout", blackOutEnable, uiColor[5]);

  
  myRadioButton[3][0].header("ShrinkSp+",isNeverActive, uiColor[2]);
  myRadioButton[3][1].header("ShrinkSp-", isNeverActive, uiColor[2]);
  myRadioButton[3][2].header("Top Sh.", topShutterEnable, uiColor[6]);
  myRadioButton[3][3].header("Bottom Sh", bottomShutterEnable, uiColor[6]);
  myRadioButton[3][4].header("ShowGrid", showGridDisable, uiColor[5]);



}
//----------------------------------------------------------------------
//----------------------------------------------------------------------

void draw() {
  background(0);

  
//-------Bild Positionieren
int flamesHeight = flames.height;


  // Scroll down slowly, and wrap around
  float flamesSpeed = 0.05;
  float flamesY = (millis() * -flamesSpeed) % flamesHeight;
  if (messageEnable){
    noStroke();
    fill(20,0,40);
  
    rect(offset, offset, 200, 200);
    textFont(f2, 200);
    fill(150, 60, 15);
    text(message[messageCount].charAt(charNumber), offset, 210);
    }
  if (imageEnable){
  // Use two copies of the image, so it seems to repeat infinitely  
    image(flames, offset, flamesY, LampeGridW, flamesHeight);
    image(flames, offset, flamesY + flamesHeight, LampeGridW, flamesHeight);
  }
  noStroke();
  fill(0);
  rect(0,0,width, offset);
  rect(0,0,offset, height);
rect(0, 210, width, height-210);
//-----------------------------

  for (int i = 0; i < meineLampe.length; i++) {
    if(!directOffEnable){
     meineLampe[i].stat();
    }
    if(fadeEnable){
      meineLampe[i].fade(fade);
    }
      if(shrinkBottomEnable){
      meineLampe[i].fade(shrinkSpeed);
    }// FADEgeschwindigkeit wird vererbt
   if(topShutterEnable){
    myTopShutter[i].display();
    myTopShutter[i].closing(2);
   }
   if(bottomShutterEnable){
    myBottomShutter[i].display();
    myBottomShutter[i].closing(2);
   }
    if(!showGridDisable){
      meineLampe[i].displayGrid();
    }
    

  }
  
  
  // Hier die Haupzündungen------------------------
  meineLampe[step0].displayOn(lBright, cc); 

  if(topShutterEnable){
    myTopShutter[step0].opening(3);
  } 
  if (bottomShutterEnable){
    myBottomShutter[step0].opening(3);
  }
  if(secondMemberEnable){
      meineLampe[step7].displayOn(lBright, cc); 

  if(topShutterEnable){
    myTopShutter[step7].opening(3);
  } 
  if (bottomShutterEnable){
    myBottomShutter[step7].opening(3);
  }
  }
    
    

  
  



  stroke(uiColor[2]);
  fill( col[0], 20);
  rect(offset, uiBackgroundY, width /2, height - 2*offset - uiBackgroundY ); // UI Linke Seite
 
  rect(buttonGridX, buttonGridY, buttonGridW, buttonGridH); //ButtonGrid rechte Seite
  
    for (int i = 0; i < buttonCols; i++) {
      for (int j = 0; j < buttonRows; j++) {

      myRadioButton[i][j].display(mouseX,mouseY);
    }
  }
  
  
  
  
  textFont(f1, 18);
  fill(uiColor[0]);


  text("Speed(a/s): " + bpm + " Bpm (" + speed +" ms)", 30, 240);
  text("Fade(y/x): " + fade, 30, 265);
  text("Brightness: " + brightPercent +" % ("+lBright +")", 15, 290);


  text("Color(f): " +cc + " " +cName[cc] + ", " + lBright + " %", 30, 315);
  text("Chaser(c): " + chaser, 30, 340);
  text("Background(f): " +backgCol + " " +cName[backgCol] + ", " + bBright + " %", 30, 365);
//------ TEST
fill(uiColor[5]);
  text("Mouse x: " +mouseX + " / Mouse y: " +mouseY, 15, 400); // Test
    text("Fade enalble : "+ fadeEnable, 15, 425); // Test

  text("Top Shutter enalble : "+ topShutterEnable, 15, 450); // Test
  text("Bottom Shutter enalble : "+ bottomShutterEnable, 15, 475); // Test
  text("Direct Off enalble : "+ directOffEnable, 15, 500); // Test
  text("FPS: " + frameRate, 15, 525);

  if (chaser == 0) {
    chaser0();
  } else if (chaser == 1) {
    chaser1();
  } else if (chaser == 2) {
    chaser2();
  } else if (chaser == 3) {
    chaser3();
  } else if (chaser == 4) {
    chaser4();
  }

  if (messageEnable){
    sendMessage();
  }


  //************************ 


  if (timer.isFinished()) {

    colorCount +=1;
    if (colorCount == meineLampe.length*2) {

      colorCount =0;
      cc +=1;
      if (cc >=col.length) {
        cc = 0;
      }
    }
     chaserCount +=1;
    timer.start(speed);
  }
    buttonText();
}

//********************************************
//********************************************

void sendMessage(){
  if (timer.isFinished()) {
    charNumber +=1;
    if (charNumber >= message[messageCount].length()) {
       charNumber = 0;
      messageCount +=1;
      chaser =4;
      blackOutEnable = false;
      topShutterEnable = true;
      bottomShutterEnable = true;
      messageEnable = false;
    }
  }
}





void chaser0() {
  secondMemberEnable = false;
   // meineLampe[step0].displayOn(lBright, cc);  
  //  myTopShutter[step0].opening(8);
  //  myBottomShutter[step0].opening( LampeGridH/2);
  if (timer.isFinished()) {
    step0 += 1;
    if (step0 >= meineLampe.length) {
      step0 = 0;
    }
    if (chaserCount == 15) {
      chaserCount = 0;
      chaser = 1;
      step0 = 0;
    }
  }
}

void chaser1() {
  secondMemberEnable = false;
  if (timer.isFinished()) {
    step0 += 1;
    step2 += 1;
    if (step2 >= meineLampe.length) {
      step0 = 0;
      step2 = 2;
    }
    //meineLampe[step0].displayOn(lBright, cc);  
    //meineLampe[step2].displayOn(lBright, cc);
  }
  if (chaserCount == 15) {
    chaserCount = 0;
    chaser = 2;
    step0 = 0;
    step2 = 2;
  }
}




void chaser2() {
  secondMemberEnable = true;

  if (timer.isFinished()) {
    step0 += 1;
    step7 -= 1;

    if (step0 >= meineLampe.length/2) {
      step0 = 0;
      step7 = 7;
    }
    //meineLampe[step0].displayOn(lBright, cc);  
    //meineLampe[step7].displayOn(lBright, cc);
  }

  if (chaserCount == 15) {
    chaserCount = 0;
    chaser = 3;
    step0 = 0;
    step7 = 7;
  }
}


void chaser3() {
  secondMemberEnable = true;


  if (timer.isFinished()) {
    step0 += 1;
    step7 -= 1;


    if (step0 >= 7) {
      step0 = 0;
      step7 = 7;
    }
    //meineLampe[step0].displayOn(lBright, cc);  
    //meineLampe[step7].displayOn(lBright, cc);
  }

  if (chaserCount == 15) {
    chaserCount = 0;
    chaser = 4;
    step0 = 0;
    step7 = 7;
  }
}


void chaser4() {
  secondMemberEnable = false;

  if (timer.isFinished()) {
    step0 = int(random(0, 7));
    //step7 = int(random(0,7));   
    //  if(step >= meineLampe.length){
    //    step = 0;
    //  }
    meineLampe[step0].displayOn(lBright, cc);  
    //  meineLampe[step7].displayOn(lBrigth, cc);
  }

  if (chaserCount == 15) {
    chaserCount = 0;
    chaser = 0;
    step0 = 0;
    step7 = 7;
  }
}
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
void keyPressed() {
  if (key == 'c') {
    chaserCount =15;
    colorCount =0;
    step0 = 0;
    step1 = 1;
    step2 = 2;
    step7 = 7;
  }
  if (key == 'f') {
    chaserCount =0;
    colorCount =15;
    step0 = 0;
    step1 = 1;
    step2 = 2;
    step7 = 7;
  }
}
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
void mousePressed(){
  for (int i = 0; i < buttonCols; i++) {
    for (int j = 0; j < buttonRows; j++) {

      if(myRadioButton[i][j].contains(mouseX,mouseY)){
        myRadioButton[i][j].work();
        println("Yeah!");
       buttonFunktion();
      }
    }
  }
}

////---------------------------------------------------------------------------------
////---------------------------------------------------------------------------------   


void buttonFunktion(){
  if(buttonFunktionI == 0){
    buttonFunktionI0();
  } else if (buttonFunktionI == 1){
    buttonFunktionI1();
  } else if (buttonFunktionI == 2){
    buttonFunktionI2();
  } else if (buttonFunktionI == 3){
    buttonFunktionI3();
  }
}

void buttonFunktionI0(){
  if(buttonFunktionJ == 0){
    bpm ++;
  } else if(buttonFunktionJ == 1){
    bpm --;
  } else if(buttonFunktionJ == 3){
    messageEnable = true;
    blackOutEnable = true;
    topShutterEnable =false;
    bottomShutterEnable =false;
    imageEnable = false;
  //  sendMessage();
  } else if(buttonFunktionJ == 4){
    imageEnable = !imageEnable;
    
  }else {
    println("Taste ist nicht belegt.");
  }
   speed = round(60000 / bpm);
}
  
void buttonFunktionI1(){
  if(buttonFunktionJ == 0){
    fade = fade + 0.1;
  } else if(buttonFunktionJ == 1){
    fade = fade -0.1;
  } else if(buttonFunktionJ == 2){
    fadeEnable = !fadeEnable;
  } else {
    println("Taste ist nicht belegt.");
  }
}
void buttonFunktionI2(){
  if(buttonFunktionJ == 0){
    lBright +=10;
    lBright = constrain(lBright, 0, 255);
    println(lBright);
    brightPercent = round((lBright/255)*100);

  } else if(buttonFunktionJ == 1){
    lBright -=10;
    lBright = constrain(lBright, 0, 255);
    brightPercent = round(lBright/255*100);

  } else if(buttonFunktionJ == 2){
    directOffEnable = !directOffEnable;
  } else if(buttonFunktionJ == 4){
    blackOutEnable = !blackOutEnable;
   } else {
    println("Taste ist nicht belegt.");
  }
}
void buttonFunktionI3(){
   if(buttonFunktionJ == 0){
    shrinkSpeed = shrinkSpeed + 0.5;
  } else if (buttonFunktionJ == 1){
    shrinkSpeed = shrinkSpeed - 0.5;
  } else if (buttonFunktionJ == 2){
    topShutterEnable = !topShutterEnable;
  } else if (buttonFunktionJ == 3){
    bottomShutterEnable = !bottomShutterEnable;
  } else if (buttonFunktionJ == 4){
    showGridDisable = !showGridDisable;
  }else {
 
    println("Taste ist nicht belegt.");
}
}

//  bpm++;
//}
//else if(funktion == 1){
//  bpm--;
//}
//else if(funktion == 2){
//  fade++;
//}
//else if(funktion == 3){
//  fade--;
//}
//}
