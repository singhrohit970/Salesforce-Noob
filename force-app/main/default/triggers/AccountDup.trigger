trigger AccountDup on Account (before insert) {
   
    for(Account acc:Trigger.new){
        integer recordsCount=[Select count() from Account where Name =:acc.Name];
        
        if(recordsCount>0){
            acc.addError('Duplicate record found');
        }
    }
    
}