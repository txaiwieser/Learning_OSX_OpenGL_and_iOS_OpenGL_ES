varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

uniform sampler2D u_Texture;
uniform highp float u_MatSpecularIntensity;
uniform highp float u_Shininess;
uniform lowp vec3 u_MatAmbientColor;
uniform lowp vec3 u_MatSpecularColor;
uniform lowp vec3 u_MatDiffuseColor;

struct Light {
  lowp vec3 Color;
  lowp float AmbientIntensity;
  lowp float DiffuseIntensity;
  lowp vec3 Direction;
};
uniform Light u_Light;

void main(void) {

  // Ambient
  lowp vec3 AmbientColor = u_Light.Color * u_MatAmbientColor;
  
  // Diffuse
  lowp vec3 Normal = normalize(frag_Normal);
  lowp float DiffuseFactor = max(-dot(Normal, u_Light.Direction), 0.0);
  lowp vec3 DiffuseColor = u_Light.Color * u_MatDiffuseColor * DiffuseFactor;

  // Specular
  lowp vec3 Eye = normalize(frag_Position);
  lowp vec3 Reflection = reflect(u_Light.Direction, Normal);
  lowp float SpecularFactor = pow(max(0.0, -dot(Reflection, Eye)), u_Shininess);
  lowp vec3 SpecularColor = u_Light.Color * u_MatSpecularColor * SpecularFactor;

  gl_FragColor = texture2D(u_Texture, frag_TexCoord) * vec4((AmbientColor + DiffuseColor + SpecularColor), 1.0);
}