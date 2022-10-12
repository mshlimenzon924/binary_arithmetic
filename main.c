#include <stdio.h>

int main(int argc, char* argv){
    int var1, var2;
    char cont = 'y', oper;
    while(cont == 'y'){
        printf("Enter Number 1: ");
        scanf("%d", &var1);
        printf("\nEnter Number 2: ");
        scanf("%d", &var2);
        printf("\nEnter Operation:");
        scanf("  %c", &oper);
        if(oper == '+'){
             printf("\nResult is: %d", intadd(var1,var2));
        }else if(oper == '-'){
            printf("\nResult is: %d", intsub(var1,var2));
        }else if(oper == '*'){
            printf("\nResult is: %d", intmul(var1,var2));
        }else{
            printf("\nInvalid Operation");
        }
        
        printf("\nAgain? ");
        scanf("  %c",&cont); 

    }

    return 0;

}

int intadd(int a,int b){
    return a + b;   
}
int intsub(int a,int b){
    return a - b;
}
int intmul(int a,int b){
    return a * b;
}





