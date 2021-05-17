import processing.sound.*;
import processing.serial.*;

Serial mySerial;
String myString=null;

int nl=10;
int val;
int miss=0;
int hit=0;
int count=1;


SoundFile file0;
SoundFile file1;
SoundFile file2;
SoundFile file3;
SoundFile file4;
SoundFile file5;
SoundFile file6;

float k=0;
int n=0;
int m=0;
int j=3;
float a=0.8;

int f=0;
int t=0;
float y=0.8;
float z=0;
int l=2;
float b=1;
int x=0;
float r=0;
int score=0;
String mp;

int hitp1;
int hitp2;
int missp1;
int missp2;
int score1;
int score2;

int flag;

int rect1X, rect1Y;
int rect2X, rect2Y; 
int rect3X, rect3Y;
color rect1Color, rect2Color,rect3Color; 
color rect1Highlight, rect2Highlight;
color currentColor;
boolean rect1Over = false;
boolean rect2Over = false;
boolean rect3Over = false;
PImage img;
PImage img1;
int stage=1;

singleplayer sp =new singleplayer();
void setup() {
  
  String myPort=Serial.list()[0];
  mySerial=new Serial(this,"COM10",9600);
  file0=new SoundFile(this,"tl.wav");
  file1=new SoundFile(this,"tr.wav");
  file2=new SoundFile(this,"bl.wav");
  file3=new SoundFile(this,"br.wav");
  file4=new SoundFile(this,"Hit.wav");
  file5=new SoundFile(this,"Miss.wav");
  file6=new SoundFile(this,"bg.mp3");
  
  
  size(500, 500);
  rect2Color = color(0);
  rect2Highlight = color(51);
  rect1Color = color(255);
  rect1Highlight = color(204);
  rect3Color=color(255);
  rect1X=135;
  rect1Y=200;
  rect2X=135;
  rect2Y=250;
  rect3X=135;
  rect3Y=300;
  img=loadImage("clouds.jpg");
  img1=loadImage("cloud1.jpg");
}

void draw()
{ 
      if(stage==1)
      {  
         background(img);
         textSize(32);
         fill(0);
         text("AVA Gaming Presents",75,100);
         textSize(40);
         fill(random(255),random(255),random(255));
         text("REBOUNCEALL",90,150);
         update(mouseX, mouseY);
  
           if (rect1Over) 
           {
             fill(rect1Highlight);
           } 
     
           else 
           {
             fill(rect1Color);
           }
     
         stroke(255);
         rect(rect1X, rect1Y, 200,26);
         fill(35);
         textSize(20);
         text("Single Player",175,220);
  
           if (rect2Over)
           {
             fill(rect1Highlight);
           } 
           else 
           {
             fill(rect2Color);
           }
         stroke(255);
         rect(rect2X, rect2Y, 200,30);
         fill(255);
         textSize(20);
         text(" Multi Player",175,270);
  
           if (rect3Over) 
           {
             fill(rect1Highlight);
           }
           else 
           {
             fill(rect3Color);
           }
         
         stroke(255);
         rect(rect3X, rect3Y, 200,30);
         delay(150);
         fill(random(255),random(255),random(255));
         textSize(20);
         text(" Blind Play",180,323);
         
           if(count==1)
           {
             file6.play();
             count++;
           }
     
         while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  
                  if(myString!=null)
                  { 
                      if(float(myString)==10.0)
                      {  
                      stage=2;
                      }
                      
                      else if(float(myString)==11.0)
                      {
                        stage=3;
                      }
                      
                      else if(float(myString)==12.0)
                      {
                        stage=4;
                      }
                  }
               }
      }
  
  if(stage==2)
  {
    sp.setup();              //Singleplayer Mode
    sp.draw();
  }
  
  if(stage==3)
  {
      sp.draw1();            //Multiplayer Mode
  }
  if(stage==4)
  {  
    sp.initialize();         //Blindplayer Mode
    sp.setup();
    sp.draw();
  }
  
  if(stage==5)      
  {
      sp.draw2();             //To display Score on Board
  }
  
  if(stage==6)
  {  
    sp.draw3();
  }
}

