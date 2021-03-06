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
#import "RWTTree.h"
#import "RWTSword.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTTree *_tree;
  RWTSword *_sword;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _tree = [[RWTTree alloc] initWithShader:_shader];
  _sword = [[RWTSword alloc] initWithShader:_shader];
  _sword.position = GLKVector3Make(0, 2, 0);
  _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
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
  glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  
  GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
  viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
  
  [_tree renderWithParentModelViewMatrix:viewMatrix];
  [_sword renderWithParentModelViewMatrix:viewMatrix];
  
}

- (void)update {
  [_tree updateWithDelta:self.timeSinceLastUpdate];
  [_sword updateWithDelta:self.timeSinceLastUpdate];
}

@end
