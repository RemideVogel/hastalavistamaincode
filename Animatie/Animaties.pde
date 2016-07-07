import fullscreen.*;
import japplemenubar.*;
import processing.video.*;
import processing.net.*; 

Client myClient; 
int message;
boolean checkActiveKanBeter = false;
boolean checkActive1KanBeter = true;
boolean checkActiveLekkerBezig = false;
boolean checkActive1LekkerBezig = true;
boolean checkActiveUitstekend = false;
boolean checkActive1Uitstekend = true;
boolean checkActiveFantastisch = false;
boolean checkActive1Fantastisch = true;

boolean playVideoKanBeter = false; 
boolean playVideoLekkerBezig = false;
boolean playVideoUitstekend = false;   
boolean playVideoFantastisch = false;

FullScreen fs;

Movie standByAnimatie;
Movie uitlegAnimatie;
Movie dansenAnimatie;
Movie eindeAnimatie;

Movie datKanBeter;
Movie lekkerBezig;
Movie uitstekend;
Movie fantastisch;


static PApplet parent;

void setup() { 
  size(1024, 768);
  frameRate( 29.97 );
  background(0);
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 7502); 

    fs = new FullScreen(this,1);
    fs.enter();

  if (dansenAnimatie == null)
  {
    dansenAnimatie = new Movie( this, "dansenAnimatie.mp4");
  }

  datKanBeter = new Movie(this, "Dat kan beter (kleurcorrectie).mp4");

  lekkerBezig = new Movie(this, "lekkerBezig.mp4");

  uitstekend = new Movie(this, "fantastisch.mp4");

  fantastisch = new Movie(this, "salsatastisch.mp4");

  parent=this;
} 

void dansenPlay()
{

  dansenAnimatie.play();
  if (dansenAnimatie.available() == true) {
    image( dansenAnimatie, 0, 0, width, height);
    dansenAnimatie.read();
  }
}

void draw() {
  if (myClient.available() > 0) { 
    message = myClient.read();
  }
  
//  switch(key){
//    case '0': message = 2; break;
//    case '1': message = 21; break;
//  }

  if (message == 2 || message == 21 || message == 22 || message == 23 || message == 24)
  {
    dansenPlay();
  }

  if (message == 2)
  {
  }

//  if (message == 21)
//  {
//    checkActiveKanBeter = true;
//  }
//
//  if (checkActiveKanBeter == true && checkActive1KanBeter == true)
//  {
//    datKanBeter.play();
//    checkActiveKanBeter = false;
//    checkActive1KanBeter = false;
//    playVideoKanBeter = true;
//  }
//
//  if (playVideoKanBeter == true) 
//  {      
//    datKanBeter.read();
//    image(datKanBeter, 412, 195, 200, 100);
//    if (datKanBeter.time() >= floor( datKanBeter.duration()))
//    {
//      datKanBeter.stop();
//      checkActive1KanBeter = true;
//      playVideoKanBeter = false;
//    }
//  }  

  if (message == 22)
  {
  }

  if (message == 23)
  {
  }

  if (message == 24)
  {
  }

  if (message == 3)
  {
    dansenAnimatie.stop();
  }
}



void standByPlay()
{
  standByAnimatie.loop();
  if (standByAnimatie.available() == true) {
    image( standByAnimatie, 0, 0, width, height);
    standByAnimatie.read();
  }
}



//void eindePlay()
//{
//  dansenAnimatie.stop();
//  eindeAnimatie.loop();
//  if (eindeAnimatie.available() == true) {
//    image( eindeAnimatie, 0, 0, width, height);
//    eindeAnimatie.read();
//  }
//}

