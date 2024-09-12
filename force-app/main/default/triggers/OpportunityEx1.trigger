trigger OpportunityEx1 on Opportunity (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        List<Account> accList = new List<Account>();
        for(Opportunity opp:Trigger.new){
            if(opp.Amount!=null && opp.AccountId!=null){
                Account acc = new Account();
                acc.Recent_Opportunity_Amount__c=opp.Amount;
                acc.id=opp.AccountId;
                accList.add(acc);   
            }
            if(!accList.isEmpty()){
                update accList;
            }
        }
    }
}