public class assignClubCaptain {
@AuraEnabled
    public static List<Players__c> getPlayerList(Id selectedIdFromLwc){
        
        List<Players__c> playerList = [SELECT Id, Name, Goals__c,Football_Club__c FROM Players__c 
                                       WHERE Football_Club__c=:selectedIdFromLwc];
        if(!playerList.isEmpty()){
            return playerList;
        }
        return null;
    }
    @AuraEnabled
    public static Boolean assignClubCaptain(Id lwcRowId){
        List<Football__c> clubList = new List<Football__c>();
        List<Players__c> playerListForAssignment = [SELECT Id, Name, Goals__c,Football_Club__c FROM Players__c WHERE Id=:lwcRowId];
        if(!playerListForAssignment.isEmpty()){
            
            for(Players__c playerObj :playerListForAssignment){
                Football__c clubObj = new Football__c();
                clubObj.Id= playerObj.Football_Club__c;
                clubObj.Captain__c = playerObj.Id;
                clubList.add(clubObj);
            }
        }
        if(!clubList.isEmpty()){
            upsert clubList;
            return true;
        }
        return false;
    }
}