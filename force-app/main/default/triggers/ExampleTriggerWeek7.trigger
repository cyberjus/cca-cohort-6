trigger ExampleTriggerWeek7 on Account (before insert, before update, after insert, after update) {

  // Before  Triggers
  if (Trigger.isBefore) {
    for (Account a : Trigger.new) {
      if (Trigger.isInsert) {
        // Update Name when Insert
        a.Name = 'Insert ' + a.Name;
      } else if (Trigger.isUpdate) {

        // Check Previous Values
        Account oldAccount = Trigger.oldMap.get(a.Id);

        // Only execute when meets criteria and did not previous meet criteria 
        if (a.Industry == 'Banking' && oldAccount.Industry != 'Banking') {
          a.Industry.addError('Industry cannot be changed');
        }

        System.debug('New Name ' + a.Name);
        System.debug('Old Name ' + oldAccount.Name);

        // Add Error if Name contains Test
        if (a.Name.contains('Test')) {
          a.Name.addError('Name cannot contain "Test"');
        }
      }
    }
  }

  // After Trigger 
  if (Trigger.isAfter) {

    // Create default contact on an Account when not there

    Set<Id> accountIds = new Set<Id>();
    for (Account account : Trigger.new) {
      accountIds.add(account.Id);
    }

    // Get Accounts with their contacts that meet our criteria
    List<Account> accountRecords = AccountUtils.getAccountWithTestContacts(accountIds).values();

    List<Contact> newContacts = new List<Contact>();
    for (Account accountRecord : accountRecords) {
      if (accountRecord.Contacts.isEmpty()) {
        // Create new contact
        newContacts.add(new Contact(AccountId = accountRecord.Id, FirstName = 'Test', 
          LastName = 'Contact', Email = 'test@test.com'));
      }
    }

    insert newContacts;
  }

}