@isTest
public class FitnessTest {
        @isTest
        Public static void calculateBMITest(){
        Fitness fit =new Fitness();
        Decimal fitness =fit.calculateBMI(100,10);
        System.assertEquals(1, fitness,'BMI does not match');
        
     }
    @isTest
        Public static void calculatePaceTest(){
        Fitness fito =new Fitness();
        Decimal fitnessomg =fito.calculatePace(10,60);
        System.assertEquals(10, fitnessomg,'BPaceTest does not match');
      
    
   } 
}