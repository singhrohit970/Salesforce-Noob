public class PokemonClass {
    
    @AuraEnabled
    
    
    public static List<Pokemon__c> getPokemons(String searchKey){
        if(searchKey!='' && searchKey!=null){
            String key = '%'+searchKey+'%';
            
            List<Pokemon__c> pokemonSearchList = [SELECT Id, Name, Height__c, Image__c , Weight__c ,Trainer__r.firstName from Pokemon__c where Name like :key];
            
            return pokemonSearchList;
        }
        else{
         
        
        List<Pokemon__c> pokemonList = [SELECT Id, Name, Height__c, Image__c , Weight__c ,Trainer__r.firstName from Pokemon__c];
        
        if(!pokemonList.isEmpty()){
    return pokemonList;
        
    }
return Null;
            
        }            
}
}