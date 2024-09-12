trigger OpportunityEx3 on Opportunity (before insert) {
    if(Trigger.isInsert && Trigger.isbefore){
        for(Opportunity opp:Trigger.new){
            
            if(opp.Amount==null){
                opp.addError('Amount can not be empty');
            }
        }
    }
}