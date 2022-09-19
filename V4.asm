.model large
.stack 9999
.data
;==========Print Welcome Screen Messages
	dotted1Mesg DB 13,10,"------------------------------------------------------------------------$"
	printWelcomeScreenMesg DB 13,10,"					WELCOME TO DLBank!$"

;==========Prompt Main Menu Options Messages
	mainMenuOptionsMesg1 DB 13,10,"Enter 1 to register$"
	mainMenuOptionsMesg2 DB 13,10,"Enter 2 to login$"
	mainMenuOptionsMesg3 DB 13,10,"Enter 3 to close program$"
	mainMenuOptionsMesg4 DB 13,10,"Enter your option: $"
	invalidOptionMesg DB 13,10,"Invalid option$"

;==========Register Bank Account Module Messages
	newAccNumMesg DB 13,10,"Your account number is $"
	promptNewAccPwMesg DB 13,10,"Set your password: $"
	doneRegisterMesg DB 13,10,"Your account has been created, Welcome To DLBank! $"
	toContinueMesg DB 13,10,"Press any button to continue...$"

;==========Login Bank Account Module Messages
	loginTooMuchMesg DB 13,10,"Wrong input(5 times). Please try again in 3 minutes$"
	promptUserAccNumMesg DB 13,10,"Enter bank account: $"
	promptUserPwMesg DB 13,10,"Enter password: $"
	invalidAccNumMesg DB 13,10,"Access Denied! (INVALID ACCOUNT NUMBER) $"
	InvalidPwMesg DB 13,10,"Access Denied! (INVALID PASSWORD) $"
	loginSuccessMesg DB 13,10,"Access Granted! $"

;==========Print User Bank Account Details Messages
	dotted2Mesg DB 13,10,"=====================$"
	bankLogoMesg DB 13,10,"       DL BANK$"
	nameMesg DB 13,10,"Hello, Mr/Ms $"
    balanceMesg DB 13,10,"Your bank balance is RM$"

;=========Prompt Sub Menu Options Messages
	subMenuOptionsMesg1 DB 13,10,"Enter 0 to Logout$"
	subMenuOptionsMesg2 DB 13,10,"Enter 1 to Deposit$"
	subMenuOptionsMesg3 DB 13,10,"Enter 2 to Withdrawal$"
	subMenuOptionsMesg4 DB 13,10,"Enter 3 to Transfer$"
	subMenuOptionsMesg5 DB 13,10,"Enter your option: $"

	promptDepositAmountMesg DB 13,10,"Enter deposit amount: $"
	depositSuccessMesg DB 13,10,"Deposit successfully!$"

	promptWithdrawalAmountMesg DB 13,10,"Enter withdrawal amount: $"
    withdrawalSuccessMesg DB 13,10,"Withdrawal successfully!$"

	promptTransferBankAccountMesg DB 13,10,"Enter receiver bank account: $"
	promptTransferAmountMesg DB 13,10,"Enter transfer amount: $"
	transferSuccessMesg DB 13,10,"Transfer successfully!$"

	promptNextTransactionMesg DB 13, 10, "Any other transaction?(Y/N)$"

	logoutSuccessMesg DB 13,10,"Logout successfully! Thank you for using DLBank ATM.$"

	confirmCloseProgramMesg DB 13, 10, "Are you sure to close program?(Y/N)$"
	summaryMesg1 DB 13, 10, "Summary$"
	summaryMesg2 DB 13, 10, "Deposit(s): $"
	summaryMesg3 DB 13, 10, "Withdrawal(s): $"
	summaryMesg4 DB	13, 10, "Transfer(s): $"
	countDep DB '0'
	countWdw DB '0'
	countTrf DB '0'



;==========All
	invalidInputMesg DB 13, 10, "INVALID INPUT!$"
	inputCount DB 0

;==========Login Bank Account Module Varibles
	accNumInput DB 35 dup('$')
	pwInput DB 35 dup('$')
	loginTrialCount DB 0

