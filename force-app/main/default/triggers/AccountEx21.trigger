trigger AccountEx21 on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Map<id,Account> accMap = New Map<id,Account>();
        List<contact> conList =new List<contact>();
        for(Account acc:Trigger.new){
            if(acc.Phone!=Null && acc.Phone!=trigger.oldmap.get(acc.id).Phone && Trigger.oldmap!=null){
                accMap.put(acc.id,acc);   
            }  
        }
        for(Contact con:[Select id ,HomePhone,AccountId from contact where AccountId in:accMap.keySet()]){
            
            //keySet(): Returns a set that contains all of the keys in the map.
            if(accMap.containskey(con.AccountId)){
                //containsKey(key): This method allows us to determine whether a key is present on the Map or not.
                // If the key is present in the apex map, it will return true.
                con.HomePhone=accMap.get(con.AccountId).Phone;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }

}