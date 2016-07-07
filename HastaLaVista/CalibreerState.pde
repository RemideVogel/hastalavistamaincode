// CALIBREREN VAN DE KINECT VOOR DE HIGHSCORES

class Calibreerstate extends State
{

    
      public void enterState( State oldState ){

      }
    
      public Calibreerstate()
      {
        println("Foto State");
      }
    
      public void doWhileInState()
      {
        background(0);
        
          if(mousePressed)
          {
            println("Mouse X = " + mouseX);
            println("Mouse Y = " + mouseY);
            
          }
        
      if ( isButtonPressed && ! wasButtonPressed ) {
      if ( isButton2Pressed && ! wasButton2Pressed ) {
          
        stateHandler.changeStateTo( NAAM_EN_FOTO_STATE );
      }
    }
  }
}
