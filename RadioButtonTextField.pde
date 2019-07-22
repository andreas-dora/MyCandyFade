class RadioButtonTextField{
   
  float x;
  float y;
  float w;
  float h;
  float f;

  
  
  RadioButtonTextField(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    w = tempH;
  }
  
  void display(){
    stroke(uiColor[0]);
    fill(uiColor[3]);
    rect(x,y,w,h);
  }
}
