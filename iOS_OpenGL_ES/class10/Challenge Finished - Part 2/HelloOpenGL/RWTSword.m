//
//  RWTSword.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTSword.h"
#import "sword.h"

@implementation RWTSword

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"sword" shader:shader vertices:(RWTVertex *)Cube_sword_Vertices vertexCount:sizeof(Cube_sword_Vertices) / sizeof(Cube_sword_Vertices[0])])) {
    
    [self loadTexture:@"sword.png"];
    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.5;
    
    self.matAmbientColor = GLKVector3Make(Cube_sword_ambient.r, Cube_sword_ambient.g, Cube_sword_ambient.b);
    self.matDiffuseColor = GLKVector3Make(Cube_sword_diffuse.r, Cube_sword_diffuse.g, Cube_sword_diffuse.b);
    self.matSpecularColor = GLKVector3Make(Cube_sword_specular.r, Cube_sword_specular.g, Cube_sword_specular.b);
    self.shininess = Cube_sword_shininess;
    
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)aDelta {
    self.rotationZ += M_PI * aDelta;
}

@end
