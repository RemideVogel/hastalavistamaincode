import fullscreen.*;
import japplemenubar.*;

import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import SimpleOpenNI.*;
import mpe.client.*;
import processing.net.*;
import org.seltar.Bytes2Web.*;
import processing.video.*;
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;

final int   BUTTON_GEEL = 2; // LDR connected to digital pin D3.
final int   BUTTON_ROOD = 3; // LDR connected to digital pin D3.

final int   LED_GEEL    = 6; // LED connected to digital pin D6.
final int   LED_ROOD    = 9; // LED connected to digital pin D9.

final int   PIR_1       = 8; // PIR connected to digital pin D8.
final int   PIR_2       = 7; // PIR connected to digital pin D7.

boolean  isButtonPressed = false;
boolean wasButtonPressed = false;

boolean isButton2Pressed = false;
boolean wasButton2Pressed = false;

boolean isLedOn = false;

boolean isActivity1Detected = false;
boolean isActivity2Detected = false;

float backToStartTimer = 60;

//Variables for blobDetection
int maxDetectionDistance = 2000;
int minDetectionDistance = 500;
int steps = 1;
int adjacent = 2000;
int kinectHeight = 2600;
PVector startPosition;

SimpleOpenNI context;
blobDetection blobDetect;


//Variables for WebCam
highscoreClass Camera;
Capture webcam;
MySQL dbconnection;
String url = "http://hwo.linkhosting.nl/wp-content/themes/twentysixteen-rico/Upload.php";
String photoFolder = "C:/Users/Hylke/Desktop/HastaLaVista";

// geel = digitalRead(2)
// rood = digitalRead(3)

Server myServer;
int message = 0;

StateHandler stateHandler;
SoftFullScreen fs;


//PApplet parent = this;
Arduino arduino;

final State   START_STATE         = new StartState();      //Overbodig
final State   STANDBY_STATE       = new StandbyState();    //Animatie Standby (Kai)
final State   WELKOM_STATE        = new WelkomState();     //Af
final State   UITLEG_STATE        = new UitlegState();     //Uitleg (Remi)
final State   KLAAR_STAAN_STATE   = new KlaarStaanState(); //Af
final State   DANSEN_STATE        = new DansenState();     //Animatie Standby
final State   BIJNA_FOTO_STATE    = new BijnaFotoState();  //Af
final State   FOTO_STATE          = new FotoState();       //Af
final State   NAAM_EN_FOTO_STATE  = new NaamEnFotoState(); //Af
final State   WIST_JE_DAT_STATE   = new WistJeDatState();  //Niet nodig
final State   KOM_BINNEN_STATE    = new KomBinnenState();  //Af
final State   TOT_ZIENS_STATE     = new TotZiensState();   //Niet nodig

PImage uitlegImage;
PImage welkomImage;
PImage startPositieImage;
PImage fotoImage;
PImage VoorDeFoto;
PImage NaDeFoto;
PImage KomBinnen;
Movie klaarStaan;


PFont candaraItalic;

void setup()
{
  size(1680, 1050);
  noStroke();
  frameRate( 29.97 );
  myServer = new Server(this, 7502);
  message = 0;

  fs = new SoftFullScreen(this, 0);
  fs.enter();

  candaraItalic = createFont("Candara Italic.ttf", 32);
  
  welkomImage = loadImage("Welkom.jpg");
  uitlegImage = loadImage("Uitleg.jpg");
  klaarStaan = new Movie(this, "KlaarStaan.mp4");
  VoorDeFoto = loadImage("VoorDeFoto.jpg");
  NaDeFoto = loadImage("NaDeFoto.jpg");
  KomBinnen = loadImage("KomBinnen.jpg");
  
  

  //All kind of stuff for the blobDetection ------------------------------------------------------
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  //Start the detphCamera
  context.enableDepth();
  context.start();

  //Define PVectors
  startPosition = new PVector(300, 300);
  //Import the different classes
  blobDetect = new blobDetection(steps, ( minDetectionDistance + maxDetectionDistance ) / 2, adjacent, kinectHeight, startPosition);

  blobDetect.createPathArray();

  //End of blobDetection stuff ------------------------------------------------------ 
  //All kind of stuff for the Camera shizzle ------------------------------------------------------
  String user     = "hwo_ricolatino";
  String pass     = "qwertyuiop";
  String database = "hwo_fotos";
  String ip       = "217.119.237.114";
  Camera = new highscoreClass(this);
  webcam = new Capture(this, 640, 480); 
  webcam.start();
  dbconnection = new MySQL( this, ip, database, user, pass );
  //End of camera shizzle

  stateHandler = new StateHandler( "HastaLaVista" );
  stateHandler.changeStateTo( START_STATE );
}

void draw()
{
  traceIfChanged("Message", message + "");
  //Allemaal toffe blobDetection shit ------------------------------------------------------
  context.update();
  myServer.write(message);
  //Einde toffe blobDetection shit, ik schrijf inmiddels al Nederlands ------------------------------------------------------

  if ( frameCount % 3 == 0 && isArduinoConnected() ) {
    arduino = getConnectedArduino();    
    readArduinoInputs();
    processData();
    writeArduinoOutputs();
  }
}

void writeArduinoOutputs() {
  arduino.digitalWrite( 13, isLedOn ? Arduino.HIGH : Arduino.LOW );
}

void processData() {
  stateHandler.handleState();
  wasButtonPressed = isButtonPressed;
  wasButton2Pressed = isButton2Pressed;
}

void readArduinoInputs() {
  isButtonPressed = arduino.digitalRead( BUTTON_GEEL ) == Arduino.HIGH;
  isButton2Pressed = arduino.digitalRead( BUTTON_ROOD ) == Arduino.HIGH;

  isActivity1Detected = arduino.digitalRead( PIR_1 ) == Arduino.HIGH;
  isActivity2Detected = arduino.digitalRead( PIR_2 ) == Arduino.HIGH;
}

void backToStart() {
  if (stateHandler.secondsInState() > backToStartTimer) {
    stateHandler.changeStateTo( STANDBY_STATE );
  }
}

