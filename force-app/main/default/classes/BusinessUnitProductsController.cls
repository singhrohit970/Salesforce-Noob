public with sharing class BusinessUnitProductsController {
    @AuraEnabled(cacheable=true)
    public static List<Business_Unit_Product_Mapping__mdt> getBusinessUnitProducts() {
        return [SELECT Business_Unit__c, Product__c FROM Business_Unit_Product_Mapping__mdt];
    }
}