;==========User Varibles
	userType DB 0
	user1AccNum DB "1234$"
	user2AccNum DB 35 dup('$')
	user1Pw DB "asdf$"
	user2Pw DB 35 dup('$')
	user1Name DB "Pua Jin Jian$"
	user2Name DB "Hoo Chun Yuan$"
	user1Balance DW 9420
	user1BalanceDec DW 5000
	user2Balance DW 6688
	user2BalanceDec DW 8500


    transferAcc DB 35 dup('$')
	transferTo DB ?

;=========================TRANSFER=========================	
	transferInput DB 35 dup('$')

;======================DEPOSIT&WITHDRAWAL======================	
	amountInput DW 0, 0, 0, 0
	amountInputConverted DW 0
	amountInputCalculated DW 0
	amountInputCalculatedDec DW 0
	tempIndex DW ?
    multiplyLoopCount DB 0
    addToDecFactor DW 0



;======================MACRO LIST======================
PRINTDECIMALPOINT MACRO
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

.code
assignToAx proc
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

printCurrentUserBalance proc
    cmp userType, 1
	je printUser1Jumper
    PRINT4DIGIT user2Balance
    jmp asdf
printUser1Jumper:
	jmp printUser1
	
asdf:
PRINTDECIMALPOINT
    PRINT4DIGIT user2BalanceDec
	jmp afterPrintBalance

printUser1:
    PRINT4DIGIT user1Balance
    PRINTDECIMALPOINT
    PRINT4DIGIT user1BalanceDec
afterPrintBalance:    	
    ret

printCurrentUserBalance endp 

addAxToBalance proc  ;;
    cmp userType, 1
    je addToUser1
    jne addToUser2
    
addToUser1:
    add user1Balance, ax
    jmp afterAddBalance
    
addToUser2:
    add user2Balance, ax
    
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
		mov ax, user1Balance
		cmp ax, amountInputCalculated
		jng invalidInputWithdrawalJmper1 ;if balance not enuf
		je compareDecIfSame ;check decimal if before decimal is same
		jmp doSub; if enuf for withdrawal
	compareDecIfSame:
		mov ax, user1BalanceDec
		cmp ax, amountInputCalculatedDec
		jng invalidInputWithdrawalJmper1 ;not enuf balance
	takeBeforeDecimal:    
		dec user1Balance ; take before decimal
		mov ax, addToDecFactor
		add user1BalanceDec, ax       
	doSub:
		mov ax, amountInputCalculatedDec
		cmp user1BalanceDec, ax
		jng takeBeforeDecimal
		mov ax, amountInputCalculated
		sub user1Balance, ax
		mov ax, amountInputCalculatedDec
		sub user1BalanceDec, ax 
		jmp returnCalculateFee
	proceedSub2:
		mov ax, user2Balance
		cmp ax, amountInputCalculated
		jng invalidInputWithdrawalJmper1 ;if balance not enuf
		je compareDecIfSame ;check decimal if before decimal is same
		jmp doSub2; if enuf for withdrawal
	compareDecIfSame2:
		mov ax, user2BalanceDec
		cmp ax, amountInputCalculatedDec
		jng invalidInputWithdrawalJmper1 ;not enuf balance
	takeBeforeDecimal2:    
		dec user2Balance ; take before decimal
		mov ax, addToDecFactor
		add user2BalanceDec, ax     
	doSub2:
		mov ax, amountInputCalculatedDec
		cmp user2BalanceDec, ax
		jng takeBeforeDecimal
		mov ax, amountInputCalculated
		sub user2Balance, ax
		mov ax, amountInputCalculatedDec
		sub user2BalanceDec, ax 
	returnCalculateFee:  
		ret    
calculateFee endp    




;======================withdrawalJumper======================
withdrawalJmper1:
	jmp withdrawalModule
transferJmper1:
	jmp transferModule
