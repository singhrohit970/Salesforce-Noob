trigger WinningSatgeTrigger on Opportunity (before update) 
{
    for(Opportunity opp:Trigger.new)
    {
       Opportunity oldOpp= Trigger.OldMap.get(opp.id);
       Boolean oldOppIsWon=oldopp.Stagename.equals('Closed Won');
          Boolean neOppiswon= opp.Stagename.equals('Closed Won');
          If(!oldOppIsWon && neOppiswon)
          {
             opp.Is_Value_Correct__c=true;
             
          }
     }
}