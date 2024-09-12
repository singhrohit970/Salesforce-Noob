trigger OpportunityTriggerEx35 on Opportunity (after update) {
    if (Trigger.isAfter && Trigger.isUpdate){
        List<Task> taskList = new  List<Task> ();
        for(Opportunity opp:Trigger.new){
            if(Opp.StageName!=Trigger.oldmap.get(opp.id).StageName){
            
            Task tasks = new Task();
            tasks.Status ='completed';
            tasks.Subject='Call';
            tasks.Priority='normal';
            tasks.OwnerId=UserInfo.getUserId();
            tasks.WhatId=opp.id;
            taskList.add(tasks);      
        }
    }
    if(!taskList.isEmpty()){
        insert taskList;
    }
}
}