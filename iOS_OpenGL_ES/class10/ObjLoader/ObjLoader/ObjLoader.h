//
//  ObjLoader.h
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjLoader : NSObject

+ (BOOL)processMtlPath:(NSString *)mtlPath objPath:(NSString *)objPath headerPath:(NSString *)headerPath implPath:(NSString *)implPath baseName:(NSString *)baseName error:(NSError **)error;

@end
