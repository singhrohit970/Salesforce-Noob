public class LeadTriggerHandler1 {
    
    public static void handleActivitiesAfterInsert(List<Lead> leadRecords){
        List<Task> taskListToInsert = new List<Task>();
        for(Lead leadrec: leadRecords){
            
            Task taskRecord = new Task();
                taskRecord.Priority='High';
                taskRecord.OwnerId= leadrec.OwnerId;
                taskRecord.Description='Follow up with the new Lead';
                taskRecord.Status='Not Started';
                taskRecord.Subject='Follow Up';
                taskRecord.WhoId=leadrec.Id;
                taskListToInsert.add(taskRecord);
        }
        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        } 
    }
    
    public static void handleActivitiesBeforeDelete(List<Lead> leadRecords){
        
        for(Lead leadRec:leadRecords){
            if(leadRec.Status=='Working-Contacted'){
                leadRec.addError('You Can not delete a Lead record if its in progress');
            }
        }
    }

}