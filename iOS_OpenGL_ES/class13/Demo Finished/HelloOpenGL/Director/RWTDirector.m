//
//  RWTDirector.m
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTDirector.h"

@implementation RWTDirector

+ (instancetype)sharedInstance {
  static dispatch_once_t pred;
  static RWTDirector *_sharedInstance;
  dispatch_once(&pred, ^{ _sharedInstance = [[self alloc] init]; });
  return _sharedInstance;
}

- (instancetype)init {
  if ((self = [super init])) {
  }
  return self;
}

@end
