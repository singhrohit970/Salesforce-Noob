trigger OppTrigger on Opportunity(after update, before update, after delete) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    //do my usecase
    OpportunityTriggerHandler.handleActivitesAfterUpdate(Trigger.NEW);
    OpportunityTriggerHandler.addTeamMembers(Trigger.NEW, Trigger.oldMap);
    OpportunityTriggerHandler.informOwner(Trigger.NEW, Trigger.oldMap);
    OpportunityTriggerHandler.notifyEveryoneWhenClosedWon(
      Trigger.New,
      Trigger.oldMap
    );

    if (Trigger.isBefore && Trigger.isUpdate) {
      OpportunityTriggerHandler.handleActivitesBeforeUpdate(
        Trigger.New,
        Trigger.OldMap
      );
    }

    if (Trigger.isAfter && Trigger.isDelete) {
      OpportunityTriggerHandler.handleActivitesAfterDelete(Trigger.Old);
    }
  }
}