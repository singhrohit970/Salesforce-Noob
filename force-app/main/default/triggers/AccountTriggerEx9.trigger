trigger AccountTriggerEx9 on Account (after update) {

    List<Account> accList=[Select Id,Fax,Phone,(select Id ,Fax,Phone from contacts) from Account where Id in: Trigger.NewMap.keyset()];
        
        List<Contact> ConListToUpdate =new List<Contact>();
    
    if(!accList.isEmpty()){
        for(Account acc:accList){
            if(!acc.contacts.isEmpty()){
                for(contact con:acc.contacts){ //fetch the related contact
                    con.Phone=acc.Phone; ///Mapping the contact and Account phone and Fax
                    con.Fax=acc.Fax;
                    ConListToUpdate.add(con);
                }
            }
            
        }
        
    }
    if(!ConListToUpdate.isEmpty()){
        update ConListToUpdate;
    }
}