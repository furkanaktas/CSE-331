	.data
 	 	
 	sonuc: .asciiz "\nSonuc : "
 	nokta: .asciiz "."
 	tam1: 	.asciiz "1. sayi tam kisim   : "
 	float1: .asciiz "1. sayi float kisim : "
 	oper:  	.asciiz "Operator            : "
 	tam2: 	.asciiz "2. sayi tam kisim   : "
 	float2: .asciiz "2. sayi float kisim : "
 	newline:.asciiz "\n\n"
 	eksi:   .asciiz "-"
 	sifir:  .asciiz "0"
	
	.text
	
	.globl main

main:	
	# s0: 1. sayi int kisim 
	# s1: 1. sayi float kisim 
	# s2: operator 
	# s3: 2. sayi int kisim 
	# s4: 2. sayi float kisim 

	jal sayiAl
	move $s5, $zero	 # s5: number of digits of first float	
	move $t0, $s1	 # part of first number of float
	move $s6, $zero	 # s6: number of digits of second float
	move $t1, $s4    # part of second number of float
	jal loop         # s5 s6 belirlendi

	move $t0, $s1    			# t0 = s1;
	blt $s0, $zero, doNegative  # if (s0 < 0)      #ilk part negatifse float part ta negatif yapildi
	
	ilkSayiRet:
	
		move $t0, $s4    				# t0 = s4;
		blt $s3, $zero, doNegative2  	# if (s3 < 0)		#ilk part negatifse float part ta negatif yapildi
		
	ikiSayiRet:
	
		blt $s5, $s6, basEsitle		# float basamak sayilari esitlenir
		
		sub $t0,$s5,$s6  		    # t0 = s5-s6    basamak sayisi farki
		move $s7, $s5     	        # s7 = s5    en buyuk basamak sayisi
		li $t1,1
		li $t2,10
		
	bas2Loop:
	    beqz $t0, ikincibuyuk		# if (t0 ==0) goto: 2buyuk
	    mult $s4, $t2
	    mflo $s4
	    sub $t0, $t0, $t1 
	    j bas2Loop

	ikincibuyuk:
	
		li $t1,1
		li $t2,10
		move $t0, $s7

		sayicevir:							# sayilarin int kisimlari basamak sayisi kadar 10 la carpildi
			beqz $t0, devam					# 1.32 , float basamak sayisi 2 ,  1*10*10 --> 100
			mult $s0, $t2
		    mflo $s0 
		    mult $s3, $t2
		    mflo $s3
		    sub $t0, $t0, $t1 
		    j sayicevir

		devam:

		add $s0, $s0,$s1    # s0 = s0 + s1;      sayi  int sayi yapildi   orn :  1.32 --> 132 oldu
		add $s3, $s3,$s4	# s3 = s3 + s4;    	 sayi  int sayi yapildi
		
		# bu adimdan sonra s1=10 ve s4=1 

		li $s1,10     # s1  , 10 la carpmak icin
		li $s4,1	  # s4  , loop kontrol icin --1 ++1

		beq $s2, 43, toplama
		toplamaRet:
		beq $s2, 45, cikarma
		cikarmaRet:
		beq $s2, 42, carpma
		carpmaRet:
	
	
#----------------------------------------
	li $v0, 10
	syscall

sayiAl:
	
	li $v0, 4
	la $a0, tam1
	syscall
	
	li $v0, 5 		# system call code for read_int
	syscall
	move $s0, $v0	 # move integer to s0

	
#----------------------------------------
	
	li $v0, 4
	la $a0, float1
	syscall

	li $v0, 5 		# system call code for read_int
	syscall 		# read int
	move $s1, $v0 	# move integer to s1

	
#----------------------------------------
	li $v0, 4
	la $a0, oper
	syscall
	
	li $v0, 12 		# system call code for read_char
	syscall 		# read char
	move $s2, $v0	# move char to s2

	li $v0, 12 		# system call code for read_char
	syscall 		# read char
			
#----------------------------------------	

	li $v0, 4
	la $a0, tam2
	syscall

	li $v0, 5 		# system call code for read_int
	syscall 		# read int
	move $s3, $v0 	# move integer to s3


#----------------------------------------
	li $v0, 4
	la $a0, float2
	syscall

	li $v0, 5 		# system call code for read_int
	syscall 		# read int
	move $s4, $v0	 # move integer to s4
	
	
	jr $ra

toplama:

	add $s0, $s0, $s3   # s0 = s0 + s3;       artik  sayi bulundu , bundan sonra basamak kaydirma islemi yapilacak
	
	move $t0,$s0        # t1 = s0;    s0 sonuc   		
	move $t1,$s7        # t0 = s7;	  s7 basamak sayisi	
	
	jal Shift
	j toplamaRet

