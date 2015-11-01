//
//  Triangle.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "VertexInfo.h"

@implementation VertexInfo

- (id)initWithString:(NSString *)string {
    if ((self = [super init])) {
        NSArray * components = [string componentsSeparatedByString:@"/"];
        if (components.count < 3) return nil;
        self.vertexIdx = [components[0] intValue];
        self.textureCoordIdx = [components[1] intValue];
        self.normalIdx = [components[2] intValue];       
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%d, %d, %d]", _vertexIdx, _textureCoordIdx, _normalIdx];
}

@end