invalidInputWithdrawalJmper1:
    jmp	invalidWithdrawalAmountInput
;============================================================



;==========Main Program
main proc
	mov ax,@data
	mov ds,ax

;==========Print Welcome Screen
printWelcomeScreen:
	PRINTSTRING dotted1Mesg
	PRINTSTRING printWelcomeScreenMesg
	PRINTSTRING dotted1Mesg

;==========Prompt Main Menu Options
PromptMainMenuOptions:
;====================Print Main Menu Options
	PRINTSTRING mainMenuOptionsMesg1
	PRINTSTRING mainMenuOptionsMesg2
	PRINTSTRING mainMenuOptionsMesg3
	PRINTSTRING mainMenuOptionsMesg4
;====================Input Main Menu Options
	SCANCHAR

;==========Compare Main Menu Options
	cmp al,'1'
	je registerBankAccModule
	cmp al,'2'
	je loginBankAccountModule
	cmp al,'3'
	je closeProgram
	PRINTSTRING invalidOptionMesg
	NEWLINE
	jmp PromptMainMenuOptions

;==========Register Bank Account Module
registerBankAccModule: 
;====================Print New Account Number
	PRINTSTRING newAccNumMesg
	lea si,user1AccNum
	lea di,user2AccNum
	mov cx,5
;====================Assign User 2 Account Number
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

;==========Login Bank Account Module
loginBankAccountModule:
	cmp loginTrialCount,5
	jne promptUserAccNum
	PRINTSTRING loginTooMuchMesg
	NEWLINE
	jmp printWelcomeScreen
;====================Prompt User Account Number
promptUserAccNum:
	PRINTSTRING promptUserAccNumMesg
	lea si,accNumInput 
scanAccNumInput:
	SCANCHAR
	cmp al,13
	je finishScanAccNumInput
	mov [si],al
	inc si
	inc inputCount
	jmp scanAccNumInput
finishScanAccNumInput:
	mov al,'$'
    mov [si], al
	cmp inputCount, 0
	je printInvalidAccNumMesg
;====================Check Account Number Input
	lea si,accNumInput
	lea di,user1AccNum
checkWithUser1AccNum:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	jne finishCheckWithUser1AccNum
	cmp al,'$'
	je setUserType1
	inc si
	inc di
	jmp checkWithUser1AccNum
finishCheckWithUser1AccNum:
	lea si,accNumInput
	lea di,user2AccNum
checkWithUser2AccNum:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	jne printInvalidAccNumMesg
	cmp al,'$'
	je setUserType2
	inc si
	inc di
	jmp checkWithUser2AccNum
;====================Set Current User Type
setUserType1:
    mov userType, 1
    jmp promptUserPw
setUserType2:
    mov userType, 2
;====================Prompt User Password
promptUserPw:
    PRINTSTRING promptUserPwMesg
	lea si,pwInput
scanPwInput:	
	SCANCHAR
	cmp al,13
	je finishScanPwInput
	mov [si],al
	inc si
	inc inputCount
	jmp scanPwInput
finishScanPwInput:
	mov al,'$'
    mov [si], al
;====================Check User Password Input
	lea si,pwInput
    cmp userType, 1
    je checkWithUser1Pw
	cmp userType, 2
    je checkWithUser2Pw
checkWithUser1Pw:
    lea di, user1Pw
    jmp checkUserPw 
checkWithUser2Pw:
    lea di, user2Pw
checkUserPw:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	jne printInvalidPwMesg
	cmp al,'$'
	je loginSuccess
	inc si
	inc di
	jmp checkUserPw
;====================Fail To Login
printInvalidAccNumMesg:
	PRINTSTRING invalidAccNumMesg
	mov inputCount, 0
	inc loginTrialCount
	jmp loginBankAccountModule
printInvalidPwMesg:
	PRINTSTRING InvalidPwMesg
	mov inputCount, 0
	jmp loginBankAccountModule 
