trigger ContactBeforeDelete on Contact (Before Delete) 
{
   for(Contact c:Trigger.old)
   {
      if(c.accountID==null)
      {
         c.addError('Hey!!! you are not authorize to delete this contact');
      }
   }
}