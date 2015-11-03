//
//  RWTBall.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTBall.h"
#import "ball.h"

@implementation RWTBall

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"Ball" shader:shader vertices:(RWTVertex *)Ball_Sphere_ball_Vertices vertexCount:sizeof(Ball_Sphere_ball_Vertices)/sizeof(Ball_Sphere_ball_Vertices[0])])) {
    [self loadTexture:@"ball.png"];
    self.width = 1.0;
    self.height = 1.0;
  }
  return self;
}

@end
