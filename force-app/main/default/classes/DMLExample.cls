public class DMLExample {

  public static void runDML() {
  
		// Insert
		Lead newLead = new Lead(LastName = 'Smith', Company = 'Lead Co 2');
		insert newLead;

		// Update
		/*Lead updateLead = new Lead(LastName = 'Malek');
		updateLead.Status = 'Working - Contacted';
		upsert updateLead;*/

		// Insert List
		/*List<Lead> leadList = new List<Lead>();
		Lead lead1 = new Lead(LastName = 'Smith', Company = 'Lead Co 3');
		Lead lead2 = new Lead(LastName = 'Smith', Company = 'Lead Co 4');
		Lead lead3 = new Lead(LastName = 'Smith', Company = 'Lead Co 5');
		leadList.add(lead1);
		leadList.add(lead2);
		leadList.add(lead3);
		insert leadList;*/

		// Delete - replace the Id with something in your org
		//Lead lead = new Lead(Id = '00Qaj00000806qQEAQ');
		//delete lead;



		// Database class example
		/*Lead newLead = new Lead(LastName = 'Smith', Company = 'Lead Co 6');
		Database.DMLOptions dmlOpts = new Database.DMLOptions();
		dmlOpts.AssignmentRuleHeader.UseDefaultRule = true;
		Database.insert(newLead, dmlOpts);*/




	}

}
