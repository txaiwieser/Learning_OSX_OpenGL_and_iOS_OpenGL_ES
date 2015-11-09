// Based on http://www.opengl-tutorial.org/beginners-tutorials/tutorial-6-keyboard-and-mouse/
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
#include "common/texture.cpp"

#define PI 3.14159265

GLuint programID;
GLuint VertexArrayID;
GLuint vertexbuffer;
GLuint uvbuffer;
GLuint MatrixID;
GLuint TextureID;
GLuint Texture;

glm::mat4 Projection;
glm::mat4 Model;
glm::mat4 View;
glm::mat4 MVP;

GLboolean upPressed;
GLboolean downPressed;
GLboolean leftPressed;
GLboolean rightPressed;

GLfloat rotY, speed, speedRot, posX, posY, posZ;

void initializeGlobals()
{
    upPressed = false;
	downPressed = false;
	leftPressed = false;
	rightPressed = false;
	rotY=45;
	speed=0.05;
	speedRot=2.0;
	posX=-10.0;
	posY=0.0;
	posZ=10.0;
}

int init_resources() {

   // Dark blue background
	glClearColor(0.0f, 0.0f, 0.4f, 0.0f);
	// Enable depth test
	glEnable(GL_DEPTH_TEST);
	// Accept fragment if it closer to the camera than the former one
	glDepthFunc(GL_LESS);

	// Allocate and assign a VAO to our handle
	glGenVertexArrays(1, &VertexArrayID);
	// Bind our VAO as the current used object
	glBindVertexArray(VertexArrayID);

	// Create and compile our GLSL program from the shaders
	programID = LoadShaders( "TransformVertexShader.vertexshader", "TextureFragmentShader.fragmentshader" );
    // Get a handle for our "MVP" uniform
	MatrixID = glGetUniformLocation(programID, "MVP");
	// Load the texture
	Texture = loadBMP_custom("uvtemplate.bmp");
	// Get a handle for our "myTextureSampler" uniform
	TextureID  = glGetUniformLocation(programID, "myTextureSampler");

	initializeGlobals();

	 // Our vertices. Tree consecutive floats give a 3D vertex; Three consecutive vertices give a triangle.
	// A cube has 6 faces with 2 triangles each, so this makes 6*2=12 triangles, and 12*3 vertices
	static const GLfloat g_vertex_buffer_data[] = {
		-1.0f,-1.0f,-1.0f,
		-1.0f,-1.0f, 1.0f,
		-1.0f, 1.0f, 1.0f,
		 1.0f, 1.0f,-1.0f,
		-1.0f,-1.0f,-1.0f,
		-1.0f, 1.0f,-1.0f,
		 1.0f,-1.0f, 1.0f,
		-1.0f,-1.0f,-1.0f,
		 1.0f,-1.0f,-1.0f,
		 1.0f, 1.0f,-1.0f,
		 1.0f,-1.0f,-1.0f,
		-1.0f,-1.0f,-1.0f,
		-1.0f,-1.0f,-1.0f,
		-1.0f, 1.0f, 1.0f,
		-1.0f, 1.0f,-1.0f,
		 1.0f,-1.0f, 1.0f,
		-1.0f,-1.0f, 1.0f,
		-1.0f,-1.0f,-1.0f,
		-1.0f, 1.0f, 1.0f,
		-1.0f,-1.0f, 1.0f,
		 1.0f,-1.0f, 1.0f,
		 1.0f, 1.0f, 1.0f,
		 1.0f,-1.0f,-1.0f,
		 1.0f, 1.0f,-1.0f,
		 1.0f,-1.0f,-1.0f,
		 1.0f, 1.0f, 1.0f,
		 1.0f,-1.0f, 1.0f,
		 1.0f, 1.0f, 1.0f,
		 1.0f, 1.0f,-1.0f,
		-1.0f, 1.0f,-1.0f,
		 1.0f, 1.0f, 1.0f,
		-1.0f, 1.0f,-1.0f,
		-1.0f, 1.0f, 1.0f,
		 1.0f, 1.0f, 1.0f,
		-1.0f, 1.0f, 1.0f,
		 1.0f,-1.0f, 1.0f
	};

	// Two UV coordinates for each vertex. They were created with Blender.
	static const GLfloat g_uv_buffer_data[] = {
		0.000059f, 1.0f-0.000004f,
		0.000103f, 1.0f-0.336048f,
		0.335973f, 1.0f-0.335903f,
		1.000023f, 1.0f-0.000013f,
		0.667979f, 1.0f-0.335851f,
		0.999958f, 1.0f-0.336064f,
		0.667979f, 1.0f-0.335851f,
		0.336024f, 1.0f-0.671877f,
		0.667969f, 1.0f-0.671889f,
		1.000023f, 1.0f-0.000013f,
		0.668104f, 1.0f-0.000013f,
		0.667979f, 1.0f-0.335851f,
		0.000059f, 1.0f-0.000004f,
		0.335973f, 1.0f-0.335903f,
		0.336098f, 1.0f-0.000071f,
		0.667979f, 1.0f-0.335851f,
		0.335973f, 1.0f-0.335903f,
		0.336024f, 1.0f-0.671877f,
		1.000004f, 1.0f-0.671847f,
		0.999958f, 1.0f-0.336064f,
		0.667979f, 1.0f-0.335851f,
		0.668104f, 1.0f-0.000013f,
		0.335973f, 1.0f-0.335903f,
		0.667979f, 1.0f-0.335851f,
		0.335973f, 1.0f-0.335903f,
		0.668104f, 1.0f-0.000013f,
		0.336098f, 1.0f-0.000071f,
		0.000103f, 1.0f-0.336048f,
		0.000004f, 1.0f-0.671870f,
		0.336024f, 1.0f-0.671877f,
		0.000103f, 1.0f-0.336048f,
		0.336024f, 1.0f-0.671877f,
		0.335973f, 1.0f-0.335903f,
		0.667969f, 1.0f-0.671889f,
		1.000004f, 1.0f-0.671847f,
		0.667979f, 1.0f-0.335851f
	};

    // Allocate and assign a VBO (vertex) to our handle
	glGenBuffers(1, &vertexbuffer);
	// Bind our VBO (vertex) as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
	// Copy the data of the triangle crated to the VBO (vertex) buffer
	glBufferData(GL_ARRAY_BUFFER, sizeof(g_vertex_buffer_data), g_vertex_buffer_data, GL_STATIC_DRAW);

    // Allocate and assign a VBO (color) to our handle
	glGenBuffers(1, &uvbuffer);
	// Bind our VBO (color) as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, uvbuffer);
	// Copy the data of the triangle crated to the VBO (color) buffer
	glBufferData(GL_ARRAY_BUFFER, sizeof(g_uv_buffer_data), g_uv_buffer_data, GL_STATIC_DRAW);

	return 1;
}

