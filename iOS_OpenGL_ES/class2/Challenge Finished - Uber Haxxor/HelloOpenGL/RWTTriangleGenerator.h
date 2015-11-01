//
//  RWTTriangleGenerator.h
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"

@interface RWTTriangleGenerator : NSObject

@property (assign) int arms;
@property (assign) float rOuter;
@property (assign) float rInner;

- (void)generate;
- (RWTVertex *)vertices;
- (unsigned int)count;

@end
