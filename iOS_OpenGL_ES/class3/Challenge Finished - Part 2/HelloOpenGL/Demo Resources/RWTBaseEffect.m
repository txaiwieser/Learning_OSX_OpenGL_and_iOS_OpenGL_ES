//
//  RWTBaseEffect.m
//  HelloOpenGL
//
//  Created by Ray Wenderlich on 9/3/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "RWTBaseEffect.h"
#import "RWTVertex.h"

@implementation RWTBaseEffect {
  GLuint _programHandle;
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
  NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
  NSError* error;
  NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
  if (!shaderString) {
    NSLog(@"Error loading shader: %@", error.localizedDescription);
    exit(1);
  }
  
  GLuint shaderHandle = glCreateShader(shaderType);
  
  const char * shaderStringUTF8 = [shaderString UTF8String];
  int shaderStringLength = [shaderString length];
  glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
  
  glCompileShader(shaderHandle);
  
  GLint compileSuccess;
  glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
  if (compileSuccess == GL_FALSE) {
    GLchar messages[256];
    glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
    NSString *messageString = [NSString stringWithUTF8String:messages];
    NSLog(@"%@", messageString);
    exit(1);
  }
  
  return shaderHandle;
}

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader {
  GLuint vertexShaderName = [self compileShader:vertexShader
                                       withType:GL_VERTEX_SHADER];
  GLuint fragmentShaderName = [self compileShader:fragmentShader
                                         withType:GL_FRAGMENT_SHADER];
  
  _programHandle = glCreateProgram();
  glAttachShader(_programHandle, vertexShaderName);
  glAttachShader(_programHandle, fragmentShaderName);
  
  glBindAttribLocation(_programHandle, RWTVertexAttribPosition, "a_Position");
  glBindAttribLocation(_programHandle, RWTVertexAttribColor, "a_Color");
  
  glLinkProgram(_programHandle);
  
  GLint linkSuccess;
  glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
  if (linkSuccess == GL_FALSE) {
    GLchar messages[256];
    glGetProgramInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
    NSString *messageString = [NSString stringWithUTF8String:messages];
    NSLog(@"%@", messageString);
    exit(1);
  }
}

- (void)prepareToDraw {
  glUseProgram(_programHandle);
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:
(NSString *)fragmentShader {
  if ((self = [super init])) {
    [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
  }
  return self;
}

@end