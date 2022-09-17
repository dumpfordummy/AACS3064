.model large
.stack 9999
.data
;==========Print Welcome Screen Messages
	printWelcomeScreenMesg1 DB 13,10,"-----------------------------------------------------------------------------$"
	printWelcomeScreenMesg2 DB 13,10,"			WELCOME TO DLBank!$"
	printWelcomeScreenMesg3 DB 13,10,"-----------------------------------------------------------------------------$"

;==========Prompt Main Menu Options Messages
	mainMenuOptionsMesg1 DB 13,10,"Enter 1 to register$"
	mainMenuOptionsMesg2 DB 13,10,"Enter 2 to login$"
	mainMenuOptionsMesg3 DB 13,10,"Enter 3 to exit$"
	mainMenuOptionsMesg4 DB 13,10,"Enter your option: $"
	invalidOptionMesg DB 13,10,"Invalid option$"
	alertMesg DB 13,10,"Please enter only Y, y, N or n.$"

;==========Register Bank Account Module Messages
	newAccNumMesg DB 13,10,"Your account number is $"
	promptNewAccPwMesg DB 13,10,"Set your password: $"
	doneRegisterMesg DB 13,10,"Your account has been created, Welcome! $"
	toContinueMesg DB 13,10,"Press any button to continue...$"


	accountCreated DB 13,10,"Account created!$"

;==========dk what 7
	nameMsg DB 13,10,"Name: $"
	balanceMsg DB 13,10,"Balance: RM $"
	dottedV2 DB 13,10,"=======$"
	bankLogo DB 13,10,"DL BANK$"
	transferSuccessMesg DB 13,10,"Transfer successfully!$"
	msg2 db 13, 10, "logout. thank you liangzai", 13, 10, '$'
	msg3 db 13, 10, "Do you wish to continue? (Y/N)", 13, 10, '$'
	msg4 db 13, 10, "Summary", 13, 10, '$'
	msg5 db 13, 10, "Deposit(s): $"
	msg6 db 13, 10, "Withdrawal(s): $"
	msg7 db	13, 10, "Transfer(s): $"
	countDep db '0'
	countWdw db '0'
	countTrf db '0'

;======================LOGIN LOGOUT MESSAGE======================
	promptUserMsg DB 13,10,"Enter bank account: $"
	promptPWMsg DB "Enter password: $"
	logoutMsg DB 13,10,"Signed out. Thank you for using DLBank$"
	accessYes DB 13,10,"Access Granted! $"
	accessNo DB 13,10,"Access Denied! (WRONG ACCOUNT NUMBER) $"
	accessNoPW DB 13,10,"Access Denied! (WRONG PASSWORD) $"
	errorMsg DB 13,10,"Please enter correct option$"
	tooMuchMsg DB 13,10,"Wrong input(5 times). Please try again in 3 minutes$"



;=========================USER=========================
	inUser DB 5 dup('$')
	inPw DB 35 dup('$')
	regUser DB 5 dup('$')
	regPW DB 35 dup('$')
	loginEnterCount DB 0
	loginTrial DB 0


	user1AccNum DB "8866$"
	user2AccNum DB 6 dup('$')

	userType DB ?

	user1Pw DB "aaaa",'$'
	user2Pw DB 35 dup('$')

	usersBalanceIndex DW userBalance1
	userBalance1 DW 9420
	userSenBalance1 DW 5000
	userBalance2 DW 6688
	userSenBalance2 DW 8500

	usersNameIndex DW name1
	name1 DB "Chun Yuan GieGie$"
	name2 DB "Robert Low$"

    transferAcc DB 35 dup('$')
	transferTo DB ?

	;=========================TRANSFER=========================	
	transferInput DB 35 dup('$')

	;======================DEPOSIT&WITHDRAWAL======================	

	amountInput DW 0, 0, 0, 0
	amountInputConverted DW 0
	amountInputCalculated DW 0
	amountInputCalculatedDec DW 0
	inputCount DW 0
	tempIndex DW ?
    multiplyLoopCount DB 0
    addToDecFactor DW 0

