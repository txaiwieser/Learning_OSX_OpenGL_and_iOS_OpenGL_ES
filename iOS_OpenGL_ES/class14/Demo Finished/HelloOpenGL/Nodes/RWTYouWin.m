//
//  RWTYouWin.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTYouWin.h"
#import "youwin.h"

@implementation RWTYouWin

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"YouWin" shader:shader vertices:(RWTVertex *)Text_Mesh_youwin_Vertices vertexCount:sizeof(Text_Mesh_youwin_Vertices)/sizeof(Text_Mesh_youwin_Vertices[0])])) {
    [self loadTexture:@"youwin.png"];
    self.rotationX = M_PI * 1/8;
    self.scale = 4.0;
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)aDelta {
  
  // If there is no delta value then don't bother updating
  if (aDelta == 0) return;
  
  // Increase the amount of rotation
  float amplitude = 0.5;
  float periodMod = 2;
  float periodicAmt = sin(CACurrentMediaTime()*periodMod) * amplitude * aDelta;
  self.rotationX += M_PI * periodicAmt;
  self.scale += 2.5*periodicAmt;
  
  [super updateWithDelta:aDelta];
  
}

@end
