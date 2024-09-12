public class AccountTriggerHandler {
    public static void handleBeforeInsertActivities(List<Account> newRecords){
        Map<Id, Id> ownerMap = new Map<Id, Id>();
        for(Account acc : newRecords){
            //creating a Map to store the account id and account's owner id
            //account id VS owner id map 
            ownerMap.put(acc.Id , acc.OwnerId);
        }
        //owner id , owner record --->user id, user record
      Map<Id, User> userRecords= new Map<Id , User>([SELECT Name from User WHERE Id IN: ownerMap.values()]);
        for(Account acc : newRecords){
           acc.Sales_Rep__c = userRecords.get(ownerMap.get(acc.Id)).Name;
        }
    }
  public static void handleAfterUpdateActivities(
    List<Account> newAcc,
    Map<Id, Account> oldMap
  ) {
    List<Id> sendThisList = new List<Id>();
    for (Account acc : newAcc) {
      //it tells you that industry value is changed and current value has been set to Biotechnology
      if (
        acc.Industry != oldMap.get(acc.Id).Industry &&
        acc.Industry == 'Biotechnology'
      ) {
        sendThisList.add(acc.Id);
      }
    }

    if (!sendThisList.isEmpty()) {
      callAsyncApex(sendThisList);
    }
  }

  //if there is anything that you do not want to do in current transaction immediately
  //you can move that code to future code thats a good practice to do and it will prevent governor limit
  //as for future method we get a seperate set of governor limit. It executes when resources are available.
  @future
  public static void callAsyncApex(List<Id> accountIds) {
    List<Contact> addConToList = new List<Contact>();
    List<Contact> conRecords = [
      SELECT Id, LeadSource
      FROM Contact
      WHERE AccountID IN :accountIds
    ];
    for (Contact con : conRecords) {
      con.LeadSource = 'Web';
      addConToList.add(con);
    }
    if (!addConToList.isEmpty()) {
      update addConToList;
    }
  }

  public static void handleAfterUndelete(List<Account> newAcc) {
    List<Id> accIds = new List<Id>();
    List<Account> accToUpdate = new List<Account>();

    //get the account id and add it in the list
    for (Account acc : newAcc) {
      accIds.add(acc.Id);
    }

    List<Account> accountsToUpdate = [
      SELECT id, Name
      FROM Account
      WHERE ID IN :accIds
    ];
    //iterate over the list accountsToUpdate
    for (Account acc : accountsToUpdate) {
      acc.Name = 'Restore ' + acc.Name;
      accToUpdate.add(acc);
    }

    if (!accToUpdate.isEmpty()) {
      update accToUpdate;
    }
  }

  public static void handleActivitiesBeforeUpdate(
    List<Account> newAcc,
    Map<Id, Account> oldMap
  ) {
    //Do the logic here
    for (Account accRecords : newAcc) {
      if (
        accRecords.Industry == 'Agriculture' &&
        accRecords.Type == 'Prospect'
      ) {
        if (
          oldMap.get(accRecords.Id).Ownership != accRecords.Ownership &&
          accRecords.Ownership == 'Private'
        ) {
          accRecords.addError('Ownership can not be modified');
        }
      }
    }
  }

  public static void handleActivitiesAfterUpdate(
    List<Account> newRecords,
    Map<Id, Account> oldMap
  ) {
    Map<Id, String> accToWebsiteMap = new Map<Id, String>();

    for (Account acc : newRecords) {
      if (acc.Website != oldMap.get(acc.Id).Website) {
        accToWebsiteMap.put(acc.Id, acc.Website);
      }
    }

    if (accToWebsiteMap.keyset().size() > 0) {
      List<Contact> addConToUpdate = new List<Contact>();
      List<Contact> conRecords = [
        SELECT Id, FirstName, Website__c, AccountId
        FROM Contact
        WHERE AccountId IN :accToWebsiteMap.keyset()
      ];
      for (Contact con : conRecords) {
        con.Website__c = accToWebsiteMap.get(con.AccountId);
        addConToUpdate.add(con);
      }
      if (addConToUpdate.size() > 0) {
        update addConToUpdate;
      }
    }
  }

  public static void handleActivitiesAfterInsert(List<Account> newAccRecords) {
    List<Contact> conList = new List<Contact>();

    for (Account acc : newAccRecords) {
      if (acc.Create__c != null) {
        for (integer i = 0; i < acc.Create__c; i++) {
          Contact con = new Contact();
          con.LastName = acc.Name + i;
          con.AccountId = acc.Id;
          conList.add(con);
        }
      }
    }
    if (!conList.isEmpty()) {
      insert conList;
    }
  }
}