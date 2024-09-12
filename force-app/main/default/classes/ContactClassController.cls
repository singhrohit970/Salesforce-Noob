public class ContactClassController {

    @AuraEnabled(cacheable=true)
    public static List<Cricketers__c> getCricketerList(String nationality ){
        system.debug('Nationality:' +nationality);
        
        if(nationality ==''){
             return [SELECT id,Name,Age__c ,Nationality__c ,Runs__c, Image_Url__c   from Cricketers__c ];   
        }
        else{
        return [SELECT id,Name,Age__c ,Nationality__c ,Runs__c, Image_Url__c   from Cricketers__c where Nationality__c=:nationality];   
        }
    }
    
    @AuraEnabled
    public static Cricketers__c getSelectedPlayerDetail(String playerId){
        Cricketers__c cricketer =[SELECT id,Name,Age__c ,Nationality__c ,Runs__c, Image_Url__c   from Cricketers__c where Id=:playerId];
        
        return Cricketer;
        
    }
}