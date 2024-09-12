trigger OpportunityEx4 on Opportunity (before update) {
    
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Opportunity opp:Trigger.new){
            if(opp.Closed_Lost_Reason__c==null && opp.StageName=='Closed Lost' && opp.StageName!=Trigger.oldMap.get(opp.id).StageName){
                opp.addError('Please populate Closed Lost Reason’ on opportunity.');
            }
        }
    }

}