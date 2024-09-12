public class OpportunityTriggerHandler {
  public static void handleActivitesAfterDelete(List<Opportunity> oldRecords) {
    //Get the account id
    Set<Id> accountIds = new Set<Id>();
    Map<Id, Id> oppVsAccountMap = new Map<Id, Id>();
    Map<Id, Id> accIdVsOwnerIdMap = new Map<Id, Id>();
    for (Opportunity opp : oldRecords) {
      accountIds.add(opp.AccountId);
      oppVsAccountMap.put(opp.Id, opp.AccountId);
    }

    List<Account> accountRecords = [
      SELECT Id, OwnerId
      FROM Account
      WHERE Id IN :accountIds
    ];
    System.debug('Account id found');
    for (Account acc : accountRecords) {
      accIdVsOwnerIdMap.put(acc.Id, acc.OwnerId);
    }

    List<Task> taskRecordList = new List<Task>();
    for (Opportunity opp : oldRecords) {
      Task taskRecord = new Task();
      taskRecord.Description = 'Please investigate why the opportunity was deleted';
      taskRecord.Priority = 'High';
      taskRecord.OwnerId = accIdVsOwnerIdMap.get(oppVsAccountMap.get(opp.Id));
      taskRecord.Status = 'Not Started';
      taskRecord.Subject = 'Start Up';
      //taskRecord.WhatId = opp.Id;
      taskRecordList.add(taskRecord);
    }

    if (!taskRecordList.isEmpty()) {
      System.debug('Insert value');
      insert taskRecordList;
    }
  }

  public static void handleActivitesBeforeUpdate(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldRecords
  ) {
    for (Opportunity newopp : newRecords) {
      if (oldRecords.get(newopp.Id).StageName != newopp.StageName) {
        newopp.Amount = newopp.Probability * newopp.ExpectedRevenue;
      }
    }
  }
  public static void notifyEveryoneWhenClosedWon(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldMapRecords
  ) {
    //fetch some users- Opportunity Owner, Account Owner, Opportunity Team member, People from the public group
    //stage is closed Won

    List<Id> oppIds = new List<Id>();
    List<Id> accountIds = new List<Id>();
    List<Id> publicGroupUsers = new List<Id>();
    for (Opportunity opp : newRecords) {
      oppIds.add(opp.Id);
      accountIds.add(opp.AccountId);
    }

    List<GroupMember> megaStarGroupMembers = [
      SELECT Id, UserOrGroupId
      FROM GroupMember
      WHERE Group.Name = 'Opportunity Maga Stars'
    ];
    for (GroupMember gM : megaStarGroupMembers) {
      publicGroupUsers.add(gm.UserOrGroupId);
    }
    List<Account> accountOwner = [
      SELECT Id, OwnerId
      FROM Account
      WHERE ID IN :accountIds
    ];
    List<OpportunityTeamMember> oppTeamMembers = [
      SELECT UserId, OpportunityId
      FROM OpportunityTeamMember
      WHERE OpportunityId IN :oppIds
    ];

    Set<Id> listofUsertoNotify = new Set<Id>();
    for (Opportunity opp : newRecords) {
      if (
        opp.StageName == 'Closed Won' &&
        oldMapRecords.get(opp.Id).StageName != opp.StageName
      ) {
        listofUsertoNotify.addAll(publicGroupUsers);
        listofUsertoNotify.add(opp.OwnerId);
        for (Account acc : accountOwner) {
          if (opp.AccountId == acc.Id) {
            listofUsertoNotify.add(acc.OwnerId);
          }
        }
        for (OpportunityTeamMember oTM : oppTeamMembers) {
          if (oTM.OpportunityId == opp.Id) {
            listofUsertoNotify.add(oTM.UserId);
          }
        }
      }
    }

    if (!listofUsertoNotify.isEmpty()) {
      sendEmailToAllTheseFolks(listofUsertoNotify);
    }
  }

  public static void sendEmailToAllTheseFolks(Set<Id> userIds) {
    List<String> emailList = new List<String>();
    List<User> userRecords = [SELECT Email FROM User WHERE ID IN :userIds];

    for (user userrec : userRecords) {
      emailList.add(userrec.Email);
    }

    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
    message.toAddresses = emailList;
    message.subject = 'Take a look at the opportunity';
    message.plainTextBody = 'This is urgent';
    Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{
      message
    };
    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
  }

  public static void informOwner(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldMapRecords
  ) {
    List<Task> taskListToInsert = new List<Task>();
    for (Opportunity opp : newRecords) {
      //Check if stage has been modified/changed or not
      if (opp.StageName != oldMapRecords.get(opp.Id).StageName) {
        //check if the current stage Name is Qualification and the previous stage Name is perception Analysis
        if (
          (opp.StageName == 'Qualification' &&
          oldMapRecords.get(opp.Id).StageName == 'Perception Analysis') ||
          (opp.StageName == 'Prospecting' &&
          oldMapRecords.get(opp.Id).StageName == 'Perception Analysis')
        ) {
          Task reminderTask = new Task();
          reminderTask.WhatId = opp.Id;
          reminderTask.Description = 'Please see why this opportunity did not progress further';
          reminderTask.Priority = 'High';
          reminderTask.IsReminderSet = true;
          reminderTask.ReminderDateTime = System.Today() + 1;
          taskListToInsert.add(reminderTask);
        }
      }
    }

    if (!taskListToInsert.isEmpty()) {
      insert taskListToInsert;
    }
  }
  public static void addTeamMembers(
    List<Opportunity> newRecords,
    Map<Id, Opportunity> oldMapRecords
  ) {
    List<OpportunityTeamMember> oppMemberList = new List<OpportunityTeamMember>();
    List<User> opportunists = [
      SELECT Id, UserRole.Name
      FROM User
      WHERE isActive = TRUE AND UserRole.Name = 'Opportunists'
    ];
    for (Opportunity opp : newRecords) {
      if (
        opp.StageName == 'Needs Analysis' &&
        opp.StageName != oldMapRecords.get(opp.id).StageName
      ) {
        for (User userRec : opportunists) {
          OpportunityTeamMember oppMember = new OpportunityTeamMember();
          oppMember.OpportunityId = opp.Id;
          oppMember.OpportunityAccessLevel = 'Edit';
          oppMember.UserId = userRec.Id;
          oppMemberList.add(oppMember);
        }
      }
    }
    if (!oppMemberList.isEmpty()) {
      insert oppMemberList;
    }
  }
  public static void handleActivitesAfterUpdate(List<Opportunity> newRecords) {
    List<Task> taskListToInsert = new List<Task>();

    List<Id> listOfOppIds = new List<Id>();
    List<OpportunityTeamMember> deleteMemberList = new List<OpportunityTeamMember>();
    for (Opportunity opp : newRecords) {
      listOfOppIds.add(opp.Id);
    }

    List<OpportunityTeamMember> teamMembers = [
      SELECT Id, OpportunityId
      FROM OpportunityTeamMember
      WHERE OpportunityId IN :listOfOppIds
    ];
    for (Opportunity opp : newRecords) {
      if (opp.StageName == 'Closed Won') {
        //create a related record a Task record.

        Task taskRecord = new Task();
        taskRecord.Priority = 'High';
        taskRecord.OwnerId = opp.OwnerId;
        taskRecord.Description = 'Please split the revenue amongst the team members';
        taskRecord.Status = 'Not Started';
        taskRecord.Subject = 'Split Revenue';
        taskRecord.WhatId = opp.Id;
        taskListToInsert.add(taskRecord);
      } else if (opp.StageName == 'Closed Lost') {
        for (OpportunityTeamMember teamMember : teamMembers) {
          if (teamMember.OpportunityId == opp.Id) {
            //yeah get rid of this team member
            deleteMemberList.add(teamMember);
          }
        }
      }
    }
    if (!taskListToInsert.isEmpty())
      insert taskListToInsert;

    if (!deleteMemberList.isEmpty()) {
      delete deleteMemberList;
    }
  }
}