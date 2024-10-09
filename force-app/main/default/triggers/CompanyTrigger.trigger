trigger CompanyTrigger on Account(after update) {
  Set<Id> syncCompanyIds = new Set<Id>();

  for (Account account : Trigger.new) {
    Account oldAccount = Trigger.oldMap.get(account.Id);
    if (account.Sic != oldAccount.Sic) {
      syncCompanyIds.add(account.Id);
    }
  }

  if (!syncCompanyIds.isEmpty()) {
    // Call our webservice
    CompanyService.syncCompany(syncCompanyIds);
  }

}
