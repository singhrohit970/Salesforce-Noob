public class ApexTractionExample {
    public static void insertLeadANDAccount(STRING accName,STRING LeadName,STRING LeadCompany)
    {
        Account a = new Account(Name=accName);
        insert a;
        Lead l1 = new Lead(LastName=LeadName,Company=LeadCompany);
        insert l1;
        Lead l2 =new Lead (LastName=LeadName,Company='Raja');
        insert l2;
    }

}