void update(int x, int y) {
  if ( overRect1(rect1X, rect1Y, 200, 30) ) {
    rect1Over = true;
    rect2Over = false;
    rect3Over = false;
  } else if ( overRect2(rect2X, rect2Y, 200,30) ) {
    rect2Over = true;
    rect1Over = false;
    rect3Over = false;
  } else if ( overRect3(rect3X, rect3Y, 200,30) ) {
    rect3Over = true;
    rect1Over = false;
    rect2Over = false;
  }else {
    rect1Over = rect2Over = rect3Over = false;
  }
}

  
void mousePressed() {
  
    if (rect1Over) 
    {
      stage=2;
    }
    
    if (rect2Over)
    {
      stage=3;
    }
    
    if(rect3Over)
    {
      stage=4;
    }
}

boolean overRect1(int x, int y, int width, int height)  {
  
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) 
  {
    return true;
  } 
  else 
  {
    return false;
  }
}

boolean overRect2(int x, int y, int width, int height) {
  
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overRect3(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

class singleplayer
{

  void initialize()
  {  
    n++;
  }

void setup()
{
  size(500,500);
}

void draw1()
{   
    delay(1);
    background(img1);
    strokeWeight(0);
    
      if(f==0)
      {   
          if(t!=3&&t!=1)
          {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  
                  if(myString!=null)
                  { 
                      if(float(myString)==0.0)
                      {  
                      y=-y;
                      t=1;
                      hitp1++;
                      }
                  }
               }
          }
          
            if(t==1)
            {   
              fill(0,128,0);
              textSize(60);
              text("Hit",120,50);
            }
          
            else if(t==3)
            {   
              fill(255,0,0);
              textSize(60);
              text("Miss",120,50);
            }
          
            fill(255);
            ellipse(125,125,z,z);
            z=z+y;
            smooth();
    
             if(z>=80)
             {  
                y=-y;
                t=3; 
                missp1++;
             }
            
             else if(z<=0)
             {   f=int(random(2));
                 y=-y;
                 t=0;
             }
      }
      
      else if(f==1)
      {   
          
          if(t!=3&&t!=1)
          {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==1.0)
                      {  
                      y=-y;
                      t=1;
                      hitp1++;
                      }
                  }
               }
          }
          
          if(t==1)
          {   
             fill(0,128,0);
             textSize(60);
             text("Hit",120,250);
          }
          
          else if(t==3)
          {   
             fill(255,0,0);
             textSize(60);
             text("Miss",120,250);
          }
          
          fill(255);
          ellipse(125,375,z,z);
          z=z+y;
          smooth();
    
          if(z>=80)
          {  
              y=-y;
              t=3;
              missp1++;
          }
            
          else if(z<=0)
          {   
              f=int(random(2));
              y=-y;
              t=0;
          }
      }
      
      if(l==2)
      {   
          
          if(x!=3&&x!=1)
          {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==2.0)
                      {  
                      b=-b;
                      x=1;
                      hitp2++;
                      }
                  }
               }
          }
          
          if(x==1)
          {   
             fill(0,128,0);
             textSize(60);
             text("Hit",275,50);
          }
          
          else if(x==3)
          {   
             fill(255,0,0);
             textSize(60);
             text("Miss",275,50);
          }
          
          fill(255);
          ellipse(375,125,r,r);
          r=r+b;
          smooth();
    
          if(r>=80)
          {  
              b=-b;
              x=3;
              missp2++;
          }
            
          else if(r<=0)
          {
              l=int(random(2,4));
              b=-b;
              x=0;
          }
      }
      
      else if(l==3)
      {   
          
          if(x!=3&&x!=1)
          {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==3.0)
                      {  
                      b=-b;
                      x=1;
                      hitp2++;
                      }
                  }
               }
          }
          
          if(x==1)
          {   
            fill(0,128,0);
            textSize(60);
            text("Hit",275,300);
          }
          
          else if(x==3)
          {   
            fill(255,0,0);
            textSize(60);
            text("Miss",275,300);
          }
          
          fill(255);
          ellipse(375,375,r,r);
          r=r+b;
          smooth();
    
          if(r>=80)
          {  
             b=-b;
             x=3;  
             missp2++;
          }
            
          else if(r<=0)
          {
              l=int(random(2,4));
              b=-b;
              x=0;
          }
      }
      
      if(missp1==3)
      {  stage=6;
         flag=0;
         draw();
      }
      
      else if(missp2==3)
      {
          stage=6;
          flag=1;
          draw();
      }
}

