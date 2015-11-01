//
//  RWTTree.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTTree.h"
#import "tree.h"

@implementation RWTTree

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"tree" shader:shader vertices:(RWTVertex *)tree_Cylinder_tree_Vertices vertexCount:sizeof(tree_Cylinder_tree_Vertices) / sizeof(tree_Cylinder_tree_Vertices[0])])) {
    
    [self loadTexture:@"tree.png"];
    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.5;
    self.matAmbientColor = GLKVector3Make(tree_Cylinder_tree_ambient.r, tree_Cylinder_tree_ambient.g, tree_Cylinder_tree_ambient.b);
    self.matDiffuseColor = GLKVector3Make(tree_Cylinder_tree_diffuse.r, tree_Cylinder_tree_diffuse.g, tree_Cylinder_tree_diffuse.b);
    self.matSpecularColor = GLKVector3Make(tree_Cylinder_tree_specular.r, tree_Cylinder_tree_specular.g, tree_Cylinder_tree_specular.b);
    self.shininess = tree_Cylinder_tree_shininess;
    
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)aDelta {
    self.rotationZ += M_PI * aDelta;
}

@end
