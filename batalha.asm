# # # # # # # # # # # # # # # # # # # # # # # #
# Universidade Federal da Fronteira Sul
# Ciência da Computação
# Organização de Computadores
# Professor: Luciano Caimi
# Débora Rebelatto - 172101034
# # # # # # # # # # # # # # # # # # # # # # # #

# Durante a interação do jogo (a cada jogada) deve ser possível:
# - ❌ reiniciar o jogo;
# - ❌ mostrar o estado atual da matriz de navios;
# - ❌ fazer uma nova jogada

# ✅  a string navios deve ser lida pela função insere_embarcacoes no início do jogo.

# ✅ Cada uma das linhas seguintes possui um navio. As linhas que especificam navios possuem 4 valores, separados por um espaço, sendo:
# - ✅ primeiro valor é a disposição do navio sendo, 0 para navio na horizontal e 1 para navio na vertical
# - ✅ segundo valor é o comprimento do navio
# - ✅ terceiro valor é a linha inicial do navio e
# - ✅ quarto valor é a coluna inicial do navio

# ❌ A função insere_embarcacoes deve verificar a validade do posicionamento dos navios, gerando uma mensagem de erro para as seguintes situações:
# a) A posição do navio é inválida. Exemplo: 0 3 11, 7
# b) O navio extrapola as dimensões da matriz. Exemplo: 0 4 9 2
# c) Ocorre sobreposição nos navios. Exemplo 0 4 2 2 e 1 3 0 3

# ❌ 1) a situação atual da matriz de jogo;
# ❌ 2) a quantidade de tiros já disparados, a quantidade de tiros que acertaram o alvo, a quantidade de barcos já afundados e a
#   posição do último tiro disparado e;
# ❌ 3) os recordes do jogo que consiste no menor número de tiros para afundar todas as embarcações de algum jogo anterior.


	.data
matriz_campo:				.space	324
matriz_interface: 	.word	-1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1

################## Mensagens do jogo ##################
start_game:							.asciz  "\n\n -------- Batalha Naval -------- \n\n"
msg_espaco:							.asciz  " "
msg_enter:							.asciz  "\n"
msg_pos_invalida:       .asciz  "\nPosicao Invalida\n"
msg_dimensao_invalida:  .asciz  "\nValores fora do limite!\n"
msg_sobreposicao_navio: .asciz  "\nNavio colidido!\n"
msg_cima:								.asciz  "\n- 0 1 2 3 4 5 6 7\n"
msg_lateral:						.word	0, 1, 2, 3, 4, 5, 6, 7

msg_menu:								.asciz "\n------------------Menu------------------\n"
msg_opcoes:        			.asciz "    1 - Reiniciar Jogo\n    2 - Mostrar estado atual da Matriz\n    3 - Nova jogada\n    4 - Sair do jogo\n"

msg_num_navio:         .asciz "\nNumero de navios: "
msg_disposicao:					.asciz "Disposicao: "
msg_comprimento: 				.asciz "Comprimento: "
msg_linha: 							.asciz "Linha inicial: "
msg_coluna: 						.asciz "Coluna inicial: "

msg_erro_posicao: 						.asciz "\nPosição Inválida, Tente novamente\n"

msg_currentVoce: 				.asciz "\nVocê:\n"
msg_currentTiros: 			.asciz "  Tiros: "
msg_currentAcertos: 		.asciz "  Acertos: "
msg_currentAfundados:		.asciz "  Afundados: "
msg_ultimoTiro: 				.asciz "  Último Tiro: "
	
msg_recordes: 					.asciz "\nRecordes:\n"
msg_recordTiros:				.asciz "  Recorde de tiros: "
msg_recordeAcertos: 		.asciz "  Recorde de acertos: "
msg_recordeAfundados: 	.asciz "  Recorde de navios afundados: "

msg_exit: 							.asciz "Finalizado\n"
msg_tiro_linha: 				.asciz "\nLinha do tiro: \n"
msg_tiro_coluna: 				.asciz "\nColuna do tiro: \n"

salva_S0:			.word	0
salva_ra:			.word	0
salva_ra1:		.word	0

