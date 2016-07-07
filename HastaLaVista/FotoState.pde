// DE MENSEN MOETEN EERST NAAR DE INSTALLATIE TERUG KOMEN, DAARNA WORDT DE FOTO GEMAAKT



class FotoState extends State
{        
      
      public void enterState( State oldState ){
        message = 3;
        blobDetect.counterScore();
      }
    
      public FotoState()
      {
        println("Foto State");
      }
    
      public void doWhileInState()
      {
        background(0);
        backToStart();   
        
      if ( isButtonPressed && ! wasButtonPressed ) 
      {
        stateHandler.changeStateTo( NAAM_EN_FOTO_STATE );
        Camera.makePicture();
      }
      
    }
    
    
}
