trigger ContactTriggerEx1 on Contact (before insert, before update) {
    if((Trigger.isBefore) && ((Trigger.isInsert) || (Trigger.isUpdate))){
        
    for(Contact con:Trigger.new){
        if(con.Email==null || con.Email==''){
            con.Email.addError('Please enter a phone number');
            if(con.Phone==null || con.Email==''){
                con.Phone.addError('Pleasse enter phone number');
            }
        }
    }
    }

}