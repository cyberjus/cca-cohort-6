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
      System.debug('%%%% ' + a.Name);
      System.debug(forecast);

      a.Q1_Forecast__c = forecast.quarters.get(0).revenue;
      a.Q2_Forecast__c = forecast.quarters.get(1).revenue;
      a.Q3_Forecast__c = forecast.quarters.get(2).revenue;
      a.Q4_Forecast__c = forecast.quarters.get(3).revenue;
    }
    System.debug('++++++ ' + accounts);
    //update accounts;
  }
}
