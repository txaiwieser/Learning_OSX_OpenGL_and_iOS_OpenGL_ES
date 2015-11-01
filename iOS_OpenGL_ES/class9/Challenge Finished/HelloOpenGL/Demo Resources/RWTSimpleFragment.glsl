varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

uniform sampler2D u_Texture;
uniform highp float u_MatSpecularIntensity;
uniform highp float u_Shininess;

struct Light {
  lowp vec3 Color;
  lowp float AmbientIntensity;
  lowp float DiffuseIntensity;
  lowp vec3 Direction;
};
uniform Light u_Light;

void main(void) {

  // Ambient
  lowp vec4 AmbientColor = vec4(u_Light.Color, 1.0) * u_Light.AmbientIntensity;
  
  // Diffuse
  lowp vec3 Normal = normalize(frag_Normal);
  lowp float DiffuseFactor = max(-dot(Normal, u_Light.Direction), 0.0);
  lowp vec4 DiffuseColor = vec4(u_Light.Color, 1.0) * u_Light.DiffuseIntensity * DiffuseFactor;
  
  // Specular
  lowp vec3 Eye = normalize(frag_Position);
  lowp vec3 Reflection = reflect(u_Light.Direction, Normal);
  lowp float SpecularFactor = pow(max(0.0, -dot(Reflection, Eye)), u_Shininess);
  highp vec4 SpecularColor = vec4(u_Light.Color, 1.0) * u_MatSpecularIntensity * SpecularFactor;
  
  gl_FragColor = texture2D(u_Texture, frag_TexCoord) * (AmbientColor + DiffuseColor + SpecularColor);

}