trigger OpportunityEx10 on Opportunity (before insert) {
    if(Trigger.isbefore && Trigger.isInsert){
        
        for(Opportunity opp:Trigger.New){
            if(opp.Amount>100000 && opp.Amount!=Null){
                opp.Description='Hot Opportunity';
                
            }
        }
    }
        
        

}