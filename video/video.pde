import processing.video.*;

PGraphics pg, pg1;
Movie movie;
PImage m;
PFont font;

void setup() {
  size(840, 430);
  frameRate(60);
  font = createFont("Arial Bold",32);
  pg = createGraphics(400, 400);
  pg1 = createGraphics(400, 400);
  movie = new Movie(this, "globos.mp4");
  movie.loop();
  
}

void grayScale(PGraphics pg, Movie movie){
  pg.loadPixels();
  movie.loadPixels();  
  
  if(movie.width > 0){
    m = movie.get();
    m.resize(400,400);
  
  for (int i = 0; i < m.width * m.height; i++) {
    colorMode(HSB,100);
    float H = hue(m.pixels[i]);
    float S = saturation(m.pixels[i]);
    float Br = brightness(m.pixels[i]);
    m.pixels[i] = color(Br);   
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
  textFont(font,20);
  text(frameRate,20,40);
}

void movieEvent(Movie m) {
  m.read();
}
