    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:

    // make sure when we start to add both inputs are positive 
    // if not extra registers to find out if it is + or - = XOR
 
    // arguments given are num1, num2 
    stp x29, x30, [sp, -64]! // creating space on the stack
    mov x29, sp              // setting fp to sp

    str x19, [sp, 16]        // saving value of x19 onto stack 
    str x20, [sp, 24]        // saving value of x20 onto stack
    str x21, [sp, 32]        // saving value of x21 onto stack
    str x22, [sp, 40]        //x22 
    str x23, [sp, 48]        //x23

    // stack - x29, x30, x19 - num1, x20 - num2, x21 - XOR bit
    // x22 - neg bit for x19, x23 - neg bit for x20
    // w0 - sum
    
    mov x19, x0              // set w19 as num1
    mov x20, x1              // set w20 as num2
    mov x0, #0               // set up sum as 0
    mov x21, #0
    mov x22, #0
    mov x23, #0

    // before we do multiplication we are gonna check if -
    cmp x19, 0               // check if negative num1 
    bge notneg1              // >= 0 if positive
    mov x22, 1               // if negative set x22 to 1

   //negate
    mov x0, 0                // num1 = 0 
    mov x1, x19              // num2 = x19
    bl intsub                // subtract 
    mov x19, x0              // set x19 to sum

notneg1:
    cmp x20, 0               // check if negative num2
    bge sign                 // >= 0 don't negate
    mov x23, 1               // set x23 to #1

    //negate 
    mov x0, 0                // num1 = 0
    mov x1, x20              // num2 = x20
    bl intsub                // subtract
    mov x20, x0              // set x20 to sum

sign:    
    eor x21, x22, x23        // xor w1 bit and w2 bit to make negate or not bit in w21
    mov x0, #0               //set sum to 0 
loop:
   cmp x20, #0               // check that num2 is not 0
   beq endloop               // if 0 branch to endloop

   and x1, x20, #1           // and num2 with &1 - put in w1
   cmp x1, #1                // check value that w1 has 1 bit
   bne else                  // if w1 not 1 bit, then go to else
   
   mov x1, x19               // mov num1 into w1
   bl intadd                 // sum += num1
                             // w0 now holds sum - intadd returns sum in w0

else:
   lsl x19, x19, #1          // num1 << 1
   lsr x20, x20, #1          // num2 >> 1
   b loop                    // loop back to top

endloop:
  // sum is in w0 

  // convert sum to negative if negative
  cmp x21, #1                // check if cmp is negative
  bne notnegate              // if negate bit in x21, then negate sum
  mov x19, x0                // just for temp I'm moving 
  mov x0, 0                  // set x0 = 0
  mov x1, x19                // set x1 = sum 
  bl intsub                  // do 0 - sum  
  //now we finished negating

notnegate: 
  // clean up 
   ldr x19 , [x29 , 16]
   ldr x20 , [x29 , 24]
   ldr x21,  [x29 , 32]
   ldr x22,  [x29 , 40]
   ldr x23,  [x29 , 48]
   ldp x29 , x30 , [ sp ] , 64
   ret 

   

