//Shaders
PShader textureShader; //default - displays 3 textures
PShader textureMix; // Mixes textures together
PShader liquidShader;
//Image textures 
PImage moon;
PImage sun;
PImage earth;

boolean defaultTextureShader = true;

void loadShader() {
  textureShader = loadShader("shader//texFrag.glsl", "shader//texVert.glsl");
  textureMix = loadShader("shader//textureMixFrag.glsl", "shader//texVert.glsl");
}

void applyShader() {
  if (defaultTextureShader) {
    resetShader();
    shader(textureShader);
    displayTexture();
  } 
  if (mixTexture) {
    resetShader();
    shader(textureMix);
    setMixingMode();
    textureMixing();
    if (fadingMix) { //Creates the fade effect from on texture to the other
      textureMix.set("time", millis()/8000.0); // alters the rate at which the textures are displayed
    }
  }}

void loadTexture() {
  moon = loadImage("moonTexture.jpg"); //https://www.solarsystemscope.com/textures/download/2k_moon.jpg
  sun = loadImage("sunTexture.jpg"); //https://www.solarsystemscope.com/textures/download/2k_sun.jpg
  earth = loadImage("earthTexture.jpg"); //https://www.solarsystemscope.com/textures/download/2k_earth_daymap.jpg
}

void displayTexture() { //Switches between default textures 
  if (sunTextChosen) {
    textureShader.set("texMatrix", sun); //'texMatrix' refers to the uniform variable holding the texture coordinates
  } else if (moonTextChosen) {
    textureShader.set("texMatrix", moon);
  } else if (earthTextChosen) {
    textureShader.set("texMatrix", earth);
  } else {
    resetShader();
  }
}

void textureMixing() { //Directs image files to shader
  textureMix.set("sun", sun);
  textureMix.set("moon", moon);
  textureMix.set("earth", earth);
}

void setMixingMode() { //Alters the uniform 'mixMode'variable, in the fragment shader to allow a change in mixing according to the 3 choices
  textureMix.set("mixMode", mixMode);
}
