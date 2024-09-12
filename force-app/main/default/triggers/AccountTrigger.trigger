trigger AccountTrigger on Account(
  before insert,
  before update,
  after undelete,
  after update
) {
  if ((Trigger.isBefore) && ((Trigger.isInsert) || (Trigger.isUpdate))) {
    for (Account acc : Trigger.new) {
      if (acc.Industry == 'Agriculture' || acc.Industry == 'Banking') {
        acc.Rating = 'Hot';
      }
    }
  }
  if (Trigger.isAfter && Trigger.isUndelete) {
    AccountTriggerHandler.handleAfterUndelete(Trigger.New);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandler.handleAfterUpdateActivities(
      Trigger.NEW,
      Trigger.oldMap
    );
      
  }
    
    if(Trigger.isBefore && Trigger.isInsert){
         AccountTriggerHandler.handleBeforeInsertActivities(Trigger.New);
    }
}