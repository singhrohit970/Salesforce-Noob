//Whenever a Lead record is updated, set the lead status to Working-Contacted
trigger LeadTrigger1 on Lead (before update) {
    
    if(Trigger.isBefore && Trigger.isUpdate){
        
        for(Lead leadRecord :Trigger.NEW){
            
            leadRecord.Status='Working-Contacted';
        }
    }

}