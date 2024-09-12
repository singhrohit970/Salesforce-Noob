trigger AccountTriggerEx6 on Account (before delete) {

    if ((Trigger.isBefore) && (Trigger.isDelete))
        
        for(Account acc:Trigger.Old){
            
            if(acc.Active__c=='Yes'){
                acc.addError('You can not delete an active account record');
            }
        }
}