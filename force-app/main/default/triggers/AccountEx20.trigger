trigger AccountEx20 on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Contact> conList = new List<Contact>();
        set<Id> accIds = new set<Id>();
        for(Account acc:Trigger.new){
            if(acc.Phone!=null && acc.Phone!=Trigger.oldmap.get(acc.id).Phone && Trigger.oldMap!=null){
                accIds.add(acc.Id);
            }
        }
        for(Account acc:[Select id ,Phone,(Select HomePhone from contacts) from Account where id in:accIds]){
            if(acc.contacts!=null){
                for(contact con:acc.Contacts){
                    con.HomePhone=acc.Phone;
                    conList.add(con);
                    
                }
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }

}