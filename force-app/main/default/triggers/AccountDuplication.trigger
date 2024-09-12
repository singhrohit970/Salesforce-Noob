trigger AccountDuplication on Account (before insert) {
    for(Account acc: Trigger.new){
        
        List<Account> mynew = [Select id from Account where Name = :acc.Name];
        If(mynew.size()>0)
        {
            
            acc.Name.addError('Account with the same name already exist');
        }
            
            
    }
    
    
}