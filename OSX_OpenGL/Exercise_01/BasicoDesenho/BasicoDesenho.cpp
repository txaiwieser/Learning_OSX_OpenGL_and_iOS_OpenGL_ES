/* BasicoDesenho.cpp
*  INF01047 - Fundamentos de Comptacao Grafica
*  fevereiro,2002 por Carla Freitas
*  atualizado em 2007 e 2012
*
*  incrementa o programa Basico com desenho de uma figura geometrica 
*/

/* include de definicoes das funcoes da glut 
   glut.h inclui gl.h, que contem os headers de funcoes da OpenGL propriamente dita
   glut.h inclui tambem definicoes necessarias para o uso de OpenGl nos diversos ambientes Windows
*/
#include <GLUT/glut.h>



// estrutura que descreve um ponto (x,y)
typedef struct XY {
        GLfloat x;
        GLfloat y;
} PontoXY;

PontoXY P1, P2, P3;


// Funcao de callback de desenho
// Executada sempre que eh necessario re-exibir a imagem
void RenderScene(void)
	{
	// Limpa a janela com a cor especificada como cor de fundo
	glClear(GL_COLOR_BUFFER_BIT);
 
    // Indica para a maquina de estados da OpenGL que todas as primitivas geometricas que 
    // forem chamadas deste ponto em diante devem ter a cor vermelha
    glColor3f (1.0f, 0.0f, 0.0f);
    
    // Chamadas de funcoes OpenGL para desenho
    glBegin (GL_TRIANGLES);
	  glVertex2f (P1.x,P1.y);
	  glVertex2f (P2.x,P2.y);
	  glVertex2f (P3.x,P3.y);
    glEnd();

	// Flush dos comandos de desenho que estejam no pipeline da OpenGL
    // para conclusao da geracao da imagem
    glFlush();
	}


// Inicializa aspectos do rendering
void SetupRC(void)
    {
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);  // cor de fundo da janela
    }

// Inicializa os tres pontos com valores default
void SetupObjeto (void)
    { 
    P1.x = 0;
    P1.y = 1;
    P2.x = -1;
    P2.y = 0;
    P3.x = 1;
    P3.y = 0;
    }
    


// Parte principal - ponto de inicio de execucao
// Cria janela 
// Inicializa aspectos relacionados a janela e a geracao da imagem
// Especifica a funcao de callback de desenho
int main( int argc, char** argv)
{
    glutInit(&argc, argv);
	
	// Indica que deve ser usado um unico buffer para armazenamento da imagem e representacao de cores RGB
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    
    // Cria uma janela com o titulo especificado
	glutCreateWindow("Meu primeiro programa OpenGL");
 
    // Especifica para a OpenGL que funcao deve ser chamada para geracao da imagem
	glutDisplayFunc(RenderScene);

    // Executa a inicializacao de parametros de exibicao
	SetupRC();
 
    // Inicializa as informacoes geometricas do objeto
    SetupObjeto();

    // Dispara a maquina de estados de OpenGL 
	glutMainLoop();
	
	return 0;
    }