cikarma:

	sub $s0, $s0, $s3   # s0 = s0 + s3;       artik  sayi bulundu , bundan sonra basamak kaydirma islemi yapilacak

	move $t0,$s0        # t1 = s0;    s0 sonuc   		
	move $t1,$s7        # t0 = s7;	  s7 basamak sayisi	
		
	jal Shift
	j cikarmaRet

carpma:

	mult $s0 $s3
	mflo $s0   			# s0 = s0 + s3;       artik  sayi bulundu , bundan sonra basamak kaydirma islemi yapilacak

	move $t0,$s0        # t1 = s0;    s0 sonuc   		
	move $t1,$s7        # t0 = s7;	  s7 basamak sayisi	
	add $t1,$t1,$t1		# carpma oldugu icin her iki sayi icinde basamak kaydirilacak
	
	jal Shift
	j carpmaRet

loop:							# s5(1. float basamak sayisi) s6(2. float basamak sayisi) belirler
        beqz $t0,inLoop   
        li $t2, 10

	    addi $s5,$s5,1  # increase counter
	    div $t0, $t2  	# sayi / 10
	    mflo $t0
	    j loop  		# loop around
	    
	    inLoop:
		    beqz $t1,return
		    addi $s6,$s6,1  	# increase counter
		    div $t1, $t2 	 	# sayi / 10
		    mflo $t1
		    j inLoop
    return:
    	jr $ra		


doNegative:
	add $t0,$t0,$t0    #t0 = t0 + t0;  //(2*t0)
	sub  $s1,$s1,$t0	#s1 = s1 - t0;
	j ilkSayiRet

doNegative2:
	add $t0,$t0,$t0	#t0 = t0 + t0;  //(2*t0)
	sub  $s4,$s4,$t0	#s4 = s4 - t0;
	j ikiSayiRet	


basEsitle:				# float kisimlarin  basamak sayilarini esitler 
	sub $t0, $s6, $s5   # t0 = s6-s5    basamak sayisi farki
	move $s7, $s6       # s7 = s6    buyuk basamak sayisi s7 de tutulur
	li $t1,1
	li $t2,10
	basLoop:
	    beqz $t0, ikincibuyuk
	    mult $s1, $t2    		# basamaklar esitlenene kadar 10 la carpildi 
	    mflo $s1	
	    sub $t0, $t0, $t1 
	    j basLoop


print:
	
	div $s0, $t2  	# toplam sayi / 10*(basamak sayisi)   
	mflo $s0		# tam kisim
	mfhi $s1		# float kisim

	li $v0, 4
	la $a0, sonuc
	syscall

	blt $s1,$zero,doPositive
	j goOn
	doPositive:
		move $t0,$s1		# t0 = s1;
		add $t0,$t0,$t0		# t0 += t0;
		sub $t0,$zero,$t0	# t0 = 0-t0;
		add $s1,$t0,$s1		# s1 = t0 + s1 
		beqz $s0, printThis
		j goOn
	printThis:
		li $v0, 4
		la $a0, eksi
		syscall

	goOn:
	li $v0, 1
	move $a0, $s0			# int kisim
	syscall

	li $v0, 4
	la $a0, nokta
	syscall

	beqz $s1,atla
	move $t0,$s1			# t0 = s1;
	li $t1,10				# t1 = 10;
	move $t2,$zero			# t2 = 0;
	loopBas:
		beqz $t0,goOn2		# float kisim 0'sa
	    addi $t2,$t2,1  	# increase counter
	    div $t0, $t1 	 	# sayi / 10
	    mflo $t0
	    j loopBas	

	goOn2:
	

	sub $t0,$s7,$t2   		# float kisim basamak sayisi, basamak sayisina esitse 0 cikmasi lazim  ,, int bolme yaptigi icin 0002 geldiginde 2 ol. kaydedilir  4-1
	beqz $t0,atla
	li $t1,1

	loopSifir:
		beqz $t0, atla		
		li $v0, 4
		la $a0, sifir
		syscall
		sub $t0,$t0,$t1   	# t0 -=1;
		j loopSifir

	atla:
	li $v0, 1
	move $a0, $s1
	syscall

	li $v0, 4
	la $a0, newline
	syscall
	
	jr $ra
	

Shift:
	addi $sp,$sp,-4
	sw $ra, 0($sp)

	li $t2,1	
	
	kaymaSayisi:
		beqz $t1, jalprint
		mult $t2,$s1
		mflo $t2
		sub $t1,$t1,$s4
		j kaymaSayisi		

jalprint:
	jal print
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra	
