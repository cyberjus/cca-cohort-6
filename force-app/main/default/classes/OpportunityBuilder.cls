public class OpportunityBuilder {
  // Takes an account name, and contact first and last names
  // Creates new account and contact records
  // Creates 3 opportunities - 30, 60, and 90 days out for close dates
  // Links opportunities to new account and contacts
  public static void createOpportunities(
    String accountName,
    String contactFirstName,
    String contactLastName
  ) {
    // Create Account
    Account newAccount = new Account(Name = accountName, Active__c = 'Yes');
    insert newAccount;

    // Create Contact
    Contact newContact = new Contact(
      FirstName = contactFirstName,
      LastName = contactLastName,
      AccountId = newAccount.Id
    );
    insert newContact;

    // Create 3 New Opportunities
    List<Opportunity> newOpportunities = new List<Opportunity>();
    for (Integer i = 30; i <= 90; i += 30) {
      Opportunity newOpportunity = new Opportunity(
        AccountId = newAccount.Id,
        Name = newAccount.Name + ' - ' + i + ' Day Target Opportunity',
        CloseDate = Date.today().addDays(i),
        StageName = 'Prospecting'
      );
      newOpportunities.add(newOpportunity);
    }
    insert newOpportunities;

    // Create Opportunity Contact Roles
    List<OpportunityContactRole> newOCRs = new List<OpportunityContactRole>();
    for (Opportunity o : newOpportunities) {
      newOCRs.add(
        new OpportunityContactRole(
          Role = 'Decision Maker',
          IsPrimary = true,
          OpportunityId = o.Id,
          ContactId = newContact.Id
        )
      );
    }
    insert newOCRs;
  }
}
