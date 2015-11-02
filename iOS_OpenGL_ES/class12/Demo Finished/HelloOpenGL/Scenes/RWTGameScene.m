//
//  RWTGameScene.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTGameScene.h"
#import "RWTPaddle.h"
#import "RWTBall.h"
#import "RWTBorder.h"
#import "RWTBrick.h"

static const int BRICKS_PER_COL = 8;
static const int BRICKS_PER_ROW = 9;

@implementation RWTGameScene {
  CGSize _gameArea;
  float _sceneOffset;
  RWTPaddle *_paddle;
  RWTBall *_ball;
  RWTBorder *_border;
  NSMutableArray *_bricks;
}

- (instancetype)initWithShader:(RWTBaseEffect *)shader {

  if ((self = [super initWithName:"RWTGameScene" shader:shader vertices:nil vertexCount:0])) {
  
    // Create the initial scene position (i.e. camera)
    _gameArea = CGSizeMake(27, 48);
    _sceneOffset = _gameArea.height/2 / tanf(GLKMathDegreesToRadians(85.0/2));
    self.position = GLKVector3Make(-_gameArea.width/2, -_gameArea.height/2 + 10, -_sceneOffset);
    self.rotationX = GLKMathDegreesToRadians(-20);
    
    // Create paddle near bottom of screen
    _paddle = [[RWTPaddle alloc] initWithShader:shader];
    _paddle.position = GLKVector3Make(_gameArea.width/2, _gameArea.height * 0.05, 0);
    _paddle.matColor = GLKVector4Make(1, 0, 0, 1);
    [self.children addObject:_paddle];
    
    // Create ball right above paddle
    _ball = [[RWTBall alloc] initWithShader:shader];
    _ball.position = GLKVector3Make(_gameArea.width/2, _gameArea.height * 0.1, 0);
    _ball.matColor = GLKVector4Make(0.5, 0.9, 0, 1);
    [self.children addObject:_ball];
    
    // Add border in center of screen
    _border = [[RWTBorder alloc] initWithShader:shader];
    _border.position = GLKVector3Make(_gameArea.width/2, _gameArea.height/2, 0);
    [self.children addObject:_border];
    
    // Generate colors for brisks
    GLKVector4 colors[BRICKS_PER_ROW];
    for (int i = 0; i < BRICKS_PER_ROW; i++) {
      colors[i] = [self color:(float)(BRICKS_PER_ROW-i) / (float)BRICKS_PER_ROW];
    }
    
    // Generate array of bricks
    _bricks = [NSMutableArray arrayWithCapacity:72];
    for (int j = 0; j < BRICKS_PER_COL; ++j) {
      for (int i = 0; i < BRICKS_PER_ROW; ++i) {
      
        RWTBrick *brick = [[RWTBrick alloc] initWithShader:shader];
        float margin = _gameArea.width * 0.1;
        float startY = _gameArea.height * 0.5;
        brick.position = GLKVector3Make(margin + (margin * i), startY + (margin * j), 0);
        brick.matColor = colors[i];
        [self.children addObject:brick];
        [_bricks addObject:brick];
      
      }
    }
    
  }
  return self;
}

// http://stackoverflow.com/questions/470690/how-to-automatically-generate-n-distinct-colors
- (GLKVector4)color:(float)x {
	float r = 0.0f;
	float g = 0.0f;
	float b = 1.0f;
	if (x >= 0.0f && x < 0.2f) {
		x = x / 0.2f;
		r = 0.0f;
		g = x;
		b = 1.0f;
	} else if (x >= 0.2f && x < 0.4f) {
		x = (x - 0.2f) / 0.2f;
		r = 0.0f;
		g = 1.0f;
		b = 1.0f - x;
	} else if (x >= 0.4f && x < 0.6f) {
		x = (x - 0.4f) / 0.2f;
		r = x;
		g = 1.0f;
		b = 0.0f;
	} else if (x >= 0.6f && x < 0.8f) {
		x = (x - 0.6f) / 0.2f;
		r = 1.0f;
		g = 1.0f - x;
		b = 0.0f;
	} else if (x >= 0.8f && x <= 1.0f) {
		x = (x - 0.8f) / 0.2f;
		r = 1.0f;
		g = 0.0f;
		b = x;
	}
	return GLKVector4Make(r, g, b, 1.0);
}

@end
