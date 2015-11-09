// Based on http://www.opengl-tutorial.org/beginners-tutorials/tutorial-2-the-first-triangle/
#define GLEW_STATIC

#include <stdio.h>
#include <stdlib.h>
#include <cmath>

// Open-source library 1: Access to the OpenGL 3.2 API functions
/* Use glew.h instead of gl.h to get all the GL prototypes declared */
// open-source library 1: Access to the OpenGL 3.2 API functions
/* Use glew.h instead of gl.h to get all the GL prototypes declared */
#include <OpenGl/OpenGL.h>

// open-source library 2: Windows + input/output cross-platform access
#include <GLUT/glut.h>

// open-source library 3: Math library
// Include GLM
#include "glm.hpp"

using namespace glm;

// Handle to the shader program
GLuint programID;

GLuint VertexArrayID;
GLuint vertexbuffer;

int init_resources() {

    // Dark blue background
	glClearColor(0.0f, 0.0f, 0.4f, 0.0f);

    // Allocate and assign a VAO to our handle
	glGenVertexArrays(1, &VertexArrayID);
	// Bind our VAO as the current used object
	glBindVertexArray(VertexArrayID);

	// Create and compile our GLSL program from the shaders
	programID = LoadShaders( "SimpleVertexShader.vertexshader", "SimpleFragmentShader.fragmentshader" );

    // Triangle created using 3 points in GLfloat
	static const GLfloat g_vertex_buffer_data[] = {
	    // x     y     z
		-1.0f, -1.0f, 0.0f, // v1
		 1.0f, -1.0f, 0.0f, // v2
		 0.0f,  1.0f, 0.0f, // v3
	};
	// Allocate and assign a VBO to our handle
	glGenBuffers(1, &vertexbuffer);
	// Bind our VBO as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
	// Copy the data of the triangle crated to the VBO buffer
	glBufferData(GL_ARRAY_BUFFER, sizeof(g_vertex_buffer_data), g_vertex_buffer_data, GL_STATIC_DRAW);

	return 1;
}

//metodo para desenhar
void onDisplay() {

    // Clear the screen
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Use our shader
    glUseProgram(programID);

    // Enable attibute index 0
    glEnableVertexAttribArray(0);
	// Bind our VBO as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    // Specify how the data buffer below is organized
	glVertexAttribPointer(
        0,                  // attribute 0. No particular reason for 0, but must match the layout in the shader.
        3,                  // size
        GL_FLOAT,           // type
        GL_FALSE,           // normalized?
        0,                  // stride
        NULL            // array buffer offset
    );

    // Draw the triangle !
    glDrawArrays(GL_TRIANGLES, 0, 3); // 3 indices starting at 0 -> 1 triangle

	glutSwapBuffers();
    glutPostRedisplay();
}

//libera recursos
void free_resources() {
    glDeleteBuffers(1, &vertexbuffer);
	glDeleteVertexArrays(1, &VertexArrayID);
	glDeleteProgram(programID);
}

int main(int argc, char* argv[]) {

    //inicia janela
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA|GLUT_DOUBLE|GLUT_DEPTH|GLUT_MULTISAMPLE);
    glutInitWindowSize(800, 450);
    glutCreateWindow("Example 2");


    if (init_resources() != 0) {
        glutDisplayFunc(onDisplay);
        glutMainLoop();
    }

    free_resources();
    return 0;
}

