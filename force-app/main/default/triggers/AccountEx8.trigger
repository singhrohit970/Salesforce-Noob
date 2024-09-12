trigger AccountEx8 on Account (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
        
        for(Account acc:Trigger.new){
            if(acc.Phone!=Null){
                if(acc.Phone!=Trigger.oldmap.get(acc.id).Phone){
                    
                    acc.Description='Phone is Updated! Old Value : ' +	Trigger.oldmap.get(acc.id).Phone+' New Value :'+acc.Phone;
                }
                
                }
        }
    }
}