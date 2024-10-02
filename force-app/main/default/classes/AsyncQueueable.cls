public class AsyncQueueable implements Queueable {

  List<Opportunity> opps;

  public AsyncQueueable(List<Opportunity> opps) {
    this.opps = opps;
  }

  public void execute(QueueableContext context) {
    Opportunity opp = this.opps.remove(0);
    opp.CloseDate = opp.CloseDate.addDays(1);
    update opp;
    if (!this.opps.isEmpty()) {
      System.enqueueJob(new AsyncQueueable(this.opps));
    }
  }

}