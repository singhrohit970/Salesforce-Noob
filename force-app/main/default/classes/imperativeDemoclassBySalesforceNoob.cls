public class imperativeDemoclassBySalesforceNoob {
    
    @AuraEnabled
    public static List<Players__c> getPlayerList(){
        List<Players__c> playerListForLWC =[Select id, Name from players__c];
        return playerListForLWC;
    }

}