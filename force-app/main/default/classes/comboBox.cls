public class comboBox {

    @AuraEnabled
    public static List<Account> getAccounts()
    {
        List<Account> accList = [Select Id ,Industry,Name from Account];
        return accList;
    }
    
}