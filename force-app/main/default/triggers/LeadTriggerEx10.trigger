trigger LeadTriggerEx10 on Lead (before insert,before update) {
    
    Map<String,contact> mapofContact = new Map<String,contact>(); //map to store email for the corresponding contact
    List<Contact> allconList =[Select Id,email from contact]; //List to store contact id and email
    for(Contact con:allconList){ //loop to itiratre over allconList
        mapofContact.put(con.email,con);
    }
    for(Lead l:trigger.new){
        if((l.email!=null) && (trigger.isInsert || (l.email!=trigger.oldmap.get(l.id).email))){
            if(mapofContact.containskey(l.email)){ //if particular email already exit in the map
                l.email.addError('Contact with the email id already exist in the system');
            }
        }
    }
}