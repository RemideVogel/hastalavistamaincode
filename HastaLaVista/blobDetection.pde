
public class blobDetection
{
  private int STEPS; 
  private int dHeight = 0;
  private int dWidth  = 0;

  private int detectionDistance;
  private int[] blobMap;
  private int[] depthMap;
  private int[] relabelMap;

  private int nrOfBlobs = 0;

  private PVector userPosition;
  private PVector userStartPosition;
  private PVector[] footstepsPosition;
  private PVector[] userPositionArray;
  private int[]footSteps;

  private int centerX = 0;
  private int centerY = 0;
  private int differenceCenterX = 0;
  private int differenceCenterY = 0;

  private int userPositionTime = 0;

  private float differencePosition;
  private float invertedHeight;

  private int score;
  private int realTimeScore;
  public int finalScore;
  private int footsteps;
  
  private int momentCheck = 0;
  public boolean datKanBeter = false;
  public boolean lekkerBezig = false;
  public boolean uitstekend = false;
  public boolean fantastisch = false;



  blobDetection(int aSteps, int aDistance, int aAdjacent, int aKinectHeight, PVector aUserStartPosition)
  {
    userStartPosition = aUserStartPosition;
    kinectHeight = aKinectHeight;
    adjacent = aAdjacent;
    depthMap = context.depthMap();
    STEPS = aSteps;
    detectionDistance = aDistance;
    dHeight = context.depthHeight() / STEPS;
    dWidth  = context.depthWidth()  / STEPS;
    relabelMap = new int[10];
    blobMap = new int[ dHeight * dWidth ];
  }

  //Making an array from the kinect that can be used for the blob detection
  void makeBlobArray() {
    int srcPos = 0;
    int dstPos = 0;
    int[] depthMap = context.depthMap();
    for (int y=0; y < dHeight; y++ )
    {
      for (int x=0; x < dWidth; x++ ) 
      {

        //set(x+width/2, y, depthMap[srcPos]/32 );
        if (depthMap[srcPos] > minDetectionDistance && depthMap[srcPos] < maxDetectionDistance  )
        {
          blobMap[dstPos] = MAX_INT - 2;
        } else {
          blobMap[dstPos] = MAX_INT - 1;
        }

        srcPos += STEPS;
        dstPos++;
      }
    }
    neighbourDetection();
  }

  //
  void neighbourDetection() {

    //Making the detection blocks around position x
    nrOfBlobs = 0;

    int aPos = -dWidth -1;
    int bPos = -dWidth;
    int cPos = -dWidth + 1;
    int dPos = -1;
    int[] depthMap = context.depthMap();

    //Setting the detection position
    int srcPos = 0;

    for (int y=0; y < dHeight; y++)
    {
      for (int x=0; x < dWidth; x++)
      {
        if ( blobMap[srcPos] != MAX_INT - 1) {
          //Search for the label from the neighbour. When not found label is 0
          int aLabel = (x > 0 && y > 0)       ? blobMap[aPos] : MAX_INT - 1;
          int bLabel = (y > 0)                ? blobMap[bPos] : MAX_INT - 1;
          int cLabel = (x < dWidth && y > 0)  ? blobMap[cPos] : MAX_INT - 1;
          int dLabel = (x > 0)                ? blobMap[dPos] : MAX_INT - 1;

          //Search for the label with the least value
          int label = min(  min(  min( aLabel, bLabel ), cLabel ), dLabel );

          //If no neighbour is is detected
          if (label <  MAX_INT - 2)
          {
            blobMap[srcPos] = label;
          } else {
            blobMap[srcPos] = ++nrOfBlobs; 

            if (aLabel < MAX_INT - 2 && x > 0 && y > 0)      blobMap[aLabel] = label;
            if (bLabel < MAX_INT - 2 && y > 0)               blobMap[bLabel] = label;
            if (cLabel < MAX_INT - 2 && x < dWidth && y > 0) blobMap[cLabel] = label;
            if (dLabel < MAX_INT - 2 && x > 0)               blobMap[dLabel] = label;
          }
        }

        srcPos++;
        aPos++;
        bPos++;
        cPos++;
        dPos++;
      }
    }
    combineBlobs();
  }