void updateState()
{
    if(leftPressed)
    {
        rotY -= speedRot;
    }
    else
    if(rightPressed)
    {
        rotY += speedRot;
    }
    else
    if(upPressed)
    {
        posX += speed * sin(rotY*PI/180);
        posZ += -speed * cos(rotY*PI/180);
    }
    //check
    else
    if(downPressed)
    {
        posX += -speed * sin(rotY*PI/180);
        posZ += speed * cos(rotY*PI/180);
    }
}

//metodo para desenhar
void onDisplay() {

    updateState();

    // Clear the screen
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Use our shader
    glUseProgram(programID);

    // Projection matrix : 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
	Projection = glm::perspective(45.0f, 4.0f / 3.0f, 0.1f, 100.0f);
	// Camera matrix
	View       = glm::lookAt(
								glm::vec3(posX,posY + speed * abs(sin(rotY*PI/180)),posZ), // Eye
								glm::vec3(posX + sin(rotY*PI/180),posY + speed * abs(cos(rotY*PI/180)),posZ - cos(rotY*PI/180)), // Look
								glm::vec3(0,1,0)  // Up
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
    // Bind our VBO (vertex) as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    // Specify how the data buffer below is organized - 1rst attribute buffer : vertices
    glVertexAttribPointer(
        0,                  // attribute. No particular reason for 0, but must match the layout in the shader.
        3,                  // size
        GL_FLOAT,           // type
        GL_FALSE,           // normalized?
        0,                  // stride
        NULL            // array buffer offset
    );

    // Enable attibute index 0 already set
    glEnableVertexAttribArray(1);
    // Bind our VBO (color) as being the active buffer and storing vertex attributes (coordinates)
	glBindBuffer(GL_ARRAY_BUFFER, uvbuffer);
    // Specify how the data buffer below is organized - 2nd attribute buffer : colors
    glVertexAttribPointer(
        1,                                // attribute. No particular reason for 1, but must match the layout in the shader.
        2,                                // size
        GL_FLOAT,                         // type
        GL_FALSE,                         // normalized?
        0,                                // stride
        NULL                          // array buffer offset
    );

    // Bind our texture in Texture Unit 0
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, Texture);
    // Set our "myTextureSampler" sampler to user Texture Unit 0
    glUniform1i(TextureID, 0);

    // Draw the triangle !
    glDrawArrays(GL_TRIANGLES, 0, 12*3); // 12*3 indices starting at 0 -> 12 triangles

	glutSwapBuffers();
    glutPostRedisplay();
}

void onKeyboardUp(unsigned char key, int x, int y) {
    switch (key) {
		case 119: //w
			upPressed = false;
			break;
		case 115: //s
			downPressed = false;
			break;
		case 97: //a
			leftPressed = false;
			break;
		case 100: //d
			rightPressed = false;
			break;

		case 27:
			exit(0);
			break;
		default:
			break;
	}
}

void onKeyboardDown(unsigned char key, int x, int y) {
    switch (key) {
		case 119: //w
			upPressed = true;
			break;
		case 115: //s
			downPressed = true;
			break;
		case 97: //a
			leftPressed = true;
			break;
		case 100: //d
			rightPressed = true;
			break;

		case 27:
			exit(0);
			break;
		default:
			break;
	}
}

//libera recursos
void free_resources() {
    // Cleanup VBO and shader
	glDeleteBuffers(1, &vertexbuffer);
	glDeleteBuffers(1, &uvbuffer);
	glDeleteProgram(programID);
	glDeleteTextures(1, &TextureID);
	glDeleteVertexArrays(1, &VertexArrayID);
}


int main(int argc, char* argv[]) {

    //inicia janela
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA|GLUT_DOUBLE|GLUT_DEPTH|GLUT_MULTISAMPLE);
    glutInitWindowSize(800, 450);
    glutCreateWindow("Example 6");

    GLenum glew_status = glewInit();
    if (glew_status != GLEW_OK) {
        fprintf(stderr, "Error: %s\n", glewGetErrorString(glew_status));
        return 1;
    }

    if (init_resources() != 0) {
        glutDisplayFunc(onDisplay);
        glutKeyboardFunc(onKeyboardDown);
        glutKeyboardUpFunc(onKeyboardUp);
        glutMainLoop();
    }

    free_resources();
    return 0;
}

