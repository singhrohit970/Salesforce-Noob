public class CreateUpdateRecord {

    @AuraEnabled
    public static List<Account> createRecord(String accountNames, String accountIndustries){
        
        List<Account> acclist = new List<Account>();
        
        if(accountNames!=Null){
            
          Account obj = new Account();
            obj.Name=accountNames;
            obj.Industry=accountIndustries;
            acclist.add(obj);
            System.debug('acclist:' +acclist);
            
          }
          if(!acclist.isEmpty()){
                insert acclist;
            return acclist; 
        }
         return null;
        
    }
    
    @AuraEnabled
    public static List<Account> updateRecord(String accountId,String accountNames, String accountIndustries){
        List<Account> updatedAccountList = new List<Account>();
        if(accountId!=Null)
        {
           
            Account accObj = new Account();
            accObj.Id=accountId;
            accObj.Name=accountNames;
            accObj.Industry= accountIndustries;
            updatedAccountList.add(accObj);
            
        }
          
        if(!updatedAccountList.isEmpty()){
            System.debug('updatedAccountList:' +updatedAccountList);
            update updatedAccountList;
            return updatedAccountList;
            
        }
       return null;
    }
    
}