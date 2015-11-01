//
//  RWTTerrain.m
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTTerrain.h"
#import "RWTBaseEffect.h"
#import "RWTVertex.h"
#import "RWTRainbow.h"

#define kNumHillKeyPoints       10
#define kNumHillSmoothSegments  10
#define kNumHillSmoothPoints    ((kNumHillKeyPoints-1)*kNumHillSmoothSegments)
#define kNumHillVertices        (kNumHillSmoothPoints*2)

#define ARC4RANDOM_MAX      0xFFFFFFFFu
CGFloat RandomFloatRange(CGFloat min, CGFloat max) {
    return ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
}

@implementation RWTTerrain {
  RWTBaseEffect *_shader;
  char *_name; 
  CGRect _rect;
  GLuint _vertexBuffer;
  CGPoint _hillKeyPoints[kNumHillKeyPoints];
  CGPoint _hillSmoothPoints[kNumHillSmoothPoints];
  RWTVertex _hillVertices[kNumHillVertices];
}

- (void) generateHillKeyPointsWithRect:(CGRect)rect {

    float startY = RandomFloatRange(rect.origin.y + rect.size.height * 0.20, rect.origin.y + rect.size.height * 0.40);

    float x = rect.origin.x;
    float y = startY;
    _hillKeyPoints[0] = CGPointMake(x, y);
    float sign=1;
  
    for(int i = 1; i < kNumHillKeyPoints - 1; ++i) {
        x += rect.size.width/(kNumHillKeyPoints - 1);
        y += sign * RandomFloatRange(rect.size.height*0.15, rect.size.height*0.25);
        sign = -sign;
        _hillKeyPoints[i] = CGPointMake(x, y);
    }
    _hillKeyPoints[kNumHillKeyPoints-1] = CGPointMake(rect.origin.x + rect.size.width, startY);
    for(int i = 0; i < kNumHillKeyPoints; ++i) {
      NSLog(@"Key point %d: %@", i, NSStringFromCGPoint(_hillKeyPoints[i]));
    }
}

- (void)generateHillSmoothPointsWithRect:(CGRect)rect {

  for (int i = 0; i < kNumHillKeyPoints; ++i) {
    CGPoint p0 = _hillKeyPoints[i];
    CGPoint p1 = _hillKeyPoints[i+1];
    float da = M_PI / (kNumHillSmoothSegments - 1);
    float ymid = (p0.y + p1.y) / 2;
    float ampl = (p0.y - p1.y) / 2;
    
    NSLog(@"p0: %@, p1: %@", NSStringFromCGPoint(p0), NSStringFromCGPoint(p1));
    
    for (int j = 0; j < kNumHillSmoothSegments; j++) {
    
      float alpha = (float)j / (float)(kNumHillSmoothSegments - 1);
      float x = (1-alpha) * p0.x + alpha * p1.x;
      float y = ymid + ampl * cosf(da*j);
            
      _hillSmoothPoints[(i*kNumHillSmoothSegments)+j] = CGPointMake(x, y);
    }
  }
  for(int i = 0; i < kNumHillSmoothPoints; ++i) {
      NSLog(@"Smooth point %d: %@", i, NSStringFromCGPoint(_hillSmoothPoints[i]));
    }
}

- (void)setHillVertexAtIndex:(int)i x:(float)x y:(float)y r:(float)r g:(float)g b:(float)b a:(float)a {
    _hillVertices[i].Position[0] = x;
    _hillVertices[i].Position[1] = y;
    _hillVertices[i].Position[2] = 0;
    _hillVertices[i].Color[0] = r;
    _hillVertices[i].Color[1] = g;
    _hillVertices[i].Color[2] = b;
    _hillVertices[1].Color[3] = a;
    NSLog(@"Point %d: %0.2f %0.2f", i, x, y);
}

- (void)generateHillVerticesWithRect:(CGRect)rect {
  for (int i = 0; i < kNumHillSmoothPoints; ++i) {
    float r, g, b;
    getRainbowColor((float)(kNumHillSmoothPoints-i) / (float)kNumHillSmoothPoints, &r, &g, &b);
    
    [self setHillVertexAtIndex:(i*2) x:_hillSmoothPoints[i].x y:_hillSmoothPoints[i].y r:r g:g b:b a:1];
    [self setHillVertexAtIndex:(i*2)+1 x:_hillSmoothPoints[i].x y:rect.origin.y r:r g:g b:b a:1];
  }
}

- (instancetype)initWithShader:(RWTBaseEffect *)shader
  rect:(CGRect)rect {

  if ((self = [super init])) {
  
    _name = "Terrain";
    _shader = shader;   
    _rect = rect;
    
    [self generateHillKeyPointsWithRect:_rect];
    [self generateHillSmoothPointsWithRect:_rect];
    [self generateHillVerticesWithRect:_rect];
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, kNumHillVertices * sizeof(RWTVertex), _hillVertices, GL_STATIC_DRAW);

  }
  return self;

}

- (void)render {
  //NSLog(@"Rendering...");
  
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
  glDrawArrays(GL_TRIANGLE_STRIP, 0, kNumHillVertices);
  //glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  
  // 3) Disable shader attribute(s)
  glDisableVertexAttribArray(RWTVertexAttribPosition);
  glDisableVertexAttribArray(RWTVertexAttribColor);
  
}

@end
