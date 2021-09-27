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

// Preenche matriz de navios e matriz de tiros
void fillMatrixes() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      shipMatrix[i][j] = 0;
      shotMatrix[i][j] = '-';
    }
  }
}

// Printa a matriz de navio na tela
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

// Printa a matriz de tiros na tela
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

// Pede informações de navio para a inicialização do jogo
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


    int isDisposicaoOk = 0;

    if (linha_inicial > 10 || coluna_inicial > 10) {
      printf("\nPosicao invalida!\n");
      isDisposicaoOk++;
    }

    if (disposicao == 0) {
      if (coluna_inicial + comprimento > 10) {
        printf("\nValores fora do limite!\n");
        isDisposicaoOk++;
      }
    } else {
      if (linha_inicial + comprimento > 10) {
        printf("\nValores fora do limite!\n");
        isDisposicaoOk++;
      }
    }

    // check if ships overlap
    for (int j = 0; j < comprimento; j++) {
      if (disposicao == 0) {
        if (shipMatrix[linha_inicial][coluna_inicial + j] != 0) {
          printf("\nNavio colidido!\n");
          isDisposicaoOk++;
        }
      } else {
        if (shipMatrix[linha_inicial + j][coluna_inicial] != 0) {
          printf("\nNavio colidido!\n");
          isDisposicaoOk++;
        }
      }
    }

    if(isDisposicaoOk > 0) {
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

void newShot() {
  printf("\nDigite a linha e coluna do tiro: \n");
  scanf("%d %d", &linha, &coluna);

  int count = 0;

  // check if shot is valid
  if (linha > 9 || coluna > 9) {
    printf("\nPosicao invalida!\n");
    count++;
  }

  // check if shot is already taken
  if (shotMatrix[linha][coluna] != '-') {
    printf("\nPosicao ja atingida!\n");
    count++;
  }

  if (count == 0) {
    // Verifica se errou ou acertou
    if (shipMatrix[linha][coluna] != 0) {
      // hit
      // Marca o tiro com um 'o'
      shotMatrix[linha][coluna] = 'o';
      printf("\nAcertou!\n");
      acertos++;
    } else {
      // miss
      // Marca o tiro com um 'x'
      shotMatrix[linha][coluna] = 'x';
      printf("\nErrou!\n");
    }
    tiros++; // Incrementa o numero de tiros
  }
}

checkIfSunk() {

  // check if ship is sunk
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      if (shipMatrix[i][j] != 0) {
        return false;
      }
    }
  }




  // check if the ship was sunk
  // if (shipMatrix[linha][coluna] != 0) {
  //   // check if the ship was sunk
  //   int shipId = shipMatrix[linha][coluna];
  //   int shipLength = 0;
  //   int shipRow = 0;
  //   int shipCol = 0;

  //   // check if the ship is horizontal
  //   for (int i = 0; i < 10; i++) {
  //     if (shipMatrix[linha][i] == shipId) {
  //       shipLength++;
  //       shipCol = i;
  //     }
  //   }

  //   if (shipLength == comprimento) {
  //     // horizontal
  //     for (int i = 0; i < comprimento; i++) {
  //       shipMatrix[linha][shipCol + i] = 0;
  //     }
  //   } else {
  //     // vertical
  //     for (int i = 0; i < 10; i++) {
  //       if (shipMatrix[i][coluna] == shipId) {
  //         shipLength++;
  //         shipRow = i;
  //       }
  //     }
  //   }
  // } else {
  //   // ship was not sunk
  //   afundados++;
  // }
}

int main() {
  fillMatrixes();

  int opcao = 222;

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
        fillMatrixes();
        printf("\nMatriz reiniciada!\n");
        getShipInfo();
        break;
      case 2:
        // mostrar o estado atual da matriz de navios
        printShotMatrix();
        currentStandings();
        printRecordes();
        break;

      case 3:
        // jogar uma nova jogada
        newShot();
        break;

      default:
        printf("Opção inválida\n");
    }
  } while (opcao != 0);

  return 0;
}
