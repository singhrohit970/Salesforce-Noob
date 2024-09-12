trigger FirstTrigger on Contact (before insert) {
    For(Contact b :Trigger.new){
        b.email='rohitsingh@ge.com';
    }
}