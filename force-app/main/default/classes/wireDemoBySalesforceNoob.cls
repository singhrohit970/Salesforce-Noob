public class wireDemoBySalesforceNoob {

    @AuraEnabled(cacheable=true)
    public static List<Players__c> getPlayerList(){
        
        List<Players__c> playerDetails =[Select id ,Name from Players__c];
        system.debug('playersDetails:' +playerDetails);
        return playerDetails;
    }
    
}