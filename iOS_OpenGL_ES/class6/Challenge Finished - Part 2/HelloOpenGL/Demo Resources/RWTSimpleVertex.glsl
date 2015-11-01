uniform highp mat4 u_ModelViewMatrix;
uniform highp mat4 u_ProjectionMatrix;

attribute vec3 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
  frag_Color = a_Color;
  gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * vec4(a_Position, 1.0);
  frag_TexCoord = a_TexCoord;
}