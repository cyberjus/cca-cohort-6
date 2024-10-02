public class AsyncBatch implements Database.Batchable<sObject> {

  Set<Id> accountIds;

  public AsyncBatch(Set<Id> accountIds) {
    this.accountIds = accountIds;
  }

  public List<Opportunity> start(Database.BatchableContext bc) {
    return [select Id, CloseDate from Opportunity where IsClosed = false and AccountId in :this.accountIds];
  }

  public void execute(Database.BatchableContext bc, List<SObject> scope) {
    for (Opportunity opp : (List<Opportunity>)scope) {
      opp.CloseDate = opp.CloseDate.addDays(1);
    }
    update scope;
  }

  public void finish(Database.BatchableContext bc) {

  }

}