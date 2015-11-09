/* BasicoMenu.cpp
*  
*  fevereiro,2002 por Carla Freitas
*  modificado em agosto, 2014
*
*  Implementa interacao por menu pop-up e por teclado 
*/
/* include de definicoes das funcoes da glut 
   glut.h inclui gl.h, que contem os headers de funcoes da OpenGL propriamente dita
   glut.h inclui tambem definicoes necessarias para o uso de OpenGl nos diversos ambientes Windows
*/

//#include <windows.h>   // use se necess‡rio
// mudar "GL" para letras maiœsculas ou minuœsculas conforme o ambiente de desenvolvimento

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <gl/gl.h>
#include <gl/glu.h>
#include <gl/glut.h>
#endif

// constantes usadas para identificar objetos
#define TRIANGULOCHEIO 1
#define TRIANGULOARAME 2
#define LINHA 3
#define QUADRILATERO 4

// estrutura que descreve um ponto (x,y)
typedef struct XY {
        float x;
        float y;
} PontoXY;

PontoXY P0, P1, P2, P3, P4;  

// guarda o tipo de objeto que deve ser  exibido
int objeto;

// Funcao que desenha
// Executada sempre que ocorre qualquer evento de janela
void RenderScene(void)
	{
	// Limpa a janela com a cor especificada como cor de fundo
	glClear(GL_COLOR_BUFFER_BIT);
    

    // Chamadas de funcoes OpenGL para desenho
    // Observe que P0 corresponde a posicao do objeto no SRU
    // Os demais pontos correspondem a geometria do obejto relativa a (0,0)
    switch (objeto)
    {
        case TRIANGULOCHEIO: 
           {glBegin (GL_TRIANGLES);
	           glVertex2f (P0.x+P1.x,P0.y+P1.y);
	           glVertex2f (P0.x+P2.x,P0.y+P2.y);
	           glVertex2f (P0.x+P3.x,P0.y+P3.y);
             glEnd();
             break;
           }
        case TRIANGULOARAME: 
           {glBegin (GL_LINE_LOOP);
	           glVertex2f (P0.x+P1.x,P0.y+P1.y);
	           glVertex2f (P0.x+P2.x,P0.y+P2.y);
	           glVertex2f (P0.x+P3.x,P0.y+P3.y);
             glEnd();
             break;
           }
        case LINHA: 
           {glBegin (GL_LINES);
	           glVertex2f (P0.x+P1.x,P0.y+P1.y);
	           glVertex2f (P0.x+P2.x,P0.y+P2.y);
	           glVertex2f (P0.x+P3.x,P0.y+P3.y);
               glVertex2f (P0.x+P4.x,P0.y+P4.y);
            glEnd();
            break;   
           }
        case QUADRILATERO:
           {
            glBegin (GL_QUADS);
			glVertex2f (P0.x+P1.x,P0.y+P1.y);
			glVertex2f (P0.x+P2.x,P0.y+P2.y);
			glVertex2f (P0.x+P3.x,P0.y+P3.y);
			glVertex2f (P0.x+P4.x,P0.y+P4.y);
			glEnd();
			break;     
		   }
	}                           
	// Alterna o buffer de geracao da imagem; contem um "flush" implicito

	glutSwapBuffers();
	}

	// Inicializa aspectos do rendering
void SetupRC(void)
    {
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);  // cor azul de fundo da janela
    }

// Inicializa os pontos com valores default, cor vermelha e objeto aramado
void SetupObjeto (void)
    { 
    P1.x = 0;
    P1.y = 1;
    P2.x = -1;
    P2.y = 0;
    P3.x = 1;
    P3.y = 0;
    P4.x = 2;
    P4.y = 1;
    glColor3f(1.0f, 0.0f, 0.0f);
    objeto=TRIANGULOARAME;
    }

// Callback de teclas especiais
// Desloca a origem do objeto conforme as teclas
// Não evita que saia da área vísivel    
void SpecialKeys(int key, int x, int y)
	{
	
    if(key == GLUT_KEY_UP)
		P0.y += 0.5;

	if(key == GLUT_KEY_DOWN)
		P0.y -= 0.5f;

	if(key == GLUT_KEY_LEFT)
		P0.x -= 0.5f;

	if(key == GLUT_KEY_RIGHT)
		P0.x += 0.5f;

	glutPostRedisplay();

    }
   

