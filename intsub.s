    // intsub function in this file

    .arch armv8-a
    .global intsub

intsub:
    // arguments given are num1, num2 
    stp x29, x30, [sp, -32]!   // creating space on the stack
    mov x29, sp                // setting fp to sp
    str x19, [sp, 16]
    str x20, [sp, 24]

   // stack - x29, x30, x19 - for num1 , x20 - for num2
   mov x19, x0 
   mov x20, x1
   
   // we will set x0 as num1 and x1 as num2 
   mov x0, 1                   // x0 = 1
   mvn  x1, x1                 // x1 = flipped bits 
   bl intadd                   // now num2 is negative
   mov x20, x0                 // put num2 back 
  
   // lets put back x19 and x20
   mov x0, x19
   mov x1, x20 
   bl intadd                   // call intadd 
   // when we return, sum will be in x0

   ldr x19, [x29, 16]
   ldr x20, [x29, 24]
   ldp x29 , x30 , [ sp ] , 32
   ret                         // sum will be in x0
