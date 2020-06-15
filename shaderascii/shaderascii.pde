PShader ascii;
PImage img;

void setup() {
  img = loadImage("grayscaletest.jpg");
  img.resize(300,0);
  
  size(300,300,P2D);
  surface.setSize(img.width,img.height);
  noStroke();
  
  ascii = loadShader("asciiFrag.glsl");
  int[] iResolution = {width,height};
  ascii.set("iResolution",iResolution);
  ascii.set("iChannel0",img);
}

void draw() {
  shader(ascii);
  image(img,0,0);
  

}
