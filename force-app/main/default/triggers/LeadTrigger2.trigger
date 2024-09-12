trigger LeadTrigger2 on Lead (before insert,before update) {
    for(Lead leadrecord : Trigger.new){
        if(string.isBlank(leadrecord.Rating)){
            leadrecord.Rating= 'warm';
            
        }
    }
}