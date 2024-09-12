public class LeadTriggerHandler {
    public static boolean alreadyExecuted = false;
    public static void checkCreationDateBeforeUpdate(List<Lead> newrecords) {
        //lead creation date < Today date -8 then throw error
        
        for (Lead leadRec : newrecords) {
            if (leadRec.CreatedDate < System.today() - 8) {
                leadRec.addError('This record can not be modified');
            }
        }
    }
    
    public static void beforeInsertHandler(List<Lead> newrecords) {
        for (Lead LeadRecord : newrecords) {
            if (String.isBlank(LeadRecord.LeadSource)) {
                LeadRecord.LeadSource = 'Other';
            }
            //validation rule on industry fields
            if (String.isBlank(LeadRecord.Industry) && Trigger.isInsert) {
                LeadRecord.addError('The Industry field can not be blank');
            }
        }
    }
    
    public static void afterInsertHandler(List<Lead> newrecords) {
        List<Task> leadTasks = new List<Task>();
        for (Lead leadRecord : newrecords) {
            //cretate a task
            Task leadTask = new Task(
                Subject = 'Follow up on Lead Status',
                WhoId = leadRecord.ID
            );
            leadTasks.add(leadTask);
        }
        insert leadTasks;
        
        //inserting another lead recorf
        //this will call the trigger recursively
        if(LeadTriggerHandler.alreadyExecuted ==false){
             LeadTriggerHandler.alreadyExecuted =true;
            Lead anotherLead = new Lead(
                LastName = 'Test Lead Single',
                Status = 'Open - Not Contacted',
                Company = 'SFDCFacts',
                Industry = 'Finance'
            );
            insert anotherLead;
           
        }
    }
    
    public static void beforeUpdateHandler(
        List<Lead> newrecords,
        Map<Id, Lead> oldRecordsMap
    ) {
        for (Lead LeadRecord : newrecords) {
            if (String.isBlank(LeadRecord.LeadSource)) {
                leadRecord.LeadSource = 'Other';
            }
            if (
                (LeadRecord.Status == 'Closed - Converted' ||
                 LeadRecord.Status == 'Closed - Not Converted') &&
                oldRecordsMap.get(LeadRecord.Id).Status == 'Open - Not Contacted'
            ) {
                LeadRecord.addError('You canot directly close an open lead record');
            }
        }
    }
}