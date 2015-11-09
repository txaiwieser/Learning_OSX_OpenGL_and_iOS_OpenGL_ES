// Include GLFW


/* Use glew.h instead of gl.h to get all the GL prototypes declared */
#include <OpenGl/OpenGL.h>

// open-source library 2: Windows + input/output cross-platform access
#include <GLUT/glut.h>
// Include GLM
#include "glm.hpp"

#ifndef SHADER_HPP
#define SHADER_HPP

GLuint LoadShaders(const char * vertex_file_path,const char * fragment_file_path);

#endif
