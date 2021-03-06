//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTBaseEffect.h"
#import "RWTSquare.h"
#import "RWTTerrain.h"

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTSquare *_square;
  RWTTerrain *_terrain;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _square = [[RWTSquare alloc] initWithShader:_shader];
  _terrain = [[RWTTerrain alloc] initWithShader:_shader rect:CGRectMake(-1, -1, 2, 2)];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:view.context];
  
  [self setupScene];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
  
  //[_square render];
  [_terrain render];
}

@end
