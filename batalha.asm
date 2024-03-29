# # # # # # # # # # # # # # # # # # # # # # # #
# Universidade Federal da Fronteira Sul
# Ciência da Computação
# Organização de Computadores
# Professor: Luciano Caimi
# Débora Rebelatto - 172101034
# # # # # # # # # # # # # # # # # # # # # # # #

# Durante a interação do jogo (a cada jogada) deve ser possível:
# - �?� reiniciar o jogo;
# - �?� mostrar o estado atual da matriz de navios;
# - �?� fazer uma nova jogada

# ✅  a string navios deve ser lida pela função insere_embarcacoes no início do jogo.

# ✅ Cada uma das linhas seguintes possui um navio. As linhas que especificam navios possuem 4 valores, separados por um espaço, sendo:
# - ✅ primeiro valor é a disposição do navio sendo, 0 para navio na horizontal e 1 para navio na vertical
# - ✅ segundo valor é o comprimento do navio
# - ✅ terceiro valor é a linha inicial do navio e
# - ✅ quarto valor é a coluna inicial do navio

# �?� A função insere_embarcacoes deve verificar a validade do posicionamento dos navios, gerando uma mensagem de erro para as seguintes situações:
# a) A posição do navio é inválida. Exemplo: 0 3 11, 7
# b) O navio extrapola as dimensões da matriz. Exemplo: 0 4 9 2
# c) Ocorre sobreposição nos navios. Exemplo 0 4 2 2 e 1 3 0 3

# �?� 1) a situação atual da matriz de jogo;
# �?� 2) a quantidade de tiros já disparados, a quantidade de tiros que acertaram o alvo, a quantidade de barcos já afundados e a
#   posição do último tiro disparado e;
# �?� 3) os recordes do jogo que consiste no menor número de tiros para afundar todas as embarcações de algum jogo anterior.

####################################################
# AO = valores temporários para leitura
# A1 = Máx embarcações
# A2 = Contador de Tiros
# A3 = Contador acertos
# A4 = Contador afundados
# A5 = Recorde Tiros
# A6 = Recorde Acertos
# A7 = valores temporários para leitura

# T0 = Inicio Contador / Menu 1 / Contador da matriz
# T1 = Disposição / Menu 2 / Máximo Matriz
# T2 = Comprimento / Menu 3 / Tamanho matriz
# T3 = Linha / Menu 4 / Mensagem Lateral
# T4 = Coluna
# T5 = Registrador para comparação
# T6 = Comparação/ -1

# S0 = Matriz Batalha
# S1 = Matriz Tiros
# S2 =
# S3 =
# S4 = 
# S5 =
# S6 =
# S7 =
# S8 =
# S9 = Recorde Afundados
# S10 = Linha
# S11 =	Coluna
####################################################

	.data
matriz_batalha:					.space	324
matriz_tiros: 					.word	-1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1

################## Mensagens do jogo ##################
start_game:							.asciz  "\n-------- Batalha Naval --------\n"
matriz_header:					.asciz  "\n----------- Matriz -----------\n"
msg_espaco:							.asciz  " "
msg_enter:							.asciz  "\n"
msg_pos_invalida:       .asciz  "\nPosicao Invalida\n"
msg_dimensao_invalida:  .asciz  "\nValores fora do limite!\n"
msg_sobreposicao_navio: .asciz  "\nNavio colidido!\n"
msg_cima:								.asciz  "\n- 0 1 2 3 4 5 6 7 8 9\n"
msg_lateral:						.word	0, 1, 2, 3, 4, 5, 6, 7, 8, 9

msg_menu:								.asciz "\n------------------Menu------------------\n    1 - Reiniciar Jogo\n    2 - Mostrar estado atual da Matriz\n    3 - Nova jogada\n    4 - Sair do jogo\n"

msg_num_navio:         	.asciz "\nNumero de navios: "
msg_disposicao:					.asciz "Disposicao: "
msg_comprimento: 				.asciz "Comprimento: "
msg_linha: 							.asciz "Linha inicial: "
msg_coluna: 						.asciz "Coluna inicial: "

msg_erro_posicao: 			.asciz "\nPosição Inválida, Tente novamente\n"

msg_currentVoce: 				.asciz "\nVocê:\n"
msg_currentTiros: 			.asciz "  Tiros: "
msg_currentAcertos: 		.asciz "  Acertos: "
msg_currentAfundados:		.asciz "  Afundados: "
msg_ultimoTiro: 				.asciz "  Último Tiro: "
msg_ultimoTiroLinha: 		.asciz "	Linha: "
msg_ultimoTiroColuna: 	.asciz "	Coluna: "

