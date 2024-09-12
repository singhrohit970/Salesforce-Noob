public class Productswrapper {
@AuraEnabled(cacheable=true)
    public static List<Products> getproducts(String recid){
         Id profileId = UserInfo.getProfileId();
         String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
         String Bu=[select Id,Bussiness_Unit__c from Opportunity where Id = :recid].Bussiness_Unit__c;
         system.debug(Bu);
        List<Products> wrapperList = new List<Products>();
        for(PricebookEntry acc : [select Product2Id, Name, UnitPrice ,Product2.BU__c from PricebookEntry where Product2.BU__c=:Bu]){
            wrapperList.add(new Products(acc));
        }
        return wrapperList;
    }
public class Products{
        @AuraEnabled
        public PricebookEntry acc;
        @AuraEnabled
        public Decimal UnitPrice;
        @AuraEnabled
        public String Fam;
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public Id Product2Id;
        @AuraEnabled
        public Integer Quantity;

        public Products(PricebookEntry acc){
            this.acc = acc;
            this.Name= acc.Name;
            this.UnitPrice = acc.UnitPrice;
            this.Fam = acc.Product2.BU__c;
            this.Product2Id = acc.Product2Id;
            system.debug(this.Fam);
        }
    }
}