msg_traco:				.asciz  "-"
msg_bandeira:			.asciz  "F"
msg_errobandeira:	.asciz  "\nNão foi possivel colocar uma bandeira.\n"
msg_errojogada:		.asciz  "\nNão foi possivel abrir a posição.\n"
msg_bomba:				.asciz  "\nA posição aberta possuia uma bomba.\nVocê perdeu.\n"
msg_ganhou:				.asciz  "\n\nParabéns!\nVocê ganhou.\n"
horizontal:				.asciz 	"\nhorizontal\n"
vertical:					.asciz 	"\nvertical\n"

#######################################################

	.text
main:
	la a0, start_game 			# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall
	
	la a0, matriz_campo
	addi a2, zero, 0					# Contador de tiros

	jal get_info_embarcacoes
	jal menu

get_info_embarcacoes:
	addi s0, zero, 0 				# S0 = Inicio contador

	la a0, msg_num_navio 		# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall
	
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add t0, zero, a0 				# Carrega número de embarcações em t0 - Final Contador

	lw	a0, (t0)			# Carrega o valor da matriz
	li 	a7, 1				# Imprime o valor
  ecall


loop:
	beq s0, t0, menu

perguntas:
	addi a1, zero, 9 				# Posição Máxima linha ou coluna
	la a0, msg_disposicao 	# Carrega mensagem disposicao navio
	li a7, 4								# Imprime msg
	ecall
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add t1, zero, a0				# T1 = Disposicao

	la a0, msg_comprimento 	# Carrega mensagem comprimento navio
	li a7, 4								# Imprime msg
	ecall
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add t2, zero, a0 				# T2 = Comprimento

pergunta_linha:
	la a0, msg_linha 				# Carrega mensagem linha navio
	li a7, 4								# Imprime msg
	ecall
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add t3, zero, a0 				# T3 = Linha
	bgt t3, a1, erro_linha 	# erro

pergunta_coluna:
	la a0, msg_coluna 			# Carrega mensagem coluna navio
	li a7, 4								# Imprime msg
	ecall
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall	
	add t4, zero, a0 				# T4 = Linha
	bgt t4, a1, erro_coluna	# erro
	
insere_embarcacoes:
	addi a1, zero, 1
	beq t1, a1, navio_vertical
	beq t1, zero, navio_horizontal

navio_horizontal:
	la a0, horizontal
	li, a7, 4
	ecall
	
	j atualiza
	
navio_vertical:
	la a0, vertical
	li, a7, 4
	ecall

atualiza:
	addi s0, s0, 1
	j loop
	
erro_linha:
	la a0, msg_erro_posicao
	li, a7, 4
	ecall
	j pergunta_linha
	
erro_coluna:
	la a0, msg_erro_posicao
	li, a7, 4
	ecall
	j pergunta_coluna
	
	


# Inicializa os registradores para serem usados na função calculabombas
inicializa1:
	# la	a0, matriz_campo	# Carrega o endereço da matriz campo em s1
	li 	a2, 8							# Carrega o número de colunas/linhas
	mul	a1, a2, a2				# Calcula o tamanho da matriz
	li	t0, 0							# Inicializa o contador que irá percorrer a matriz
	li	t1, 9							# Inicializa o comparador de bomba
	li	t2, 0							# Inicializa o contador secundário que irá contar as colunas da matriz
	li	t3, 0							# Inicializa o comparador da coluna 0
	li	t4, 7							# Inicializa o comparador da coluna 7
	li	t5, 0							# Inicializa o contador terciário que irá contar as linhas da matriz
	li	a4, 0							# Inicializa o contador de posições abertas
	li	a5, 0							# Inicializa o contador de bombas da matriz

# Inicializa os registradores para serem usados nas próximas funções
inicializa2:
	li	t0, 0										# Inicializa o contador que irá percorrer a matriz
	li	t1, 8										# Inicializa o comparador de coluna para impressão da matriz
	mul	a6, t1, t1							# Calcula o tamanho da matriz
	li	t2, -1									# Inicializa o comparador para a impressão de traços na matriz interface
	li	t4, 2										# Inicializa o comparador de jogada, para abrir uma posição
	la	s0, matriz_interface		# Carrega o endereço da matriz interface em s0
	la	s1, matriz_campo				# Carrega o endereço da matriz campo em s1
	la	t3, msg_lateral					# Carrega o endereço da mensagem que ira ser impressa na lateral da matriz para indicar a marcação das posições
	li	t5, 4										# Inicializa o registrador
	li 	s8, 10									# Inicializa o comparador de bandeira
	j	imprimefirst
	

