//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
  GLuint _vertexBuffer;
  GLuint _indexBuffer;
  RWTBaseEffect *_shader;
  GLsizei _indexCount;
}

- (void)setupVertexBuffer {

  const static RWTVertex vertices[] = {
    {{1, -1, 0}, {1, 0, 0, 1}}, // V0
    {{1, 1, 0}, {0, 1, 0, 1}}, // V1
    {{-1, 1, 0}, {0, 0, 1, 1}}, // V2
    {{-1, -1, 0}, {0, 0, 0, 0}} // V3
  };
  
  const static GLubyte indices[] = {
    0, 1, 2,
    2, 3, 0
  };
  _indexCount = sizeof(indices) / sizeof(indices[0]);
  
  // Generate vertex buffer
  glGenBuffers(1, &_vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  
  // Generate index buffer
  glGenBuffers(1, &_indexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

}

- (void)setupShader {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
}

- (void)viewDidLoad
{
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
  
  glEnableVertexAttribArray(RWTVertexAttribPosition);
  glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Position));
  
  glEnableVertexAttribArray(RWTVertexAttribColor);
  glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Color));
  
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
  //glDrawArrays(GL_TRIANGLES, 0, 3);
  glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  
  glDisableVertexAttribArray(RWTVertexAttribPosition);
  glDisableVertexAttribArray(RWTVertexAttribColor);
  
}

@end
