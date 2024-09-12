trigger AccountTriggerEx8 on Account (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        List<Contact> conList=[Select id,Accountid from contact where AccountId IN:Trigger.oldMap.keyset()];
        
        if(!conList.isEmpty()){
            
            for(Contact con:conList){
                con.accountid=null;
            }
        }
        update conList;
    }
}