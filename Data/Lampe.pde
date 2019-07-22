class Lampe{
  
  float x;
  float y;
  float w;
  float h;
  float f;
  float fSpeed;
  float shrink;
  float maxShrink;

   int c;

  
  
  Lampe(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    maxShrink = tempH/2;
 
  }
  
  void displayOn(float tempF, int tempC){
        f = tempF;
        c = tempC;
        
        if(directOffEnable){
        noStroke();
        if(blackOutEnable){
          fill(0);
        } else {
       fill(col[c], f);
       
      rect(x,y,w,h);
        }
        }

  }
  
   void fade(float tempSpeed){
        fSpeed = tempSpeed;
        if(f > 0){
          f = f - fSpeed;
        }
   }
   
      void bootomShrink(float shrink_){
        shrink = shrink_;
        if(h < maxShrink){
          h =  - shrink;
        }
   }

  void stat(){
  noStroke();
  if(blackOutEnable){
    fill(0);
  } else {
  fill(col[c], f);
  rect(x,y,w,h);
  }
}
  void displayGrid(){
  stroke(uiColor[2]);
 
  noFill();
  rect(x,y,w,h);
}
}
