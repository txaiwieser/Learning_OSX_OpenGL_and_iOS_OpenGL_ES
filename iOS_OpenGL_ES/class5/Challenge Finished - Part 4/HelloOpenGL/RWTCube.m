//
//  RWTCube.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTCube.h"

const static RWTVertex Vertices[] = {
  // Front
  {{1, -1, 1}, {1, 0, 0, 1}},  // 0
  {{1, 1, 1}, {1, 0, 0, 1}},   // 1
  {{-1, 1, 1}, {0, 1, 0, 1}},  // 2
  {{-1, -1, 1}, {0, 1, 0, 1}}, // 3
  
  // Back
  {{-1, -1, -1}, {1, 0, 0, 1}}, // 4
  {{-1, 1, -1}, {1, 0, 0, 1}},  // 5
  {{1, 1, -1}, {0, 1, 0, 1}},   // 6
  {{1, -1, -1}, {0, 1, 0, 1}},  // 7
};

const static GLubyte Indices[] = {
  // Front
  0, 1, 2,
  2, 3, 0,
  // Back
  4, 5, 6,
  6, 7, 4,
  // Left
  3, 2, 5,
  5, 4, 3,
  // Right
  7, 6, 1,
  1, 0, 7,
  // Top
  1, 6, 5,
  5, 2, 1,
  // Bottom
  3, 4, 7,
  7, 0, 3
};

@implementation RWTCube

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  
  if ((self = [super initWithName:"square" shader:shader vertices:(RWTVertex *)Vertices vertexCount:sizeof(Vertices) / sizeof(Vertices[0]) inidices:(GLubyte *)Indices indexCount:sizeof(Indices) / sizeof(Indices[0])])) {
    
  }
  return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
  self.rotationZ += M_PI * aDelta;
  self.rotationY += M_PI * aDelta;
}

@end
