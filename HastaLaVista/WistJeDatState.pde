// WIST JE DAT?? - FEITJES ENZO

class WistJeDatState extends State
{

    
      public void enterState( State oldState ){

      }
    
      public WistJeDatState()
      {
          println("Wist je dat State");
      }
    
      public void doWhileInState()
      {
        backToStart();
        background(0,255,0);
        
      if ( isButtonPressed && ! wasButtonPressed ) 
      {
        stateHandler.changeStateTo( KOM_BINNEN_STATE );
      }
      
        textSize(32);
        text("Feitjes!", width/4, height/4);
    }
}
