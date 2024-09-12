trigger OpportunityTrigger22 on Opportunity (before delete) {
     if(Trigger.isBefore && Trigger.isDelete){
        Profile p = [Select id from profile where Name ='System Administrator'];  
         for(Opportunity opp:Trigger.old){
             If(opp.StageName=='Closed One' && opp.StageName=='Closed Lost'){
                 if(userInfo.getprofileId()!=p.Id)
                     opp.addError('Only System Admin can delete closed Opportunity');
             }
         }         
    }
}