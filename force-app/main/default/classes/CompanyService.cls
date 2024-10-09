public class CompanyService {
  @future(callout=true)
  public static void syncCompany(Set<Id> accountIds) {
    Map<Id, Account> accounts = new Map<Id, Account>(
      [
        SELECT Id, Sic
        FROM Account
        WHERE Id IN :accountIds AND Sic != NULL
      ]
    );
    for (Account account : accounts.values()) {
      Company company = getCompany(account.Sic);
      account.Name = company.Name;
      account.AnnualRevenue = company.market_cap;
    }
    update accounts.values();
  }

  // https://www.devtoolsdaily.com/fake_json_api/
  public static Company getCompany(String id) {
    Http http = new Http();

    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://testapi.devtoolsdaily.com/companies/' + id);
    request.setMethod('GET');

    HttpResponse response = http.send(request);

    System.debug(response.getBody());

    Company company = (Company) JSON.deserialize(
      response.getBody(),
      Company.class
    );

    System.debug(company);
    System.debug(company.name);

    return company;
  }

  // https://testapi.devtoolsdaily.com/companies/1
  public class Company {
    public String name;
    public String countryCode;
    public Decimal market_cap;
    public String id;

    public Company() {
    }
  }
}