# Função que imprime a linha marcadora das posições da matriz na parte de cima, e inicia com o 0 na lateral
imprimefirst:
	la	a0, msg_cima		# Linha de números
	li	a7, 4						# Imprime
	ecall
	
	lw  a0, 0(t3)		# Valor da lateral
	li 	a7, 1				# Imprime
	ecall

	la a0, msg_espaco		# Espaço
	li a7, 4						# Imprime
	ecall
	
	addi t3, t3, 4		# Acessa o próximo valor da mensagem
	j imprime


	# Função que imprime os valores da matriz
	imprime:
		beq 	t0, a6, pensa		# Realiza a repetição da função conta em todos os indices da matriz
		beq	t0, t1, pula			# Se o contador for igual a 7, pula para a função pula

		lw  	a0, 0(s0)				# Carrega o valor da matriz
		beq	a0, t2, arruma		# Se o valor for igual a -1, pula para a função arruma
		bge	a0, s8, arruma2 	# Se o valor for igual a 10, pula para a função arruma2
		li 	a7, 1							# Imprime o valor
		ecall

		la	a0, msg_espaco		# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
		li	a7, 4							# Imprime a mensagem
		ecall

		addi	s0, s0, 4				# Acrescenta 4 no endereço da matriz, acessa o próximo número
		addi	t0, t0, 1				# Acrescenta 1 no contador
		j	imprime


		# Função que arruma os valores -1 na matriz para serem impressos como traço
		arruma:
			la	a0, msg_traco		# Carrega a mensagem traço, para ser impresso as posições que não foram abertas ainda
			li	a7, 4						# Imprime a mensagem
			ecall
			la	a0, msg_espaco	# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
			li	a7, 4						# Imprime a mensagem
			ecall
			addi	s0, s0, 4			# Acrescenta 4 no endereço da matriz, acessa o próximo número
			addi	t0, t0, 1			# Acrescenta 1 no contador
			j	imprime


		# Função que arruma os valores 10 na matriz para serem impressos como F
		arruma2:
			la	a0, msg_bandeira	# Carrega a mensagem bandeira, para ser impresso nas posições que foram inseridas uma bandeira
			li	a7, 4							# Imprime a mensagem
			ecall
			la	a0, msg_espaco		# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
			li	a7, 4							# Imprime a mensagem
			ecall
			addi	s0, s0, 4				# Acrescenta 4 no endereço da matriz, acessa o próximo número
			addi	t0, t0, 1				# Acrescenta 1 no contador
			j	imprime


		# Função que pula a linha na matriz e imprime a marcação
		pula:
			la	a0, msg_enter		# Carrega a mensagem enter, para pular a linha
			li	a7, 4						# Imprime a mensagem
			ecall
			addi	t1, t1, 8			# Acrescenta o número da próxima quebra de linha na matriz
	
			lw  	a0, 0(t3)			# Carrega o primeiro valor da mensagem que vai na lateral da matriz para marcar as posições
			li 	a7, 1						# Imprime o valor
			ecall

			la	a0, msg_espaco	# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
			li	a7, 4						# Imprime a mensagem
			ecall
			addi	t3, t3, 4			# Acessa o próximo valor da mensagem
			j 	imprime


