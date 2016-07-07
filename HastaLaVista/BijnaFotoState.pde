class BijnaFotoState extends State
{        
      
      public void enterState( State oldState ){
        blobDetect.counterScore();
        message = 3;
      }
      
      public BijnaFotoState()
      {
        println("Foto State");
      }
    
      public void doWhileInState()
      {
        background(0);
        backToStart();
        image(VoorDeFoto, 0, 0, width, height);  
        
        translate(655, 685);
        rotate((TWO_PI / 4) * 3);
        fill(140,192,68);
        textFont(candaraItalic);
        textSize(60);
        text(blobDetect.finalScore, 0, 0);
        
        webcam.read();
        translate(-50, 280);
        image(webcam, 0, 0, 640 * 0.75, 480 * 0.75);
        
      if ( isButtonPressed && ! wasButtonPressed ) 
      {
        Camera.makePicture();
        stateHandler.changeStateTo( NAAM_EN_FOTO_STATE );
      }
      
      if ( isButton2Pressed && ! wasButton2Pressed ) 
      {
        stateHandler.changeStateTo( KOM_BINNEN_STATE );
      }
    }
    
    
}
