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


####################################################
# AO = valores temporários para leitura
# A1 = Máx embarcações
# A2 = Contador de Tiros
# A3 = Contador acertos
# A4 = Contador afundados
# A5 =
# A6 =
# A7 = valores temporários para leitura

# T0 = Inicio Contador / Menu 1
# T1 = Disposição / Menu 2
# T2 = Comprimento / Menu 3
# T3 = Linha / Menu 4
# T4 = Coluna
# T5 = Registrador para comparação
# T6 =

# S0 = Início contador
# S1 = Matriz Batalha
# S2 = 
# S3 =
# S4 = 
# S5 =
# S6 = 
# S7 = 
# S8 =
# S9 =
# S10 = Linha
# S11 =	Coluna
####################################################

	.data
matriz_batalha:				.space	324
matriz_interface: 		.word	-1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1

################## Mensagens do jogo ##################
start_game:							.asciz  "\n-------- Batalha Naval --------\n"
msg_espaco:							.asciz  " "
msg_enter:							.asciz  "\n"
msg_pos_invalida:       .asciz  "\nPosicao Invalida\n"
msg_dimensao_invalida:  .asciz  "\nValores fora do limite!\n"
msg_sobreposicao_navio: .asciz  "\nNavio colidido!\n"
msg_cima:								.asciz  "\n- 0 1 2 3 4 5 6 7\n"
msg_lateral:						.word	0, 1, 2, 3, 4, 5, 6, 7

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

msg_exit: 							.asciz "Finalizado\n"
msg_tiro_linha: 				.asciz "\nLinha do tiro: \n"
msg_tiro_coluna: 				.asciz "\nColuna do tiro: \n"

salva_S0:								.word	0
salva_ra:								.word	0
salva_ra1:							.word	0

msg_traco:							.asciz  "-"
msg_bandeira:						.asciz  "F"

msg_ganhou:							.asciz  "\n\nParabéns!\nVocê ganhou.\n"
horizontal:							.asciz 	"\nhorizontal\n"
vertical:								.asciz 	"\nvertical\n"

#######################################################

	.text
main:
	la a0, start_game 			# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall

get_info_embarcacoes:
	la a0, msg_num_navio 		# Carrega msg 
	li a7, 4 								# Imprime msg
	ecall
	
	addi a7, zero, 5 				# Le valor inserido pelo usuario
	ecall
	add t0, zero, a0 				# Carrega número de embarcações em t0 - Final Contador

  la a0, msg_enter
  li a7, 4
  ecall
  
loop:
	beq s0, t0, inicializa

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
		bgt t3, t5, erro_linha 	# erro

	pergunta_coluna:
		la a0, msg_coluna 			# Carrega mensagem coluna navio
		li a7, 4								# Imprime msg
		ecall
		addi a7, zero, 5 				# Le valor inserido pelo usuario
		ecall	
		add t4, zero, a0 				# T4 = Linha
		bgt t4, t5, erro_coluna	# erro

insere_embarcacoes:
	addi t5, zero, 1					# Valor para comparação
	beq t1, t5, navio_vertical
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
	
erro_disposicao:
	la a0, msg_erro_posicao
	li, a7, 4
	ecall
	j pergunta_disposicao

inicializa:
	addi a2, zero, 0					# Contador de tiros
	addi a3, zero, 0					# Contador acertos
	addi a4, zero, 0					# Contador afundados

	# la	a6, matriz_batalha	# Carrega o endereço da matriz campo em a6
	# li 	a2, 8								# Carrega o número de colunas/linhas
	# mul	a1, a2, a2					# Calcula o tamanho da matriz
	
	# li	t0, 0								# Inicializa o contador que irá percorrer a matriz
	# li	t1, 9								# Inicializa o comparador de bomba
	# li	t2, 0			# Inicializa o contador secundário que irá contar as colunas da matriz
	# li	t3, 0			# Inicializa o comparador da coluna 0
	# li	t4, 7			# Inicializa o comparador da coluna 7
	# li	t5, 0			# Inicializa o contador terciário que irá contar as linhas da matriz
	# li	a4, 0			# Inicializa o contador de posições abertas
	# li	a5, 0			# Inicializa o contador de bombas da matriz
	j menu

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

reiniciar_jogo:
	# Reiniciar matrizes
	jal get_info_embarcacoes
	
estado_matriz:
	# Imprime Matriz
	la	a0, msg_cima			# Carrega a mensagem das marcações que vão na parte de cima da matriz
	li	a7, 4							# Imprime a mensagem
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

	j menu
	
nova_jogada:
	la a0, msg_tiro_linha
	li a7, 4
	ecall
	
	addi	a7, zero, 5 		# Lê o valor da linha inserido pelo jogador
	ecall

	add 	s10, zero, a0 	# S10 = Linha

	la a0, msg_tiro_coluna
	li a7, 4
	ecall

	addi	a7, zero, 5 		# Lê o valor da coluna inserido pelo jogador
	ecall

	add s11, zero, a0 		# S11 =  Coluna
	addi a1, a1, 1
	
	j menu

exit:
	la a0, msg_exit
	li a7, 4
	ecall
