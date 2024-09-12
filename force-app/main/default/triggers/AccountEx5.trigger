trigger AccountEx5 on Account (After insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        List<Opportunity> oppList = new List<Opportunity>();
            List<Contact> conList = new List<Contact>();
        for(Account acc:Trigger.new){
            if(acc.Contact__c){
                Contact con = new Contact();
                con.LastName=acc.Name +'FN';
                con.FirstName=acc.Name+ 'LN';
                con.AccountId=acc.id;
                conList.add(con);
            }
        
        if(acc.Opportunity__c && acc.Active__c=='Yes'){
            Opportunity opp = new Opportunity();
            opp.Name=acc.Name;
            opp.CloseDate=system.today();
            opp.StageName ='Prospecting';
            opp.AccountId=acc.id;
            oppList.add(opp);
        }
    }
        
        if(!conList.isEmpty()){
            insert conList;
        }
        
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }

}