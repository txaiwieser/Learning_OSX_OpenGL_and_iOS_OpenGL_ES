//
//  RWTTestScene.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTTestScene.h"
#import "RWTMushroom.h"

@implementation RWTTestScene {
  RWTMushroom *_mushroom;
}

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"RWTestScene" shader:shader vertices:nil vertexCount:0])) {
  
    _mushroom = [[RWTMushroom alloc] initWithShader:shader];
    [self.children addObject:_mushroom];
    
    self.position = GLKVector3Make(0, -1, -5);
  
  }
  return self;
}

@end
