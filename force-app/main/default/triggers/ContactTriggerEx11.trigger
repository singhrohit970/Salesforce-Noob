trigger ContactTriggerEx11 on Contact(
  after insert,
  after update,
  after delete,
  after undelete
) {
  switch on Trigger.operationType {
    //first we are checking for after insert
    when AFTER_INSERT {
      ContactTriggerHandlerEx11.afterInsertHandler(Trigger.new);
    }
    when AFTER_UPDATE {
      ContactTriggerHandlerEx11.afterUpdateHandler(Trigger.new, Trigger.oldMap);
    }
    when AFTER_DELETE {
      ContactTriggerHandlerEx11.afterDeleteHandler(Trigger.new);
    }
    when AFTER_UNDELETE {
      ContactTriggerHandlerEx11.afterUndeleteHandler(Trigger.new);
    }
  }
}