//
//  RWTModel.m
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTModel.h"
#import "RWTBaseEffect.h"

@implementation RWTModel {
  char *_name;
  GLuint _vao;
  GLuint _vertexBuffer;
  GLuint _indexBuffer;
  unsigned int _vertexCount;
  unsigned int _indexCount;
  RWTBaseEffect *_shader;
}

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices
                 vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount {
  if ((self = [self init])) {
    
    // Initialize passed in variables
    _name = name;
    _vertexCount = vertexCount;
    _indexCount = indexCount;
    _shader = shader;
    
    // Create the vertex array
    glGenVertexArraysOES(1, &_vao);
    glBindVertexArrayOES(_vao);
    
    // Create vertex buffer
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(RWTVertex), vertices, GL_STATIC_DRAW);

    // Create index buffer
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
    
    // Bind vertex attributes
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
    
    // Reset bindings
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
  }
  return self;
}

- (void)render {

  [_shader prepareToDraw];
  
  glBindVertexArrayOES(_vao);
  glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  glBindVertexArrayOES(0);

}

@end