msg_recordes: 					.asciz "\nRecordes:\n"
msg_recordTiros:				.asciz "  Recorde de tiros: "
msg_recordeAcertos: 		.asciz "  Recorde de acertos: "
msg_recordeAfundados: 	.asciz "  Recorde de navios afundados: "

msg_exit: 							.asciz "\nFinalizado\n"
msg_tiro_linha: 				.asciz "\nLinha do tiro: \n"
msg_tiro_coluna: 				.asciz "\nColuna do tiro: \n"

msg_traco:							.asciz  "-"

msg_ganhou:							.asciz  "\n\nParabéns!\nVocê ganhou.\n"
horizontal:							.asciz 	"\nhorizontal\n"
vertical:								.asciz 	"\nvertical\n"

#######################################################

	.text
main:
	la a0, start_game 			# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall

#######################################################
# função: get_info_embarcacoes
# entrada:
# saída:
#######################################################
get_info_embarcacoes:
	la a0, msg_num_navio 		# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall

	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add a1, zero, a0 				# A1 = Número de embarcações/Final Contador

  la a0, msg_enter
  li a7, 4
  ecall
  j loop

#######################################################
# função: loop
# entrada:
# saída:
#######################################################
loop:
	beq t0, a1, inicializa
	j pergunta_disposicao

perguntas:
	pergunta_disposicao:
		addi t5, zero, 1 				# Máximo disposição
		la a0, msg_disposicao 	# Carrega mensagem disposicao navio
		li a7, 4								# Imprime msg
		ecall
		addi a7, zero, 5 				# Le valor inserido pelo usuario
		ecall
		add t1, zero, a0				# T1 = Disposicao
		bgt t1, t5, erro_disposicao
	
	pergunta_comprimento:
		la a0, msg_comprimento 	# Carrega mensagem comprimento navio
		li a7, 4								# Imprime msg
		ecall
		addi a7, zero, 5 				# Le valor inserido pelo usuario
		ecall
		add t2, zero, a0 				# T2 = Comprimento

	pergunta_linha:
		addi t5, zero, 9 				# Máximo linha e coluna
		la a0, msg_linha 				# Carrega mensagem linha navio
		li a7, 4								# Imprime msg
		ecall
		addi a7, zero, 5 				# Le valor inserido pelo usuario
		ecall
		add t3, zero, a0 				# T3 = Linha
	
		add t6, t2, t3
		bgt t6, t5, erro_linha
		bgt t3, t5, erro_linha 	# erro

	pergunta_coluna:
		la a0, msg_coluna 			# Carrega mensagem coluna navio
		li a7, 4								# Imprime msg
		ecall
		addi a7, zero, 5 				# Le valor inserido pelo usuario
		ecall	
		add t4, zero, a0 				# T4 = Linha
		
		add t6, t2, t4
		bgt t6, t5, erro_linha
		
		bgt t4, t5, erro_coluna	# erro

#######################################################
# função: insere_embarcacoes
# entrada:
# saída:
#######################################################
insere_embarcacoes:
	addi t5, zero, 1					# Valor para comparação
	beq t1, t5, navio_vertical
	beq t1, zero, navio_horizontal

#######################################################
# função: navio_horizontal
# entrada:
# saída:
#######################################################
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
	addi t0, t0, 1
	j loop

#######################################################
# Erros:
#		erro_linha
#		erro_coluna
#		erro_disposicao
#######################################################
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
	
erro_disposicao:
	la a0, msg_erro_posicao
	li, a7, 4
	ecall
	j pergunta_disposicao

#######################################################
# função: inicializa
# entrada:
#		a2 ⇒ Contador de Tiros
#		a3 ⇒ Contador de Acertos
#		a4 ⇒ Contador de Afundados
# saída:
#######################################################
inicializa:
	addi 	a2, zero, 0						# A2 = Contador de tiros
	addi 	a3, zero, 0						# A3 = Contador acertos
	addi 	a4, zero, 0						# A4 = Contador afundados
	addi 	s10, zero, 0
	addi 	s11, zero, 0
	j menu