  void combineBlobs() 
  {

    int aPos = -dWidth - 1;
    int bPos = -dWidth;
    int cPos = -dWidth + 1;
    int dPos = -1;
    int a = 0;
    int[] depthMap = context.depthMap();
    relabelMap = new int[nrOfBlobs+1];

    //Setting the detection position
    int srcPos = 0;

    for (int i = 0; i <= nrOfBlobs; i++)
    {
      relabelMap[i] = i;
    }

    for (int y=0; y < dHeight; y++)
    {
      for (int x=0; x < dWidth; x++)
      {
        if ( blobMap[srcPos] == MAX_INT - 1 ) {

          blobMap[srcPos] = 0;
        } else if ( x > 0 && y > 0 ) {

          //Search for the label from the neighbour         
          if (relabelMap[ blobMap[aPos] ] != relabelMap[ blobMap[ srcPos ] ] && blobMap[aPos] != 0 ) {
            relabel( relabelMap, blobMap[aPos], blobMap[srcPos]  );
          }         

          if ( relabelMap[ blobMap[bPos] ] != relabelMap[ blobMap[ srcPos ] ] && blobMap[bPos] != 0 ) {
            relabel( relabelMap, blobMap[bPos], blobMap[srcPos]  );
          }

          if ( x < dWidth && relabelMap[ blobMap[cPos] ] != relabelMap[ blobMap[ srcPos ] ] && blobMap[cPos] != 0 ) {
            relabel( relabelMap, blobMap[cPos], blobMap[srcPos]  );
          }

          if ( relabelMap[ blobMap[dPos] ] != relabelMap[ blobMap[ srcPos ] ] && blobMap[dPos] != 0 ) {
            relabel( relabelMap, blobMap[dPos], blobMap[srcPos]  );
          }
        }

        srcPos++;
        aPos++;
        bPos++;
        cPos++;
        dPos++;
      }
    }
    relabelBlobmap();
  }


  private void relabel(int[] relabelMap, int aLabel, int bLabel ) 
  {
    int minLabel = (int) min( relabelMap[ aLabel ], relabelMap[ bLabel ] );
    int maxLabel = (int) max( relabelMap[ aLabel ], relabelMap[ bLabel ] ); 

    relabelMap[ aLabel ] = minLabel;
    relabelMap[ bLabel ] = minLabel;

    for (int i = 0; i < relabelMap.length; i++ ) {
      if ( relabelMap[ i ] == maxLabel ) {
        relabelMap[ i ] = minLabel;
      } else if ( relabelMap[ i ] > maxLabel ) {
        relabelMap[i]--;
      }
    }
  }


  void relabelBlobmap()
  {
    int srcPos = 0;
    for (int y=0; y < dHeight; y++)
    {
      for (int x=0; x < dWidth; x++)
      {
        if ( blobMap[srcPos] >= MAX_INT - 2 ) {
          println( "Odd, large label..." + srcPos + " -> " + blobMap[ srcPos ] );
        } else {
          blobMap[srcPos] = relabelMap[ blobMap[ srcPos ] ];
        }
        srcPos++;
      }
    }
    calculateMiddlePoint();
  }

  int[] colors = {
    0x000000, 
    0x0000FF, 
    0x00FF00, 
    0x00FFFF, 
    0xFF0000, 
    0xFF00FF, 
    0xFFFF00, 
    0xFFFFFF, 
    0x000080, 
    0x008000, 
    0x008080, 
    0x800000, 
    0x800080, 
    0x808000, 
    0x808080
  };

  void drawBlobmap()
  {
    int srcPos = 0;
    for (int y=0; y < dHeight; y++)
    {
      for (int x=0; x < dWidth; x++)
      {
        if ( blobMap[srcPos] < colors.length ) {
          set(x, y, colors[blobMap[srcPos]] );
        } else {
          set(x, y, 0xFF8000);
        }
        srcPos++;
      }
    }
    
    ellipse(300, 300, 30, 30);
    ellipse(centerX, centerY, 20, 20);
  }

  void calculateMiddlePoint() 
  {
    int srcPos = 0;
    int xyTotal = 0;
    int xTotal = 0;
    int yTotal = 0;


    for (int y=0; y < dHeight; y++)
    {
      for (int x=0; x < dWidth; x++)
      {
        if (blobMap[srcPos] == 1)
        {
          xTotal = xTotal + x;
          yTotal = yTotal + y;  
          xyTotal++;
        }
        srcPos++;
      }
    }

    if (xyTotal > 0) 
    {

      centerX = xTotal / xyTotal - differenceCenterX;
      centerY = yTotal / xyTotal - differenceCenterY;
      userPosition = new PVector(centerX, centerY);
    }
  } 

  void calibrateUserPosition() 
  {       

    PVector differencePosition = PVector.sub(userPosition, userStartPosition);
    int[] differencePos = int(differencePosition.array());
    differenceCenterX = differencePos[0];
    differenceCenterY = differencePos[1];
    
    println(differencePos);
  }

