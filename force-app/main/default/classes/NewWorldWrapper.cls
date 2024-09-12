public class NewWorldWrapper {
  @AuraEnabled(cacheable=true)
    public static String getName(){
       String name= [select Name from PricebookEntry where id ='01u2w000001VBhMAAW'].Name;
        return name;
    }
    
     @AuraEnabled(cacheable=true)
     public static String getAddress(){
        return 'Rohit Address';
    }
}