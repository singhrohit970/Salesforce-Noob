public class TestAccountClass {

@AuraEnabled(cacheable=true)    
    public static List<Account> getAccount(){
        
        List<Account> accList=[SELECT id ,Name,Website,Phone from Account limit 14];
        
        if(!accList.isEmpty()){
            system.debug('accList:'+ accList);
            return accList;
        }
        return Null;
            
        
        
    }
    
    
    @AuraEnabled
    
    public static String updateAccountDetails(object accountData){
        system.debug('accountData:' +accountData);
        
      
         List<Account> accountList = (List<Account>) JSON.deserialize(
          JSON.serialize(accountData), List<Account>.class
         );
         system.debug('accountList:'+ accountList);
        
        
        
         if(!accountList.isEmpty()){
             update accountList;
             return 'Account Updated';
            
        }
         return 'failed';
    }
    
    

}