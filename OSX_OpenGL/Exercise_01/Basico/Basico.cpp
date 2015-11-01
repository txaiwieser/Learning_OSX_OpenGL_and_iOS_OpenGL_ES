// Basico.cpp
// 
// primeira versao em fevereiro, 2002 por Carla Freitas
// baseado em Simple.c (OpenGL SuperBible)
// atualizado em 2007 e 2012


/* include de definicoes das funcoes da glut 
   glut.h inclui gl.h, que contem os headers de funcoes da OpenGL propriamente dita
   glut.h inclui tambem definicoes necessarias para o uso de OpenGl nos diversos ambientes Windows
*/
// cuide para que o include siga o formato do ambiente que esta sendo usado
#include <GLUT/glut.h>


// Funcao de callback de desenho
// Executada sempre que eh necessario re-exibir a imagem
void RenderScene(void)
	{
	// Limpa a janela com a cor especificada como cor de fundo
	glClear(GL_COLOR_BUFFER_BIT);

    // Aqui devem ser inseridas chamadas de funcoes OpenGL para desenho


	// Flush dos comandos de desenho que estejam no "pipeline" da OpenGL
    // para conclusao da geracao da imagem
    glFlush();
    
	}


// Inicializa aspectos do rendering
void SetupRC(void)
    {
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);  // cor de fundo da janela
    }


// Parte principal - ponto de incio de execucao
// Cria janela 
// Inicializa aspectos relacionados a janela e a geracao da imagem
// Especifica a funcao de callback de desenho
int main( int argc, char** argv)
    {
	// Indica que deve ser usado um unico buffer para armazenamento da imagem e representacao de cores RGB
     glutInit(&argc, argv);
     glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    
    // Cria uma janela com o titulo especificado
	glutCreateWindow("Programa Basico OpenGL");

    // Especifica para a OpenGL que funcao deve ser chamada para geracao da imagem
	glutDisplayFunc(RenderScene);

    // Executa a inicializacao de parametros de exibicao
	SetupRC();

    // Dispara a "maquina de estados" de OpenGL 
	glutMainLoop();
	
	return 0;
    }