;======================MENU LIST======================
	menuOpt0Mesg DB 13, 10, "0. Exit$"
	menuOpt1Mesg DB 13, 10, "1. Deposit$"
	menuOpt2Mesg DB 13, 10, "2. Withdrawal$"
	menuOpt3Mesg DB 13, 10, "3. Transfer$"
	promptOptMesg DB 13, 10, "Enter the option:$"
	promptDepositAmountMesg DB 13, 10, "Enter the deposit amount:$"
	promptWithdrawalAmountMesg DB 13, 10, "Enter the withdrawal amount:$"
	promptBankTypeMesg DB 13, 10, "Enter Bank Type:$"
	promptBankAccountMesg DB 13, 10, "Transfer to(Bank Account)?(Enter 0 back to menu):$"
	promptTransferAmountMesg DB 13, 10, "Enter the transfer amount:$"
	promptNextTransactionMesg DB 13, 10, "Any other transaction?(Y/N)$"
    depositSuccessMesg DB 13, 10, "Deposit successfully!$"
    balanceMesg DB 13, 10, "Your balance: $"
    invalidInputMesg DB 13, 10, "Invalid input$"
    withdrawalSuccessMesg DB 13, 10, "Withdrawal successfully!$"

;======================MACRO LIST======================
PRINTDOT MACRO
	mov ah,02H 
	mov dl,2EH
	int 21H
endm

PRINT4DIGIT Macro input
	mov ax, input
	mov bx, 100
	div bl
	push ax
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
endm

	PRINTSTRING Macro Input
	mov ah,09h
	lea dx,input
	int 21h
	endm 

	NEWLINE MACRO
	;newline
	mov ah,02H 
	mov dl,0DH 
	int 21H 
	mov dl,0AH 
	int 21H
	endm

	SCANCHAR Macro
	mov ah,01h
	int 21h
	endm

	CLEARSCREEN MACRO
    mov AX, 0600H
    mov BH,71H
    mov CX, 0000H 
    mov DX,174FH
    int 10H
	endm

	PRINTRINGGITBALANCE MACRO input
	mov ax, input
	mov bx, 100
	div bl
	push ax
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	endm

PRINTSENBALANCE MACRO input
	mov dl, '.'
	mov ah, 02h
	int 21h
	mov ax, input
	mov bx, 100
	div bl
	push ax
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	mov ah, 0
	mov bx, 10
	div bl
	push ax
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	pop ax
	xchg ah,al
	add al,30h
	mov ah,02h
	mov dl,al
	int 21h
	endm

.code
assignToAx proc  ;;
    cmp multiplyLoopCount, 0
	je move1ToAx
	jne move10ToAx
	
move1ToAx:
    mov ax, 1
    jmp afterAssignAx
    
move10ToAx:
    mov ax, 10
afterAssignAx:    	
    ret
assignToAx endp

printCurrentUserBalance proc  ;;
    NEWLINE
    cmp userType, 1
	je printUser1Jumper
    PRINT4DIGIT userBalance2
    jmp asdf
printUser1Jumper:
	jmp printUser1
	
asdf:
PRINTDOT
    PRINT4DIGIT userSenBalance2
	jmp afterPrintBalance

printUser1:
    PRINT4DIGIT userBalance1
    PRINTDOT
    PRINT4DIGIT userSenBalance1
afterPrintBalance:    	
    ret

printCurrentUserBalance endp 

addAxToBalance proc  ;;
    cmp userType, 1
    je addToUser1
    jne addToUser2
    
addToUser1:
    add userBalance1, ax
    jmp afterAddBalance
    
addToUser2:
    add userBalance2, ax
    
afterAddBalance:    	
    ret 
addAxToBalance endp



calculateFee proc
    mov amountInputCalculated, 0
    mov amountInputCalculatedDec, 0
    push amountInputConverted
    mov ax, amountInputConverted
    mov bx, 10000
    div bx
    xchg dx, ax
    mov bx, 1
    mul bx
    
    mov amountInputCalculatedDec, ax
    
    pop amountInputCalculated 
    
    
