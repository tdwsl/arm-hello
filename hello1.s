/* hello [name] */

.data

askMsg:		.ascii	"What is your name?\n>\0"
helloMsgP1:	.ascii	"Hello, \0"
helloMsgP2:	.ascii	"!\n\0"

input:		.fill	80,1,0

.text

.globl _start
_start:
		ldr	%r1,=askMsg
		bl	putStr

		bl	readLine

		ldr	%r1,=helloMsgP1
		bl	putStr
		ldr	%r1,=input
		bl	putStr
		ldr	%r1,=helloMsgP2
		bl	putStr

		mov	%r7,$1
		swi	$0

readLine:
		mov	%r7,$3
		ldr	%r1,=input
		mov	%r2,$80
		mov	%r0,$1
		swi	$0

readLine0:
		ldrb	%r0,[%r1]
		cmp	%r0,#10
		beq	readLine1
		add	%r1,#1
		b	readLine0
readLine1:
		mov	%r0,$0
		strb	%r0,[%r1]

		mov	%pc,%r14

putStr:
		mov	%r2,%r1
		sub	%r2,#1
putStr0:
		add	%r2,#1
		ldrb	%r0,[%r2]
		cmp	%r0,#0
		bne	putStr0

		sub	%r2,%r1
		mov	%r7,$4
		mov	%r0,$1
		swi	$0

		mov	%pc,%r14
