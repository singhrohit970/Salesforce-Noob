trigger CaseTrigger on Case (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        
        for(Case caserecord: Trigger.NEW){
            if(caserecord.Origin=='Phone'){
                caserecord.Priority='High';
                
            }
            else{
               caserecord.Priority='Low'; 
            }
        }
    }

}