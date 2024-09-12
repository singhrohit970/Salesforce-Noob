public class ContactTriggerHandler {
  public static void handleActivitiesAfterUpdate(
    List<Contact> newCon,
    Map<Id, Contact> oldMapRecords
  ) {
    List<Id> accountIdsToInform = new List<Id>();
    for (Contact con : newCon) {
      if (con.AccountId != null) {
        if (
          con.Email != oldMapRecords.get(con.Id).Email ||
          con.Phone != oldMapRecords.get(con.Id).Phone
        ) {
          //parent account exists for this contact and email and phone has benn modified as part of this update
          //send email to account owner
          accountIdsToInform.add(con.AccountId);
        }
      }
    }
    List<String> emailAddressList = new List<String>();
    List<Account> accountRecords = [
      SELECT OwnerId, Owner.Email
      FROM Account
      WHERE Id IN :accountIdsToInform
    ];
    for (Account acc : accountRecords) {
      emailAddressList.add(acc.Owner.Email);
    }
    if (!emailAddressList.isEmpty()) {
      //send the email
      Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
      for (Id accId : accountIdsToInform) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = emailAddressList;
        message.optOutPolicy = 'FILTER';
        message.subject = 'Contact Email or Phone Changed';
        message.plainTextBody = 'The email and phone information of your child Contact has been modified.Please Confirm the changes';
        messages.add(message);
      }

      Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
      if (results[0].success) {
        System.debug('The email was sent successfully.');
      } else {
        System.debug(
          'The email failed to send: ' + results[0].errors[0].message
        );
      }
    }
  }

  public static void handleActivitiesBeforeInsert(List<Contact> newCon) {
    List<Contact> existingRecords = [
      SELECT Id, LastName, Phone, Email
      FROM Contact
      LIMIT 50000
    ];
    for (Contact conRecords : newCon) {
      for (Contact existingcon : existingRecords) {
        if (
          existingcon.Email == conRecords.Email &&
          existingcon.Phone == conRecords.Phone &&
          existingcon.LastName == conRecords.Lastname
        )
          conRecords.addError('Duplicate Contact');
      }
      //compare lastname , email , phone with all contact records in the system right now
      //if(conRecords.AccountId == Null){
      //  conRecords.addError('Please select account before saving the Contact Record');
    }
    List<Id> accountIds = new List<Id>();
    Map<Id, Id> conIdVsAccIdMap = new Map<Id, Id>();
    for (Contact con : newCon) {
      accountIds.add(con.AccountId);
      conIdVsAccIdMap.put(con.Id, con.AccountId);
    }

    //Whenever a Contact record is created, fetch BillingAddress from Parent Account and save it in the MailingAddress field on the contact record
    Map<Id, Account> accountRecordMap = new Map<Id, Account>(
      [
        SELECT
          Id,
          Max_Contacts__c,
          BillingStreet,
          BillingCity,
          BillingState,
          BillingCountry,
          BillingPostalCode,
          (SELECT id FROM contacts)
        FROM Account
        WHERE Id IN :accountIds
      ]
    );

    for (Id accId : accountRecordMap.keySet()) {
      Integer numberOfContactsPerAccount = (accountRecordMap.get(accId)
          .contacts)
        .size();

      if (
        accountRecordMap.get(accId).Max_Contacts__c < numberOfContactsPerAccount
      ) {
        System.debug('Error with this contact insertion');
        for (Contact con : newCon) {
          if (con.AccountId == accId) {
            con.addError('This contact insertion is not allowed');
          }
        }
      }
    }

    for (Contact con : newCon) {
      if (accountRecordMap.containsKey(con.AccountId)) {
        con.MailingCity = accountRecordMap.get(con.AccountId).BillingCity;
        con.MailingStreet = accountRecordMap.get(con.AccountId).BillingStreet;
        con.MailingPostalCode = accountRecordMap.get(con.AccountId)
          .BillingPostalCode;
        con.MailingState = accountRecordMap.get(con.AccountId).BillingState;
        con.MailingCountry = accountRecordMap.get(con.AccountId).BillingCountry;
      }
    }
  }

  public static void handleActivitiesAfterInsert(List<Contact> newRecords) {
    List<ContactShare> addRecordToList = new List<ContactShare>();
    Id conInnovPublicGroup = [
      SELECT Id, Name
      FROM Group
      WHERE Name = 'Contact Innovators'
      LIMIT 1
    ]
    .ID;
    for (Contact conRecords : newRecords) {
      ContactShare conS = new ContactShare();
      conS.ContactAccessLevel = 'Edit';
      conS.ContactId = conRecords.Id;
      conS.RowCause = 'Manual';
      conS.UserorGroupId = conInnovPublicGroup;
      addRecordToList.add(conS);
    }
    if (!addRecordToList.isEmpty()) {
      insert addRecordToList;
    }
  }
}