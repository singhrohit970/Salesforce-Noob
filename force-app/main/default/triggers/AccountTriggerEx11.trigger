trigger AccountTriggerEx11 on Account (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        
        for(Account acc:Trigger.new){
            
            if(acc.CopyBillingtoShipping__c){
            acc.BillingStreet=acc.ShippingStreet;
            acc.BillingCity=acc.ShippingCity;
            acc.BillingPostalCode=acc.ShippingPostalCode;
            acc.BillingCountry =acc.ShippingCountry;
          
        }
    }
}
}