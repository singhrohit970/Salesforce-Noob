trigger LeadTestTrigger on Lead (before insert) {
system.debug('Lead is executed');
}