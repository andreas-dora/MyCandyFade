class RadioButton{
    
  float x;
  float y;
  float w;
  float h;
  float f;
  int gridI; // Für die Hilfseintragung in der Taste * Rückgabe des Tastenbehls an die
  int gridJ; // globalen Variablen buttonFunktionI + buttonFunktionJ
  int transp; // für mouseOver
  String header = ""; // Für jeden Button muss erstmal ein (leerer String vorhanden sein.
  Boolean buttonActive = false;   // In void header wird gegen den neuen Inhalt ausgetauscht.
  color actCol;

  
  
  RadioButton(float tempX, float tempY, float tempW, float tempH, int gridI_, int gridJ_){
    x = tempX+offset/2;
    y = tempY+offset/2;
    w = tempW-offset;
    h = tempH-offset;
    gridI = gridI_;
    gridJ = gridJ_;
  

    

  }
  void header(String header_,  boolean act_, color actCol_){
    header = header_;
    buttonActive = act_;
    actCol = actCol_;
}
  
    boolean contains(float mx, float my){
    if(mx > x && mx <  x +w && 
    my >  y && my < y+h){
    return true;
    } else {
      return false;
    }
  }
  
   void display(float mx, float my ){
    if (contains(mx, my)){
      transp = 120;
    } else { 
      transp = 30;
    }
    if(buttonActive){
      stroke(actCol);
    } else {
   stroke(uiColor[2]);
    }
    fill(uiColor[3],transp);
    rect(x,y,w,h );
  //   rect(x + offset/2,y +offset/2,w - offset,h - offset);
    textFont(f1, 10);
    fill(uiColor[0]);
    text("["+gridI+"]["+gridJ+"]", x +offset, y + h-offset); 
    textFont(f1, 14);
    text(header,x +offset/2, y +offset*2); 
   // rect(x-offset/2,y-offset/2,w-offset/2,h-offset/2);

  }
  //  void isMouseOver(){
  //if(mouseX > x && mouseX <  x +w && 
  //mouseY >  y && mouseY < y+h){
  //mouseIsOver = true;
  //} else {
  //  mouseIsOver = false;
  //}
    
  //  if(mouseIsOver ==  true){
  //    transp = 150;
  //  } else {
  //    transp = 30;
  //  }
  //  }
    




 // void display(float mx, float my ){
 //   if (contains(mx, my)){
 //     fill(#E8C536);
 //   } else { 
 //     fill(0);
 //   }
 //   stroke(#E8C536);
 //   //fill(c);
 //   rect(x,y,w,h);
 //   fill(#E8C536);
 //   textAlign(CENTER);
 //   text(buttonText, x+w/2, y+h/2);
 // }
  
  
  void work(){
    buttonFunktionI = gridI;
    buttonFunktionJ = gridJ; 
    println(buttonFunktionI + " " +buttonFunktionJ);
  }
}
