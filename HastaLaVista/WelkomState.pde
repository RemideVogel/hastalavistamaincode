// EEN WELKOM WOORDJE NAAR DE GEBRUIKER TOE

class WelkomState extends State
{
  

  
    public WelkomState()
    {
        println( "Welkom State" );

    }
    
    public void enterState( State oldState ) {
        image(welkomImage, 0, 0, width, height);
        
    }
    
    public void doWhileInState()
    {
      backToStart();
      
      if ( isButtonPressed && ! wasButtonPressed ) 
      {
//             arduino.digitalWrite( LED_GEEL , Arduino.HIGH );
             stateHandler.changeStateTo( UITLEG_STATE );
      }
      
//      if ( isButton2Pressed && ! wasButton2Pressed ) 
//      {
////             arduino.digitalWrite( LED_ROOD , Arduino.HIGH );
//             stateHandler.changeStateTo( STANDBY_STATE );
//      }
        
      
//      if ( stateHandler.milliSecondsInState() % 1000 < 500 ) {
//          background( 0 ,   0, 255 );
//      } else {
//           background( 0 , 255, 255 );
//      }
    }
}
