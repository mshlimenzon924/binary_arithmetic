    .arch armv8-a
    .global intadd

intadd:
   // arguments given are num1, num2 
   // x0 - starts off as num1
   // x1 - starts off as num2 then becomes carry
   // x2 - temp

   eor x2, x0, x1   // sum = a xor b 
   and x1, x0, x1   // carry = a and b 
   mov x0, x2
  
loop: 
   cmp x1, #0      // carry - 0
   beq end         // if carry is 0 break out

   lsl x1, x1, #1  // left shift num2 and put it

   // now new cycle begins
   eor x2, x0, x1  // w2 will hold the sum
   and x1, x0, x1  // and then w1 will hold carry
   mov x0, x2

   b loop          // not BL!!!! B + L = links

end:
   ret             //return with x0 having sum  
