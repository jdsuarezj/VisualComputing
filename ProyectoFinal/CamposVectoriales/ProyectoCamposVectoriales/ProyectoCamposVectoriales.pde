ArrayList<PVector> points = new ArrayList<PVector>(); // Lista con las posiciones del vector 

// Paleta de colores
color[] pal = {
  color(0, 0, 255), // Azul
  color(0, 255, 0), // Verde
  color(255, 255, 255), // Blanco
  color(255, 0, 0) // Rojo
};
 
float scale = 0.01; // Factor de escala del vector
float scaleGauss = 0.003; // Factor de escala de distorción de los puntos
String[] variant ={"Campo vectorial","Campo vectorial con movimiento","Campo vectorial con ruido","Campo vectorial cartesianas", "Campo vectorial hiperbólico"};
int pos = 0;
int variants = 5;
float time = 2; // Factor de escala para el paso del tiempo

void setup() {
  size(1600, 900);
  background(0);
  textSize(20);  
  //strokeWeight(0.5); // Ancho del vector
  noFill();    

  // Crea los puntos en el plano en el rango [-5,5]
  for (float x=-5; x<=5; x+=0.07) {
    for (float y=-5; y<=5; y+=0.07) {      
      PVector v = new PVector(x+randomGaussian()*scaleGauss, y+randomGaussian()*scaleGauss);
      points.add(v);
    }
  }
}
 
void draw() {  
  println(pos);    
  fill(0);  
  noStroke();
  rect(0, 0, width, 60);
  fill(255);
  text(variant[pos],50,50);    
  chooseVariant();    
}


void vectorFieldInit(){  
  int point_idx = 0; 
  for (PVector p : points) {
    // Puntos en el plano centrado en la pantalla 
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
 
    // Colores basados en la paleta de color
    // noise, más armónico que random
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
                
    // vector del campo
    PVector v = new PVector(0, 0);    
    p.x += scale * v.x;
    p.y += scale * v.y;
 
    point_idx++; // Puntos con la paleta de color     
  }  
}

void vectorFieldMove(){
  int point_idx = 0; 
  for (PVector p : points) {
    // Puntos en el plano centrado en la pantalla 
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
 
    // Colores basados en la paleta de color
    // noise, más armónico que random
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
                
    // vector del campo
    PVector v = new PVector(0.1, 0.1);    
    p.x += scale * v.x;
    p.y += scale * v.y;
 
    point_idx++; // Puntos con la paleta de color       
  }  
}

void vectorFieldRuido(){
  int point_idx = 0; 
  for (PVector p : points) {
    // Puntos en el plano centrado en la pantalla 
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
 
    // Colores basados en la paleta de color
    // noise, más armónico que random
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
                
    // vector del campo
    float n = TWO_PI * noise(p.x,p.y);
    PVector v = new PVector(cos(n),sin(n));

    p.x += scale * v.x;
    p.y += scale * v.y;
 
    point_idx++; // Puntos con la paleta de color       
  }  
}

void vectorFieldCartesianas(){
  int point_idx = 0; 
  for (PVector p : points) {
    // Puntos en el plano centrado en la pantalla 
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
 
    // Colores basados en la paleta de color
    // noise, más armónico que random
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
                
    // vector del campo
    float n = 5*map(noise(p.x,p.y),0,1,-1,1);
    PVector v = new PVector(n,n);

    p.x += scale * v.x;
    p.y += scale * v.y;
 
    point_idx++; // Puntos con la paleta de color       
  }  
}

void vectorFieldHiper(){
  int point_idx = 0; 
  for (PVector p : points) {
    // Puntos en el plano centrado en la pantalla 
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
 
    // Colores basados en la paleta de color
    // noise, más armónico que random
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn], 15); // Asigna el color con una opacidad
    point(xx, yy); // Muestra los puntos en pantalla
                
    // vector del campo
    PVector v = hyperbolic(p,1);
    v.mult(1);

    p.x += scale * v.x;
    p.y += scale * v.y;
 
    point_idx++; // Puntos con la paleta de color       
  }  
}

// Conversión de polares a cartesianas 
PVector circle(float n) { 
  return new PVector(cos(n), sin(n));
}

PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}

void chooseVariant(){
 switch(pos){
   case 0:
     vectorFieldInit();
     break;
   case 1:
     vectorFieldMove();
     break;   
   case 2:
     vectorFieldRuido();
     break; 
   case 3:
     vectorFieldCartesianas();
     break;    
   case 4:
     vectorFieldHiper();
     break; 
 } 
}

void keyPressed(){
  if(keyCode == UP){
    pos = (pos+1)%variants;
  }else if(keyCode == DOWN){
    pos=(pos-1)%variants;
    if (pos ==-1) pos = variants-1;
  }
}
