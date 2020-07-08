ArrayList<PVector> points = new ArrayList<PVector>(); // Lista con las posiciones del vector
PImage img;

// Paleta de colores
color[] pal = {
  color(0, 0, 255), // Azul
  color(0, 255, 0), // Verde
  color(255, 255, 255), // Blanco
  color(255, 0, 0) // Rojo
};

float scale = 0.001; // Factor de escala del vector
float scaleGauss = 0.3; // Factor de escala de distorción de los puntos
int value = 0;

void setup() {
  size(1600, 900);
  //strokeWeight(0.5); // Ancho del vector
  background(0, 0, 0);
  noFill();  
  //img = loadImage("walter.jpg");
  img = loadImage("darth.jpg");

  // Crea los puntos en el plano en el rango [-3,3]
  for (float x=-3; x<=3; x+=0.07) {
    for (float y=-3; y<=3; y+=0.07) {      
      PVector v = new PVector(x+randomGaussian()*scaleGauss, y+randomGaussian()*scaleGauss);
      points.add(v);
    }
  }
}

// Conversión de polares a cartesianas 
PVector circle(float n) { 
  return new PVector(cos(n), sin(n));
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}

PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}

void draw() {
  int point_idx = 0; 
  for (PVector p : points) {    
    // Puntos en el plano centrado en la pantalla
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);

    // Colores basados en la paleta de color
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
   
    PVector v1 = sinusoidal(p,1);

    int img_x = (int)map(p.x,-3,3,0,img.width);
    int img_y = (int)map(p.y,-3,3,0,img.height);

    float b = brightness( img.get(img_x,img_y) )/255.0;    
    PVector br = circle(b);
    float a = 5*PVector.angleBetween(br,v1);

    PVector v = circle(a);
        
    p.x += scale * v.x;
    p.y += scale * v.y;
    println(scale);
    point_idx++; // Puntos con la paleta de color
  }  
}

void keyPressed(){
  if(keyCode == UP && scale < 0.1){
    scale = scale*10;    
  }else if(keyCode == DOWN && scale > 0.000001){
    scale = scale/10;    
  }
}