// Callback comum de teclado     
void KeyboardFunc ( unsigned char key, int x, int y )
{
     if(key == 'r') // reset do objeto para a origem (0,0) e vermelho 
       { P0.x=0; 
         P0.y=0;
         glColor3f(1.0f,0.0f,0.0f);
       }
     glutPostRedisplay();
     
}

// Callback de menu     
void TrataMenu ( int valor )
{
     switch(valor)
        {
        case 1: // cor vermelha
            glColor3f (1.0f, 0.0f, 0.0f);
            break;

        case 2: // cor azul
            glColor3f (0.0f, 0.0f, 1.0f);
            break;

        case 3: // cor verde
            glColor3f (0.0f, 1.0f, 0.0f);
            break;

        case 4:  // cor branca
            glColor3f (1.0f, 1.0f, 1.0f);
            break;

        case 5:  // cor preta
            glColor3f (0.0f, 0.0f, 0.0f);
            break;

        case 6:   // cor amarela
            glColor3f (1.0f, 1.0f, 0.0f);
            break;

        case 7:   // triangulo preenchido
            objeto=TRIANGULOCHEIO;
            break;

        case 8:    // triangulo aramado
            objeto=TRIANGULOARAME;
            break;

        case 9:    // somente uma linha
            objeto=LINHA;
            break;
        case 10:   // um quadrilatero 
            objeto=QUADRILATERO;
            break;
        case 11:   // cor de fundo branca
            glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
            break;
        case 12:   // cor de fundo azul
            glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
            break;
        
        default: // default para objeto
            objeto=TRIANGULOARAME;
            break;
        }
     
     glutPostRedisplay();   
}


// Parte principal - ponto de início de execucao
// Cria janela 
// Inicializa aspectos relacionados a janela e a geracao da imagem
// Cria menus e associa funcao de tratamento
// Especifica a funcao callback de desenho
// Especifica funcoes de callback de teclado para teclas normais e especiais

int main(int argc, char** argv)
    {
	// Indica que devem ser usados dois buffers para armazenamento da imagem e representacao de cores RGB
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    
    // Inicializa a glut com parâmetros recebidos pelo programa principal
    glutInit(&argc, argv);
    
    // Cria uma janela com o titulo especificado
	glutCreateWindow("Programa com uso de Menu");
        
    // Cria menu para escolher a cor corrente e o objeto a ser exibido
	int menuCor;  // sub-menu para cor do objeto
    int menuObjeto;    // sub-menu para tipo de objeto
    int mainMenu;
          
    menuCor = glutCreateMenu(TrataMenu);
	glutAddMenuEntry("Vermelho",1);
	glutAddMenuEntry("Azul",2);
	glutAddMenuEntry("Verde",3);
	glutAddMenuEntry("Branco",4);
	glutAddMenuEntry("Preto",5);
	glutAddMenuEntry("Amarelo",6);
		
	menuObjeto = glutCreateMenu(TrataMenu);
	glutAddMenuEntry("Triangulo preenchido",7);
	glutAddMenuEntry("Triangulo aramado",8);
	glutAddMenuEntry("Linha",9);
	glutAddMenuEntry("Quadrilatero",10);
	    
	mainMenu = glutCreateMenu(TrataMenu);
	glutAddSubMenu("Cor", menuCor);
   	glutAddSubMenu("Objeto", menuObjeto);
    glutAddMenuEntry("Fundo Branco",11);
    glutAddMenuEntry("Fundo Azul",12);
        
	glutAttachMenu(GLUT_RIGHT_BUTTON);
 
       // Especifica a funcao que vai tratar teclas comuns 
    glutKeyboardFunc(KeyboardFunc);
    
    // Especifica a funcao que vai tratar teclas especiais
 	      
    glutSpecialFunc(SpecialKeys);
  
    // Especifica para a OpenGL a funcao responsavel pelo desenho
	glutDisplayFunc(RenderScene);

    // Executa a inicializacao de parametros de exibicao
	SetupRC();
 
    // Inicializa as informacoes geometricas do objeto
    SetupObjeto();

    // Dispara a "maquina de estados" de OpenGL 
	glutMainLoop();
    
return 0;
    }
