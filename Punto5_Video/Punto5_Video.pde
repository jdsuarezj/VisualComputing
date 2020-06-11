import processing.video.*;

PGraphics pg, pg1;
Movie movie;
PImage m;

void setup() {
  size(840, 430);
  frameRate(30);
  pg = createGraphics(400, 400);
  pg1 = createGraphics(400, 400);
  movie = new Movie(this, "globos.mp4");
  movie.loop();
}

void grayScaleRGB(PGraphics pg, Movie movie){
  pg.loadPixels();
  movie.loadPixels();  
  
  if(movie.width > 0){
    m = movie.get();
    m.resize(400,400);
  
  for (int loc = 0; loc < m.width * m.height; loc++) {       
    float r = red  (m.pixels[loc]);      
    float g = green(m.pixels[loc]);      
    float b = blue (m.pixels[loc]);  
     
    color c = color(int((0.2126*r+0.7152*g+0.0722*b)));      
    m.pixels[loc] = c;    
  }
  
  m.updatePixels();
  pg.image(m, 0, 0);
  }
}

void grayScale(PGraphics pg, Movie movie){
  pg.loadPixels();
  movie.loadPixels();  
  
  if(movie.width > 0){
    m = movie.get();
    m.resize(400,400);
  
  for (int loc = 0; loc < m.width * m.height; loc++) {
    colorMode(HSB,100);
    float H = hue(m.pixels[loc]);
    float S = saturation(m.pixels[loc]);
    float Br = brightness(m.pixels[loc]);
    m.pixels[loc] = color(Br);   
  }
  
  m.updatePixels();
  pg.image(m, 0, 0);
  }
}

void draw() {
  pg.beginDraw();
  pg.image(movie, 0, 0,400,400);  
  pg.endDraw();  
  pg1.beginDraw();  
  grayScale(pg1, movie);
  pg1.endDraw();  
  image(pg, 15, 15);
  image(pg1, 425, 15);
  println(frameRate);
}

void movieEvent(Movie m) {
  m.read();
}
