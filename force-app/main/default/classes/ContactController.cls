public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Product2> getContactList() {
        return [SELECT Id, Description, Name FROM Product2 LIMIT 10];
    }
}