// KOM ANDERS EVEN BINNEN, LEKKER CORONATJE DOEN!

class KomBinnenState extends State
{

    
      public void enterState( State oldState ){

      }
    
      public KomBinnenState()
      {
          println("Kom Binnen State");
      }
    
      public void doWhileInState()
      {
        backToStart();
        background(0,0,255);
        
      if(stateHandler.secondsInState() > 20)
      {
        stateHandler.changeStateTo( STANDBY_STATE );
      }
      
      if(isButtonPressed && ! wasButtonPressed)
      {
        stateHandler.changeStateTo( STANDBY_STATE );
      }
      
        image(KomBinnen,0,0,width,height);
    }
}
