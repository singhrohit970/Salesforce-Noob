public Class TestDemoBatch implements Database.Batchable<SObject>{
    
    public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT id,Name from Account'); //it will not hit exception even the query return 1 m records
    } 
    public void execute(Database.BatchableContext bc , List<Account> subListfromStartMethod){
        
        //logic to process 2000 records
        for(Account acc: subListfromStartMethod){
            acc.name= 'Batch updated-'+ acc.name; 
        }
        UPDATE  subListfromStartMethod; 
}
    public void finish(Database.BatchableContext bc){
        //post process logic 
        
    System.debug('Batch executed');
}
}