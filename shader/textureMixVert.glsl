//Code extracted from Amnon Owen 
//from https://github.com/AmnonOwed/P5_CanTut_GeometryTexturesShaders2B8/blob/master/GLSL_TextureMix/data/textureMixFrag.glsl
uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  gl_Position = transform * position;

  vertColor = color;
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
 
 }