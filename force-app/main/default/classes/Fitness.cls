/* 
use method name as calculateBMI
Formula needed: (Body wt in kg)/(Body height in meter)2

Pace Calculator
Method name use: calculatePace
Pace formula: result form below formula is in km per min .convert it to km per hour
(Distance in KM)/(Time in min)


*/
public class Fitness {
    
    
    Public  Decimal calculateBMI (Decimal weight, Decimal height ){
        Decimal BMI= Weight/(height*height);
        return BMI;
        
    }  
    Public  Decimal calculatePace (Decimal Dis, Decimal minutes){
      Decimal Tim = minutes/60;
        Decimal Pace= Dis/Tim;
        return Pace;
    }  
}