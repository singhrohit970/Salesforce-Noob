public class Box {
    Private Integer l;
    Private Integer b;
    Private Integer h;
    Private Integer m;
    Public Box()  //Default Constructor
    {
       l=0;
       b=0;
       h=0;
       
    }
    Public Box(Integer len, Integer br, Integer he){  //Parametrize constructor
        l=len;
        b=br;
        h=he;
        
      }    
    Public Integer Volume(){  //Volume Method
        
        Integer vol= l*b*h;
        return vol;
       }
     Public Integer SurafceArea(){  //Surface Method
        
        Integer Sur= (2*(l*b+l*h+b*h));
        return Sur;
      }
    
     Public Integer Density(Integer mass){  //Density Method
        Integer vol= l*b*h;
     
        Integer Den=mass/vol ;
        return Den;
     }
}