//
//  TriangleSet.h
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VertexInfo.h"
#import "Material.h"

@interface ModelObjectPart : NSObject

@property (nonatomic, strong) Material *material;
@property (nonatomic, strong) NSMutableArray *vertexInfos;

@end
