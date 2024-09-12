trigger AccountTriggerEx15 on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        
        List<Contact> conlist = new List<Contact>();
        for(Account acc:Trigger.new){
           Contact con = new Contact();
            con.LastName=acc.Name;
            con.FirstName=acc.Name;
            con.AccountId=acc.id;
            conlist.add(con);
        }
        if(!conlist.isEmpty())
            insert conlist;
    }

}