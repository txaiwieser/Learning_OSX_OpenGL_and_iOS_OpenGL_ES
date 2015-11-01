//
//  Material.h
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Material : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float shininess;
@property (nonatomic, assign) float ambientR;
@property (nonatomic, assign) float ambientG;
@property (nonatomic, assign) float ambientB;
@property (nonatomic, assign) float diffuseR;
@property (nonatomic, assign) float diffuseG;
@property (nonatomic, assign) float diffuseB;
@property (nonatomic, assign) float specularR;
@property (nonatomic, assign) float specularG;
@property (nonatomic, assign) float specularB;
@property (nonatomic, assign) float alpha;

@end
