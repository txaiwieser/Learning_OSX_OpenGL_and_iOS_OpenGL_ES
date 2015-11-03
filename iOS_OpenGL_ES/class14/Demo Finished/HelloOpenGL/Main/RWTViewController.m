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
#import "RWTGameScene.h"
#import "RWTDirector.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTGameScene *_scene;
}

- (void)setupScene {
  
  [RWTDirector sharedInstance].view = self.view;
  [[RWTDirector sharedInstance] playBackgroundMusic:@"bulletstorm_bg_v1.mp3"];

  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _scene = [[RWTGameScene alloc] initWithShader:_shader];
  _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
  
  [RWTDirector sharedInstance].scene = _scene;
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
  
  GLKMatrix4 viewMatrix = GLKMatrix4Identity;
  [[RWTDirector sharedInstance].scene renderWithParentModelViewMatrix:viewMatrix];
}

- (void)update {
  [[RWTDirector sharedInstance].scene updateWithDelta:self.timeSinceLastUpdate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [[RWTDirector sharedInstance].scene touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [[RWTDirector sharedInstance].scene touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [[RWTDirector sharedInstance].scene touchesEnded:touches withEvent:event];
}

@end
