//
//  RWTPaddle.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTPaddle.h"
#import "paddle.h"

@implementation RWTPaddle

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"Paddle" shader:shader vertices:(RWTVertex *)Paddle_Cube_paddle_Vertices vertexCount:sizeof(Paddle_Cube_paddle_Vertices)/sizeof(Paddle_Cube_paddle_Vertices[0])])) {
    [self loadTexture:@"paddle.png"];
    self.width = 5.0;
    self.height = 1.0;
    
  }
  return self;
}

@end