foundCost:     
    cmp amountInputCalculatedDec, 1000
    jge mov10000
    cmp amountInputCalculatedDec, 100
    jge mov1000
    cmp amountInputCalculatedDec, 10
    jge mov100
    cmp amountInputCalculatedDec, 0
    jge mov10

mov10000:
    mov addToDecFactor, 10000
    jmp compareUserTypeSub
mov1000:
    mov addToDecFactor, 1000
    jmp compareUserTypeSub
mov100:
    mov addToDecFactor, 100
    jmp compareUserTypeSub
mov10:
    mov addToDecFactor, 10
        
compareUserTypeSub:
    cmp userType, 1
    jne proceedSub2

    
proceedSub:
    mov ax, userBalance1
    cmp ax, amountInputCalculated
    jng invalidInputWithdrawalJmper1 ;if balance not enuf
    je compareDecIfSame ;check decimal if before decimal is same
    jmp doSub; if enuf for withdrawal

compareDecIfSame:
    mov ax, userSenBalance1
    cmp ax, amountInputCalculatedDec
    jng invalidInputWithdrawalJmper1 ;not enuf balance
takeBeforeDecimal:    
    dec userBalance1 ; take before decimal
    mov ax, addToDecFactor
    add userSenBalance1, ax
            
doSub:
    mov ax, amountInputCalculatedDec
    cmp userSenBalance1, ax
    jng takeBeforeDecimal
    mov ax, amountInputCalculated
    sub userBalance1, ax
    mov ax, amountInputCalculatedDec
    sub userSenBalance1, ax 
    jmp returnCalculateFee

proceedSub2:
    mov ax, userBalance2
    cmp ax, amountInputCalculated
    jng invalidInputWithdrawalJmper1 ;if balance not enuf
    je compareDecIfSame ;check decimal if before decimal is same
    jmp doSub2; if enuf for withdrawal

compareDecIfSame2:
    mov ax, userSenBalance2
    cmp ax, amountInputCalculatedDec
    jng invalidInputWithdrawalJmper1 ;not enuf balance
takeBeforeDecimal2:    
    dec userBalance2 ; take before decimal
    mov ax, addToDecFactor
    add userSenBalance2, ax
            
doSub2:
    mov ax, amountInputCalculatedDec
    cmp userSenBalance2, ax
    jng takeBeforeDecimal
    mov ax, amountInputCalculated
    sub userBalance2, ax
    mov ax, amountInputCalculatedDec
    sub userSenBalance2, ax 
    
    
returnCalculateFee:  
    ret    
calculateFee endp    




;======================withdrawalJumper======================
withdrawalJmper1:
	jmp withdrawal
transferJmper1:
	jmp transfer
invalidInputWithdrawalJmper1:
    jmp	invalidInputWithdrawal
;============================================================



;==========Main Program
main proc
	mov ax,@data
	mov ds,ax

;==========Print Welcome Screen
printWelcomeScreen:
	PRINTSTRING printWelcomeScreenMesg1
	PRINTSTRING printWelcomeScreenMesg2
	PRINTSTRING printWelcomeScreenMesg3

;==========Prompt Main Menu Options
PromptMainMenuOptions:
;====================Print Main Menu Options
	PRINTSTRING mainMenuOptionsMesg1
	PRINTSTRING mainMenuOptionsMesg2
	PRINTSTRING mainMenuOptionsMesg3
	PRINTSTRING mainMenuOptionsMesg4
;====================Input Main Menu Options
	SCANCHAR
	cmp al,'1'
	je registerBankAccModule
	cmp al,'2'
	je loginJumper2
	cmp al,'3'
	je quitJumper
	PRINTSTRING invalidOptionMesg
	PRINTSTRING alertMesg
	NEWLINE
	jmp PromptMainMenuOptions

;==========Register Bank Account Module
registerBankAccModule: 
;====================Print New Account Number
	PRINTSTRING newAccNumMesg
	lea si,user1AccNum
	lea di,user2AccNum
	mov cx,5
