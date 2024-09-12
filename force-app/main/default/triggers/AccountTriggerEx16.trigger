trigger AccountTriggerEx16 on Account (After insert) {

    if(Trigger.isInsert && Trigger.isAfter){
                List<Opportunity > oppList = new List<Opportunity>();
        for(Account acc:Trigger.New){

                Opportunity opp = new Opportunity();
                opp.StageName='Prospecting';
                opp.Name=acc.Name+ 'Opp';
                opp.AccountId = acc.Id ;
                opp.CloseDate=System.today();
                oppList.add(opp);
                 
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
}