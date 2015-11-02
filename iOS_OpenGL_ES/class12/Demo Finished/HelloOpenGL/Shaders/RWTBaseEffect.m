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
  GLuint _modelViewMatrixUniform;
  GLuint _projectionMatrixUniform;
  GLuint _texUniform;
  GLuint _lightColorUniform;
  GLuint _lightAmbientIntensityUniform;
  GLuint _lightDiffuseIntensityUniform;
  GLuint _lightDirectionUniform;
  GLuint _matSpecularIntensityUniform;
  GLuint _shininessUniform;
  GLuint _matColorUniform;
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
  glBindAttribLocation(_programHandle, RWTVertexAttribTexCoord, "a_TexCoord");
  glBindAttribLocation(_programHandle, RWTVertexAttribNormal, "a_Normal");
  
  glLinkProgram(_programHandle);
  
  self.modelViewMatrix = GLKMatrix4Identity;
  _modelViewMatrixUniform = glGetUniformLocation(_programHandle, "u_ModelViewMatrix");
  _projectionMatrixUniform = glGetUniformLocation(_programHandle, "u_ProjectionMatrix");
  _texUniform = glGetUniformLocation(_programHandle, "u_Texture");
  _lightColorUniform = glGetUniformLocation(_programHandle, "u_Light.Color");
  _lightAmbientIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.AmbientIntensity");
  _lightDiffuseIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.DiffuseIntensity");
  _lightDirectionUniform = glGetUniformLocation(_programHandle, "u_Light.Direction");
  _matSpecularIntensityUniform = glGetUniformLocation(_programHandle, "u_MatSpecularIntensity");
  _shininessUniform = glGetUniformLocation(_programHandle, "u_Shininess");
  _matColorUniform = glGetUniformLocation(_programHandle, "u_MatColor");
  
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
  glUniformMatrix4fv(_modelViewMatrixUniform, 1, 0, self.modelViewMatrix.m);
  glUniformMatrix4fv(_projectionMatrixUniform, 1, 0, self.projectionMatrix.m);
  
  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, self.texture);
  glUniform1i(_texUniform, 1);
  
  glUniform3f(_lightColorUniform, 1, 1, 1);
  glUniform1f(_lightAmbientIntensityUniform, 0.1);
  GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
  glUniform3f(_lightDirectionUniform, lightDirection.x, lightDirection.y, lightDirection.z);
  glUniform1f(_lightDiffuseIntensityUniform, 0.7);
  glUniform1f(_matSpecularIntensityUniform, 2.0);
  glUniform1f(_shininessUniform, 8.0);
  glUniform4f(_matColorUniform, self.matColor.r, self.matColor.g, self.matColor.b, self.matColor.a);
  
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:
(NSString *)fragmentShader {
  if ((self = [super init])) {
    [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
  }
  return self;
}

@end