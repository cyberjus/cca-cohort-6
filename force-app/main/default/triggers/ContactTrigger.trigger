trigger ContactTrigger on Contact(before insert) {
  Set<Id> accountIds = new Set<Id>();
  for (Contact contact : Trigger.new) {
    if (contact.Email == 'test@test.com') accountIds.add(contact.AccountId);
  }

  Map<Id, Account> accountRecords = AccountUtils.getAccountWithTestContacts(accountIds);

  for (Contact contact : Trigger.new) {
    if (!accountRecords.get(contact.AccountId).Contacts.isEmpty()) {
      contact.addError('Test Contact Already Exists');
    }
  }

}