#######################################################
# função: menu
#		Lê entrada de usuário para fazer transições
# entrada:
#		t0 ⇒ 1
#		t1 ⇒ 2
#		t2 ⇒ 3
#		t3 ⇒ 4
# saída:
#######################################################
menu:
	addi t0, zero, 1	# T0 = 1
	addi t1, zero, 2	# T1 = 2
	addi t2, zero, 3	# T2 = 3
	addi t3, zero, 4	# T3 = 4

	la a0, msg_menu 	# Menu
	li a7 4
	ecall
		
	li a7, 5
	ecall
	
	# Transições de menu
	beq t0, a0, reiniciar_jogo	# branch if equal to reiniciar_jogo
	beq t1, a0, estado_matriz		# branch if equal to estado_matriz
	beq t2, a0, nova_jogada			# branch if equal to nova_jogada
	beq t3, a0, exit						# branch if equal to exit

#######################################################
# função: reiniciar_jogo
# entrada:
# saída:
#######################################################
reiniciar_jogo:
	addi 	a0, zero, 0
	addi 	a1, zero, 0
	addi 	a2, zero, 0
	addi 	a3, zero, 0
	addi 	a4, zero, 0
	addi 	a5, zero, 0
	addi 	a6, zero, 0
	addi 	a7, zero, 0

	addi 	t0, zero, 0
	addi 	t1, zero, 0
	addi 	t2, zero, 0
	addi 	t3, zero, 0
	addi 	t4, zero, 0
	addi 	t5, zero, 0
	addi 	t6, zero, 0

	addi 	s0, zero, 0
	addi 	s1, zero, 0
	addi 	s9, zero, 0
	addi 	s10, zero, 0
	addi 	s11, zero, 0
	
	# Reiniciar matrizes
	j get_info_embarcacoes
	
#######################################################
# função: imprime_matriz
#		Imprime numeração e inicializa contadores
#	entradas:
#		t0 = Contador da matriz
#		t1 = Máximo matriz
#		t2 = mensagem lateral
#		t3 = Tamanho matriz
#		t6 = -1
#		s0 = Matriz Batalha
#		s1 = Matriz tiros
#######################################################
imprime_matriz:
	li	t0, 0							# Min Contador
	li	t1, 10							# Max Contador
	la	t2, msg_lateral		# t2 = Mensagem Lateral
	li	t6, -1							# t6 = -1

	la	s0, matriz_batalha	# S0 = Matriz Batalha
	la	s1, matriz_tiros		# S1 = Matriz Tiros
	mul	t3, t1, t1				# t3 = Calcula o tamanho da matriz

	la	a0, msg_cima			# Carrega a mensagem das marcações que vão na parte de cima da matriz
	li	a7, 4							# Imprime a mensagem
	ecall

	j	imprime_lateral

# Função que imprime a linha marcadora das posições da matriz na parte de cima, e inicia com o 0 na lateral
imprime_lateral:
	lw a0, 0(t2)		# Carrega o primeiro valor da mensagem que vai na lateral da matriz para marcar as posições
	li a7, 1			# Imprime o valor
	ecall

	la	a0, msg_espaco		# Carrega a mensagem espa�o, para dar um espa�amento entre a marca��o e a matriz
	li	a7, 4			# Imprime a mensagem
	ecall

	addi	t2, t2, 4		# Acessa o próximo valor da mensagem

	j 	imprime

imprime:
	beq t0, t3, standings			# Realiza a repetição da função conta em todos os indices da matriz
	beq	t0, t1, pula						# Se o contador for igual a 7, pula para a função pula

	lw  	a0, 0(s1)					# Carrega o valor da matriz

	beq	a0, t6, arruma
	li 	a7, 1							# Imprime o valor
	ecall

	la	a0, msg_espaco		# Carrega a mensagem espa�o, para dar um espa�amento entre a marca��o e a matriz
	li	a7, 4							# Imprime a mensagem
	ecall

	addi s0, s0, 4			# Acrescenta 4 no endereço da matriz, acessa o próximo número
	addi t0, t0, 1			# Acrescenta 1 no contador
	j	imprime

	arruma:
		la	a0, msg_traco		# Carrega a mensagem tra�o, para ser impresso as posi��es que n�o foram abertas ainda
		li	a7, 4			# Imprime a mensagem
		ecall

		la	a0, msg_espaco		# Carrega a mensagem espa�o, para dar um espa�amento entre a marca��o e a matriz
		li	a7, 4			# Imprime a mensagem
		ecall

		addi	s0, s0, 4		# Acrescenta 4 no endere�o da matriz, acessa o pr�ximo n�mero
		addi	t0, t0, 1		# Acrescenta 1 no contador
		j	imprime
		
	pula:
		la	a0, msg_enter		# Carrega a mensagem enter, para pular a linha
		li	a7, 4						# Imprime a mensagem
		ecall

		addi	t1, t1, 10			# Acrescenta o número da próxima quebra de linha na matriz

		lw  a0, 0(t2)			# Carrega o primeiro valor da mensagem que vai na lateral da matriz para marcar as posições
		li 	a7, 1						# Imprime o valor
		ecall

		la	a0, msg_espaco		# Carrega a mensagem espa�o, para dar um espa�amento entre a marca��o e a matriz
		li	a7, 4			# Imprime a mensagem
		ecall

		addi	t2, t2, 4			# Acessa o próximo valor da mensagem
		j 	imprime

