public class LeadAsynchronous {
    
    @future
    public static void updateLeadRecords(Set<ID> existingRecordIds){
        List<Lead> existingRecords =[Select id,LeadSource from Lead where id IN :existingRecordIds];
        for(Lead record :existingRecords){
            record.LeadSource='web';
        }
        
        update existingRecords;
        
    } 
    @future
    public static void createLeadRecord(){
        Lead anotherLead = new Lead(LastName='Test',Status='Open',Company='Raja',Industry='finance');
        insert anotherLead;
        
       }
}