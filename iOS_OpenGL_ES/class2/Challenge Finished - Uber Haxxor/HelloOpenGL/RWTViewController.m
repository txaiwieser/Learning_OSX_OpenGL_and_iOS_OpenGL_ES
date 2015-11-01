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
#import "RWTTriangleGenerator.h"

@implementation RWTViewController {
  GLuint _vertexBuffer;
  RWTBaseEffect *_shader;
  int _curTriangle;
  RWTTriangleGenerator *_gen;
}

- (void)setupVertexBuffer {
  
  // Create triangle generator
  _gen = [[RWTTriangleGenerator alloc] init];
  _gen.arms = 5;
  _gen.rOuter = 1.0;
  _gen.rInner = 0.5;
  [_gen generate];
  
  // Create vertex buffer
  glGenBuffers(1, &_vertexBuffer);
  
  // Bind buffer to "GL_ARRAY_BUFFER" slot in context
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  
  // Send data from CPU -> GPU memory
  glBufferData(GL_ARRAY_BUFFER, [_gen count] * sizeof(RWTVertex), [_gen vertices], GL_STATIC_DRAW);
  
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
  
  // 2) Issue draw command
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glDrawArrays(GL_TRIANGLES, 0, _gen.count);
  //glDrawArrays(GL_LINE_STRIP, 0, _curTriangle);
  
  // 3) Disable shader attribute(s)
  glDisableVertexAttribArray(RWTVertexAttribPosition);
}

- (void)refresh {
  [_gen generate];
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, [_gen count] * sizeof(RWTVertex), [_gen vertices], GL_STATIC_DRAW);
}

- (IBAction)armsValueChanged:(UISlider *)sender {
  _gen.arms = sender.value;
  [self refresh];
}

- (IBAction)outerValueChanged:(UISlider *)sender {
  _gen.rOuter = sender.value;
  [self refresh];
}

- (IBAction)innerValueChanged:(UISlider *)sender {
  _gen.rInner = sender.value;
  [self refresh];
}

@end
