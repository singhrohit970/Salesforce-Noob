//As soon as a Lead record is created, create a Task for the Lead Owner to follow up with the customer.
trigger LeadTrigger4 on Lead (After insert, Before Delete) {
    
    if (Trigger.isAfter && Trigger.isInsert){
        LeadTriggerHandler1.handleActivitiesAfterInsert(Trigger.NEW);
    }
    
    if(Trigger.isBefore && Trigger.isDelete){
        
       LeadTriggerHandler1.handleActivitiesBeforeDelete(Trigger.OLD);
    }
}