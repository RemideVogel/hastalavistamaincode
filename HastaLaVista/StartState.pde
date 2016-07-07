// Wachten tot de beide PIR's veranderen

import processing.video.*;

class StartState extends State
{
    boolean wasActivity1Detected;
    boolean wasActivity2Detected;
    boolean isActivity1Active;
    boolean isActivity2Active;
    
    
    public StartState()
    {
       super("Start state");
    }
    
    public void enterState( State oldState ){
        message = 0;
        wasActivity1Detected = isActivity1Detected;
        wasActivity2Detected = isActivity2Detected;
        isActivity1Active = false;
        isActivity2Active = false;
    }
    
    public void doWhileInState()
    {
      if ( wasActivity1Detected != isActivity1Detected ) {
        isActivity1Active = true;
      }
      if ( wasActivity2Detected != isActivity2Detected ) {
        isActivity2Active = true;
      }
       if (isActivity2Active ) {
         stateHandler.changeStateTo( STANDBY_STATE );
       }
    }
}
