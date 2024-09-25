public with sharing class OpportunityTriggerHandler extends TriggerHandler {
    
    public override void afterUpdate() {

        System.debug('+++ OpportunityTrigger');

        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : (List<Opportunity>)Trigger.new) {
        if (opp.Amount != ((Map<Id, Opportunity>)Trigger.oldMap).get(opp.Id).Amount) {
            accountIds.add(opp.AccountId);
        }
        }

        if (!accountIds.isEmpty()) {
            update OpportunityUtils.sumOpportunitiesOnAccounts(accountIds);
        }


    }

}