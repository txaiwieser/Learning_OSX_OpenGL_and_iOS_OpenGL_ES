//#include <windows.h>   // use as needed for your system
#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <gl/glut.h>
#endif

#include <stdlib.h>

class GLintPoint {
public:
		GLint x, y;
};

int random(int m)
{
	return rand()%m;
}

void drawDot(GLint x, GLint y, int cor)
{
#if 1
	switch (cor) {
	case 0: glColor3f(1.0f, 0.0f, 0.0f); break;
	case 1: glColor3f(0.0f, 1.0f, 0.0f); break;
	case 2: glColor3f(0.0f, 0.0f, 1.0f); break;
	}
#else
	float r = (float) random(256) / 255.0f; 
	float g = (float) random(256) / 255.0f; 
	float b = (float) random(256) / 255.0f; 
	glColor3f(r,g,b);
#endif
	
	glBegin(GL_POINTS);
	glVertex2i(x, y);
	glEnd();
}

//<<<<<<<<<<<<<<<<<<<<<<< myInit >>>>>>>>>>>>>>>>>>>>
 void myInit(void)
 {
    glClearColor(1.0,1.0,1.0,0.0);       // set white background color
    glColor3f(0.0f, 0.0f, 1.0f);          // set the drawing color 
    glMatrixMode(GL_PROJECTION); 
    glLoadIdentity();
    gluOrtho2D(0.0, 320.0, 0.0, 320.0);
    glMatrixMode(GL_MODELVIEW); 
}

void Sierpinski(void) 
{
  GLintPoint T[3]= {{10,10},{300,30},{200, 300}};
  
  int index = random(3);         // 0, 1, or 2 equally likely 
  GLintPoint point = T[index]; 	 // initial point
  glPointSize(4.0f);
  drawDot(point.x, point.y, 0);     // draw initial point 
  for(int i = 0; i < 10000; i++) {  // draw 1000 dots {
    index = random(3); 	
    point.x = (point.x + T[index].x) / 2;
    point.y = (point.y + T[index].y) / 2;

    drawDot(point.x,point.y, i % 3);  
    //   if (i%1000==0) for (int j=0; j<100000; j++) {};
    glFlush();
  } 
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
  glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 
  Sierpinski();   
  glFlush();		                 // send all output to display 
}

//<<<<<<<<<<<<<<<<<<<<<<<< main >>>>>>>>>>>>>>>>>>>>>>
int main(int argc, char** argv)
{
  glutInit(&argc, argv);          // initialize the toolkit
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); // set display mode
  glutInitWindowSize(640,640);     // set window size
  glutInitWindowPosition(200, 150); // set window position on screen
  glutCreateWindow("sierpinski triangle"); // open the screen window
  glutDisplayFunc(myDisplay);     // register redraw function
  myInit();                   
  glutMainLoop(); 		     // go into a perpetual loop
  return 0;
}
