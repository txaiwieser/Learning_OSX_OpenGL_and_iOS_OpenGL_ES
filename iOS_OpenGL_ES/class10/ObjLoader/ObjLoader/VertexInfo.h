//
//  Triangle.h
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VertexInfo : NSObject

@property (nonatomic, assign) int vertexIdx;
@property (nonatomic, assign) int textureCoordIdx;
@property (nonatomic, assign) int normalIdx;

- (id)initWithString:(NSString *)string;

@end
