//
//  ModelObject.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "ModelObject.h"

@implementation ModelObject

- (id)init {
    if ((self = [super init])) {
        self.name = nil;
        self.vertices = [NSMutableArray array];
        self.textureCoords = [NSMutableArray array];
        self.normals = [NSMutableArray array];
        self.modelObjectParts = [NSMutableArray array];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@: Vertices %@, Texture Coords %@, Normals %@, Model Object Parts %@]", _name, _vertices, _textureCoords, _normals, _modelObjectParts];
}

@end
