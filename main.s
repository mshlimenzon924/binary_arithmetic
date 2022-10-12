    // Template main.s file for Lab 3
    // Spruha Nayak and Mira Shlimenzon

    .arch armv8-a
    .global main
main:
    stp x29, x30, [sp, -48]! // creating stack + saving fp and lr
    mov x29, sp              // putting new sp value into fp

    // stack: x29, x30, x19 -num1, x20 - num2, space for scanf

    // put all callee-registers onto stack (saved old values)
    str x19, [sp, 16]        // push x19 onto stack to store num1
    str x20, [sp, 24]        // push x20 onto stack to store num2
    // sp + 32 = spot for scanf

prompt:
    // driver function main lives here, modify this for your other functions
    
    // prompt for num1 
    ldr x0, =string1         // when to use w0
    bl printf

    //scanf for num1 
    ldr x0, =prompt1
    ldr x9, [x29], 32       // made x29 = now x29 + 32
    // x29 is now x29 + 32
    mov x1, x29             // mov x29 into x1
    bl scanf                // now address spot has num1  we need
    ldr x19,[x29]           // loading num1 into w19

    // prompt for num2
    ldr x0, =string2
    bl printf

    //scanf for num2
    ldr x0, =prompt1
    mov x1, x29            // accessing scanf address
    bl scanf
    ldr x20,[x29]          // loading num2 into x20 

    // prompt for oper
    ldr x0, =string3
    bl printf

    // scanf for oper
    ldr   x0, =scanchar      
    mov x1, x29           // Save stack pointer + 32 to x1
    bl      scanf         // Scan user's answer
    ldrb    w0, [x29]     // Put the user's value in r0

    cmp    x0, '*'
    beq    multiply

    cmp    x0, '+'
    beq    addition

    cmp    x0, '-'
    beq    subtraction

    //prompt error
    
    ldr x0, =string5
    bl printf
    ldr x0, =string6
    bl printf
    bl loop

multiply:

    mov x0, x19              // put num1 into x0
    mov x1, x20              // put num2 into x1
    bl intmul                // goes to multiply func
    mov x1, x0               // moves result into print parameter
    ldr x0, =string4         // moves string into print parameter
    bl printf                // prints Result is: #
    ldr x0, =string6         // moves again prompt into parameter
    bl printf                // prints Again? 
    bl loop                  // goes to scan and possibly repeat

addition:
    mov x0, x19              // put num1 into x0
    mov x1, x20              // put num2 into x1
    bl intadd                // goes to add func
    mov x1, x0               // moves result into print parameter
    ldr x0, =string4         // moves string into print parameter
    bl printf                // prints Result is: #
    ldr x0, =string6         // moves again prompt into parameter
    bl printf                // prints Again? 
    bl loop                  // goes to scan and possibly repeat

subtraction:   
    mov x0, x19              // put num1 into x0
    mov x1, x20              // put num2 into x1
    bl intsub                // goes to sub func
    mov x1, x0               // moves result into print parameter
    ldr x0, =string4         // moves string into print parameter
    bl printf                // prints Result is: #
    ldr x0, =string6         // moves again prompt into parameter
    bl printf                // prints Again? 
    bl loop                  // goes to scan and possibly repeat


loop: ldr     w0, =scanchar    //w?
      mov x1, x29              // Save stack pointer + 32
      bl      scanf            // Scan user's answer
      ldr     x1, =yes         // Put address of 'y' in x1
      ldrb    w1, [x1]         // Load the actual character 'y' into x1
      ldrb    w0, [x29]        // Put the user's value in r0
      cmp     w0, w1           // Compare user's answer to char 'y'
      beq      prompt          // if y is equal to users answer reprompt

 
end: 
     ldr x9, [x29], -32        //move x29 = sp -32  
     ldr x19 , [x29 , 16] 
     ldr x20 , [x29 , 24]
     ldp x29 , x30 , [ sp ] , 48
     ret


yes:
    .byte   'y'

scanchar:
    .asciz  " %c"

string1:
   .asciz "Enter Number 1: "
prompt1:
    .asciz "%lld"//\n
string2:
   .asciz "Enter Number 2: "
string3:
   .asciz "Enter Operation: "
string4:
   .asciz "Result is: %lld\n"
string5:
   .asciz "Invalid Operation\n"
string6:
   .asciz "Again? "