# Função que espera o jogador tomar uma decisão, e a partir dessa decisão executa as funções de colocar uma bandeira, ou abrir uma posição
pensa:
	beq	s6, t2, exit			# Se foi aberto uma bomba, pula para o fim
	sub	s7, a6, a5				# Calcula o número de casas que devem ser abertas para ganhar o jogo (quantidade de casas da matriz - número de bombas)


	addi	a7, zero, 5			# Lê o valor inserido pelo jogador (1 = inserebandeira / 2 = abre posição)
	ecall
	add 	s9, zero, a0		# Carrega o valor lido em s9

	la	a0, msg_linha			# Carrega a mensagem de linha
	li	a7, 4							# Imprime a mensagem
	ecall
	addi	a7, zero, 5			# Lê o valor da linha inserido pelo jogador
	ecall
	add 	s10, zero, a0		# Carrega o valor da linha em s10

	la	a0, msg_coluna		# Carrega a mensagem de coluna
	li	a7, 4							# Imprime a mensagem
	ecall
	addi	a7, zero, 5			# Lê o valor da coluna inserido pelo jogador
	ecall
	add 	s11, zero, a0		# Carrega o valor da coluna em s11


	mul	t6, s10, a2							# Calcula a posição, fazendo a operação: (linha * quantidadedecolunas)
	add	t6, t6, s11							# Calcula a posição, fazendo a operação: (linha * quantidadedecolunas) + coluna
	la	s0, matriz_interface		# Carrega o endereço da matriz interface em s0
	la	s2, matriz_campo				# Carrega o endereço da matriz campo em s2
	mul	t6, t6, t5							# Calcula posição na matriz
	add	s0, s0, t6							# Carrega posição na matriz interface
	add	s2, s2, t6							# Carrega posição na matriz campo
	lw	a0, 0(s0)								# Carrega valor da posição da matriz interface
	lw	a1, 0(s2)								# Carrega valor da posição da matriz campo
	
	beq	s9, t4, jogada					# Se o jogador escolheu abrir uma posição, pula para a função jogada
	j	bandeira									# Se não, pula para a função bandeira
	
	
	# Função que verifica se já tem uma bandeira, se não pode ser colocada uma bandeira e se puder realiza o cálculo que coloca a bandeira na posição da matriz
	bandeira:
		bge 	a1, s8, retirabandeira		# Se o valor da posição da matriz campo é maior ou igual a 10, pula para a função retira bandeira
		bgt 	a0, t2, bandeira2		# Se o valor da posição da matriz interface é maior que -1, pula para a função bandeira2
		add	a1, a1, s8			# Adiciona 10 ao valor da posição armazenada em a1
		sw	a1, 0(s0)			# Grava o novo valor na posição da matriz interface
		sw	a1, 0(s2)			# Grava o novo valor na posição da matriz campo
		j	inicializa2


		# Função que verifica se a posição não pode ser colocada uma bandeira, se puder realiza o cálculo que coloca a bandeira na posição da matriz
		bandeira2:
			blt	a0, s8, errobandeira	# Se o valor da posição da matriz interface é menor que 10, pula para a função errobandeira
			add	a1, a1, s8		# Adiciona 10 ao valor da posição armazenada em a1
			sw	a1, 0(s0)		# Grava o novo valor na posição da matriz interface
			sw	a1, 0(s2)		# Grava o novo valor na posição da matriz campo
			j	inicializa2

		# Função que realiza o cálculo para retirar a bandeira
		retirabandeira:
			sub 	a1, a1, s8		# Subtrai 10 do valor da posição armazenada em a1
			sw	t2, 0(s0)		# Grava o valor de -1 na matriz interface
			sw	a1, 0(s2)		# Grava o valor subtraido de 10 na matriz campo
			j	inicializa2


		# Função que imprime a mensagem que não pode ser colocada uma bandeira na posição desejada
		errobandeira:
			la	a0, msg_errobandeira	# Carrega a mensagem errobandeira, que indica que não é possível colocar uma bandeira na posição desejada
			li	a7, 4			# Imprime a mensagem
			ecall
			j	inicializa2


	# Função que abre uma posição na matriz interface, calcula o número de posições abertas e confere se a posição aberta não é uma bomba ou se não pode ser aberta
	jogada:
		li	a3, 9				# Inicializa o comparador de bomba
		beq	a3, a1, bomba			# Se o valor da posição for igual a 9, pula para a função bomba
		bgt	a0, t2, errojogada		# Se o valor da posição na matriz interface é maior que -1, pula para a função errojogada
		sw	a1, 0(s0)			# Grava o valor da posição da matriz campo na matriz interface
		addi	a4, a4, 1			# Calcula o número de posições abertas
		j 	inicializa2
	
		
		# Função que imprime a mensagem que não é possivel abrir a posição desejada da matriz
		errojogada:
			la	a0, msg_errojogada	# Carrega a mensagem errojogada, que indica que não é possivel abrir a posição desejada
			li	a7, 4			# Imprime a mensagem
			ecall
			j	inicializa2

		
		# Função que imprime a mensagem que o jogador explodiu a bomba, inicializa as variaveis e manda para a impressão da matriz campo
		bomba:
			la	a0, msg_bomba		# Carrega a mensagem bomba, que indica que a posição aberta possuia uma bomba e que o jogador perdeu
			li	a7, 4			# Imprime a mensagem
			ecall
			li	s6, -1			# Inicializa o registrador com -1, para ser utilizado na finalização do programa
			la	s0, matriz_campo	# É carregado a matriz campo em s0 para ser impresso após a explosão da bomba
			la	t3, msg_lateral		# Carrega o endereço da mensagem que ira ser impressa na lateral da matriz para indicar a marcação das posições
			li	t0, 0			# Inicializa o contador que irá percorrer a matriz
			li	t1, 8			# Inicializa o comparador de coluna para impressão da matriz
			j	imprimefirst
	




