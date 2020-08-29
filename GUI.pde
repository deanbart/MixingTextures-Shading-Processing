import controlP5.*;
ControlP5 cp5;
ControlFont font;

Textlabel frameRateLabel;
Textlabel mixModeLabel;

//Variables to select texture
boolean sunTextChosen = false;
boolean moonTextChosen = false;
boolean earthTextChosen = false;

boolean rotateCam = false;

//Variables for mixing textures 
boolean mixTexture = false; //Choose to apply the mixing texture effect
boolean fadingMix = false; //Fades in from one texture to the other
int mixMode = 0; //There are 3 mixing modes to choose from 'subtle','regular' and 'obvious' (0,1,2)

void addGUIControls() {
  //GUI controls using 'ControlP5'
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  PFont p = createFont("Verdana", 18); 
  font = new ControlFont(p);
  cp5.setFont(font);

  //Slider: Set level of subdivision 
  cp5.addSlider("icolevel") 
    .setRange(1, 7) //Level range
    .setPosition(width/2-100, height-50)
    .setSize(200, 30)
    .setNumberOfTickMarks(7)
    ;

  //Button: Turn off/on camera rotation
  cp5.addButton("rotate") 
    .setPosition(width/2-220, height-50)
    .setSize(100, 30)
    ;

  //TextLabel: Used to display frame rate 
  frameRateLabel = cp5.addTextlabel("framerate")
    .setPosition(20, 20);
    
  //Dropdown List: Texture choice
  DropdownList dropTexture = cp5.addDropdownList("Select Texture")
    .setPosition(10, height-130)
    .setSize(190, height-10)
    .setItemHeight(25)
    .setBarHeight(25);
  dropTexture.addItem("Moon", 0);
  dropTexture.addItem("Sun", 1);
  dropTexture.addItem("Earth", 2);

  //Button: Turn off/on texture mixing
  cp5.addButton("mix") 
    .setPosition(width-230, height-50)
    .setSize(100, 30)
    ;
  //Button: Turn off/on fade effect when texture mixing 
  cp5.addButton("fade") 
    .setPosition(width-230, height-90)
    .setSize(100, 30)
    ;

  mixModeLabel = cp5.addTextlabel("mixmode") //Displays current mode
    .setPosition(width/2-100, 20);

  //Buttons to set Mixing Mode for texture mixing
  cp5.addButton("subtle") 
    .setPosition(width-110, height-50)
    .setSize(100, 30)
    ;
  cp5.addButton("regular") 
    .setPosition(width-110, height-85)
    .setSize(100, 30)
    ;
  cp5.addButton("obvious") 
    .setPosition(width-110, height-120)
    .setSize(100, 30)
    ;
}
void subtle() {
  mixMode = 0; //'0' Represents the 'Subtle' effect in the fragment shader
}
void regular() {
  mixMode = 1;
}
void obvious() {
  mixMode = 2;
}
void icolevel(int n) { //Set 'ICOLEVEL' slider's value equal to level of subdivision
  levels = n;
}

void rotate(boolean b) { //Toggle boolean according to the 'Rotate' button's state
  if (rotateCam ==true) {
    rotateCam =! b;
  } else {
    rotateCam = b;
  }
}
void mix(boolean b) { //Toggle boolean according to the 'Mix' button's state
  if (mixTexture ==true) {
    mixTexture =!b;
  } else {
    mixTexture = b;
  }
}
void fade(boolean b) { //Toggle boolean according to the 'Fade' button's state
  if (fadingMix ==true) {
    fadingMix =! b;
  } else {
    fadingMix = b;
  }
}

void controlEvent(ControlEvent theEvent) {
  //Logic to change between textures using the GUI components
  if (theEvent.isController()) { 
    if (theEvent.getController().getName()=="Select Texture"   
      && theEvent.getController().getValue() == 0) {
      moonTextChosen = true;
      sunTextChosen = false;
      println("Moon texture");
    }
    if (theEvent.getController().getName()=="Select Texture"   
      && theEvent.getController().getValue() == 1) {
      sunTextChosen = true;
      moonTextChosen = false;
      println("Sun texture");
    }
    if (theEvent.getController().getName()=="Select Texture" 
      && theEvent.getController().getValue() == 2) {
      earthTextChosen = true;
      moonTextChosen = false;
      sunTextChosen = false;
      println("Earth texture");
    }
  }
}

//Stops GUI components from moving in 3D space 
//http://www.sojamo.de/libraries/controlP5/examples/extra/ControlP5withPeasyCam/ControlP5withPeasyCam.pde
void removeGUIDepth() { 
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD(); //Renders in 2D
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);

  //Stops PEasy Cam movements when using controls
  if (cp5.isMouseOver()) { 
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}
