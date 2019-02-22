//Christian Attard
//2015 @ introwerks 


PImage img;
PImage initimg;
int c;
int a=0;
String basedir = "C:/Users/Gaming 05/Desktop/Anima2019/processing-3.5.3/subtleSorting/in";
String name = "frame"; //file name 
String type = ".png"; //file type
int count = int(random(666));
color col;
String[] filenames;
java.io.File folder = new java.io.File(dataPath(basedir));
java.io.FilenameFilter extfilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(type);
  }
};



final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

// channels for depth: RED, GREEN, BLUE, HUE, SATURATION, BRIGHTNESS, NRED, NGREEN, NBLUE, NHUE, NSATURATION, NBRIGHTNESS. 
int channel = BRIGHTNESS;
// channel weight.
float channel_weight = 3;

float getChannel(color c) {
  int ch = channel>5?channel-6:channel;
  float cc;

  switch(ch) {
  case RED: 
    cc = red(c); 
    break;
  case GREEN: 
    cc = green(c); 
    break;
  case BLUE: 
    cc = blue(c); 
    break;
  case HUE: 
    cc = hue(c); 
    break;
  case SATURATION: 
    cc = saturation(c); 
    break;
  default: 
    cc= brightness(c); 
    break;
  }

  return channel_weight * (channel>5?255-cc:cc);
}


void setup() {
  filenames = folder.list(extfilter);
  initimg = loadImage(basedir+"/"+filenames[0]);  
  surface.setSize(initimg.width, initimg.height);
}

void draw() {
  if (a + 1 == filenames.length) {
    println("Done"); 
    exit();
  }
  img = loadImage(basedir+"/"+filenames[a]);
  image(img, 0, 0);
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      c = i+(j*width);
      col = img.pixels[c];
      fill(col);
      noStroke();
      rect(i, j+getChannel(col), 1, getChannel(col));
      img.updatePixels();
    }
  }
  channel_weight+=0.04;
  int b=10000;
  saveFrame(name + "_" + (b+a) + type);
  image(img, 0, 0);
  a++;
}