;==============================Assign User 2 Account Number
assignUser2AccNum:
	mov al,[si]
	mov [di],al
	inc si
	inc di
	loop assignUser2AccNum
	lea si,user2AccNum
	mov al,[si+3]
	inc al
	mov [si+3],al
	PRINTSTRING user2AccNum
;====================Prompt New Account Password
	PRINTSTRING promptNewAccPwMesg
	lea si, user2Pw
	jmp createPW
assignUser2Pw:
	SCANCHAR
	cmp al,13
	je finishAssignUser2Pw
	mov [si],al
	inc si
	jmp assignUser2Pw
finishAssignUser2Pw:
    mov al, '$'
    mov [si], al
	PRINTSTRING doneRegisterMesg
	PRINTSTRING toContinueMesg
	SCANCHAR
    jmp printWelcomeScreen

;==========Jumper
loginJumper2:
	jmp login
quitJumper:
	jmp quit
;==========Login Bank Account Module==================
login:
	cmp loginTrial,5
	je tooMuch
	PRINTSTRING promptUserMsg
	lea si,inUser 
	jmp loginPrompt

loginPrompt:
	SCANCHAR
	cmp al,13
	je reset
	mov [si],al
	inc si
	inc loginEnterCount
	jmp loginPrompt

reset:
	mov al,'$'
    mov [si], al
	lea si,inUser
	lea di,user1AccNum
	jmp checkAcc

checkAcc:
	mov al,[di]
	mov bl,[si]
	cmp loginEnterCount, 0
	je loginFailedJumper
	cmp al,'$'
	je setUserType1
	cmp al,bl
	jne reset2
	inc si
	inc di
	jmp checkAcc

reset2:
	lea si,inUser
	lea di,user2AccNum
	jmp check2

check2:
	mov al,[di]
	mov bl,[si]
	cmp al,'$'
	je setUserType2
	cmp al,bl
	jne loginFailedJumper
	inc si
	inc di
	jmp check2

loginJumper:
	jmp login

tooMuch:
	PRINTSTRING tooMuchMsg
	jmp quit

loginFailedJumper:
	jmp loginFailed

;==================login bank password==================
setUserType1:
    mov userType, 1
    jmp proceedLoginPW
    
setUserType2:
    mov userType, 2
    
proceedLoginPW:
    NEWLINE
    PRINTSTRING promptPWMsg
	lea si,inPw
	mov loginEnterCount,0
    cmp userType, 1
    jne loginPW2

loginPW1:
    lea di, user1Pw
    jmp loginPWPrompt 
    
loginPW2:
    lea di, user2Pw

loginPWPrompt:	
	SCANCHAR
	cmp al,13
	je resetPW
	mov [si],al
	inc si
	inc loginEnterCount
	jmp loginPWPrompt

resetPW:
	mov al,'$'
    mov [si], al
	lea si,inPw
	jmp checkPW

checkPW:
	mov al,[di]
	mov bl,[si]
	cmp loginEnterCount, 0
	je loginFailed
	cmp al,'$'
	je loginSuccess
	cmp al,bl
	jne loginFailedPW
	inc si
	inc di
	jmp checkPW

exit:
	mov ah,09h
	mov dx,offset inUser
	int 21h

loginSuccess:
	PRINTSTRING accessYes
	PRINTSTRING toContinue
	SCANCHAR
	NEWLINE
	jmp checkBankDetails 

loginFailed:
	PRINTSTRING accessNo
	mov loginEnterCount, 0
	inc loginTrial
	jmp login

loginFailedPW:
	PRINTSTRING accessNoPW
	mov loginEnterCount, 0
	jmp login 

checkBankDetails:
	cmp userType,1
	je showUser1
	cmp userType,2
	je showUser2Jumper

showUser2Jumper:
	jmp showUser2

showUser1:
	PRINTSTRING dottedV2
	PRINTSTRING bankLogo
	PRINTSTRING dottedV2
	PRINTSTRING nameMsg
	PRINTSTRING name1
	PRINTSTRING balanceMsg
	PRINTRINGGITBALANCE userBalance1
	PRINTSENBALANCE userSenBalance1
	NEWLINE
	jmp quit

