Public Class Helloworld{
    Public String getday(Integer daynum){
    
      String daystring='';
     
     Switch on daynum{
     when 0{
     daystring='Sunday';
      }
    when 1{
     daystring='Monday';
      }
    when 2{
     daystring='Tuesday';
      }
    when 3{
     daystring='Wednesday';
      }
    when 4{
     daystring='Thrudsay';
    }
    when 5{
     daystring='Friday';
      }
    when 6{
     daystring='Saturday';
      }
      when 7{
        daystring='Banglore';
         }
    when else{
     daystring='Invalid Day number';
    }
  }
  return daystring;
}
Public String getday(String abbrevation){
String daystring='';
Switch on abbrevation{
     when 'Sun'{
     daystring='Sunday';
      }
    when 'Mon'{
     daystring='Monday';
      }
    when 'Tue'{
     daystring='Tuesday';
      }
    when 'Wed'{
     daystring='Wednesday';
      }
    when 'Thru'{
     daystring='Thrudsay';
    }
    when 'Fri'{
     daystring='Friday';
      }
    when 'Sat'{
     daystring='Saturday';
      }
    when else{
     daystring='Invalid Day number';
    }
}
return daystring;
}

}