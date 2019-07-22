class TopShutter{
  
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

  
  
  TopShutter(float tempX, float tempY, float tempW, float tempClosedPosition){
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
     fill(0);
     noStroke();
     rect(x,y,w,h);
   
        

  //   noStroke();
  
  //for(int i = shades; i > 0; i--){
  //  fill(0, 70);
  //  rect(x,y ,w, h +(shadesH*i) );
  //}

   }
}