showUser2:
	PRINTSTRING dottedV2
	PRINTSTRING bankLogo
	PRINTSTRING dottedV2
	PRINTSTRING nameMsg
	PRINTSTRING name2
	PRINTSTRING balanceMsg
	PRINTRINGGITBALANCE userBalance2
	PRINTSENBALANCE userSenBalance2
	NEWLINE


menu:
init:
    mov multiplyLoopCount, 0
	mov inputCount, 0
	mov amountInputConverted, 0
	mov amountInputCalculated, 0
	mov amountInputCalculatedDec, 0 
	PRINTSTRING menuOpt0Mesg
	PRINTSTRING menuOpt1Mesg
	PRINTSTRING menuOpt2Mesg
	PRINTSTRING menuOpt3Mesg
	PRINTSTRING promptOptMesg
	SCANCHAR
	cmp al, '0'
	je quitJumper2
	cmp al, '1'
	je deposit
	cmp al, '2'
	je withdrawalJmper
	cmp al, '3'
	je transferJmper
	jmp menu

quitJumper2:
	jmp quit
	
;======================withdrawalJumper======================
withdrawalJmper:
	jmp withdrawal
transferJmper:
	jmp transfer
invalidInputWithdrawalJmper:
    jmp	invalidInputWithdrawal
;============================================================

;======================depositModule======================
deposit:
    inc countDep
	PRINTSTRING promptDepositAmountMesg
	lea si, amountInput
    mov multiplyLoopCount, 0
	mov inputCount, 0
promptDepositAmountInput:
	SCANCHAR
	mov ah, 0
	cmp al,13
	je proceedDeposit
	inc inputCount
	sub ax, 30h
	mov [si],ax
	add si, 2
	jmp promptDepositAmountInput	

proceedDeposit:
    cmp inputCount, 0
    je invalidInputDeposit
    cmp inputCount, 4
    jg invalidInputDeposit
	mov cx, inputCount
	mov bx, 1
    jmp multiplyDeposit
    
invalidInputDeposit:
    PRINTSTRING invalidInputMesg
    jmp deposit
    


multiplyDeposit:
    lea si, amountInput
	mov tempIndex, cx
	dec tempIndex
	
    push bx ; indexing correction
    mov ax, tempIndex
    mov bx, 2
    mul bx
    pop bx
    mov tempIndex, ax
	call assignToAx
	mul bx
	mov bx, ax
	mov ax, tempIndex
	add si, ax
	mov ax, [si]
	mul bx
	call addAxToBalance
	inc multiplyLoopCount
	loop multiplyDeposit
	
	NEWLINE
	PRINTSTRING depositSuccessMesg
    PRINTSTRING balanceMesg
    call printCurrentUserBalance
    NEWLINE
    jmp menu

;======================withdrawalModule======================	
	
withdrawal:
    inc countWdw
	PRINTSTRING promptWithdrawalAmountMesg
	lea si, amountInput
    mov multiplyLoopCount, 0
	mov inputCount, 0
	mov amountInputConverted, 0

promptWithdrawalAmountInput:
	SCANCHAR
	mov ah, 0
	cmp al,13
	je proceedWithdrawal
	inc inputCount
	sub ax, 30h
	mov [si],ax
	add si, 2
	jmp promptWithdrawalAmountInput	

proceedWithdrawal:
    cmp inputCount, 0
    je invalidInputWithdrawal
    cmp inputCount, 4
    jg invalidInputWithdrawal
	mov cx, inputCount
	mov bx, 1
    jmp multiplyWithdrawal
    
invalidInputWithdrawal:
    PRINTSTRING invalidInputMesg
    jmp withdrawal


multiplyWithdrawal:
    lea si, amountInput
	mov tempIndex, cx
	dec tempIndex
	
    push bx ; indexing correction
    mov ax, tempIndex
    mov bx, 2
    mul bx
    pop bx
    mov tempIndex, ax
    
	call assignToAx
	
	mul bx
	mov bx, ax
	mov ax, tempIndex
	add si, ax
	mov ax, [si]
	mul bx
	add amountInputConverted, ax
	inc multiplyLoopCount
	loop multiplyWithdrawal
	
	call calculateFee
		
	NEWLINE
	PRINTSTRING withdrawalSuccessMesg
    PRINTSTRING balanceMesg
    call printCurrentUserBalance
    NEWLINE
    jmp menu
	
	

