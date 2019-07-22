class Timer{
  
  int savedTime;
  int totalTime;
  
  Timer(){
    
  }
  
  void start(int tempTotalTime){
    totalTime = tempTotalTime;
    savedTime = millis();
  }
  
  boolean isFinished(){
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
  
}
