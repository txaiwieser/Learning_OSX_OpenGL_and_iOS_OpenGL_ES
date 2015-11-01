//
//  RWTTriangleGenerator.m
//  HelloOpenGL
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTTriangleGenerator.h"
#import "RWTVertex.h"

#import <vector>

@implementation RWTTriangleGenerator {
  std::vector<RWTVertex> _vertices;
}

- (void)generate {
  _vertices.clear();
  
  float angle = M_PI / self.arms;
  RWTVertex center = {{0, 0, 0}};
  
  for (int i = 0; i < 2 * self.arms; i++) {
    double r = (i & 1) == 0 ? self.rInner : self.rOuter;
    RWTVertex vertex;
    vertex.Position[0] = cosf((i * angle)-angle/2) * r;
    vertex.Position[1] = sinf((i * angle)-angle/2) * r;
    vertex.Position[2] = 0;
    _vertices.push_back(vertex);
    if (_vertices.size() % 3 == 0) {
      int lastIndex = _vertices.size();
      _vertices.push_back(_vertices[lastIndex-1]);
      _vertices.push_back(center);
      _vertices.push_back(_vertices[lastIndex-3]);
      _vertices.push_back(_vertices[lastIndex-1]);
    }
  }
  int lastIndex = _vertices.size()-1;
  _vertices.push_back(_vertices[0]);
  _vertices.push_back(center);
  _vertices.push_back(_vertices[0]);
  _vertices.push_back(_vertices[lastIndex-1]);
  
  NSLog(@"- - - - -");
  for (std::vector<RWTVertex>::iterator pos = _vertices.begin(); pos != _vertices.end(); ++pos) {
    RWTVertex vertex = *pos;
    NSLog(@"%f %f %f", vertex.Position[0], vertex.Position[1], vertex.Position[2]);
  }
  
}

- (RWTVertex *)vertices {
  return _vertices.data();
}

- (unsigned int)count {
  return _vertices.size();
}

@end
