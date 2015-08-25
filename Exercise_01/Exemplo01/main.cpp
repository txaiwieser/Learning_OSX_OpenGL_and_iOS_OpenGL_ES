/******************************************************/
/* Not so awesome Cube - 3D fractal with openGL       */
/* Copyleft (c) 2013. Ridlo W. Wibowo                 */
/* If you are using this program,                     */
/*      please comment to the related post in         */
/*      https://astrokode.wordpress.com/               */
/******************************************************/

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <gl/glut.h>
#endif

#include <stdlib.h>

/* initial parameter */
double x_i = -1.5;
double y_i = -1.5;
double z_i = -1.5;
double length_i = 3.0;
int level_i = 3; // orde fractal

bool fullscreen = false;
bool mouseDown = false;

float x_rot = 0.0f;
float y_rot = 0.0f;

float x_diff = 0.0f;
float y_diff = 0.0f;

// draw the solid square
void DrawCube(double x, double y, double z, double length){
    glBegin(GL_QUADS);
    glColor3f(0.0, 1.0, 1.0);
    glVertex3f(x, y, z);
    glVertex3f(x+length, y, z);
    glVertex3f(x+length, y+length, z);
    glVertex3f(x, y+length, z);
    
    glColor3f(1.0, 1.0, 0.0);
    glVertex3f(x+length, y, z);
    glVertex3f(x+length, y, z+length);
    glVertex3f(x+length, y+length, z+length);
    glVertex3f(x+length, y+length, z);
    
    glColor3f(0.5, 0.5, 0.8);
    glVertex3f(x+length, y, z+length);
    glVertex3f(x, y, z+length);
    glVertex3f(x, y+length, z+length);
    glVertex3f(x+length, y+length, z+length);
    
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(x, y, z+length);
    glVertex3f(x, y, z);
    glVertex3f(x, y+length, z);
    glVertex3f(x, y+length, z+length);
    
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(x, y+length, z);
    glVertex3f(x+length, y+length, z);
    glVertex3f(x+length, y+length, z+length);
    glVertex3f(x, y+length, z+length);
    
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(x, y, z+length);
    glVertex3f(x+length, y, z+length);
    glVertex3f(x+length, y, z);
    glVertex3f(x, y, z);
    glEnd();
}

/* rekursif */
void DrawRecur(double x, double y, double z, double length, int orde){
    if (orde == 0){
        DrawCube(x, y, z, length);
    } else{
        length = length/3.;
        for (int i=0;i<3;i++){
            for (int j=0;j<3;j++){
                for (int k=0;k<3;k++){
                    if (i==1 && j==1 || i==1 && k==1 || j==1 && k==1 || i==1 && j==1 && k==1){
                        continue; // membuat lubang <span class="wp-smiley wp-emoji wp-emoji-bigsmile" title=":D">:D</span>
                    } else {
                        DrawRecur(x+i*length, y+j*length, z+k*length, length, orde-1); // membuat kotak
                    }
                }}}
    }
}

void init(){
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_COLOR_MATERIAL);
    
    //  glEnable(GL_LIGHTING);
    //  glEnable(GL_LIGHT0);
    glEnable(GL_NORMALIZE);
    glShadeModel(GL_SMOOTH);
    glLoadIdentity ();
    //  glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
    
    //  GLfloat acolor[] = {1.5, 1.5, 1.5, 1.0};
    //  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, acolor);
}


/* menampilkan */
void display(){
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_MODELVIEW);
    glClearColor(1.0f, 1.0f, 1.0f, 0.0f);
    glLoadIdentity();
    
    gluLookAt(0.0f, 0.0f, 10.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f);
    
    glRotatef(x_rot, 1.0f, 0.0f, 0.0f);
    glRotatef(y_rot, 0.0f, 1.0f, 0.0f);
    
    DrawRecur(x_i, y_i, z_i, length_i, level_i);
    
    glFlush();
    glutSwapBuffers();
}


/* agar smooth kalau layar di resize */
void resize(int w, int h){
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glViewport(0, 0, w, h);
    gluPerspective(45.0f, 1.0f * w / h, 1.0f, 100.0f);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void keyboard(unsigned char key, int x, int y){
    switch(key){
        case 27 :
            exit(1); break;
    }
}

void specialKeyboard(int key, int x, int y){
    if (key == GLUT_KEY_F1){
        fullscreen = !fullscreen;
        
        if (fullscreen)
            glutFullScreen();
        else{
            glutReshapeWindow(500, 500);
            glutPositionWindow(50, 50);
        }
    }
}

void mouse(int button, int state, int x, int y){
    if (button == GLUT_LEFT_BUTTON && state == GLUT_DOWN){
        mouseDown = true;
        
        x_diff = x - y_rot;
        y_diff = -y + x_rot;
    }
    else
        mouseDown = false;
}

void mouseMotion(int x, int y){
    if (mouseDown){
        y_rot = x - x_diff;
        x_rot = y + y_diff;
        glutPostRedisplay();
    }
}

int main(int argc, char *argv[]){
    glutInit(&argc, argv);
    
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowPosition(50, 50);
    glutInitWindowSize(500, 500);
    glutCreateWindow("Fractal Cube");
    
    init();
    glutDisplayFunc(display);
    glutKeyboardFunc(keyboard);
    glutSpecialFunc(specialKeyboard);
    glutMouseFunc(mouse);
    glutMotionFunc(mouseMotion);
    glutReshapeFunc(resize);
    
    glutMainLoop();
    return 0;
}