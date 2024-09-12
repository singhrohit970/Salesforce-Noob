trigger ContactCount on Contact (after insert,after delete) {
    
    List<account> addaccount = new List<account>();
    List <id> addcon = new List <id>();
    
    if(trigger.isinsert){
    for (contact con :trigger.new)
    {
        
        addcon.add(con.accountid);
    }  
    }    
    
       if(trigger.isdelete){
    for (contact con :trigger.new)
    {
        
        addcon.add(con.accountid);
    }  
    }
    
    list<account> acc = [Select id ,No_of_COntacts__c, (select id from contacts) from account where id in:addcon];
    
    for(account a:acc)
    {
        a.No_of_COntacts__c = a.contacts.size();
        addaccount.add(a);
    }
    update addaccount;
}