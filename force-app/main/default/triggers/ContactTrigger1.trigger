//Write a trigger to automatically create a USER whenever CONTACT is created.
trigger ContactTrigger1 on Contact (after insert) {
    List<User> userList = new List<User>();
    List<Profile> profileList = [SELECT Id, Name FROM Profile WHERE Name = 'Chatter External User'];

    for (Contact c : Trigger.new) {
        User u = new User();
        u.LastName = c.LastName;
        u.Email = c.Email;
        u.Username = 'testmail@test.com';
        u.Alias = 'test';
        u.IsActive = true;
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LocaleSidKey = 'en_US';

        if (profileList.size() > 0) {
            u.ProfileId = profileList[0].Id;
            userList.add(u);
        }
    }

    if (!userList.isEmpty()) {
        insert userList;
    }
}