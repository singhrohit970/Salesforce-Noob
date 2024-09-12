trigger UpdateParentAccount on Contact (after insert, after update) {
    // List to store Parent Account IDs to update
    Set<Id> parentAccountIds = new Set<Id>();
    
    // Map to store the latest Contact ID for each Parent Account
    Map<Id, Id> latestContactMap = new Map<Id, Id>();

    // Iterate through the triggered Contacts
    for (Contact con : Trigger.new) {
        // Check if the Contact has a Parent Account
        if (con.AccountId != null) {
            // Add the Parent Account ID to the set
            parentAccountIds.add(con.AccountId);

            // Update the latest Contact ID for the Parent Account
            latestContactMap.put(con.AccountId, con.Id);
        }
    }

    // Query the Parent Accounts with the specified IDs
    List<Account> parentAccounts = [SELECT Id, Recently_Updated_Contact__c  FROM Account WHERE Id IN :parentAccountIds];

    // Update the Recently Updated Contact field for each Parent Account
    for (Account acc : parentAccounts) {
        acc.Recently_Updated_Contact__c  = latestContactMap.get(acc.Id);
    }

    // Update the Parent Accounts
    update parentAccounts;
}