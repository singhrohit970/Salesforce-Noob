public with sharing class ProductSelectionController {
    
    
    @AuraEnabled(cacheable=true)
    public static List<String> getBusinessUnits() {
        List<String> businessUnits = new List<String>();
        for (AggregateResult result : [SELECT BU__c FROM Product2 WHERE BU__c != null GROUP BY BU__c]) {
            String businessUnit = (String) result.get('BU__c');
            businessUnits.add(businessUnit);
        }
        return businessUnits;
    }
    
    
   @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsByBU() {
        return [SELECT Id, Description, Name FROM Product2 LIMIT 10];
    }
}

/*    
      @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsByBU(String bu) {
        List<Product2> products = new List<Product2>();
        if (String.isNotBlank(bu)) {
            products = [SELECT Id, Name FROM Product2 WHERE BU__c = :bu];
        }
        return products;
*/