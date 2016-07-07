// BEDANKT & TOT ZIENS!!

class TotZiensState extends State
{

      public void enterState( State oldState ){
        background(0);
      }
    
      public TotZiensState()
      {
          println(" Tot Ziens State ");
      }
    
      public void doWhileInState()
      {
        backToStart();
        textSize(32);
        text("Bedankt en groetjes!!", width/4, height/4);
        
      if(stateHandler.secondsInState() > 2)
      {
        stateHandler.changeStateTo( STANDBY_STATE );
      }
      
    
    }
}
