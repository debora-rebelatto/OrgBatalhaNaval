# # # # # # # # # # # # # # # # # # # # # # # #
# Universidade Federal da Fronteira Sul
# Ciência da Computação
# Organização de Computadores
# Professor: Luciano Caimi
# Débora Rebelatto - 172101034
# Victor
# # # # # # # # # # # # # # # # # # # # # # # #
	.data
# Os navios do inimigo estão colocados em uma string chamada “navios” presente na área de dados (.data)
# matriz_navio
# matriz_acertos
matriz_campo:		.space	324
matriz_interface: 	.word	-1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1,  -1,-1,-1,-1,-1,-1,-1,-1

################## Mensagens do jogo ##################

msg_espaco: 		.asciz"\n"
msg_pos_invalida:       .asciz  "\nPosicao Invalida\n"
msg_dimensao_invalida:  .asciz  "\nValores fora do limite!\n"
msg_sobreposicao_navio: .asciz  "\nNavio colidido!\n"
msg_cima:		.asciz  "\n- 0 1 2 3 4 5 6 7\n"

msg_menu:               .asciz "\n------------------Menu------------------\n"
msg_reiniciar:        	.asciz "    1 - Reiniciar Jogo\n"
msg_estado_matriz:      .asciz "    2 - Mostrar estado atual da Matriz\n"
msg_nova_jogada:        .asciz "    3 - Nova jogada\n"
msg_sair:		.asciz "    4 - Sair do jogo\n"
msg_novo_navio:         .asciz "\nNumero de navios:\n"
msg_infos_navio:        .asciz "\nDigite a disposicao, comprimento, linha inicial e coluna inicial do navio: \n"

msg_disposicao:		.asciz "\nDisposicao: \n"
msg_comprimento: 	.asciz "Comprimento: \n"
msg_linha: 		.asciz "Linha inicial: \n"
msg_coluna: 		.asciz "Coluna inicial: \n"

msg_currentVoce: 	.asciz "\nVocê:\n"
msg_currentTiros: 	.asciz "  Tiros: "
msg_currentAcertos: 	.asciz "  Acertos: "
msg_currentAfundados:	.asciz "  Afundados: "
msg_ultimoTiro: 	.asciz "  Último Tiro: "
	
msg_recordes: 		.asciz "\nRecordes:\n"
msg_recordTiros:	.asciz "  Recorde de tiros: "
msg_recordeAcertos: 	.asciz "  Recorde de acertos: "
msg_recordeAfundados: 	.asciz "  Recorde de navios afundados: "

msg_exit: 		.asciz "Finalizado\n"
msg_tiro_linha: 	.asciz "\nLinha do tiro: \n"
msg_tiro_coluna: 	.asciz "\nColuna do tiro: \n"

#######################################################

	.text
main:
	la a0, matriz_campo
	#jal insere_embarcacoes
	jal menu

inicializa1:
	la	a0, matriz_campo	# Carrega o endereço da matriz campo em s1
	li 	a2, 8			# Carrega o número de colunas/linhas
	mul	a1, a2, a2		# Calcula o tamanho da matriz
	li	t0, 0			# Inicializa o contador que irá percorrer a matriz
	li	t1, 9			# Inicializa o comparador de bomba
	li	t2, 0			# Inicializa o contador secundário que irá contar as colunas da matriz
	li	t3, 0			# Inicializa o comparador da coluna 0
	li	t4, 7			# Inicializa o comparador da coluna 7
	li	t5, 0			# Inicializa o contador terciário que irá contar as linhas da matriz
	li	a4, 0			# Inicializa o contador de posições abertas
	li	a5, 0			# Inicializa o contador de bombas da matriz
	#j 	calculabombas

# Durante a interação do jogo (a cada jogada) deve ser possível:
# - ❌ reiniciar o jogo;
# - ❌ mostrar o estado atual da matriz de navios;
# - ❌ fazer uma nova jogada

# ❌  a string navios deve ser lida pela função insere_embarcacoes no início do jogo.

