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
#import "RWTDirector.h"

static const int BRICKS_PER_COL = 8;
static const int BRICKS_PER_ROW = 9;

@implementation RWTGameScene {
  CGSize _gameArea;
  float _sceneOffset;
  RWTPaddle *_paddle;
  RWTBall *_ball;
  RWTBorder *_border;
  NSMutableArray *_bricks;
  CGPoint _previousTouchLocation;
  float _ballVelocityX;
  float _ballVelocityY;
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
    _ballVelocityX = 10;
    _ballVelocityY = 10;
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

- (CGPoint)touchLocationToGameArea:(CGPoint)touchLocation {

  float ratio = [RWTDirector sharedInstance].view.frame.size.height / _gameArea.height;
  float actualX = touchLocation.x / ratio;
  float actualY = ([RWTDirector sharedInstance].view.frame.size.height - touchLocation.y) / ratio;
  CGPoint actual = CGPointMake(actualX, actualY);
  return actual;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [touch locationInView:[RWTDirector sharedInstance].view];
  _previousTouchLocation = [self touchLocationToGameArea:touchLocation];
  

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [touch locationInView:[RWTDirector sharedInstance].view];
  touchLocation = [self touchLocationToGameArea:touchLocation];

  CGPoint diff = CGPointMake(touchLocation.x - _previousTouchLocation.x, touchLocation.y - _previousTouchLocation.y);
  _previousTouchLocation = touchLocation;
  
  float newX = _paddle.position.x + diff.x;
  newX = MIN(MAX(newX, _paddle.width/2), _gameArea.width - _paddle.width/2);
  _paddle.position = GLKVector3Make(newX, _paddle.position.y, _paddle.position.z);

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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

- (void)updateWithDelta:(NSTimeInterval)dt {
  [super updateWithDelta:dt];
  
  float newX = _ball.position.x + _ballVelocityX * dt;
  float newY = _ball.position.y + _ballVelocityY * dt;
  
  if (newX < 0) {
    newX = 0;
    _ballVelocityX = -_ballVelocityX;
  }
  if (newY < 0) {
    newY = 0;
    _ballVelocityY = -_ballVelocityY;
  }
  if (newX > 27.0) {
    newX = 27.0;
    _ballVelocityX = -_ballVelocityX;
  }
  if (newY > 48.0) {
    newY = 48.0;
    _ballVelocityY = -_ballVelocityY;
  }
  
  _ball.position = GLKVector3Make(newX, newY, _ball.position.z);
  
  CGRect ballRect = [_ball boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
  CGRect paddleRect = [_paddle boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
  
  if (CGRectIntersectsRect(ballRect, paddleRect)) {
    _ballVelocityY = -_ballVelocityY;
  }
  
  RWTBrick *brickToDestroy = nil;
  for (RWTBrick *brick in _bricks) {
    CGRect brickRect = [brick boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
    if (CGRectIntersectsRect(brickRect, ballRect)) {
      brickToDestroy = brick;
      break;
    }
  }
  
  if (brickToDestroy) {
    [self.children removeObject:brickToDestroy];
    [_bricks removeObject:brickToDestroy];
    _ballVelocityY = -_ballVelocityY;
  }
  
}

@end
