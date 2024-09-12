public class GetChild {
  @AuraEnabled
  public static List<Account> getContactDetails() {
    List<Account> accList = [
      SELECT Id, Name, (SELECT Name, FirstName, LastName FROM Contacts)
      FROM Account
      ORDER BY createdDate
      LIMIT 3
    ];

    if (!accList.isEmpty()) {
      return accList;
    }
    return null;
  }
}