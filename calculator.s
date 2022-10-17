#
# Usage: ./calculator <op> <arg1> <arg2>
#

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text
checkIfExists:
        movq $ERR_MSG, %rdi
        mov $0, %al
        call printf
	leave
	ret

checkIfMinus:
        cmp subtract_op, %sil
        jne checkIfMulti

        # movq %r13, %rdi
        # mov $0, %al
        # call atol

        # mov %rax, %rbx

        # movq %r14, %rdi
        # mov $0, %al
        # call atol

        # sub %rax, %rbx
        # mov %rbx, %rsi

	sub %r14, %r13
	mov %r13, %rsi
        mov $format, %rdi
        mov $0, %al
        call printf

        leave
        ret

checkIfMulti:
        cmp multi, %sil
        jne checkIfDiv

        # movq %r13, %rdi
        # mov $0, %al
        # call atol

        # mov %rax, %rbx

        # movq %r14, %rdi
        # mov $0, %al
        # call atol

        # imulq %rax, %rbx
        # mov %rbx, %rsi

	imulq %r13, %r14
	mov %r14, %rsi
        mov $format, %rdi
        mov $0, %al
        call printf

        leave
        ret

checkIfDiv:
        cmp divid, %sil
        jne checkIfExists
  	
        mov %r13, %rax
	
	cqto
        idivq %r14
        mov %rax, %rsi
        
        mov $format, %rdi
        mov $0, %al
        call printf
  
        leave
        ret

# int main(int argc, char argv[][])
main:
  # Function prologue
  enter $0, $0

  # Variable mappings:
  # op -> %r12
  # arg1 -> %r13
  # arg2 -> %r14
  movq 8(%rsi), %r12  # op = argv[1]
  movq 16(%rsi), %r13 # arg1 = argv[2]
  movq 24(%rsi), %r14 # arg2 = argv[3]

  # Hint: Convert 1st operand to long int
        movq %r13, %rdi
	mov $0, %al
	call atol
	
        mov %rax, %r13 # stored completely

  # Hint: Convert 2nd operand to long int
        movq %r14, %rdi
        mov $0, %al
        call atol

        mov %rax, %r14 # stored completely


  # Hint: Copy the first char of op into an 8-bit register
  # i.e., op_char = op[0] - something like mov 0(%r12), ???
	mov 0(%r12), %sil
	
	# mov %sil, %rsi
	# movq $txt, %rdi

	# mov $0, %al
        # call printf

  # if (op_char == '+')
      cmp addit, %sil
	
	jne checkIfMinus

	addq %r13, %r14
        mov %r14, %rsi
	
	mov $format, %rdi
        mov $0, %al
        call printf
	
	leave
	ret

  # else if (op_char == '-') {
  # }	
  # else {
  #   // print error
  #   // return 1 from main
  # }

  # Function epilogue
  leave
  ret


# Start of the data section
.data

ERR_MSG: .asciz "Unknown operation\n"

format: .asciz "%ld\n"

txt: .byte 'h'

addit: .byte '+'
subtract_op: .byte '-'
multi: .byte '*'
divid: .byte '/'

