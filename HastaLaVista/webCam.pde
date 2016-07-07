import org.seltar.Bytes2Web.*;

public class highscoreClass {
  int score = blobDetect.finalScore;
  boolean checkWebcam;
  String filenamePrefix = "imageName-";
  String filename;
  int sequenceNr  = nrOfSavedImagesInFolder( photoFolder );
  PImage webcamImage;
  

  PApplet p; 
  
  //setup 
  highscoreClass(PApplet p) 
  { this.p = p;
    String[] devices = Capture.list();   
  }

  //draw
  void makePicture() 
  {
   // boolean checkWebcam = false;
   // for(checkWebcam == true) {
//     background(255);
     webcam.read();
//     image(webcam, 0, 0);
     filename = filenamePrefix + sequenceNr; // + ".png";

     webcamImage = webcam.get();
     webcamImage.save( filename );
     saveFrame( filename );
   }
   
   void Connection(){
//      int fileCount = theList.length;
//      println(str(fileCount) + " files");
//        
        // connect to database of server "localhost"
       if ( dbconnection.connect() ) {
        
        // now send data to database
        ImageToWeb img = new ImageToWeb(p);
        //img.save("jpg", false);
        img.post("test",url,filename,false,img.getBytes(g));
        
        filename = filename + ".jpg";
       
        
     //  dbconnection.execute( "INSERT INTO incoming_photos (photo_name, score_taken) VALUES ('"+filename+" , "+score+"');" );
       dbconnection.query(" INSERT INTO incoming_photos ( photo_name, score_taken) VALUES ('%s', '%s')", filename, blobDetect.finalScore);
        
//        println();
        sequenceNr++;
        score++;
        }
        else
      {
      println("Error in the connection :-( ");
      }
    
   
     }
     
     int nrOfSavedImagesInFolder( String folder ) {
         
         File theDir = new File( folder );
         String[] theList = theDir.list();
         return theList.length;
         
         
     }
}
