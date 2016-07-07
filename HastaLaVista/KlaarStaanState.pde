// KLAAR STAAN!!

class KlaarStaanState extends State
{

      public void enterState( State oldState ){
        message = 2;
      }
    
      public KlaarStaanState()
      {
          println("Klaar Staan State");
      }
    
      public void doWhileInState()
      {
        background(0);
        klaarStaan.loop();
        klaarStaan.read();
        image(klaarStaan, 0, 0, width, height);
        
      if(stateHandler.secondsInState() >= 15){
        klaarStaan.stop();
        stateHandler.changeStateTo( DANSEN_STATE );
      }
      
    }
}
