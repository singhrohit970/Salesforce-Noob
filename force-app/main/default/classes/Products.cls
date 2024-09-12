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