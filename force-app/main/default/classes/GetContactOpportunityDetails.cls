public class GetContactOpportunityDetails {
  @AuraEnabled
  public static List<Account> getChildDetails(String recId) {
    //parent (Account) to child (contact & opportunity) SOQL Query. Go to contact and opportunity record and find the child relationship name.
    List<Account> accList = [
      SELECT
        Id,
        (SELECT id, Name FROM Contacts),
        (SELECT id, Name FROM opportunities)
      FROM Account
      WHERE Id = :recId
    ];
    System.debug('accList:' + accList);

    //Null Check
    if (!accList.isEmpty()) {
      return accList;
    }
    return null;
  }
}