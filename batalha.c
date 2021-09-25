#include <stdio.h>
#include <stdbool.h>

// create a 10x10 matrix
int shipMatrix[10][10];
int shotMatrix[10][10];

int disposicao, comprimento, linha_inicial, coluna_inicial, linha_final, coluna_final;
int numships = 0;
int recordeTiros = 0;
int recordeAcerto = 0;
int recordeAfundados = 0;
int tiros = 0;
int acertos = 0;
int afundados = 0;
int ultimoTiro = 0;
int linha, coluna;

void fillWithZeros() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      shipMatrix[i][j] = 0;
    }
  }
}

void fillWithZerosShot() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      shotMatrix[i][j] = '-';
    }
  }
}

void printShipMatrix() {
  printf("\n- 0 1 2 3 4 5 6 7 8 9\n");
  for (int i = 0; i < 10; i++) {
    printf("%d ", i);
    for (int j = 0; j < 10; j++) {
      printf("%d ", shipMatrix[i][j]);
    }
    printf("\n");
  }
}

void printShotMatrix() {
  printf("\n- 0 1 2 3 4 5 6 7 8 9\n");
  for (int i = 0; i < 10; i++) {
    printf("%d ", i);
    for (int j = 0; j < 10; j++) {
      printf("%c ", shotMatrix[i][j]);
    }
    printf("\n");
  }
}

void getShipInfo() {
  // prompt user for number of ships
  printf("\nNumero de navios: ");
  scanf("%d", &numships);

  for(int i = 0; i < numships; i++) {
    printf("\nDigite a disposicao, comprimento, linha inicial e coluna inicial do navio: \n");
    scanf("%d %d %d %d", &disposicao, &comprimento, &linha_inicial, &coluna_inicial);

    printf("\nDisposicao: %d\n", disposicao);
    printf("Comprimento: %d\n", comprimento);
    printf("Linha inicial: %d\n", linha_inicial);
    printf("Coluna inicial: %d\n", coluna_inicial);


    bool dispok = true;
    if (linha_inicial > 10 || coluna_inicial > 10) {
      printf("\nPosicao invalida!\n");
      dispok = false;
    }

    if (disposicao == 0) {
      if (coluna_inicial + comprimento > 10) {
        printf("\nValores fora do limite!\n");
        dispok = false;
      }
    } else {
      if (linha_inicial + comprimento > 10) {
        printf("\nValores fora do limite!\n");
        dispok = false;
      }
    }

    // check if ships overlap
    for (int j = 0; j < comprimento; j++) {
      if (disposicao == 0) {
        if (shipMatrix[linha_inicial][coluna_inicial + j] != 0) {
          printf("\nNavio colidido!\n");
          dispok = false;
        }
      } else {
        if (shipMatrix[linha_inicial + j][coluna_inicial] != 0) {
          printf("\nNavio colidido!\n");
          dispok = false;
        }
      }
    }

    // check if ship is horizontal or vertical
    if(dispok == true) {
      if (disposicao == 1) {
        // vertical
        for (int j = 0; j < comprimento; j++) {
          shipMatrix[linha_inicial + j][coluna_inicial] = i + 1;
        }
      } else {
        // horizontal
        for (int j = 0; j < comprimento; j++) {
          shipMatrix[linha_inicial][coluna_inicial + j] = i + 1;
        }
      }
      printShipMatrix();
    } else {
      i--;
    }
  }
}

void currentStandings() {
  printf("\nVocê:\n");
  printf("  Tiros: %d\n", tiros);
  printf("  Acertos: %d\n", acertos);
  printf("  Afundados: %d\n", afundados);
  printf("  Último Tiro: linha %d coluna %d\n", linha, coluna);
  printf("\n");
}

void printRecordes() {
  // mostrar os recordes
  printf("\nRecordes:\n");
  printf("  Recorde de tiros: %d\n", recordeTiros);
  printf("  Recorde de acertos: %d\n", recordeAcerto);
  printf("  Recorde de navios afundados: %d\n", recordeAfundados);
  printf("\n");
}

int main() {
  fillWithZeros();
  fillWithZerosShot();

  int opcao = 0;

  printf("\n 🚢 Batalha Naval 🚢 \n");

  getShipInfo();

  do {
    printf("\n------------------ Menu ------------------\n");
    printf("  1 - Reiniciar Jogo\n");
    printf("  2 - Mostrar estado atual da Matriz\n");
    printf("  3 - Nova jogada\n");
    printf("  0 - Exit\n");

    scanf("%d", &opcao);

    switch (opcao) {
      case 1:
        // reiniciar o jogo
        fillWithZeros();
        fillWithZerosShot();
        printf("\nMatriz reiniciada!\n");
        break;
      case 2:
        // mostrar o estado atual da matriz de navios
        printShotMatrix();
        currentStandings();
        printRecordes();
        break;

      case 3:
        // jogar uma nova jogada
        printf("\nDigite a linha e coluna do tiro: \n");
        scanf("%d %d", &linha, &coluna);

        // check if the shot is a hit or miss
        if (shipMatrix[linha][coluna] != 0) {
          // hit
          // mark the shot in the matrix with an 'o'
          shotMatrix[linha][coluna] = 'o';
          printf("\nAcertou!\n");
          acertos++;
        } else {
          // miss
          // mark the shot in the matrix with a 'x'
          shotMatrix[linha][coluna] = 'x';
          printf("\nErrou!\n");
        }

        tiros++;
        break;

      default:
        printf("Opção inválida\n");
    }
  } while (opcao != 0);

  return 0;
}
