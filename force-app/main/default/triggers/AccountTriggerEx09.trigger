trigger AccountTriggerEx09 on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Account acc:Trigger.new){
            
            if(acc.Active__c=='No' && acc.Active__c!=Trigger.Oldmap.get(acc.id).Active__c){
                accIds.add(acc.Id);
        }
    }
    for(Account acc:[Select id ,Active__c,(Select id,StageName from opportunities) FROM Account where id in:accIds]){
        If(acc.opportunities !=Null){
            for(Opportunity opp:acc.opportunities){
                if(opp.StageName!='Closed Won' && opp.StageName!='Closed Lost'){
                opp.StageName='Closed Lost';    
                oppList.add(opp);
            }
        }
    }  
}

if(!oppList.isEmpty()){
    update oppList;
}
    }
}