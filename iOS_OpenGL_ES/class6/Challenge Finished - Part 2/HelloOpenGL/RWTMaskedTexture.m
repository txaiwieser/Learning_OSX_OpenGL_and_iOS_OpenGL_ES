//
//  RWTMaskedTexture.m
//  HelloOpenGL
//
//  Created by Main Account on 3/22/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTMaskedTexture.h"

const static RWTVertex Vertices[] = {
    {{1, -1, 1}, {1, 1, 1, 1}, {1, 0}}, // 0
    {{1, 1, 1}, {1, 1, 1, 1}, {1, 1}}, // 1
    {{-1, 1, 1}, {1, 1, 1, 1}, {0, 1}}, // 2
    {{-1, -1, 1}, {1, 1, 1, 1}, {0, 0}}, // 3
};

const static GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
};

@implementation RWTMaskedTexture

- (instancetype)initWithShader:(RWTBaseEffect *)shader texture:(NSString *)texture mask:(NSString *)mask {

  if ((self = [super initWithName:"square" shader:shader
    vertices:(RWTVertex *)Vertices
    vertexCount:sizeof(Vertices) / sizeof(Vertices[0])
    inidices:(GLubyte *)Indices
    indexCount:sizeof(Indices) / sizeof(Indices[0])])) {
    
    self.texture = [self loadTexture:texture];
    if (mask) {
      self.mask = [self loadTexture:mask];
    }

  }
  return self;
}

@end
