public with sharing class OpportunityForecastBuilder {
  public static void buildOpportunityForecast() {
    List<Opportunity> opps = [SELECT Id, Amount, CloseDate FROM Opportunity];

    OpportunityForecast forecast = new OpportunityForecast();

    for (Opportunity opp : opps) {
      forecast.addOpportunity(opp);
    }

    System.debug(forecast);
  }

  public static void buildOpportunityForecastByAccount() {
    List<Account> accounts = [
      SELECT Id, Name, (SELECT Id, Amount, CloseDate FROM Opportunities)
      FROM Account
    ];

    for (Account a : accounts) {
      OpportunityForecast forecast = new OpportunityForecast();
      for (Opportunity opp : a.Opportunities) {
        forecast.addOpportunity(opp);
      }
      System.debug(a.Name);
      System.debug(forecast);
    }
  }
}
