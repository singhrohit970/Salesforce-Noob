trigger PositionTriggerEx1 on Position__c (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        
        for(Position__c po:Trigger.new){
            if(po.MAX_PAY__c==Null && po.MIN_PAY__c==Null && po.Open_Date__c==Null && po.Status__c=='New Position'){
                    po.Open_Date__c= System.today();
                    po.MIN_PAY__c=5;
                    po.MAX_PAY__c=10;   
            } 
        }
    }
}