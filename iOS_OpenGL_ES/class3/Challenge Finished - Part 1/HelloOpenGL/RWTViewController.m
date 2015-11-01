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
#import "RWTRainbow.h"

#define kNumHillKeyPoints       10
#define kNumHillVertices        (kNumHillKeyPoints)

@implementation RWTViewController {
  GLuint _vertexBuffer;
  GLuint _indexBuffer;
  GLsizei _indexCount;
  RWTBaseEffect *_shader;
  CGPoint _hillKeyPoints[kNumHillKeyPoints];
  RWTVertex _hillVertices[kNumHillVertices];
  CGRect _rect;
}

#define ARC4RANDOM_MAX      0xFFFFFFFFu
CGFloat RandomFloatRange(CGFloat min, CGFloat max) {
    return ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
}

- (void) generateHillKeyPoints {
    float x = _rect.origin.x;
    float y = _rect.origin.y;
    _hillKeyPoints[0] = CGPointMake(x, y);
    for(int i = 1; i < kNumHillKeyPoints - 1; ++i) {
        x += _rect.size.width/(kNumHillKeyPoints - 1);
        y = RandomFloatRange(_rect.origin.y, 
          _rect.origin.y + _rect.size.height);
        _hillKeyPoints[i] = CGPointMake(x, y);
    }
    _hillKeyPoints[kNumHillKeyPoints-1] = CGPointMake(
      _rect.origin.x + _rect.size.width, _rect.origin.y);
}

- (void)setHillVertexAtIndex:(int)i x:(float)x y:(float)y 
  r:(float)r g:(float)g b:(float)b a:(float)a {
    _hillVertices[i].Position[0] = x;
    _hillVertices[i].Position[1] = y;
    _hillVertices[i].Position[2] = 0;
    _hillVertices[i].Color[0] = r;
    _hillVertices[i].Color[1] = g;
    _hillVertices[i].Color[2] = b;
    _hillVertices[1].Color[3] = a;
    NSLog(@"Point %d: %0.2f %0.2f", i, x, y);
}

- (void)generateHillVertices {
  for (int i = 0; i < kNumHillKeyPoints; ++i) {
    float r, g, b;
    getRainbowColor((float)(kNumHillKeyPoints-i) / 
      (float)kNumHillKeyPoints, &r, &g, &b);
    
    [self setHillVertexAtIndex:i x:_hillKeyPoints[i].x 
      y:_hillKeyPoints[i].y r:r g:g b:b a:1];
  }
}

- (void)setupVertexBuffer {
  
  _rect = CGRectMake(-1, -1, 2, 2);
  [self generateHillKeyPoints];
  [self generateHillVertices];
  
  // Create vertex buffer
  glGenBuffers(1, &_vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, kNumHillVertices * sizeof(RWTVertex), _hillVertices, GL_STATIC_DRAW);

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
  glDrawArrays(GL_LINE_STRIP, 0, kNumHillVertices);
  //glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  
  // 3) Disable shader attribute(s)
  glDisableVertexAttribArray(RWTVertexAttribPosition);
  glDisableVertexAttribArray(RWTVertexAttribColor);
}

@end
