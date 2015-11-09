// Based on http://www.opengl-tutorial.org/beginners-tutorials/tutorial-3-matrices/
#define GLEW_STATIC

#include <stdio.h>
#include <stdlib.h>
#include <cmath>

// open-source library 1: Access to the OpenGL 3.2 API functions
/* Use glew.h instead of gl.h to get all the GL prototypes declared */
#include "GL/glew.h"

// open-source library 2: Windows + input/output cross-platform access
#include "GL/freeglut.h"

// open-source library 3: Math library
// Include GLM
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
using namespace glm;

#include "common/shader.cpp"

// Handle to the shader program
GLuint programID;

GLuint VertexArrayID;
GLuint vertexbuffer;
GLuint MatrixID;

glm::mat4 Projection;
glm::mat4 Model;
glm::mat4 View;
glm::mat4 MVP;

int init_resources() {

    // Dark blue background
	glClearColor(0.0f, 0.0f, 0.4f, 0.0f);

	// Allocate and assign a VAO to our handle
	glGenVertexArrays(1, &VertexArrayID);
	// Bind our VAO as the current used object
	glBindVertexArray(VertexArrayID);

	// Create and compile our GLSL program from the shaders
	programID = LoadShaders( "SimpleTransform.vertexshader", "SingleColor.fragmentshader" );

	// Get a handle for our "MVP" uniform
	MatrixID = glGetUniformLocation(programID, "MVP");

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

    // Use our shader
    glUseProgram(programID);

    // Clear the screen
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Projection matrix : 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
	Projection = glm::perspective(45.0f, 4.0f / 3.0f, 0.1f, 100.0f);
	// Or, for an ortho camera :
	//glm::mat4 Projection = glm::ortho(-10.0f,10.0f,-10.0f,10.0f,0.0f,100.0f); // In world coordinates

	// Camera matrix
	View       = glm::lookAt(
								glm::vec3(4,3,3), // Camera is at (4,3,3), in World Space
								glm::vec3(0,0,0), // and looks at the origin
								glm::vec3(0,1,0)  // Head is up (set to 0,-1,0 to look upside-down)
						   );
	// Model matrix : an identity matrix (model will be at the origin)
	Model      = glm::mat4(1.0f);
	// Our ModelViewProjection : multiplication of our 3 matrices
	MVP        = Projection * View * Model; // Remember, matrix multiplication is the other way around

    // Send our transformation to the currently bound shader,
    // in the "MVP" uniform
    glUniformMatrix4fv(MatrixID, 1, GL_FALSE, &MVP[0][0]);

    // Enable attibute index 0 already set
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

    glDisableVertexAttribArray(0);

	glutSwapBuffers();
    glutPostRedisplay();
}

//libera recursos
void free_resources() {
    // Cleanup VBO and shader
	glDeleteBuffers(1, &vertexbuffer);
	glDeleteProgram(programID);
	glDeleteVertexArrays(1, &VertexArrayID);
}

int main(int argc, char* argv[]) {

    //inicia janela
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA|GLUT_DOUBLE|GLUT_DEPTH|GLUT_MULTISAMPLE);
    glutInitWindowSize(800, 450);
    glutCreateWindow("Example 3");

    GLenum glew_status = glewInit();
    if (glew_status != GLEW_OK) {
        fprintf(stderr, "Error: %s\n", glewGetErrorString(glew_status));
        return 1;
    }

    if (init_resources() != 0) {
        glutDisplayFunc(onDisplay);
        glutMainLoop();
    }

    free_resources();
    return 0;
}
