public class ContactClass {

    @AuraEnabled
    public static String updateSecondaryContact (String accId,String contactRowId ){
        List<Account> accListToUpdate = new List<Account>();
        
        Account accObject = new Account();
        accObject.Id= accId;
        accObject.Primary_Contact__c =contactRowId;
        
        accListToUpdate.add(accObject);
            
            if(!accListToUpdate.isEmpty()){
                update accListToUpdate;
                return 'Assign Contact Successfully';
            }
        return 'failed';
        
    }
    //accId is the current account record id which we get from LWC.
    @AuraEnabled
    public static List<Contact> getrelatedContact(String accId){
    
    
    List<Contact> conList =[Select id ,Name,Phone,AccountId from Contact where AccountId =:accId];
    
    system.debug('conList' +conList);
    if(!conList.isEmpty()){
        return conList;
    }
    
return Null;
}
}