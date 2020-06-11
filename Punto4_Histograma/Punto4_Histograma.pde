PGraphics pg, pg1;
PImage img, img2;
int[] hist;
int max, min;
boolean selectMin;

void setup()
{
  size(840, 430);
  pg = createGraphics(400, 400);
  pg1 = createGraphics(400, 400);
  img = loadImage("guatape.jpg");
  img.resize(400, 400);
  img2 = loadImage("guatape.jpg");
  img2.resize(400, 400);  
  selectMin = true;
  max = 256;
  min = 0;
  hist = new int[256];
  calculateHistogram(img);
}

void calculateHistogram(PImage img)
{
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int bright = int(brightness(img.get(i, j)));
      hist[bright]++;
    }
  }
}

void histogram(PGraphics pg)
{
  // Encuentra el valor más grande en el histograma
  int histMax = max(hist);
  pg.stroke(255);
  // Dibuja la mitad del histograma (omite cada segundo valor)
  for (int i = 0; i < pg.width; i += 2) {
    // Map i (from 0..img.width) a una ubicación en el histograma (0..255)
    int which = int(map(i, 0, pg.width, 0, 255));
    // Convierta el valor del histograma en una ubicación entre    
    int y = int(map(hist[which], 0, histMax, pg.height, 0));
    // la parte inferior y la parte superior de la imagen
    if (which == min || which == min+1)
    {
      pg.stroke(200, 100, 50);
    } else if (which == max || which == max+1)
    {
      pg.stroke(50, 100, 200);
    } else
    {
      pg.stroke(255);
    }
    pg.line(i, pg.height, i, y);
  }
}

void dibujar(PImage img, PImage img2, PGraphics pg) {

  img.loadPixels();

  for (int i = 0; i < img.width * img.height; i++) {
    color c= color(img.pixels[i]);
    // RGB 
    float R = red(c);
    float G = green(c);
    float B = blue(c);
    float Br = int((R+G+B)/3);
    
    if (min <= Br && Br <= max)
    {
      img2.pixels[i] = color(Br);
    } else
    {
      img2.pixels[i] = color(0);
    }
  }
  img2.updatePixels();
  pg.image(img2, 0, 0);
}

void draw()
{
  pg.beginDraw();
  pg.image(img, 0, 0);
  pg.endDraw();

  pg1.beginDraw();
  dibujar(img, img2, pg1);
  histogram(pg1);
  pg1.endDraw();

  image(pg, 15, 15);
  image(pg1, 425, 15);
}

void mouseClicked() {
  if (mouseX > 425 && mouseX < 825)
  {
    if (mouseY > 15 && mouseY < 415)
    {
      int x = mouseX - 425;
      int m = int(map(x, 0, pg1.width, 0, 255));

      if (selectMin)
      {
        if (m < max)
        {
          min = m;
          selectMin = false;
        } else
        {
          max = m;
        }
        selectMin = false;
      } else
      {
        if (m > min)
        {
          max = m;
          selectMin = true;
        } else
        {
          min = m;
        }
      }
    }
  }
}
