public with sharing class ContactTriggerHandlerEx11 {
  public static void afterInsertHandler(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : newContacts) {
      //check if contact has linked account//accountid
      if (String.isNotBlank(con.AccountId)) {
        //store the account id of each contact
        accountIds.add(con.AccountId);
      }
    }

    AccountContactServices.updateActiveContacts(accountIds);
  }
  public static void afterUpdateHandler(
    List<Contact> newContacts,
    Map<Id, Contact> oldContactsMap
  ) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : newContacts) {
      // capture the account id only if active checkbox value is flipped
      if (
        String.isNotBlank(con.AccountId) &&
        oldContactsMap.get(con.Id).Active__c != con.Active__c
      ) {
        //store the account id of each contact

        accountIds.add(con.AccountId);
      } else if (oldContactsMap.get(con.Id).AccountId != con.AccountId) {
        accountIds.add(con.AccountId);
        accountIds.add(oldContactsMap.get(con.Id).AccountId); //old account id
      }
    }
    //get aggregate result for all accounts
    AccountContactServices.updateActiveContacts(accountIds);
  }

  public static void afterDeleteHandler(List<Contact> oldContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : oldContacts) {
      //check if contact has linked account//accountid
      if (String.isNotBlank(con.AccountId)) {
        //store the account id of each contact
        accountIds.add(con.AccountId);
      }
    }
    AccountContactServices.updateActiveContacts(accountIds);
  }

  public static void afterUndeleteHandler(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : newContacts) {
      //check if contact has linked account//accountid
      if (String.isNotBlank(con.AccountId)) {
        //store the account id of each contact
        accountIds.add(con.AccountId);
      }
    }
    AccountContactServices.updateActiveContacts(accountIds);
  }
}