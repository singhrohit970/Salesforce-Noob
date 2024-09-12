public class LeadBatchApex implements Database.batchable<SObject> {

    //start
    Public Database.QueryLocator start (Database.BatchableContext Bc){
        return Database.getQueryLocator('SELECT id,LeadSource from Lead');
        
    }
    //execute
    Public void execute(Database.BatchableContext BC, List<Lead> scope){
        
        for(Lead leadrecords : scope){
            leadrecords.LeadSource='Web';
            }
        update scope;
    }
    //finish
    Public void finish(Database.BatchableContext BC ){
        System.debug('Batch Finished');
        
    }
}