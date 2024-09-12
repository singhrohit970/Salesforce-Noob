public class testDemoTest {

    public static List<Account> getAccount(){
        
        List<Account> accList = new List<Account>();
        for(integer i=0;i<=20000;i++){
            
            Account acc = new Account();
            acc.Name='Demo';
            accList.add(acc);
            System.debug('accList' +accList);
        }
        insert accList;
        return accList;
        
    }
}