;====================Login Successfully
loginSuccess:
	PRINTSTRING loginSuccessMesg
	PRINTSTRING toContinueMesg
	SCANCHAR

;==========Print User Bank Account Details
	cmp userType,1
	je showUser1BankAccDetails
	cmp userType,2
	je showUser2BankAccDetails
showUser1BankAccDetails:
	PRINTSTRING dotted2Mesg
	PRINTSTRING bankLogoMesg
	PRINTSTRING dotted2Mesg
	PRINTSTRING nameMesg
	PRINTSTRING user1Name
	PRINTSTRING balanceMesg
	call printCurrentUserBalance
	NEWLINE
	jmp promptSubMenuOptions
showUser2BankAccDetails:
	PRINTSTRING dotted2Mesg
	PRINTSTRING bankLogoMesg
	PRINTSTRING dotted2Mesg
	PRINTSTRING nameMesg
	PRINTSTRING user2Name
	PRINTSTRING balanceMesg
	call printCurrentUserBalance
	NEWLINE
	jmp promptSubMenuOptions

;====================================Jumper====================================
withdrawalJmper:
	jmp withdrawalModule
transferJmper:
	jmp transferModule
invalidInputWithdrawalJmper:
    jmp	invalidWithdrawalAmountInput
;====================================Jumper====================================

;=========Prompt Sub Menu Options
promptSubMenuOptions:
    mov multiplyLoopCount, 0
	mov inputCount, 0
	mov amountInputConverted, 0
	mov amountInputCalculated, 0
	mov amountInputCalculatedDec, 0
;==================Print Sub Menu Options
	PRINTSTRING subMenuOptionsMesg1
	PRINTSTRING subMenuOptionsMesg2
	PRINTSTRING subMenuOptionsMesg3
	PRINTSTRING subMenuOptionsMesg4
	PRINTSTRING subMenuOptionsMesg5
;==================Input Sub Menu Options
	SCANCHAR
	cmp al, '0'
	je logout
	cmp al, '1'
	je depositModule
	cmp al, '2'
	je withdrawalModule
	cmp al, '3'
	je transferModule
	jmp promptSubMenuOptions

;==========Deposit Module
depositModule:
    inc countDep
	PRINTSTRING promptDepositAmountMesg
	lea si, amountInput
    mov multiplyLoopCount, 0
	mov inputCount, 0
scanDepositAmountInput:
	SCANCHAR
	mov ah, 0
	cmp al,13
	je finishScanDepositAmountInput
	inc inputCount
	sub ax, 30h
	mov [si],ax
	add si, 2
	jmp scanDepositAmountInput	
finishScanDepositAmountInput:
    cmp inputCount, 0
    je invalidDepositAmountInput
    cmp inputCount, 4
    jg invalidDepositAmountInput
	mov cl, inputCount
	mov ch, 0
	mov bx, 1
    jmp multiplyDepositAmountInput
invalidDepositAmountInput:
    PRINTSTRING invalidInputMesg
    jmp depositModule
multiplyDepositAmountInput:
	mov tempIndex, cx
	dec tempIndex
    lea si, amountInput
    push bx
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
	loop multiplyDepositAmountInput
	NEWLINE
	PRINTSTRING depositSuccessMesg
    PRINTSTRING balanceMesg
    call printCurrentUserBalance
	NEWLINE
    jmp promptSubMenuOptions

;==========Withdrawal Module
withdrawalModule:
    inc countWdw
	PRINTSTRING promptWithdrawalAmountMesg
	lea si, amountInput
    mov multiplyLoopCount, 0
	mov inputCount, 0
	mov amountInputConverted, 0
scanWithdrawalAmountInput:
	SCANCHAR
	mov ah, 0
	cmp al,13
	je finishScanWithdrawalAmountInput
	inc inputCount
	sub ax, 30h
	mov [si],ax
	add si, 2
	jmp scanWithdrawalAmountInput	
