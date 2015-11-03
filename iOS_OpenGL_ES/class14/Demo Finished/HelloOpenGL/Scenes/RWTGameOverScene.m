//
//  RWTGameOverScene.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTGameOverScene.h"
#import "RWTYouLose.h"
#import "RWTYouWin.h"
#import "RWTGameScene.h"
#import "RWTDirector.h"

@implementation RWTGameOverScene {
  GLfloat _timeSinceStart;
}

- (instancetype)initWithShader:(RWTBaseEffect *)shader win:(BOOL)win {
  if ((self = [super initWithName:"RWTGameOverScene" shader:shader vertices:nil vertexCount:0])) {
  
    CGSize gameArea = CGSizeMake(27, 48);
    float sceneOffset = gameArea.height/2 / tanf(GLKMathRadiansToDegrees(85.0/2));
    self.position = GLKVector3Make(-gameArea.width/2, -gameArea.height/2 + 10, -sceneOffset);
    self.rotationX = GLKMathDegreesToRadians(-45);
    
    RWTNode *message;
    if (win) {
      message = [[RWTYouWin alloc] initWithShader:self.shader];
      message.matColor = GLKVector4Make(0, 1, 0, 1);
    } else {
      message = [[RWTYouLose alloc] initWithShader:self.shader];
      message.matColor = GLKVector4Make(1, 0, 0, 1);
    }
    message.position = GLKVector3Make(13.5, 24, 0);
    [self.children addObject:message];
  
  }
  return self;
  
}

- (void)updateWithDelta:(NSTimeInterval)dt {
  [super updateWithDelta:dt];
  
  _timeSinceStart += dt;
  if (_timeSinceStart > 5) {
    [RWTDirector sharedInstance].scene = [[RWTGameScene alloc] initWithShader:self.shader];
  }
}

@end
