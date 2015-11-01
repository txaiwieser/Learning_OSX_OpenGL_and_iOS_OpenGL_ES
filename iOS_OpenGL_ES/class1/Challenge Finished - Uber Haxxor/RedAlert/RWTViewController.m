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
  float _curVal;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  self.secsPerFlash = 2.0;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(_curVal * self.rMult, _curVal * self.gMult, _curVal * self.bMult, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

- (void)update {
  _curVal = (sinf(self.timeSinceFirstResume * 50*M_PI / _secsPerFlash) * 0.5) + 0.5;
}

@end
