public class TaskTriggerHandler {
  public static void handleActivitiesBeforeUpdate(List<Task> taskRecords) {
    List<Id> contactIdList = new List<Id>();
    Map<Id, Id> taskVsConMap = new Map<Id, ID>();
    Map<Id, Id> conVsAccountMap = new Map<ID, ID>();
    for (Task eachTask : taskRecords) {
      //to check if WHO ID is a contact or a Lead, proceed only if it is a contact
      if (String.valueOf(eachTask.WhoId).startsWith('003')) {
        contactIdList.add(eachTask.WhoId);

        //taskId Vs ContactId
        taskVsConMap.put(eachTask.Id, eachTask.WhoId);
      }
    }
    //accountids VS accountrecord
    Map<Id, Account> accountRecordMap = new Map<Id, Account>(
      [
        SELECT Id, Modify_Task_Permission__c
        FROM Account
        WHERE ID IN (SELECT AccountId FROM Contact WHERE Id IN :contactIdList)
      ]
    );

    //task id , Contact id
    //Account Records
    //contact id, Account id
    //task id, account record
    //contactId VS account Id
    List<Contact> conRecords = [
      SELECT AccountID
      FROM Contact
      WHERE ID IN :contactIdList
    ];
    for (Contact con : conRecords) {
      conVsAccountMap.put(con.Id, con.AccountID);
    }
    for (Task eachTask : taskRecords) {
      if (
        !accountRecordMap.get(
            conVsAccountMap.get(taskVsConMap.get(eachTask.Id))
          )
          .Modify_Task_Permission__c
      ) {
        eachTask.addError('You Can not update the Task!');
      }
    }
  }

  public static void handleActivitiesAfterInsert(List<Task> taskRecords) {
    Map<Id, Integer> conCountMap = new Map<Id, Integer>();
    for (Task taskrec : taskRecords) {
      if (
        taskrec.WhoId != null && String.valueOf(taskrec.WhoId).startswith('003')
      ) {
        if (conCountMap.containsKey(taskrec.WhoId)) {
          Integer countVar = conCountMap.get(taskrec.WhoId) + 1;
          conCountMap.put(taskRec.WhoId, countVar);
        } else {
          conCountMap.put(taskRec.WhoId, 1);
        }
      }
    }
    List<Contact> conRecords = [
      SELECT Id, Number_of_task_Associated__c
      FROM Contact
      WHERE Id IN :conCountMap.KeySet()
    ];

    List<Contact> conRecordToUpdate = new List<Contact>();
    for (Contact con : conRecords) {
      if (con.Number_of_task_Associated__c != null) {
        con.Number_of_task_Associated__c =
          con.Number_of_task_Associated__c + conCountMap.get(con.Id);
      } else {
        con.Number_of_task_Associated__c = conCountMap.get(con.Id);
      }
      conRecordToUpdate.add(con);
    }

    if (!conRecordToUpdate.isEmpty()) {
      update conRecordToUpdate;
    }
  }
}