# Cada uma das linhas seguintes possui um navio. As linhas que especificam navios possuem 4 valores, separados por um espaço, sendo:
# - ❌ primeiro valor é a disposição do navio sendo, 0 para navio na horizontal e 1 para navio na vertical
# - ❌ segundo valor é o comprimento do navio
# - ❌ terceiro valor é a linha inicial do navio e
# - ❌ quarto valor é a coluna inicial do navio

insere_embarcacoes:
	# ❌ A função insere_embarcacoes deve verificar a validade do posicionamento dos navios, gerando uma mensagem de erro para as seguintes situações:
	# ❌ 1) a situação atual da matriz de jogo;
	# ❌ 2) a quantidade de tiros já disparados, a quantidade de tiros que acertaram o alvo, a quantidade de barcos já afundados e a
	#   posição do último tiro disparado e;
	# ❌ 3) os recordes do jogo que consiste no menor número de tiros para afundar todas as embarcações de algum jogo anterior.
	la a0, msg_novo_navio # Carrega msg
	li a7, 4 # Imprime msg
	ecall

	addi a7, zero, 5 # Le valor inserido pelo usuario
	ecall

	add s0, zero, a0 # Carrega o valor de número de embarcações em s0

loop:
	addi s1, zero, 0 # Inicio contador
	add t1, zero, s0 # Final contador
	


le_valores:
	la a0, msg_infos_navio
	li a7, 4
	ecall
	
	addi a7, zero, 5 # Le valor inserido pelo usuario
	ecall


menu:
	addi a1, zero, 1
	addi a2, zero, 2
	addi a3, zero, 3
	addi a4, zero, 4

	la a0, msg_menu # Menu
	li a7 4
	ecall

	la a0, msg_reiniciar # Reinicia
	li a7 4
	ecall

	la a0, msg_estado_matriz # Estado Matriz
	li a7 4
	ecall

	la a0, msg_nova_jogada # Nova jogada
	li a7 4
	ecall

	la a0, msg_sair # Sair
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
	j imprime_matriz

	la a0, msg_currentVoce
	li a7 4
	ecall

	la a0, msg_currentTiros
	li a7 4
	ecall

	# Tiros

	la a0, msg_espaco
	li a7 4
	ecall

	la a0, msg_currentAcertos
	li a7 4
	ecall

	# Acertos

	la a0, msg_espaco
	li a7 4
	ecall

	la a0, msg_currentAfundados
	li a7 4
	ecall

	# Afundados

	la a0, msg_espaco
	li a7 4
	ecall

	la a0, msg_ultimoTiro
	li a7 4
	ecall

	# Ultimo tiro linha x coluna

	la a0, msg_espaco
	li a7 4
	ecall

	la a0, msg_recordes
	li a7 4
	ecall

	la a0, msg_recordTiros
	li a7 4
	ecall
	
	# Recorde Tiros
	
	la a0, msg_espaco
	li a7 4
	ecall
	
	la a0, msg_recordeAcertos
	li a7 4
	ecall
	
	# Recorde Acertos
	
	la a0, msg_espaco
	li a7 4
	ecall

	la a0, msg_recordeAfundados
	li a7 4
	ecall
	
	# Recorde Afundados
	
	la a0, msg_espaco
	li a7 4
	ecall
	
	j menu

imprime_matriz:
	la	a0, msg_cima		# Carrega a mensagem das marcações que vão na parte de cima da matriz
	li	a7, 4			# Imprime a mensagem
	ecall
	
	# lw  	a0, 0(t3)		# Carrega o primeiro valor da mensagem que vai na lateral da matriz para marcar as posições
	# li 	a7, 1			# Imprime o valor
  	# ecall
  	# la	a0, msg_espaco		# Carrega a mensagem espaço, para dar um espaçamento entre a marcação e a matriz
	# li	a7, 4			# Imprime a mensagem
	# ecall
	# addi	t3, t3, 4		# Acessa o próximo valor da mensagem

	
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
	
	add 	s11, zero, a0 # Carrega o valor da coluna em s11
	
	j menu

exit:
	la a0, msg_exit
	li a7, 4
	ecall
