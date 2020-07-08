/*
* CONTROLES:
* Oprimir las teclas "x" "y" e "z"
* para habilitar y deshabilitar los respectivos
* rotores del giroscopio.
*
* Oprimir ENTER para habilitar y
* deshabilitar los ejes de referencia.
*
* Up y DOWN permiten ajustar la velocidad
* con la que se mueven los rotores del giroscopio.
*
* El boton izquierdo del mouse permite
* mover todo el sistema para explorarlo.
*
*/

import nub.core.*;
import nub.core.constraint.*;
import nub.primitives.*;
import nub.processing.*;
import nub.timing.*;

Scene scene;
Node viewNode, nx, ny, nz, cubeNode;
float speed ;
boolean drawAxes, moveX, moveY, moveZ;

void setup(){
  size(720, 480, P3D);
  scene = new Scene(this);
  viewNode = new Node();
  noFill();
  
  nx = new Node(viewNode) {
    @Override
    public void graphics(PGraphics pg) {
      strokeWeight(3);
      stroke(255,0,0);
      circle(0,0,200);
      fill(255,0,0);
      circle(100,0,5);
    }
  };
  ny = new Node(nx) {
    @Override
    public void graphics(PGraphics pg) {
      strokeWeight(3);
      stroke(0,255,0);
      circle(0,0,180);
      fill(0,255,0);
      circle(0,90,5);
    }
  };
    nz = new Node(ny) {
    @Override
    public void graphics(PGraphics pg) {
      strokeWeight(3);
      stroke(0,0,255);
      circle(0,0,160);
      fill(0,0,255);
      circle(0,80,5);
    }
  };
  nz.rotate(1.0,0.0,0.0,PI/2);
  cubeNode = new Node(nz, createShape(BOX, 30));
  drawAxes = false;
  moveX = false; 
  moveY= false;
  moveZ= false;
  speed = 0.05;
}

void draw(){
  background(240,240,240);
  if(moveX)
    nx.rotate(1.0,0.0,0.0,speed);
  if(moveY)
    ny.rotate(0.0,1.0,0.0,speed);
  if(moveZ)
    nz.rotate(new Vector(0.0,1.0,0.0),speed,0.0);
  if(drawAxes)
    scene.drawAxes(200);
  
  scene.render();
}
void keyPressed(){
  if(keyCode == ENTER){
    drawAxes = !drawAxes;
  }else if(keyCode == UP){
    speed= (speed+0.001)%1;
  }else if(keyCode == DOWN){
    speed= (speed-0.001)%1;
    if(speed <= 0)
      speed = 0.001;
  }
  else if(key == 'x'){
     moveX = !moveX;
  }else if(key == 'y'){
     moveY = !moveY;
  }else if(key == 'z'){
     moveZ = !moveZ;
  }
     
}

void mouseDragged() {
  if (mouseButton == LEFT)
    scene.mouseSpinEye();
}