  void saveUserPosition()
  {
//    println("save user position");
//    boolean checkNull = false;
//    while (checkNull == false) 
//    {
      blobDetect.makeBlobArray();
      
      if (userPosition != null)
      {   
        
        userPositionArray[userPositionTime] = userPosition;
        
//        checkNull = true;
        userPositionTime++;
      }
      
      if(userPosition == null)
      {
        userPosition = new PVector(0,0);
      }
      
      if(userPositionTime > 5)
      {
//       println(userPositionTime); 
      }
//    }
    if (userPositionTime == footsteps)
    {
      userPositionTime = 0;
    }
    println(userPosition);
  }

  void counterScore()
  {
    for (int i = 0; i < footsteps-1; i++)    
    {
      
      float scoreCount = PVector.dist(footstepsPosition[i], userPositionArray[i]);
      
      if(scoreCount > 150)
      {
       scoreCount = 150;  
      }
      
      score = score + int(scoreCount);
    }

    finalScore = 7801 - score;
    score = 0;
  }
  
  void realTimeScore()
  {
    datKanBeter = false;
    lekkerBezig = false;
    uitstekend = false;
    fantastisch = false; 
    
    for (int i = 0; i < 5; i++)
    {
      float realTimeScoreCount = PVector.dist(footstepsPosition[momentCheck], userPositionArray[momentCheck]);
      
      if(realTimeScoreCount > 150)
      {
       realTimeScoreCount = 150;  
      }
      
      realTimeScore = realTimeScore + int(realTimeScoreCount);
    }
    


    if (realTimeScore < 60)
    {
     fantastisch = true;
     println("FANTASTISCH");
    } else if (realTimeScore > 60 && realTimeScore < 200)
    {
     println("UITSTEKEND");
      uitstekend = true;
    }
    else if(realTimeScore > 200 && realTimeScore < 400)
    {
     println("LEKKER_BEZIG");
      lekkerBezig = true;
    }
    else
    {
     println("DAT_KAN_BETER");
      datKanBeter = true;
    }
    
    momentCheck = momentCheck + 5;
    realTimeScore = 0;
  }

  void createPathArray()
  {
    int [][]footSteps = { 
      //1 t/m 10
      {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300},
      
//      //11 t/m 20
//      {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300},
//      
//      //21 t/m 30
//      {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300},
//      
//      //31 t/m 40
//      {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300},
//      
//      //41 t/m 50
//      {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300}, {300, 300},
//      
//      //51 t/m 52
//      {300, 300}, {300, 300}
    };

    userPositionArray = new PVector[ footSteps.length ];
    footstepsPosition = new PVector[ footSteps.length ];


    for ( int i = 0; i < footSteps.length; i++ ) {
      if ( i < footSteps.length ) {
        footstepsPosition[i] = new PVector(footSteps[i][0], footSteps[i][1]);
      } else {
        i = footSteps.length;
      }
    } 

    footsteps = footSteps.length;
  }



  //  void heightDetection()
  //  {
  //    int middleDistance = centerY * dWidth + centerX;
  //    int srcPos = 0;
  //    int hypotenuse = MAX_INT;
  //    int minX = 0;
  //    int minY = 0;
  //    int x = 0;
  //    int y = 0;
  //
  //    for (int i = 0; i < blobMap.length; i++)
  //    {
  //      if(x < dWidth) {
  //        x++;        
  //      } else {
  //        y++;
  //        x = 0;
  //      }      
  //      
  //      if (blobMap[srcPos] == 1) 
  //      {
  //        if (depthMap[srcPos] < hypotenuse)
  //        {
  //          hypotenuse = depthMap[srcPos];
  //          int minPos = srcPos;
  //          minX = x;
  //          minY = y;
  //        }
  //      }
  //      srcPos++;
  //    }
  //  
  //  //println("hypo: " + hypotenuse);
  //  //println("minX: " + minX);
  //  //println("minY: " + minY);
  //  ellipse(minX, minY, 10, 10);
  //  //int hypotenuse = depthMap[middleDistance]; 
  //
  //  if (hypotenuse != 0) 
  //  {
  //
  //    float invertedHeightSqrt = (hypotenuse*hypotenuse) - (adjacent*adjacent);
  //    float invertedHeight = sqrt(invertedHeightSqrt);
  //    float personHeight = kinectHeight - invertedHeight;
  //
  //    println("");
  //    println("adjecent " + adjacent);
  //    println("hypotenuse " + hypotenuse);
  //    println("invertedHeight: " +invertedHeight);
  //    println("personHeight: " +personHeight);
  //    println("KinectHeight: " +kinectHeight);
  //  }
  //}
}