;======================transferModule======================
    transfer:
    
    promptBankAccount:
	PRINTSTRING promptBankAccountMesg
	lea si, transferInput
	
    promptBankAccountInput:
	SCANCHAR
	cmp al,13
	jne contPromptBankAccountInputJumper
	mov al,'$'
	mov [si], al
	lea si, transferInput
	mov al, [si]
	cmp al, '0'
	je menuJumper1
	cmpCurrentUser:
	cmp userType, 1
	je checkTransferToMyselfUser1
	cmp userType, 2
	je checkTransferToMyselfUser2
	jmp cmpUser1

	contPromptBankAccountInputJumper:
	jmp contPromptBankAccountInput

	menuJumper1:
	jmp menu
	checkTransferToMyselfUser1:
	lea si, transferInput
	lea di, user1AccNum
	mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    jmp invalidBankAccountInput
    
    checkTransferToMyselfUser2:
	lea si, transferInput
	lea di, user2AccNum
	mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser1
    jmp invalidBankAccountInput
	
	cmpUser1:
    lea si, transferInput
    lea di, user1AccNum
    mov al, [si]
    cmp al, [di]
    jne cmpUser2
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser2
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser2
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne cmpUser2
    mov transferTo, 1
    jmp promptTransferAmount
    
    cmpUser2:
    lea si, transferInput
    lea di, user2AccNum
    mov al, [si]
    cmp al, [di]
    jne invalidBankAccountInput
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne invalidBankAccountInput
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne invalidBankAccountInput
    inc si
    inc di
    mov al, [si]
    cmp al, [di]
    jne invalidBankAccountInput
    mov transferTo, 2
	jmp promptTransferAmount 
	
    contPromptBankAccountInput:
	mov [si],al
	inc si
	jmp promptBankAccountInput

    invalidBankAccountInput:
    PRINTSTRING invalidInputMesg
    jmp promptBankAccount

    promptTransferAmount:
	PRINTSTRING promptTransferAmountMesg
	lea si, transferInput
	mov inputCount, 0
	
    promptTransferAmountInput:
	SCANCHAR
	cmp al,13
	jne contPromptTransferAmountInput
	mov al,'$'
	mov [si], al
	cmp inputCount,0
	je invalidInputTransfer
	cmp inputCount,4
	jg invalidInputTransfer
	mov cx, inputCount
    jmp multiplyTransfer
    
    contPromptTransferAmountInput:
	mov [si],al
	inc si
	inc inputCount
	jmp promptTransferAmountInput
	
    invalidInputTransfer:
    PRINTSTRING invalidInputMesg
    jmp promptTransferAmount
    
    multiplyTransfer:
    lea si, transferInput
    mov ax, 0
    mov dx, 0
    cmp cx, 4
    je four
    cmp cx, 3
    je three
    cmp cx, 2
    je two
    cmp cx, 1
    je one
    
    four:
    mov dl, [si]
    add ax, dx
    sub ax, 30h
    mov bx, 10
    mul bx
    inc si
    
    three:
    mov dl, [si]
    add ax, dx
    sub ax, 30h
    mov bx, 10
    mul bx
    inc si
    
    two:
    mov dl, [si]
    add ax, dx
    sub ax, 30h
    mov bx, 10
    mul bx
    inc si
    
    one:
    mov dl, [si]
    add ax, dx
    sub ax, 30h
    mov amountInputConverted, ax
    cmp userType, 1
    je deductFromCurrentUser1
    cmp userType, 2
    je deductFromCurrentUser2Jumper
    
    deductFromCurrentUser1:
    cmp ax, userBalance1
    jg invalidInputTransfer
    je compareDecimal1
    jmp validToTransfer1

	deductFromCurrentUser2Jumper:
	jmp deductFromCurrentUser2
    
	invalidInputTransferJumper2:
	jmp invalidInputTransfer

    compareDecimal1:
    mov ax, amountInputConverted
    mov dx, 0 
	mov bx, 10000
	div bx
	cmp dx, userSenBalance1
	jg invalidInputTransferJumper2
	
    validToTransfer1:
    mov ax, amountInputConverted
    mov dx, 0
    sub userBalance1, ax 
	mov bx, 10000
	div bx
	cmp userSenBalance1, dx
	jge noNeedBorrow1
    sub userBalance2, 1
    add userSenBalance1, 10000
    
    noNeedBorrow1: 
	sub userSenBalance1, dx	
	NEWLINE
	PRINTSTRING transferSuccessMesg
	PRINTSTRING balanceMesg
	NEWLINE    
    PRINT4DIGIT userBalance1
    PRINTDOT
    PRINT4DIGIT userSenBalance1
	jmp finishDeductFromCurrentUser

	invalidInputTransferJumper:
	jmp invalidInputTransfer



    deductFromCurrentUser2:
    cmp ax, userBalance2
    jg invalidInputTransferJumper
    je compareDecimal2
    jmp validToTransfer2

    compareDecimal2:
    mov ax, amountInputConverted
    mov dx, 0 
	mov bx, 10000
	div bx
	cmp dx, userSenBalance2
	jg invalidInputTransferJumper

    validToTransfer2:
    mov ax, amountInputConverted
    mov dx, 0
    sub userBalance2, ax 
	mov bx, 10000
	div bx
	cmp userSenBalance2, dx
	jge noNeedBorrow2
    sub userBalance1, 1
    add userSenBalance2, 10000
    
    noNeedBorrow2: 
	sub userSenBalance2, dx	
	NEWLINE
	PRINTSTRING transferSuccessMesg
    PRINTSTRING balanceMesg
    NEWLINE    
    PRINT4DIGIT userBalance2
    PRINTDOT
    PRINT4DIGIT userSenBalance2
    NEWLINE
	jmp finishDeductFromCurrentUser    
    
    finishDeductFromCurrentUser:    
    cmp transferTo, 1
    je transferToUser1
    cmp transferTo, 2
    je transferToUser2
    
    transferToUser1:
    mov ax, amountInputConverted
    add userBalance1, ax
    jmp finishTransfer
    
    transferToUser2:
    mov ax, amountInputConverted
    add userBalance2, ax
    jmp finishTransfer
    
    finishTransfer:
    inc countTrf
    NEWLINE


