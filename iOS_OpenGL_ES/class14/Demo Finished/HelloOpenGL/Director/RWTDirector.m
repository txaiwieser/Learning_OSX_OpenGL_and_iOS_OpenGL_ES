//
//  RWTDirector.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTDirector.h"

@implementation RWTDirector {
  AVAudioPlayer *_backgroundMusicPlayer;
  AVAudioPlayer *_popEffect;
}

+ (instancetype)sharedInstance {
  static dispatch_once_t pred;
  static RWTDirector *_sharedInstance;
  dispatch_once(&pred, ^{ _sharedInstance = [[self alloc] init]; });
  return _sharedInstance;
}

- (instancetype)init {
  if ((self = [super init])) {
    _popEffect = [self preloadSoundEffect:@"pop.wav"];
  }
  return self;
}

- (void)playBackgroundMusic:(NSString *)filename {
  _backgroundMusicPlayer = [self preloadSoundEffect:filename];
  _backgroundMusicPlayer.numberOfLoops = -1;
  [_backgroundMusicPlayer play];
}

- (AVAudioPlayer *)preloadSoundEffect:(NSString *)filename {
  NSURL *URL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
  AVAudioPlayer *retval = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
  [retval prepareToPlay];
  return retval;
}

- (void)playPopEffect {
  [_popEffect play];
}

@end
