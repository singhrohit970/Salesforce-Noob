public class comboboxwithDatatableDemo {
  @AuraEnabled
  //this method will return all the list of account
  public static List<Account> getAccountDetails() {
    List<Account> accList = [SELECT Id, Name FROM Account];
    return accList;
  }

  //this method will return the contact of selected account in LWC ComboBox
  @AuraEnabled
  public static List<Contact> getContactDetails(String SelectedAccountId) {
    List<Contact> contactList = [
      SELECT Id, Name, Email, AccountId
      FROM Contact
      WHERE AccountID = :SelectedAccountId
    ];
    return contactList;
  }
}