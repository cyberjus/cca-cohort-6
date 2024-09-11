


//List<Account> account = [select Id from Account];
//update account;

Id campaignId = '701aj00000SXFx9AAH';

List<Lead> leads = new List<Lead>();
/*leads.add(new Lead(FirstName = 'Justin', LastName = 'Smith', Company = 'CCA', 
  Email = 'justin@justinmsmith.com'));
leads.add(new Lead(FirstName = 'Warren', LastName = 'Walters', Company = 'CCA', 
  Email = 'warren@cloudcodeacademy.com'));*/

for (Integer i=1; i<150; i++) {
  leads.add(new Lead(FirstName = 'Lead', LastName = 'Number'+i, Company = 'CCA', 
    Email = 'lead' + i + '@test.invalid'));
}

AvoidDMLInLoops.importLeads(campaignId, leads);