finishScanWithdrawalAmountInput:
    cmp inputCount, 0
    je invalidWithdrawalAmountInput
    cmp inputCount, 4
    jg invalidWithdrawalAmountInput
	mov cl, inputCount
	mov ch, 0
	mov bx, 1
    jmp multiplyWithdrawalAmountInput
invalidWithdrawalAmountInput:
    PRINTSTRING invalidInputMesg
    jmp withdrawalModule
multiplyWithdrawalAmountInput:
    lea si, amountInput
	mov tempIndex, cx
	dec tempIndex
    push bx
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
	loop multiplyWithdrawalAmountInput
	call calculateFee
	NEWLINE
	PRINTSTRING withdrawalSuccessMesg
    PRINTSTRING balanceMesg
    call printCurrentUserBalance
	NEWLINE
    jmp promptSubMenuOptions
	
;==========Transfer Module
transferModule:
	PRINTSTRING promptTransferBankAccountMesg
	lea si, transferInput
	mov inputCount, 0
promptBankAccountInput:
	SCANCHAR
	cmp al, '$'
	je invalidBankAccountInput
	cmp al,13
	je cmpCurrentUser
	mov [si], al
	inc si
	inc inputCount
	jmp promptBankAccountInput
cmpCurrentUser:
	mov al,'$'
	mov [si], al
	cmp inputCount, 0
	je invalidBankAccountInput
	cmp userType, 1
	je checkTransferToMyselfUser1
	cmp userType, 2
	je checkTransferToMyselfUser2
checkTransferToMyselfUser1:
	lea si, transferInput
	lea di, user1AccNum
contCheckTransferToMyselfUser1:
	mov al, [si]
	mov dl, [di]
    cmp al, dl
    jne cmpUser1
	cmp al, '$'
	je invalidBankAccountInput
	inc si
	inc di
	jmp contCheckTransferToMyselfUser1
checkTransferToMyselfUser2:
	lea si, transferInput
	lea di, user2AccNum
contCheckTransferToMyselfUser2:
	mov al, [si]
	mov dl, [di]
    cmp al, dl
    jne cmpUser1
	cmp al, '$'
	je invalidBankAccountInput
	inc si
	inc di
	jmp contCheckTransferToMyselfUser2
cmpUser1:
    lea si, transferInput
    lea di, user1AccNum
contCmpUser1:
    mov al, [si]
	mov dl, [di]
    cmp al, dl
    jne cmpUser2
	cmp al, '$'
	je setTransferToUser1
    inc si
    inc di
    jmp contCmpUser1
cmpUser2:
    lea si, transferInput
    lea di, user2AccNum
contCmpUser2:
    mov al, [si]
	mov dl, [di]
    cmp al, dl
    jne invalidBankAccountInput
	cmp al, '$'
	je setTransferToUser2
    inc si
    inc di
    jmp contCmpUser2
setTransferToUser1:
	mov transferTo, 1
	jmp promptTransferAmount
setTransferToUser2:
	mov transferTo, 2
	jmp promptTransferAmount
invalidBankAccountInput:
    PRINTSTRING invalidInputMesg
    jmp transferModule
promptTransferAmount:
	PRINTSTRING promptTransferAmountMesg
	lea si, transferInput
	mov inputCount, 0
promptTransferAmountInput:
	SCANCHAR
	cmp al, '$'
	je invalidInputTransfer
	cmp al,13
	jne contPromptTransferAmountInput
	mov al,'$'
	mov [si], al
	cmp inputCount, 0
	je invalidInputTransfer
	cmp inputCount, 4
	jg invalidInputTransfer
    jmp multiplyTransferAmountInput
contPromptTransferAmountInput:
	mov [si],al
	inc si
	inc inputCount
	jmp promptTransferAmountInput
invalidInputTransfer:
    PRINTSTRING invalidInputMesg
    jmp promptTransferAmount
