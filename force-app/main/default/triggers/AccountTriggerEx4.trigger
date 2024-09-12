trigger AccountTriggerEx4 on Account (before insert,before update) {
    
    if((Trigger.isBefore) && ((Trigger.isInsert) || (Trigger.isUpdate))){
        
        for(Account acc:Trigger.new){
            
            if(acc.Industry=='Banking'){
              acc.AnnualRevenue =50000000;
            }
            else if(acc.Industry=='Finance'){
                acc.AnnualRevenue =4000000;
            }
                else if(acc.Industry=='Insurance'){
                    acc.AnnualRevenue =3500000;
                }
                    else if (acc.Industry=='Healthcare'){
                        acc.AnnualRevenue =2500000;
                    }
                        else{
                            acc.AnnualRevenue =500;
                        }
            
        }
    }
}