;======================nextTransaction?======================
    nextTransaction:
	PRINTSTRING promptNextTransactionMesg
	NEWLINE
	SCANCHAR
	cmp al, 'y'
	je menuJumper
	cmp al, 'Y'
	je menuJumper
	cmp al, 'n'
	je quit
	cmp al, 'N'
	je quit
	jmp nextTransaction

menuJumper:
	jmp menu

exit2:
	mov ah,09h
	mov dx,offset inUser
	int 21h
		

quit:
    NEWLINE
	PRINTSTRING logoutMsg
	jmp PMPT

quitAttemptOverflow:
    jmp LOGOUT


;==================user defined function=======================
optionPromptJmp1:
	jmp optionPromptJmp2

PMPT:	
    lea dx, msg3
	mov ah, 09h
	int 21h
	mov ah, 01h	;read input
	int 21h
	JMP CMPARE
	
CMPARE:	cmp al, 59h
	JE optionPromptJmp1
	cmp al, 79h
	JE optionPromptJmp1	
	cmp al, 4eh
	JE SUMM
	cmp al, 6eh
	JE SUMM
	JMP OTHER

SUMM:	lea dx, msg5
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countDep
	int 21h
	lea dx, msg6
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countWdw
	int 21h
	lea dx, msg7
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countTrf
	int 21h
	JMP LOGOUT


OTHER:	lea dx, errMsg
	mov ah, 09h
	int 21h
	JMP PMPT

LOGOUT:	
    lea dx, msg2
	mov ah, 09h
	int 21h
	mov ah, 4ch
	int 21h	

	mov ah,4ch
	int 21h
main endp
	end main