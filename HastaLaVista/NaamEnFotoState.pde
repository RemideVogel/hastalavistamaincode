// DE FOTO IS GEMAAKT EN DE MENSEN ZIEN HUN SCORE + NAAM IN BEELD

class NaamEnFotoState extends State
{
    
          public NaamEnFotoState()
    {
      println("Naam & Foto State");
    }
    
      public void enterState( State oldState ){
        
      }
    
      public void doWhileInState()
    {
        backToStart();
        image(NaDeFoto, 0, 0, width, height);
        
        PImage webcamImage = Camera.webcamImage;
        webcamImage.resize(0, 100);
        translate(525,425 + 160 * 1.3 + 110);
        rotate((TWO_PI / 4) * 3);
        image(webcamImage, 0, 0, 320 * 1.3, 240 * 1.3);
        
      if ( isButtonPressed && ! wasButtonPressed ) 
      {
          Camera.Connection();
          stateHandler.changeStateTo( KOM_BINNEN_STATE );
      }
      
      if ( isButton2Pressed && ! wasButton2Pressed ) 
      {
          stateHandler.changeStateTo( KOM_BINNEN_STATE );
      }
    }
}
