//
//  RWTModel.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTModel.h"
#import "RWTBaseEffect.h"

@implementation RWTModel {
  char *_name;
  GLuint _vao;
  GLuint _vertexBuffer;
  GLuint _indexBuffer;
  unsigned int _vertexCount;
  unsigned int _indexCount;
  RWTBaseEffect *_shader;
}

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount inidices:(GLubyte *)indices indexCount:(unsigned int)indexCount {
  if ((self = [super init])) {
    
    _name = name;
    _vertexCount = vertexCount;
    _indexCount = indexCount;
    _shader = shader;
    self.position = GLKVector3Make(0, 0, 0);
    self.rotationX = 0;
    self.rotationY = 0;
    self.rotationZ = 0;
    self.scale = 1.0;
    
    if (self.shader) {
    
      glGenVertexArraysOES(1, &_vao);
      glBindVertexArrayOES(_vao);
      
      // Generate vertex buffer
      glGenBuffers(1, &_vertexBuffer);
      glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
      glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(RWTVertex), vertices, GL_STATIC_DRAW);
      
      // Generate index buffer
      glGenBuffers(1, &_indexBuffer);
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
      glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);

      // Enable vertex attributes
      glEnableVertexAttribArray(RWTVertexAttribPosition);
      glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Position));
      glEnableVertexAttribArray(RWTVertexAttribColor);
      glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Color));
      glEnableVertexAttribArray(RWTVertexAttribTexCoord);
      glVertexAttribPointer(RWTVertexAttribTexCoord, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, TexCoord));
      glEnableVertexAttribArray(RWTVertexAttribNormal);
      glVertexAttribPointer(RWTVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Normal));
      
      glBindVertexArrayOES(0);
      glBindBuffer(GL_ARRAY_BUFFER, 0);
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
  }
  return self;
}

- (GLKMatrix4)modelMatrix {
  GLKMatrix4 modelMatrix = GLKMatrix4Identity;
  modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
  modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
  modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
  modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
  modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
  return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {

  if (!self.shader) return;
  
  GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
  _shader.modelMatrix = [self modelMatrix];
  _shader.modelViewMatrix = modelViewMatrix;
  _shader.texture = self.texture;
  [_shader prepareToDraw];

  glBindVertexArrayOES(_vao);
  glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
  glBindVertexArrayOES(0);

}

- (void)updateWithDelta:(NSTimeInterval)dt {

}

- (void)loadTexture:(NSString *)filename {
  
  NSError *error;
  NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
  
  NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
  GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
  if (info == nil) {
    NSLog(@"Error loading file: %@", error.localizedDescription);
  } else {
    self.texture = info.name;
  }
}

@end
