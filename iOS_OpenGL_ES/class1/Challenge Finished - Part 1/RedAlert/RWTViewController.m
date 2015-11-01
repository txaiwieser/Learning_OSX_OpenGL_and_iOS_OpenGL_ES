//
//  RWTViewController.m
//  RedAlert
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
  float _curRed;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:view.context];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(_curRed, 0, 0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

- (void)update {
  float secsPerFlash = 2;
  _curRed = (sinf(self.timeSinceFirstResume * 2*M_PI / secsPerFlash) * 0.5) + 0.5;
}

@end
