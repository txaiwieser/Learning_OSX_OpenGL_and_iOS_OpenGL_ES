typedef enum {
  RWTVertexAttribPosition = 0,
  RWTVertexAttribColor,
  RWTVertexAttribTexCoord,
  RWTVertexAttribNormal
} RWTVertexAttributes;

typedef struct {
  GLfloat Position[3];
  GLfloat Color[4];
  GLfloat TexCoord[2];
  GLfloat Normal[3];
} RWTVertex;