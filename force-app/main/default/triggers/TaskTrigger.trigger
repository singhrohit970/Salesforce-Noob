//Whenever a Task is created, set the priority to High

trigger TaskTrigger on Task(before insert, after insert, before update) {
  if (Trigger.isInsert && Trigger.isBefore) {
    for (Task taskrecord : Trigger.NEW) {
      //read it like for every task that is inside trigger.new variable
      System.debug('Found task record');
      taskrecord.Priority = 'High';
    }
  }
  if (Trigger.isAfter && Trigger.isInsert) {
    TaskTriggerHandler.handleActivitiesAfterInsert(Trigger.New);
  }

  if (Trigger.isUpdate && Trigger.isBefore) {
    TaskTriggerHandler.handleActivitiesBeforeUpdate(Trigger.New);
  }
}