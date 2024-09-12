public class oppproduct {
    @AuraEnabled(cacheable=false)
    public static void saveproducts(String pro,String quan,String recordId,String unit){
    //public static void saveproducts(String pro){
        system.debug(pro);
        System.debug(quan);
        System.debug(recordId);
        System.debug(unit);
        OpportunityLineItem Obj=new OpportunityLineItem();
        Obj.Quantity=Integer.valueOf(quan);
        Obj.Product2Id=pro;
        Obj.OpportunityId=recordId;
        Obj.UnitPrice=Integer.valueOf(unit);
        system.debug(obj);
        insert Obj;
    }   
}