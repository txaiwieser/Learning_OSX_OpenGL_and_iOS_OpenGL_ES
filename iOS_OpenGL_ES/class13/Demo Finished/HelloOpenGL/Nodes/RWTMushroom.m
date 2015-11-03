//
//  RWTMushroom.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTMushroom.h"
#import "mushroom.h"

@implementation RWTMushroom

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"mushroom" shader:shader vertices:(RWTVertex*) Mushroom_Cylinder_mushroom_Vertices vertexCount:sizeof(Mushroom_Cylinder_mushroom_Vertices) / sizeof(Mushroom_Cylinder_mushroom_Vertices[0])])) {
    
    [self loadTexture:@"mushroom.png"];
    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.5;
    //self.matColor = GLKVector4Make(1, 0, 0, 1);
  
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
  self.rotationZ += M_PI * dt;
}

@end
