	.file	"Fib.c"
	.text
	.globl	fibonacci
	.def	fibonacci;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci 		;разворачивание стека
fibonacci:
	pushq	%rsi
	.seh_pushreg	%rsi 		;добавление элемента в стек
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp 			;выделение сорока байт в стеке, с вычетом из rsp
	.seh_stackalloc	40 			;расширение стека
	.seh_endprologue 			;конец определения стека
	xorl	%esi, %esi 			;функция зануляет esi
	movl	%ecx, %ebx 			; ebx=ecx
.L3: ;
	cmpl	$1, %ebx 			;if (ebx<=1)
	jle	.L5 					;вызывается, если ebx<=1 (true)
	leal	-1(%rbx), %ecx 		;ecx=rbx-1
	subl	$2, %ebx 			;ebx=ebx-2
	call	fibonacci			;вызывается функция фибоначчи
	addl	%eax, %esi 			; результат fibonacci сохраняется в eax и записывается в: esi = esi + eax
	jmp	.L3
.L5: 							;срабатывает, если ebx==1 (рекурсия по одной из ветвей дошла до конца)
	leal	(%rbx,%rsi), %eax 	;сохраняет сумму rbx+rsi в eax
	addq	$40, %rsp 			;увеличивает значение указателя стека на 40 байт
	popq	%rbx 				;восстановление значения rbx из стека
	popq	%rsi 				;восстановление значения rsi из стека
	ret 						;возвращает управление вызывающей функции .L3
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270 \320\277\320\276\320\264 \320\275\320\276\320\274\320\265\321\200\320\276\320\274 %d \321\200\320\260\320\262\320\275\320\276 %d\12\0"
	.section	.text.startup,"x"
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$6, %ecx  			;Запоминаем 6 для вызова fibonacci
	call	fibonacci 			;Вызываем fibonacci, результат сохранится в eax
	movl	$6, %edx
	leaq	.LC0(%rip), %rcx
	movl	%eax, %r8d
	call	printf 				;в предыдущих строках собираем данные для вызова printf и вывода на экран
	xorl	%eax, %eax			;зануление eax
	addq	$40, %rsp
	ret							;возврат функции
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
