//Whenever a Lead is updated and industry is Healthcare, set Lead Source as Purchased List, SIC code as 1100, Primary as Yes

trigger LeadTrigger3 on Lead (before update) {
    
    for(Lead leadrec: Trigger.New){
        if(leadrec.Industry=='Healthcare'){
            leadrec.LeadSource='Purchased List';
            leadrec.SicCode__c='1100';
            leadrec.Primary__c ='Yes';
        }
    }
}