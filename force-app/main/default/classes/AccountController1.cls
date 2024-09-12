public with sharing class AccountController1 {
        
        
    @AuraEnabled(cacheable=true)
        
    public static List<Account> getAccountData() {
        return [SELECT Id, Name, Industry, Phone, Website FROM Account LIMIT 10];
    }
        
}