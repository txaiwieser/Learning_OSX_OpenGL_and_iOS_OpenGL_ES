//
//  main.m
//  ObjLoader
//
//  Created by Main Account on 8/5/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjLoader.h"

typedef NS_ENUM(int, ReturnCodes) {
    ReturnCodeSuccess = 0,
    ReturnCodeNoSuchObjFile,
    ReturnCodeFailedToProcessObjFile
};

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        if (argc < 2) {
            printf("Usage: %s [path to obj file]\r\n", argv[0]);
            return ReturnCodeSuccess;
        }
        
        NSFileManager * fm = [NSFileManager new];
        
        // Get mtl path and dir path
        NSString * objPath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        NSString * dirPath = [objPath stringByDeletingLastPathComponent];
        if (dirPath.length == 0) {
            dirPath = [fm currentDirectoryPath];
        }
        
        if (![fm fileExistsAtPath:objPath]) {
            objPath = [dirPath stringByAppendingPathComponent:objPath];
            printf("Mtl path: %s\r\n", [objPath cStringUsingEncoding:NSUTF8StringEncoding]);
            if (![fm fileExistsAtPath:objPath]) {
                printf("Error: %s does not exist\r\n", argv[1]);
                return ReturnCodeNoSuchObjFile;
            }
        }
        
        // Get other paths based on mtl path
        NSString * baseName = [objPath lastPathComponent];
        baseName = [baseName stringByDeletingPathExtension];
        NSString * mtlPath = [[dirPath stringByAppendingPathComponent:baseName] stringByAppendingPathExtension:@"mtl"];
        NSString * headerPath = [[dirPath stringByAppendingPathComponent:baseName] stringByAppendingPathExtension:@"h"];
        NSString * implPath = [[dirPath stringByAppendingPathComponent:baseName] stringByAppendingPathExtension:@"m"];
        
        printf("Mtl path: %s\r\n", [mtlPath cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("Obj path: %s\r\n", [objPath cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("Header path: %s\r\n", [headerPath cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("Impl path: %s\r\n", [implPath cStringUsingEncoding:NSUTF8StringEncoding]);

        // Process away!
        NSError *error;
        BOOL success = [ObjLoader processMtlPath:mtlPath objPath:objPath headerPath:headerPath implPath:implPath baseName:baseName error:&error];
        if (!success) {
            const char * errorMessage = [error.localizedDescription cStringUsingEncoding:NSUTF8StringEncoding];
            printf("Failed to process obj file: %s\r\n", errorMessage);
            return ReturnCodeFailedToProcessObjFile;
        } else {
            printf("Success!\r\n");
            return ReturnCodeSuccess;
        }
        
    }
    return 0;
}

