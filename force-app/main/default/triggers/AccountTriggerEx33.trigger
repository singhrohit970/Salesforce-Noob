trigger AccountTriggerEx33 on Account (after update) {
    
    if(Trigger.isAfter && Trigger.isUpdate){
        Map<id, Account> accMap = new Map<id, Account>();
         List<Contact> conList = new List<Contact>();
        for(Account acc:Trigger.new){
            if(((acc.BillingCity!=Trigger.oldmap.get(acc.id).BillingCity) ||
               (acc.BillingCountry!=Trigger.oldmap.get(acc.id).BillingCountry)||
               (acc.BillingState!=Trigger.oldmap.get(acc.id).BillingState)||
               (acc.BillingStreet!=Trigger.oldmap.get(acc.id).BillingStreet)||
               (acc.BillingPostalCode!=Trigger.oldmap.get(acc.id).BillingPostalCode)) && Trigger.oldmap!=null){
                accMap.put(acc.ID ,acc);
                } 
        }
        for(contact con:[Select id , Accountid from Contact where id in:accMap.keySet()]){
            if(accMap.containsKey(con.AccountId)){
                con.MailingCity=accMap.get(con.AccountId).BillingCity;
                con.MailingCountry=accMap.get(con.AccountId).BillingCountry;
                con.MailingState=accMap.get(con.AccountId).BillingState;
                con.MailingStreet=accMap.get(con.AccountId).BillingStreet;
                con.MailingPostalCode=accMap.get(con.AccountId).BillingPostalCode;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
}