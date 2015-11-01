//
//  RWTMaskedTexture.h
//  HelloOpenGL
//
//  Created by Main Account on 3/22/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTModel.h"

@interface RWTMaskedTexture : RWTModel

- (instancetype)initWithShader:(RWTBaseEffect *)shader texture:(NSString *)texture mask:(NSString *)mask;

@end
