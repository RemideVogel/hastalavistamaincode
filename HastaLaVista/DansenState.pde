// DE GEBRUIKERS ZIJN AAN HET DANSEN, ER IS NU EEN VIDEO IN BEELD EN DE KINECT MOET TRACKEN

import processing.video.*;

class DansenState extends State
{
  Movie dansMovie;
  Movie dancingScreen;
  boolean checkTimer = true;
  boolean checkTimer2 = true;
  long timer2;
  long timer;
  //    length = 4.054f

  public void enterState( State oldState ) {  
  if (dancingScreen == null)
    {
      dancingScreen = new Movie( parent, "homeApplicatie.mp4");
    }
    dancingScreen.loop();
  }

  public void leaveState( State newState )
  {
    
  }

  public DansenState()
  {
    println("Dans State");
  }

  public void doWhileInState()
  {
    blobDetect.makeBlobArray();
    
    Timer();
//    Timer2();
    
    
//    if
//    (blobDetect.datKanBeter == true)
//    {
//      message = 21;
//      blobDetect.datKanBeter = false;
//     
//    }
//    else if(blobDetect.lekkerBezig == true)
//    {
//      message = 22;
//      blobDetect.lekkerBezig = false;
//    }
//    else if(blobDetect.uitstekend == true)
//    {
//      message = 23;
//      blobDetect.uitstekend = false;
//    }
//    else if(blobDetect.fantastisch == true)
//    {
//      message = 24;
//      blobDetect.fantastisch = false;
//    } else {
      message = 2;
//    }
    
    if ( stateHandler.secondsInState() > 0.1 ) {
      blobDetect.calibrateUserPosition(); 
    }
    
    if ( stateHandler.secondsInState() >= 57 ) {
      stateHandler.changeStateTo( BIJNA_FOTO_STATE );
    } 
    
//    if (isButtonPressed && ! wasButtonPressed) {
//      
//    }    
    
    image( dancingScreen, 0, 0, width, height );
    dancingScreen.read();
    blobDetect.drawBlobmap();
    println("userPOSITION: " + blobDetect.userPosition);
  }

  void moviePlay()
  {
  }
  
  void Timer()
    {
        if(checkTimer)
        {
          timer = stateHandler.secondsInState() + 1;
          checkTimer = false;
        }
        
        if(timer <= stateHandler.secondsInState())
        {
          blobDetect.saveUserPosition();
          println("Jaaah, user opgeslagen");
          checkTimer = true;
        }
    }
    
  void Timer2()
    {
        if(checkTimer2)
        {
          timer2 = stateHandler.secondsInState() + 10;
          checkTimer2 = false;
        }
        
        if(timer2 <= stateHandler.secondsInState())
        {
          blobDetect.realTimeScore();
          println("Yeahh, score berekent");
          checkTimer2 = true;
        }
    }
}

