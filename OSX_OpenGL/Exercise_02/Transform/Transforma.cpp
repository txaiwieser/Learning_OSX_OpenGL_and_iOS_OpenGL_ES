/* Transforma.cpp
*  
*  fevereiro,2002 por Carla Freitas
*  adaptado em agosto, 2014. 
*
*  Implementa transformacoes geometricas simples 
*/

/* include de definicoes das funcoes da glut 
   glut.h inclui gl.h, que contem os headers de funcoes da OpenGL propriamente dita
   glut.h inclui tambem definicoes necessarias para o uso de OpenGl nos diversos ambientes Windows
*/
//#include <windows.h>   // usar se necessario

// mudar "GL" para letras maiœsculas ou minuœsculas conforme o ambiente de desenvolvimento

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <gl/gl.h>
#include <gl/glu.h>
#include <gl/glut.h>
#endif


// estrutura que descreve um ponto (x,y)
typedef struct XY {
        float x;
        float y;
} PontoXY;

PontoXY  P1, P2, P3; 

// parametros de translacao, rotacao e escala

float xDesloc=0.5, yDesloc=-0.5;
float vRot=30.0;
float xScale=0.5, yScale=0.5;

// Inicializa os pontos com valores default, cor azul
void SetupObjeto (void)
    { 
    
      P1.x = 0;  // P1 = (0,0.3)
      P1.y = 0.3;
      P2.x = -0.2; // P2 = (-0.2,0)
      P2.y = 0;
      P3.x = 0.2;  // P3 = (0.2,0)
      P3.y = 0;
     }
    
    
// Inicializa caracteristicas para geracao da imagem
// como window no SRU
// usa funcao da GLU  
void SetupRC(void)
    {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);  // cor branca de fundo da janela
    }

//  Desenha triangulo
void DesenhaTriangulo (void)
    {
     glBegin (GL_TRIANGLES);
	    glVertex2f (P1.x,P1.y);
	    glVertex2f (P2.x,P2.y);
	    glVertex2f (P3.x,P3.y);
     glEnd();
    }
    
    
// Funcao que desenha
// Executada sempre que ocorre qualquer evento de janela
void RenderScene(void)
	{
	 // Limpa a janela com a cor especificada como cor de fundo
	 glClear(GL_COLOR_BUFFER_BIT);
    
    // Chamadas de funcoes OpenGL para desenho
    // Os pontos correspondem a geometria do objeto relativa a (0,0)
    
     // Indica que a matriz de transformacao a ser alterada eh a MODEL_VIEW
     glMatrixMode(GL_MODELVIEW);
     glLoadIdentity();
     
     // Desenha eixos
     glColor3f(1.0f, 0.0f, 0.0f); // eixos vermelhos
     glBegin(GL_LINES);
       glVertex2f (0.0, -1.0);
       glVertex2f (0.0, 1.0);
       glVertex2f (-1.0, 0.0);
       glVertex2f (1.0, 0.0);
     glEnd();
  
     //  A sequencia a seguir eh composta de modo que a ordem de aplicacao das transformacoes
     //  eh escala - rotacao - translacao                                                      
     
     glColor3f(1.0, 0.0, 0.0);
     DesenhaTriangulo();            // triangulo original
          
     glTranslatef (xDesloc, 0.0,0.0);           //translacao em X
     glColor3f(0.0, 1.0, 0.0);
     DesenhaTriangulo();          // verde 
     
         
     // glPushMatrix();        
     
     glTranslatef(0.0,yDesloc, 0.0);  // translacao  em Y (composta com a trans em X)
     
     glPushMatrix();
     
     glRotatef (vRot,0.0, 0.0, 1.0);      // rotacao de 30 graus antihorario
     glColor3f(1.0, 1.0, 0.0);         // amarelo
     DesenhaTriangulo();
     
     
     glPopMatrix();
     glScalef (xScale, yScale, 1.0);       // escalamento
     glColor3f(0.0, 0.0, 0.0);
     DesenhaTriangulo();               // todas as transformacoes acumuladas
                              
	// Alterna o buffer de geracao da imagem; contem um "flush" implicito
     glutSwapBuffers();
	  
    }
// Callback comum de teclado     
void KeyboardFunc ( unsigned char key, int x, int y ) {

     if(key == 'q') { // reset do objeto situacao inicial
//         exit(0);
     }
       
     // vocês deve modificar esta funcao para realizar o exercicio 02  
     
}

// Parte principal - ponto de inicio de execucao
// Cria janela 
// Inicializa aspectos relacionados a janela e a geracao da imagem
// Especifica a funcao callback de desenho

int main(int argc, char** argv)
    {
	// Indica que devem ser usados dois buffers para armazenamento da imagem e representacao de cores RGB
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    
    // Inicializa a glut com parâmetros recebidos pelo programa principal
    glutInit(&argc, argv);
    
    // Cria uma janela com o titulo especificado
	glutCreateWindow("Exemplo com transformacoes");

    // Especifica a funcao de desenho
    glutDisplayFunc(RenderScene);
    
    // Callback de teclado 
    glutKeyboardFunc(KeyboardFunc);
    
     // Executa a inicializacao de parametros de exibicao
	SetupRC();
 
    // Inicializa as informacoes geometricas do objeto
    SetupObjeto();

    // Dispara a "maquina de estados" de OpenGL 
	glutMainLoop();
	return (0);
    
    }

