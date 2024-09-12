//If an Account with Industry Agriculture and Type prospect is updated and Ownership is set to Private, do not allow user to set this Ownership.
 
trigger AccountTrigger007 on Account (before update,after update, after insert) {
    
    if(Trigger.isUpdate && Trigger.isBefore){
        
        //call the trigger handler class here.
        AccountTriggerHandler.handleActivitiesBeforeUpdate(Trigger.New, Trigger.oldMap);
    }
    
    
    if(Trigger.isUpdate && Trigger.isAfter){
        
        //call the trigger handler class here.
        AccountTriggerHandler.handleActivitiesAfterUpdate(Trigger.New, Trigger.oldMap);
        
    }
        if(Trigger.isAfter && Trigger.isInsert){
              //call the trigger handler class here.
             AccountTriggerHandler.handleActivitiesAfterInsert(Trigger.New);
        }    
}