#######################################################
#	função: estado_matriz
# entrada:
# saída:
#######################################################
estado_matriz:
	la a0, matriz_header
	li a7, 4
	ecall

	j imprime_matriz

#######################################################
# função: standings
# entrada:
#		a2	⇒ Tiros
#		a3	⇒ Acertos
#		a4	⇒ Afundados
#		a5	⇒ Recorde Tiros
#		a6	⇒ Recorde Acertos
#		s9 	⇒ Recorde Afundados
#		s10 ⇒ Último tiro linha
#		s11 ⇒ Último tiro coluna
#######################################################
standings:
	la a0, msg_enter
	li a7 4
	ecall

	# Current Game
	la a0, msg_currentVoce
	li a7, 4
	ecall
	
	# Tiros
	la a0, msg_currentTiros
	li a7, 4
	ecall
	addi a0, a2, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall
	
	# Acertos
	la a0, msg_currentAcertos
	li a7 4
	ecall
	addi a0, a3, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall

	# Afundados
	la a0, msg_currentAfundados
	li a7 4
	ecall
	addi a0, a4, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall

	# Ultimo tiro linha x coluna
	la a0, msg_ultimoTiro
	li a7 4
	ecall

		# Linha
	la a0, msg_ultimoTiroLinha
	li a7 4
	ecall
	addi a0, s10, 0
	li a7, 1
	ecall
	
		# Coluna
	la a0, msg_ultimoTiroColuna
	li a7 4
	ecall
	addi a0, s11, 0
	li a7, 1
	ecall

	la a0, msg_enter
	li a7 4
	ecall

	# Recordes
	la a0, msg_recordes
	li a7 4
	ecall

		# Recorde Tiros
	la a0, msg_recordTiros
	li a7 4
	ecall
	addi a0, a5, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall
	
		# Recorde Acertos
	la a0, msg_recordeAcertos
	li a7 4
	ecall
	addi a0, a6, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall
	
		# Recorde Afundados
	la a0, msg_recordeAfundados
	li a7 4
	ecall
	addi a0, s9, 0
	li a7, 1
	ecall
	la a0, msg_enter
	li a7 4
	ecall
	
	j menu

#######################################################
# função: nova_jogada
# 	Faz tiros e incrementa contador de tiros
# entrada:
#		a2	⇒ Tiros
#		s10 ⇒ Linha
#		s11 ⇒ Coluna
# saída:
#######################################################
nova_jogada:
	addi t5, zero, 9

	jogada_linha:
		la a0, msg_tiro_linha
		li a7, 4
		ecall

		addi	a7, zero, 5 		# Lê o valor da linha inserido pelo jogador
		ecall

		add 	s10, zero, a0 	# S10 = Linha
		bgt 		s10, t5, erro_linha 	# erro

	jogada_coluna:
		la a0, msg_tiro_coluna
		li a7, 4
		ecall

		addi	a7, zero, 5 		# Lê o valor da coluna inserido pelo jogador
		ecall

		add s11, zero, a0 			# S11 =  Coluna
		bgt s11, t5, erro_linha 	# erro
		j increase

	increase:
		addi a2, a2, 1				# Atualiza contador de tiros

		j menu

erro_tiro_linha:
	la a0, msg_erro_posicao
	li a7, 4
	ecall
	j jogada_linha

erro_tiro_coluna:
	la a0, msg_erro_posicao
	li a7, 4
	ecall
	j jogada_coluna

#######################################################
# função: exit
#		Finaliza jogo
#######################################################
exit:
	la a0, msg_exit
	li a7, 4
	ecall
	nop

