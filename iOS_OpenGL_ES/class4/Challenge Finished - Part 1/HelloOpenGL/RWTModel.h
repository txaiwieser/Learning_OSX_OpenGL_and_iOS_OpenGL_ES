//
//  RWTModel.h
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"

@class RWTBaseEffect;

@interface RWTModel : NSObject

@property (nonatomic, strong) RWTBaseEffect *shader;

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount;
- (void)render;

@end