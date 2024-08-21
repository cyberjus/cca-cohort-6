public with sharing class OpportunityForecast {
  List<QuarterForecast> quarters;

  public OpportunityForecast() {
    this.quarters = new List<QuarterForecast>();
    for (Integer i = 1; i <= 4; i++) {
      quarters.add(new QuarterForecast(i));
    }
  }

  public void addOpportunity(Opportunity opp) {
    this.quarters.get((Integer) Math.floor((opp.CloseDate.month()-1)/3)).add(opp);
  }

  public class QuarterForecast {
    Integer quarter;
    Decimal revenue;
    Integer count;

    public QuarterForecast(Integer quarter) {
      this.quarter = quarter;
      this.revenue = 0.0;
      this.count = 0;
    }

    public void add(Opportunity opp) {
      this.revenue += opp.Amount;
      this.count++;
    }
  }
}
