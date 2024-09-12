/*
 Account controller Class
THis class has helpful method to work with account object

*/
public class AccountController {
    

    public static void updateAvgCaseResolutionDays(List<Id> accountIds){
        Map<Id , Integer> accountTotalCaseMap = new Map<Id , Integer>(); // Map for Account Id  & totalCases
        Map<Id, Integer> accountTotalCaseDaysMap = new Map<Id , Integer>(); // Map for Account Id & totalDays
      
        // retrive all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate, AccountId
                             FROM Case
                             WHERE IsClosed=true
                            	AND AccountId IN: accountIds]){
                                    
                                    //if map does not have current account id, then add it
                                    if(! accountTotalCaseMap.containsKey(caseObj.AccountId)){
                                        accountTotalCaseMap.put(caseObj.AccountId, 0);
                                        accountTotalCaseDaysMap.put(caseObj.AccountId, 0);
                                    }
                                 Integer totalCases =  accountTotalCaseMap.get(caseObj.AccountId);
                                    totalCases++;
                                    accountTotalCaseMap.put(caseObj.AccountId , totalCases);
                                    

            // get duration in days and add it to totalDays
            
            Integer totalDays =accountTotalCaseDaysMap.get(caseObj.AccountId);
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
                                    accountTotalCaseDaysMap.put(caseObj.AccountId, totalDays);
        }
        
        
        
        
        //list of accounts to update
        List<Account> accountToUpdate = new List<Account>();
        for(Id accountId: accountTotalCaseMap.keySet()){
            //get the total days and total cases from Map
            Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId)/accountTotalCaseMap.get(accountId);
        // update account object
        accountToUpdate.add (new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays));
        }
        
        update accountToUpdate;
    }
    
    
    
    
    
    
    
    
     
    //insert a list of account
    Public Static List<Account> insertAccounts(List<Account> accountToInsert){
        
        insert accountToInsert;
        return accountToInsert;
    }
   //insert an account record
    Public Static Account insertAccount(Account accountToInsert){
        insert accountToInsert;
        return accountToInsert;
      } 
    
    //Get all account record
    Public Static List<Account> getAllAccounts(){
        //Retrive all accounts and assign to a list collection
        List<Account> accounts = [SELECT Name,Phone from Account];
        return accounts;
    }
    
    //Print all accounts
    Public static void  printAllAccounts(){
        //Retrive all accounts using getAllAccount method
        List<Account> accounts =getAllAccounts();
        
        //iterate over all accounts and print account information
        for( Account account : accounts){
            System.debug('Account Name:' +account.Name+' Account Phone:'+account.Phone);
            }
    }

}