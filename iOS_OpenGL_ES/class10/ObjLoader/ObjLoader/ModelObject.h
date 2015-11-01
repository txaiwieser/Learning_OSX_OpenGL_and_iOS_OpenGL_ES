//
//  ModelObject.h
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelObjectPart.h"
#import "Vector3.h"
#import "Vector2.h"

@interface ModelObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *vertices;
@property (nonatomic, strong) NSMutableArray *textureCoords;
@property (nonatomic, strong) NSMutableArray *normals;
@property (nonatomic, strong) NSMutableArray *modelObjectParts;

@end
