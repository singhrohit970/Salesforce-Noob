trigger ContactTriggerEx on Contact (after insert) {
    if((Trigger.isInsert) && (Trigger.isAfter)){
       List<Account> accList = new List<Account>();
      
        for(Contact con:Trigger.New){
            if(con.AccountId==null){   //Check if account is present on contact.
            
            Account acc = new Account();  //insert account record if contact account is not populated. 
            acc.Name=con.LastName;
            acc.Phone = con.Phone;
             accList.add(acc);
          }
        }
        if(!accList.isEmpty()){
            System.debug('List Value:' +accList);
            insert accList;
        }      
    }
}