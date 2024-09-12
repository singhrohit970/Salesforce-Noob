trigger ContactBeforeInsert on Contact (before Insert) {
for(Contact contact:Trigger.new){
   contact.description='Contact created by Rohit Singh';
   }

}