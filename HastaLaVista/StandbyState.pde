// GEEN MENSEN IN DE BUURT => ANIMATIE OM TE STARTEN IN BEELD

import processing.video.*;

class StandbyState extends State
{

  Movie myMovie;

  boolean standbyDetected = false;

  public StandbyState()
  {
    println("Stand By State");
  }

  public void enterState( State oldState ) {
    message = 0;
    //         arduino.digitalWrite( LED_GEEL ,  );
    //         arduino.digitalWrite( LED_ROOD ,  );

    if (myMovie == null)
    {
      myMovie = new Movie( parent, "homeApplicatie.mpg");
    }
    myMovie.loop();
    
    backToStart();
  }

  public void doWhileInState()
  {
    if (isActivity2Detected ) {
      stateHandler.changeStateTo( WELKOM_STATE );
    } else {
      if ( myMovie.available() ) {
        image( myMovie, 0, 0, width, height );
        myMovie.read();
      }
    }
  }


  public void leaveState( State newState )
  {
    if ( myMovie != null ) {
      myMovie.stop();
    }
  }
}

