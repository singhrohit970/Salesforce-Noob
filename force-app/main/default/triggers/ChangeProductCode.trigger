trigger ChangeProductCode on Product2 (before insert) {
   List<Product2> productList=trigger.new;// newer version of the records
   for(Product2 pro:productList)
   {
       if(pro.productCode!=null && pro.productCode!='')
    {
     pro.productCode='XYZ-'+pro.productCode;
    }
  }

}