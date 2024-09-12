trigger AccountEx44 on Account (before delete) {

    if(Trigger.isBefore && Trigger.isUpdate){
        Profile p = [Select id, Name from Profile where Name='System Administrator'];
            for(Account acc:Trigger.old){
                if(UserInfo.getProfileId()!=p.Id){
                    acc.AddError('You do not have permission to delete an Account, Please Contact System Administrator');
                }
            }
    }
        
}