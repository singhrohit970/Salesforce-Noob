public class ShowTerritories {

    @AuraEnabled(cacheable=true)
    public static List<ServiceTerritory> getTerritories(){
        
        List<ServiceTerritory> terrList = [select id,name from ServiceTerritory ];
        return terrList;
     
    }
    
    
    @AuraEnabled(cacheable=true)
    public static Integer getAccountCount() {
        Integer count = [SELECT COUNT() FROM Account];
        return count;
    }
}