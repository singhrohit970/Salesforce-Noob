trigger CaseTriggerEx1 on Case (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        List<Account> accList = new List<Account>();
        for(Case cs:Trigger.new){
            if(cs.AccountId!=null){
            Account acc = new Account();
            acc.New_Case_Number__c=cs.CaseNumber;
                acc.Id=cs.AccountId;
               accList.add(acc);
        }
            if(!accList.isempty()){
                update accList;
            }
    }
}
}