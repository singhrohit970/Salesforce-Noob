trigger AccountTriggerEx34 on Account (after update) {
    if(Trigger.isAfter && trigger.isUpdate){
        Set<Id> accID = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        for(Account acc:Trigger.new){
            if(((acc.BillingCity!=Trigger.oldmap.get(acc.id).BillingCity) ||
                (acc.BillingCountry!=Trigger.oldmap.get(acc.id).BillingCountry)||
                (acc.BillingState!=Trigger.oldmap.get(acc.id).BillingState)||
                (acc.BillingStreet!=Trigger.oldmap.get(acc.id).BillingStreet)||
                (acc.BillingPostalCode!=Trigger.oldmap.get(acc.id).BillingPostalCode)) && Trigger.oldmap!=null){
                    accID.add(acc.ID);
                } 
        }
        
        for(Account acc: [SELECT Id,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,(Select id from contacts) FROM Account where ID in:accID]){
            if(acc.Contacts!=Null){
                for(Contact con:acc.Contacts){
                    con.MailingCity= acc.BillingCity;
                    con.MailingCountry=acc.BillingCountry;
                    con.MailingStreet=acc.BillingStreet;
                    con.MailingState=acc.BillingState;
                    con.MailingPostalCode=acc.BillingPostalCode;
                    conList.add(con);
                }
            }            
    }
    if(!conList.isEmpty()){
        update conList;
    }
   }
}