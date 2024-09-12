trigger ContactTriggerEx7 on Contact (before insert,before update) {
    
    for(Contact con:Trigger.new){
        integer recordsCount=[Select count() from contact where LastName =:con.Lastname];
        
        if(recordsCount>0){
            con.addError('Duplicate record found');
        }
    }
    

}