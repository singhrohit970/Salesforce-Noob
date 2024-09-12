trigger AccountTriggerEx12 on Account (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
        
        for (Account acc:Trigger.new){
            if(acc.CreatedDate<System.today()-6){
                acc.addError('You can not update account 7 day back');
            }
        }
    }
    
}