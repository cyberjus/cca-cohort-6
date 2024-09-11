trigger AccountTrigger on Account (after update) {

  List<Id> accountIds = new List<Id>();
  for (Account account : Trigger.new) {
    accountIds.add(account.Id);
  }

  AccountTriggerHelper.updateOpportunities(accountIds);


}