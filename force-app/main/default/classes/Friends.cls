/*Pizza Rates:
1 slice - $8/slice
2-3 slice - $7/slice
>3 slice - $6/slice

Ross ordered - 3 slices so rose will have =7*3
Chandler ordered - 1 slice so Chandler will have =1*8
Joey ordered - 4 slices so Joey will have =6*4 amount
*/

public class Friends {
//Create rate card with constant    
final Integer ONLY_ONE_SLICE=8;
final Integer UPTO_3_SLICE=7;
final Integer MORE_THAN_THREE_SLICE=6;

// this method accepts number slices
    // and returns the amount    
    Public Integer getbill(Integer Numberofslices){
        
        Integer billamount = Numberofslices ==1? ONLY_ONE_SLICE*Numberofslices :(Numberofslices<=3 ? UPTO_3_SLICE*Numberofslices :MORE_THAN_THREE_SLICE*Numberofslices);
            return billamount;
    }
}