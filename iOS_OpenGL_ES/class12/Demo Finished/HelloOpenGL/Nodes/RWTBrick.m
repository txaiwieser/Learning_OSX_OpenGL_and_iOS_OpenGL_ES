//
//  RWTBrick.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTBrick.h"
#import "brick.h"

@implementation RWTBrick

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"Brick" shader:shader vertices:(RWTVertex *)Cube_brick_Vertices vertexCount:sizeof(Cube_brick_Vertices)/sizeof(Cube_brick_Vertices[0])])) {
    [self loadTexture:@"brick.png"];
    self.width = 2.0;
    self.height = 1.0;
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)aDelta {
  
  // If there is no delta value then don't bother updating
  if (aDelta == 0) return;
  
  // Increase the amount of rotation
  self.rotationY += M_PI_4 * aDelta;
  self.rotationZ+= M_PI_4 * aDelta;
  
  [super updateWithDelta:aDelta];
  
}

@end
