//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTBaseEffect.h"
#import "RWTVertex.h"

@implementation RWTViewController {
  GLuint _vertexBuffer;
  GLuint _indexBuffer;
  GLsizei _indexCount;
  RWTBaseEffect *_shader;
}

- (void)setupVertexBuffer {
  
  // Vertex data
  const static RWTVertex vertices[] = {
    {{1, -1, 0},  {1, 0, 0, 1}}, // V0, Red
    {{1, 1, 0}, {0, 1, 0, 1}}, // V1, Green
    {{-1, 1, 0}, {0, 0, 1, 1}}, // V2, Blue
    {{-1, -1, 0}, {0, 0, 0, 1}} // V3, Black
  };

  const static GLubyte indices[] = {
       0, 1, 2,
       2, 3, 0
  };
  _indexCount = sizeof(indices) / sizeof(indices[0]);
  
  // Create vertex buffer
  glGenBuffers(1, &_vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  // Create index buffer
  glGenBuffers(1, &_indexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
  
}

- (void)setupShader {
  // Set up shader (more on this later)
  // This will place the vertices exactly where you set them, colored white
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:view.context];
  
  [self setupShader];
  [self setupVertexBuffer];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
  
  [_shader prepareToDraw];
  
  // 1) Enable shader attribute(s)
  glEnableVertexAttribArray(RWTVertexAttribPosition);
  glVertexAttribPointer(
    RWTVertexAttribPosition, // Vertex attribute index
    3, // Number of components per vertex attribute
    GL_FLOAT, // Type of component
    GL_FALSE, // Specifies whether values should be normalized
    sizeof(RWTVertex), // Stride
    (const GLvoid *) offsetof(RWTVertex, Position) // Offset from 1st component
  );
  glEnableVertexAttribArray(RWTVertexAttribColor);
  glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Color));
  
  // 2) Issue draw command
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
  glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  
  // 3) Disable shader attribute(s)
  glDisableVertexAttribArray(RWTVertexAttribPosition);
  glDisableVertexAttribArray(RWTVertexAttribColor);
}

@end
