/**
 Part C: Mixing multiple textures ...
 Tutorial:
 -Select the subdivision via the 'Icolevel' slider, use the 'Rotate' button to rotate the camera around the shape.
 -In order to check performance, view the frame rate label which is placed in the left hand corner.
 -To mix multiple texture first select a texture of your choice using the 'Select Texture' drop-down list and then click the 'Mix button'
 -Proceed to select the Mixing mode via the 3 buttons (Subtle, Regular or Obvious)
 -You can then click on the 'Fade' button which cycles through textures by fading them on top of each other
 -It is recommended to use 'Fade' effect, with no rotation on
 */

import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam;
PShape ico;
int levels;

void setup() {
  size(1366, 768, P3D);
  addGUIControls();
  cam = new PeasyCam(this, 200);
  loadShader();
  loadTexture();
}

void draw() { 
  lights();
  background(0);
  applyShader();
  displayTexture();
  displayIco();
  if (rotateCam == true) { 
    rotateCamera();//Operated using the 'rotate' button
  }
  frameRateLabel.setValue("FPS: " + Float.toString(frameRate)); //Display fps 
  resetShader();
  removeGUIDepth();
}

void displayIco() { 
  ico = createIcosahedron(levels);
  ico.scale(60);
  shape(ico);
}
void rotateCamera() { //Note: Code extracted from my coursework 1 
  //Rotates camera around the icosahedron
  float x1;
  float z1;
  int steps = 200;
  int radius = 200;

  pushMatrix(); 
  x1= radius*sin(map(frameCount % steps, 0, steps, 0, TWO_PI));
  z1 =radius*cos(map(frameCount % steps, 0, steps, 0, TWO_PI));
  popMatrix();
  camera(x1, 50, z1, 0, 0, 0, 0, -1, 0);
}
