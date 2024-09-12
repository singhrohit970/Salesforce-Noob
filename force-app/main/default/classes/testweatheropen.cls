public with sharing class testweatheropen {

public String city{get;set;}
public String temp{get;set;}
public String pressure{get;set;}
public String humidity{get;set;}
public String temp_min{get;set;}
public String temp_max{get;set;}


    public testweatheropen(ApexPages.StandardController stdController) 
    {

    Account account =(Account)stdController.getRecord();  //get the current account record
    account =[select Id,ShippingCity from Account wHERE Id=:account.Id ];
    
    String accountCity =account.ShippingCity;
    String apikey='09bf36b3c68680f8a525411800269158';

    String requestEndPoint= 'https://api.openweathermap.org/data/2.5/weather';
    requestEndPoint+='?q='+accountCity;
    requestEndPoint+='&units=metric';
    requestEndPoint+='&APPID='+apikey;


    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.SetEndPoint(requestEndPoint);
    request.setMethod('GET');
    HttpResponse response =http.send(request);

    if(response.getStatusCode()==200)
    {
    Map<String,Object> results= (Map<String,Object>)JSON.deserializeUntyped(response.getbody());
    city = String.valueOf(results.get('name'));
    Map<String,Object> mainresults= (Map<String,Object>)(results.get('main'));
    temp=String.valueOf(mainresults.get('temp'));
    pressure=String.valueOf(mainresults.get('pressure'));
    humidity=String.valueOf(mainresults.get('humidity'));
    temp_min=String.valueOf(mainresults.get('temp_min'));
    temp_max=String.valueOf(mainresults.get('temp_max'));
    
}else{
ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'There was an error in reading data');
ApexPages.addMessage(myMsg);
     }
   }
 }