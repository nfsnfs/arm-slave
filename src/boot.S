# To make sure the section be the first in kernel
.section ".text.boot"

.global _start

_start:
	mov sp, #0x8000

	ldr r1, =boot_bss_start
	ldr r2, =boot_bss_end
	mov r3, #0x00

# clear boot bss section
1:
	cmp r1, r2
	stmltia r1!, {r3}
	blt 1b

	# switch to SVC mode and disable interrupt
	msr cpsr_cxsf, #(SVC_MODE | NO_INT)
	
	# using user mode stack for boot
	ldr sp, svc_stack

	bl start
	b .