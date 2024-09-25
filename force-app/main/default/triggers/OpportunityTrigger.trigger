trigger OpportunityTrigger on Opportunity (after update) {
  new OpportunityTriggerHandler().run();
}