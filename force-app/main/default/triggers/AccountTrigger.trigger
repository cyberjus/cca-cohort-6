trigger AccountTrigger on Account (after update) {

  System.debug('+++ AccountTrigger');

  List<Id> accountIds = new List<Id>();
  for (Account account : Trigger.new) {
    accountIds.add(account.Id);
  }

  AccountTriggerHelper.updateOpportunities(accountIds);


}