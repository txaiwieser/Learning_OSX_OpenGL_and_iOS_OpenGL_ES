//
//  RWTModel.h
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"

@class RWTBaseEffect;
@import GLKit;

@interface RWTNode : NSObject

@property (nonatomic, strong) RWTBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;

// CHANGE: Children!
@property (nonatomic, strong) NSMutableArray *children;

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)filename;

@end
