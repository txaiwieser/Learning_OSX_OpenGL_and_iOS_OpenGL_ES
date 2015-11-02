//
//  RWTBorder.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTBorder.h"
#import "border.h"

@implementation RWTBorder

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"Border" shader:shader vertices:(RWTVertex *)Border_Cube_Border_Vertices vertexCount:sizeof(Border_Cube_Border_Vertices)/sizeof(Border_Cube_Border_Vertices[0])])) {
    [self loadTexture:@"border.png"];
    self.width = 27.0;
    self.height = 48.0;
  }
  return self;
}

@end
