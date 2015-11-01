//
//  RWTSquare.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTSquare.h"

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

@implementation RWTSquare

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"square" shader:shader vertices:(RWTVertex *)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) inidices:(GLubyte *)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
  
  }
  return self;
}

@end
