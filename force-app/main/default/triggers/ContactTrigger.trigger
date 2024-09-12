trigger ContactTrigger on Contact(before insert, after insert, after update) {
  if (Trigger.isBefore && Trigger.isInsert) {
    //calling the apex class class.method name
    ContactTriggerHandler.handleActivitiesBeforeInsert(Trigger.NEW);
  }
  if (Trigger.isAfter && Trigger.isInsert) {
    ContactTriggerHandler.handleActivitiesAfterInsert(Trigger.NEW);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    ContactTriggerHandler.handleActivitiesAfterUpdate(
      Trigger.NEW,
      Trigger.OldMap
    );
  }
}