void draw()
{   
    background(img1);
    strokeWeight(0);
        
        if(j==0)
        {   
            if(n==1)
            file0.play();
          
            if(m!=3&&m!=1)
            {
                while(mySerial.available()>0) 
                {
                    myString=mySerial.readStringUntil(nl);
                    if(myString!=null)
                    { 
                        if(float(myString)==0.0)
                        {  
                        a=-a;
                        m=1;
                        file4.play();
                        hit++;
                        }
                    }
               }
            }
          
            
            if(m==1)
            {   
              fill(0,128,0);
              textSize(60);
              text("Hit",120,50);
            }
          
            else if(m==3)
            {   
              fill(255,0,0);
              textSize(60);
              text("Miss",120,50);
            }
          
            fill(255);
            ellipse(125,125,k,k);
            k=k+a;
            smooth();
    
            if(k>=80)
            {  
               a=-a;
               m=3;
               file5.play();
               miss++;
            }
            
            else if(k<=0)
            {    n=0;
                 j=int(random(4));
                 a=-a;
                 m=0;
            }
        }
    
        else if(j==1)
        {     
            if(n==1)
            file2.play();
            
            if(m!=3&&m!=1)
            {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==1.0)
                      {  
                        a=-a;
                        m=1;
                        file4.play();
                        hit++;
                      }
                  }
               }
            }

              
            if(m==1)
            {
              fill(0,128,0);
              textSize(60);
              text("Hit",120,250);
            }
          
            else if(m==3)
            {
              fill(255,0,0);
              textSize(60);
              text("Miss",120,250);
            }
         
            fill(255);
            ellipse(125,375,k,k);
            k+=a;
            smooth();
    
            if(k>=80)
            {  
             a=-a;
             m=3;
             file5.play();
             miss++;
            }
            
            else if(k<=0)
            {   
             n=0;
             j=int(random(4));
             a=-a;
             m=0;
            }
      }
    
      else if(j==2)
      {    
          if(n==1)
          file1.play();
           
          if(m!=3&&m!=1)
            {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==2.0)
                      {  
                      a=-a;
                      m=1;
                      file4.play();
                      hit++;
                      }
                  }
               }
          }
         
           fill(255);
           ellipse(375,125,k,k);
           k+=a;
           smooth();
    
           if(m==1)
           {
              fill(0,128,0);
              textSize(60);
              text("Hit",275,50);
           }
          
          else if(m==3)
          {
              fill(255,0,0);
              textSize(60);
              text("Miss",275,50);
          }
          
          
          if(k>=80)
          {  
             a=-a; 
             m=3;
             file5.play();
             miss++;
             
          }
            
          else if(k<=0)
          {   
             m=0;
             n=0;
             j=int(random(4));
             a=-a;
          }
      }
    
      else if(j==3)
      {    
           if(n==1)
           file3.play();
            
            
            if(m!=3&&m!=1)
            {
              while(mySerial.available()>0) 
              {
                  myString=mySerial.readStringUntil(nl);
                  if(myString!=null)
                  { 
                      if(float(myString)==3.0)
                      {  
                      a=-a;
                      m=1;
                      file4.play();
                      hit++;
                      }
                  }
               }
            }
         
           fill(255);
           ellipse(375,375,k,k);
           k+=a;
           smooth();
    
           if(m==1)
           {
              fill(0,128,0);
              textSize(60);
              text("Hit",275,300);
           }
          
           else if(m==3)
           {
              fill(255,0,0);
              textSize(60);
              text("Miss",275,300);
           }
         
           if(k>=80)
           {
             a=-a;
             m=3;
             file5.play();
             miss++;
           }  
            
           else if(k<=0)
           {   n=0;
               j=int(random(4));
               a=-a;
               m=0;
           }
      }
     
         score=hit*3-miss*1;
         mp=str(score);
         
     if(miss==3 && k<=0)
     {
       stage=5;
       draw();
     }
}

void draw2()
{
    background(img1);
    fill(255,0,0);
    text("GAME OVER",100,200);
    fill(255);
    text("Score : "+mp,100,300);
}

void draw3()
{   background(img1);
    fill(255,0,0);
    text("GAME OVER",100,200);
    
      if(flag==0)
      {
        fill(255);
      text("Player 1 Wins",100,300);
      }
      
      else if(flag==1)
      {
        fill(255);  
        text("Player 2 Wins",100,300);
      }
    
}
}
