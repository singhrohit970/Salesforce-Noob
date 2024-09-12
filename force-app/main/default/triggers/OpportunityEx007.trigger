trigger OpportunityEx007 on Opportunity (before update) {

     if(Trigger.isBefore && Trigger.isUpdate)
         
         for(Opportunity opp:Trigger.new){
                 if(opp.StageName!=Trigger.oldmap.get(opp.id).StageName){
                     if(opp.StageName=='Closed Won'){
                         opp.Description='Opp is closed one';
                         
                     }
                     else if(opp.StageName=='Closed Lost'){
                          opp.Description='closed lost';
                         
                     }
                     else{
                          opp.Description='Opp is Opened ';
                     }
             }
             
         
}
}