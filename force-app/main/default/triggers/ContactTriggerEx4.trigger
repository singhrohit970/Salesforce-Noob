trigger ContactTriggerEx4 on Contact (before insert,before update) {
    
    if((Trigger.isBefore) && (Trigger.isInsert || Trigger.isUpdate)){
    for(Contact con: Trigger.New){
        if(con.AccountId ==null){
            con.addError('Please select a account for the new contact');
        }
    }
    }

}