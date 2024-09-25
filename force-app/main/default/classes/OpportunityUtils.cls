public with sharing class OpportunityUtils {
    
    public static Boolean disableTrigger = false;

    public static List<AggregateResult> opportunityTotalsByAccount(Set<Id> accountIds) {
        return [select AccountId, SUM(Amount) total from Opportunity where AccountId 
            in :accountIds GROUP BY AccountId];
    }

    public static List<Account> sumOpportunitiesOnAccounts(Set<Id> accountIds) {
        AggregateResult[] oppTotals = OpportunityUtils.opportunityTotalsByAccount(accountIds);

        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult total : oppTotals) {
            accountsToUpdate.add(new Account(Id = (Id)total.get('AccountId'), 
            AnnualRevenue = (Decimal)total.get('total')));
        }
        return accountsToUpdate;
    }

}