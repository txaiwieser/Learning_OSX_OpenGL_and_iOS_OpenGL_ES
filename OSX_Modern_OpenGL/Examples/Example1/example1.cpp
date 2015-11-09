// Based on http://www.opengl-tutorial.org/beginners-tutorials/tutorial-1-opening-a-window/
#define GLEW_STATIC

#include <stdio.h>
#include <stdlib.h>
#include <cmath>

// open-source library 1: Access to the OpenGL 3.2 API functions
/* Use glew.h instead of gl.h to get all the GL prototypes declared */
#include <OpenGl/OpenGL.h>

// open-source library 2: Windows + input/output cross-platform access
#include <GLUT/glut.h>

// open-source library 3: Math library
// Include GLM
#include "glm.hpp"
using namespace glm;

int init_resources() {

    glClearColor(1.0f, 1.0f, 1.0f, 0.0f);

	return 1;
}

//metodo para desenhar
void onDisplay() {

    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glutSwapBuffers();
    glutPostRedisplay();
}

//libera recursos
void free_resources() {



}

int main(int argc, char* argv[]) {

    //inicia janela
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA|GLUT_DOUBLE|GLUT_DEPTH|GLUT_MULTISAMPLE);
    glutInitWindowSize(800, 450);
    glutCreateWindow("Example 1");



    if (init_resources() != 0) {
        glutDisplayFunc(onDisplay);
        glutMainLoop();
    }

    free_resources();
    return 0;
}
