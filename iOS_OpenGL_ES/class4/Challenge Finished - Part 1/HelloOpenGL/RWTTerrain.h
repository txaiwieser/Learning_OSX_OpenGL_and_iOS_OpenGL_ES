//
//  RWTTerrain.h
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWTBaseEffect;

@interface RWTTerrain : NSObject

- (instancetype)initWithShader:(RWTBaseEffect *)shader
  rect:(CGRect)rect;
- (void)render;

@end
