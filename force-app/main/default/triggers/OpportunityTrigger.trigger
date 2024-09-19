trigger OpportunityTrigger on Opportunity (after update) {
  // Example to Rollup field on Account from Opportunities

  Set<Id> accountIds = new Set<Id>();
  for (Opportunity opp : Trigger.new) {
   if (opp.Amount != Trigger.oldMap.get(opp.Id).Amount) {
      accountIds.add(opp.AccountId);
    }
  }

  if (!accountIds.isEmpty()) {

    AggregateResult[] oppTotals = [select AccountId, SUM(Amount) total from Opportunity where AccountId 
      in :accountIds GROUP BY AccountId];

    List<Account> accountsToUpdate = new List<Account>();
    for (AggregateResult total : oppTotals) {
      accountsToUpdate.add(new Account(Id = (Id)total.get('AccountId'), 
        AnnualRevenue = (Decimal)total.get('total')));
    }

    update accountsToUpdate;
  }


}