menu:
	addi a1, zero, 1
	addi a2, zero, 2
	addi a3, zero, 3
	addi a4, zero, 4

	la a0, msg_menu 	# Menu
	li a7 4
	ecall

	la a0, msg_opcoes # Opções Menu
	li a7 4
	ecall
	
	li a7, 5
	ecall
	
	# Transições de menu
	beq a1, a0, reiniciar_jogo
	beq a2, a0, estado_matriz
	beq a3, a0, nova_jogada
	beq a4, a0, exit

reiniciar_jogo:
	# Reiniciar matrizes
	jal insere_embarcacoes
	j menu
	
estado_matriz:
	#j imprime_matriz

	la a0, msg_currentVoce
	li a7, 4
	ecall

	la a0, msg_currentTiros
	li a7, 4
	ecall

	# Tiros
 
	lw	a0, (t0)			# Carrega o valor da matriz
	li 	a7, 1				# Imprime o valor
  ecall

	la a0, msg_enter
	li a7 4
	ecall

	la a0, msg_currentAcertos
	li a7 4
	ecall

	# Acertos
	# li a0, a5
	# li a7, 4
	# ecall

	la a0, msg_enter
	li a7 4
	ecall

	la a0, msg_currentAfundados
	li a7 4
	ecall

	# Afundados
	# li a0, a4
	# li a7, 4
	# ecall
	
	la a0, msg_enter
	li a7 4
	ecall

	la a0, msg_ultimoTiro
	li a7 4
	ecall

	# Ultimo tiro linha x coluna
	
	la a0, msg_enter
	li a7 4
	ecall

	la a0, msg_recordes
	li a7 4
	ecall

	la a0, msg_recordTiros
	li a7 4
	ecall
	
	# Recorde Tiros
	
	la a0, msg_enter
	li a7 4
	ecall
	
	la a0, msg_recordeAcertos
	li a7 4
	ecall
	
	# Recorde Acertos
	
	la a0, msg_enter
	li a7 4
	ecall

	la a0, msg_recordeAfundados
	li a7 4
	ecall
	
	# Recorde Afundados

	la a0, msg_enter
	li a7 4
	ecall
	
	j menu

imprime_matriz:
	la	a0, msg_cima			# Carrega a mensagem das marcações que vão na parte de cima da matriz
	li	a7, 4							# Imprime a mensagem
	ecall

	# lw  	a0, 0(t3)			# Carrega o primeiro valor da mensagem que vai na lateral da matriz para marcar as posições
	# li 	a7, 1						# Imprime o valor
	# ecall

	# la	a0, msg_espaco	# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
	# li	a7, 4						# Imprime a mensagem
	# ecall

	# addi	t3, t3, 4			# Acessa o próximo valor da mensagem

	
nova_jogada:
	la a0, msg_tiro_linha
	li a7, 4
	ecall
	
	addi	a7, zero, 5 # Lê o valor da linha inserido pelo jogador
	ecall
	
	add 	s10, zero, a0 # Carrega o valor da linha em s10

	la a0, msg_tiro_coluna
	li a7, 4
	ecall
	
	addi	a7, zero, 5 # Lê o valor da linha inserido pelo jogador
	ecall
	
	
	add a6, zero, a0	# Carrega o valor da coluna em s11
	addi a2, a2, 1
	
	j menu

exit:
	la a0, msg_exit
	li a7, 4
	ecall