multiplyTransferAmountInput:
    lea si, transferInput
    mov ax, 0
    mov dx, 0
    cmp inputCount, 4
    je four
    cmp inputCount, 3
    je three
    cmp inputCount, 2
    je two
    cmp inputCount, 1
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
    je deductFromCurrentUser2
deductFromCurrentUser1:
    cmp ax, user1Balance
    jg invalidInputTransfer
    je compareDecimal1
    jmp validToTransfer1
compareDecimal1:
    mov ax, amountInputConverted
    mov dx, 0 
	mov bx, 10000
	div bx
	cmp dx, user1BalanceDec
	jg invalidInputTransfer
validToTransfer1:
    mov ax, amountInputConverted
    mov dx, 0
    sub user1Balance, ax 
	mov bx, 10000
	div bx
	cmp user1BalanceDec, dx
	jge noNeedBorrow1
    sub user1Balance, 1
    add user1BalanceDec, 10000
noNeedBorrow1: 
	sub user1BalanceDec, dx	
	NEWLINE
	PRINTSTRING transferSuccessMesg
	PRINTSTRING balanceMesg
    PRINT4DIGIT user1Balance
    PRINTDECIMALPOINT
    PRINT4DIGIT user1BalanceDec
	jmp finishDeductFromCurrentUser

deductFromCurrentUser2:
    cmp ax, user2Balance
    jg invalidInputTransfer
    je compareDecimal2
    jmp validToTransfer2
compareDecimal2:
    mov ax, amountInputConverted
    mov dx, 0 
	mov bx, 10000
	div bx
	cmp dx, user2BalanceDec
	jg invalidInputTransfer
validToTransfer2:
    mov ax, amountInputConverted
    mov dx, 0
    sub user2Balance, ax 
	mov bx, 10000
	div bx
	cmp user2BalanceDec, dx
	jge noNeedBorrow2
    sub user2Balance, 1
    add user2BalanceDec, 10000
noNeedBorrow2: 
	sub user2BalanceDec, dx	
	NEWLINE
	PRINTSTRING transferSuccessMesg
    PRINTSTRING balanceMesg
    PRINT4DIGIT user2Balance
    PRINTDECIMALPOINT
    PRINT4DIGIT user2BalanceDec
	jmp finishDeductFromCurrentUser    

finishDeductFromCurrentUser:    
    cmp transferTo, 1
    je transferToUser1
    cmp transferTo, 2
    je transferToUser2

transferToUser1:
    mov ax, amountInputConverted
    add user1Balance, ax
    jmp finishTransfer
transferToUser2:
    mov ax, amountInputConverted
    add user2Balance, ax
    jmp finishTransfer
finishTransfer:
    inc countTrf

;======================nextTransaction?======================
nextTransaction:
	NEWLINE
	PRINTSTRING promptNextTransactionMesg
	SCANCHAR
	cmp al, 'y'
	je promptSubMenuOptions
	cmp al, 'Y'
	je promptSubMenuOptions
	cmp al, 'n'
	je logout
	cmp al, 'N'
	je logout
	jmp nextTransaction
logout:
	PRINTSTRING logoutSuccessMesg
	NEWLINE
	jmp printWelcomeScreen	
closeProgram:
    lea dx, confirmCloseProgramMesg
	mov ah, 09h
	int 21h
	mov ah, 01h
	int 21h
	cmp al, 'y'
	je summary
	cmp al, 'Y'
	je summary	
	cmp al, 'n'
	je printWelcomeScreen
	cmp al, 'N'
	je printWelcomeScreen
	lea dx, invalidInputMesg
	mov ah, 09h
	int 21h
	jmp closeProgram
summary:
	lea dx, summaryMesg1
	mov ah, 09h
	int 21h	
	lea dx, summaryMesg2
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countDep
	int 21h
	lea dx, summaryMesg3
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countWdw
	int 21h
	lea dx, summaryMesg4
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, countTrf
	int 21h	

	mov ah,4ch
	int 21h
main endp
	end main