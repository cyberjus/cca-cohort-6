public with sharing class AccountTriggerHelper {
   
    public static void updateOpportunities(Id accountId) {

        List<Opportunity> opps = [select Id, Amount 
            from Opportunity where AccountId = :accountId];

        // Get Total Amount
        Decimal totalAmount = 0;
        for (Opportunity opp : opps) {
            if (opp.Amount != null) totalAmount += opp.Amount;
        }

        // Update Opps
        List<Opportunity> updateOpps = new List<Opportunity>();
        for (Opportunity opp : opps) {
            opp.Description = 'Total Open Opportunities: ' + totalAmount;
            updateOpps.add(opp);
        }

        update updateOpps;
    }

    public static void updateOpportunities(List<Id> accountIds) {

        List<Opportunity> opps = [select Id, AccountId, Amount 
            from Opportunity where AccountId in :accountIds and Amount != null];

        // Get Total Amount
        Map<Id, Decimal> totalAmount = new Map<Id, Decimal>();
        for (Opportunity opp : opps) {
            if (!totalAmount.containsKey(opp.AccountId)) totalAmount.put(opp.AccountId, 0);
            if (opp.Amount != null) totalAmount.put(opp.AccountId, totalAmount.get(opp.AccountId)+opp.Amount);
        }

        // Update Opps
        List<Opportunity> updateOpps = new List<Opportunity>();
        for (Opportunity opp : opps) {
            opp.Description = 'Total Open Opportunities: ' + totalAmount.get(opp.AccountId);
            updateOpps.add(opp);
        }

        update updateOpps;
    }

}