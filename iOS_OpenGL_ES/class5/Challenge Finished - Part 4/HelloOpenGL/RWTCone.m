//
//  RWTCone.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTCone.h"

@implementation RWTCone

const static RWTVertex Vertices[] = {
  // Face 1: Red
  {{1, 0, 0.5}, {1, 0, 0, 1}},
  {{0, 1, 0}, {1, 0, 0, 1}},
  {{0, 0, 1}, {1, 0, 0, 1}},
  
  // Face (2, 6, 1): Orange
  {{1, 0, -0.5}, {1, 0.5, 0, 1}},
  {{0, 1, 0}, {1, 0.5, 0, 1}},
  {{1, 0, 0.5}, {1, 0.5, 0, 1}},
  
  // Face (3, 6, 2): Yellow
  {{0, 0, -1}, {1, 1, 0, 1}},
  {{0, 1, 0}, {1, 1, 0, 1}},
  {{1, 0, -0.5}, {1, 1, 0, 1}},
  
  // Face (4, 6, 3): Green
  {{-1, 0, -0.5}, {0, 1, 0.2, 1}},
  {{0, 1, 0}, {0, 1, 0.2, 1}},
  {{0, 0, -1}, {0, 1, 0.2, 1}},
  
  // Face (5, 6, 4): Blue
  {{-1, 0, 0.5}, {0, 0.3, 1, 1}},
  {{0, 1, 0}, {0, 0.3, 1, 1}},
  {{-1, 0, -0.5}, {0, 0.3, 1, 1}},
  
  // Face (0, 6, 5): Purple
  {{0, 0, 1}, {0.7, 0, 1, 1}},
  {{0, 1, 0}, {0.7, 0, 1, 1}},
  {{-1, 0, 0.5}, {0.7, 0, 1, 1}},
  
};

const static GLubyte Indices[] = {
  0, 1, 2,
  3, 4, 5,
  6, 7, 8,
  9, 10, 11,
  12, 13, 14,
  15, 16, 17
};

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  
  if ((self = [super initWithName:"cone" shader:shader
                         vertices:(RWTVertex *)Vertices
                      vertexCount:sizeof(Vertices) / sizeof(Vertices[0])
                         inidices:(GLubyte *)Indices
                       indexCount:sizeof(Indices) / sizeof(Indices[0])])) {
    
    self.scaleX = 0.25;
    self.scaleZ = 0.25;
    self.scaleY = 2.0;
    
  }
  return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
  [super updateWithDelta:aDelta];
  self.rotationY += M_PI * aDelta;
}

@end
