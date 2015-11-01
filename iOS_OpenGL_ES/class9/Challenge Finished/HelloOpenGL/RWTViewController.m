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
#import "RWTCube.h"

@interface RWTViewController ()
@property (weak, nonatomic) IBOutlet UISlider *lightXSlider;
@property (weak, nonatomic) IBOutlet UISlider *lightYSlider;
@property (weak, nonatomic) IBOutlet UISlider *lightZSlider;
@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTCube *_cube;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _cube = [[RWTCube alloc] initWithShader:_shader];
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
  
  GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5);
  viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
  
  [_cube renderWithParentModelViewMatrix:viewMatrix];
  
}

- (void)update {
  [_cube updateWithDelta:self.timeSinceLastUpdate];
}

- (IBAction)ambientValueChanged:(UISlider *)sender {
  _shader.ambientIntensity = sender.value;
}

- (IBAction)diffuseValueChanged:(UISlider *)sender {
  _shader.diffuseIntensity = sender.value;
}

- (IBAction)specularValueChanged:(UISlider *)sender {
  _shader.specularIntensity = sender.value;
}

- (IBAction)specularPowerChanged:(UISlider *)sender {
  _shader.specularPower = sender.value;
}

- (void)refreshLight {
  _shader.lightDirection = GLKVector3Normalize(GLKVector3Make(self.lightXSlider.value, self.lightYSlider.value, self.lightZSlider.value));
}

- (IBAction)lightValueChanged:(id)sender {
  [self refreshLight];
}

@end
