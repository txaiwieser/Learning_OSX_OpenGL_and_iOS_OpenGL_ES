//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
#import "RWTSquare.h"
#import "RWTCube.h"
#import "RWTCone.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTSquare *_square;
  RWTCube *_cube;
  RWTCone *_cone;
  BOOL _shaking;
  float _shakeDuration;
  float _shakeOffset;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  
  _square = [[RWTSquare alloc] initWithShader:_shader];
  _square.rotationX = -GLKMathDegreesToRadians(90);
  _square.position = GLKVector3Make(0, -5, 0);
  float squareScale = 10;
  _square.scaleX = squareScale;
  _square.scaleY = squareScale;
  _square.scaleZ = squareScale;
  
  _cube = [[RWTCube alloc] initWithShader:_shader];

  _cone = [[RWTCone alloc] initWithShader:_shader];
  _cone.position = GLKVector3Make(0, -5, 0);
  _cone.velocity = GLKVector3Make(0, 2, 0);
  
  _shaking = YES;
  
  _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width/self.view.bounds.size.height, 1, 150);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
  [EAGLContext setCurrentContext:view.context];
  
  [self setupScene];
  
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(0, 0, 0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);

  GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0, _shakeOffset, -10, _cone.position.x, _cone.position.y + _shakeOffset, _cone.position.z, 0, 1, 0);
  
  [_square renderWithParentModelViewMatrix:viewMatrix];
  //[_cube renderWithParentModelViewMatrix:viewMatrix];
  [_cone renderWithParentModelViewMatrix:viewMatrix];
}

- (void)update {

  if (_shaking) {
    _shakeDuration += self.timeSinceLastUpdate;
    if (_shakeDuration >= 2) {
      _shaking = NO;
      _shakeOffset = 0;
    } else {
      _shakeOffset = sin(CACurrentMediaTime()*M_PI*20) * 0.1;
      NSLog(@"Shake duration: %0.2f, offset: %0.2f", _shakeDuration, _shakeOffset);
    }
  }

  [_square updateWithDelta:self.timeSinceLastUpdate];
  //[_cube updateWithDelta:self.timeSinceLastUpdate];
  [_cone updateWithDelta:self.timeSinceLastUpdate];
}

@end
