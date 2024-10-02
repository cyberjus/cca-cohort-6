trigger AccountAsyncExampleTrigger on Account (before update) {

  Map<Id, Account> accounts = new Map<Id, Account>();
  for (Account a : Trigger.new) {
    if (String.isEmpty(a.Description)) {
      accounts.put(a.Id, a);
    }
  }

  if (!accounts.isEmpty()) {
    AsyncOperations.asyncComplexOperation(accounts.keySet());
  }

}