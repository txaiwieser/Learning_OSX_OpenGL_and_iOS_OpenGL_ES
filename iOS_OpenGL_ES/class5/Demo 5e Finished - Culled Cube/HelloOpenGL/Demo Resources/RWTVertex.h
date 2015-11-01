typedef enum {
  RWTVertexAttribPosition = 0,
  RWTVertexAttribColor
} RWTVertexAttributes;

typedef struct {
  GLfloat Position[3];
  GLfloat Color[4];
} RWTVertex;