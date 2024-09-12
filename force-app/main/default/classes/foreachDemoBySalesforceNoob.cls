public class foreachDemoBySalesforceNoob {

    @AuraEnabled(cacheable=true)
    public static List<Players__c> getPlayerList(){
        List<Players__c> playerList =[Select id,Name from Players__c];
        return playerList;
    }
}