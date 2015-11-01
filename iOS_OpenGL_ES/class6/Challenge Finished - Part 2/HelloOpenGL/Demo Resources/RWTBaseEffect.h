//
//  RWTBaseEffect.h
//  HelloOpenGL
//
//  Created by Ray Wenderlich on 9/3/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GLKit;

@interface RWTBaseEffect : NSObject

@property (assign) GLuint programHandle;
@property (assign) GLKMatrix4 modelMatrix;
@property (assign) GLKMatrix4 modelViewMatrix;
@property (assign) GLKMatrix4 projectionMatrix;
@property (assign) GLuint texture;
@property (assign) GLuint mask;

//@property (assign) GLKVector3 lightColor;
//@property (assign) GLfloat ambientIntensity;
//@property (assign) GLfloat diffuseIntensity;
//@property (assign) GLfloat specularIntensity;
//@property (assign) GLKVector3 lightDirection;
//@property (assign) float specularPower;

- (id)initWithVertexShader:(NSString *)vertexShader
            fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
