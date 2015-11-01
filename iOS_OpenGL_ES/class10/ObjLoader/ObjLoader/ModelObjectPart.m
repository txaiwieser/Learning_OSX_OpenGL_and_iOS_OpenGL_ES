//
//  TriangleSet.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "ModelObjectPart.h"

@implementation ModelObjectPart

- (id)init {
    if ((self = [super init])) {
        self.material = nil;
        self.vertexInfos = [NSMutableArray array];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@, %@]", _material, _vertexInfos];
}

@end
