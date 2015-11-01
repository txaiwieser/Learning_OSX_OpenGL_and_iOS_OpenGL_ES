//
//  Material.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "Material.h"

@implementation Material

- (NSString *) description {
    return [NSString stringWithFormat:@"%@: ambient [%0.2f, %0.2f, %0.2f], diffuse [%0.2f %0.2f %0.2f], specular [%0.2f, %0.2f, %0.2f], shininess %0.2f, alpha %0.2f", _name, _ambientR, _ambientG, _ambientB, _diffuseR, _diffuseG, _diffuseB, _specularR, _specularG, _specularB, _shininess, _alpha];
}

@end
