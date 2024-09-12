/*
Prime number is a number whic is divisible by 1 or itself 


*/ 

public class PrimeNumber {
    
 Public Boolean Primecheck(Integer num){
       for(integer i=2;i<num;i++){
            If((math.mod(num, i)==0 ))  {
             	return false;
            } 
        }
        return true;
         
     }
}