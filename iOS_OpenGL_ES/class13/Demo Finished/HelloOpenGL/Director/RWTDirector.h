//
//  RWTDirector.h
//  HelloOpenGL
//
//  Created by Main Account on 3/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTDirector : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, strong) UIView *view;

@end
