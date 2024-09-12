public class LeadQueueable implements Queueable {
    
    public void execute(QueueableContext context){
        
        List<Lead> existingrecords =[SELECT id,LeadSource from Lead];
        for(Lead record :[SELECT id,LeadSource from Lead]){
            
            record.LeadSource ='Web';
        }
        Update existingrecords;
        
    }

}