// UITLEG IN BEELD OVER HOE ONZE INSTALLATIE WERKT

class UitlegState extends State
{

  public UitlegState()
  {
    println( "Uitleg State" );
  }

  public void enterState( State oldState)
  {
    image(uitlegImage, 0, 0, width, height);
    backToStart();
  }

  public void doWhileInState()
  {
    backToStart();
    if ( isButtonPressed && ! wasButtonPressed )
    {
      //show image: ga op start staan en bereid je voor.        
      stateHandler.changeStateTo( KLAAR_STAAN_STATE ) ;
    }
    //kinect start track
    //        if( /* iemand is getrackt */ )
    //        {
    //        //go to dansen_state
    //        stateHandler.changeStateTo( DANSEN_STATE ) ;
    //        }

    if ( isButton2Pressed && ! wasButton2Pressed ) {
      //         arduino.digitalWrite( LED_ROOD , HIGH );
      stateHandler.changeStateTo( WELKOM_STATE );
    }
  }
}

