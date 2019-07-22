class BottomShutter {
  
  
  float x;
  float y;
  float w;
  float h;
  float f;
  float closingSpeed;
  float oSpeed;
  float closedPosition;
  int shades = 6;
  float shadesH; // x/shades
  boolean shutterIsOpen = false;


   int c;

  
  
  BottomShutter(float tempX, float tempY, float tempW, float tempClosedPosition){
    x = tempX;
    y = tempY;
    w = tempW;
    // Wenn nur ein Shutter aktiv ist, muss dieser die ganze Lampe abdecken
    // Sind beide Shutter aktiv müssen sie nur die hälfte der Lampe schließen.
   // shadesH =tempX/shades;
   // closedPosition =  closedPosition_/2;
   h = tempClosedPosition;

    closedPosition = tempClosedPosition;
    
      
      
 
  }
  
  void opening(float tempSpeed){
    oSpeed = tempSpeed;
    if( h > 0){
      h =-oSpeed;
      h = constrain(h, 0, closedPosition);
    } else if(h <= 0){
      h = 0;
      shutterIsOpen = true;
    }
      
    
    
     
  }
  
   void closing(float cSpeed_){
     closingSpeed = cSpeed_;
     if(shutterIsOpen){
        if(h < closedPosition){
          h = h + closingSpeed;
        } else if (h >= closedPosition){
          shutterIsOpen = false;
     }
   }
   }
   void display(){
     noStroke();

     fill(0);
     rect(x,y,w,-h);
   
   }
}
  //   noStroke();
  
  //for(int i = shades; i > 0; i--){
  //  fill(0, 70);
  //  rect(x,y ,w, h +(shadesH*i) );
  //}

    

  //   noStroke();
  
  //for(int i = shades; i > 0; i--){
  //  fill(0, 70);
  //  rect(x,y ,w, h +(shadesH*i) );
  //}

  
//  float x;
//  float y;
//  float w;
//  float h;
//  float ShutterH;
//  float f;
//  float closingSpeed;
//  float openingSpeed;
//  float closedPosition;
//  float openPosition;
//  int shades = 6;
//  float shadesH; // x/shades



//  int c;



//  BottomShutter(float tempX, float tempY, float tempW, float tempH) {
//    x = tempX;
//    y = tempY;
//    w = tempW;
//    // Wenn nur ein Shutter aktiv ist, muss dieser die ganze Lampe abdecken
//    // Sind beide Shutter aktiv müssen sie nur die hälfte der Lampe schließen.
//    shadesH =tempX/shades;
//    closedPosition =  tempH;
//ShutterH = tempH;
//    h = tempH;
//  }

//  void opening(float open_) {
//    //openingSpeed =oSpeed_;
//   if ( h >= 0) {
 
//     h -= open_;
//   } else if (h<= ShutterH){
//     h+=2;
//   }
     
//  }

//  void closing(float cSpeed_) {
//    closingSpeed = cSpeed_;
//    if (h < closedPosition) {
//      h = h + closingSpeed;
//    }
//  }
//  void display() {


//    noStroke();

//    //for(int i = shades; i > 0; i--){
//    //  fill(0, 60);
//    //  rect(x,y ,w,-h -(shadesH*i) );
//    //}
//    fill(50);
//    rect(h, y, w, x );
//    //filter(blur);
//  }
//}
