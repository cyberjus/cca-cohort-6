public class AsyncSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    Map<Id, Account> accountIds = new Map<Id, Account>([select Id from Account]);
    AsyncBatch batch = new AsyncBatch(accountIds.keySet()); 
    Database.executeBatch(batch, 5);
  }
}