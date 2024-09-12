public class DatatableDemo {
    
    @AuraEnabled
    public static List<Contact> getRelatedContacts (String accountRecordId,String searchValue){
        //partial search
        if(searchValue!=''  && searchValue!=Null){
            String key = '%'+searchValue+'%';
            
            
            List<Contact> conList = [SELECT id,Name,Phone,AccountId 
                                     from Contact 
                                     where AccountId=: accountRecordId and 
                                     Name like :key ];
            if(!conList.isempty()){
                return conList;
            }
            return null;
            

        }else{
                List<Contact> conList = [SELECT id,Name,Phone,AccountId 
                                         from Contact
                                         where AccountId=: accountRecordId ];
                return conList;
                
            }
        
    } 
}