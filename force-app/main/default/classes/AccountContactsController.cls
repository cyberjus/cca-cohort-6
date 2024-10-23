public with sharing class AccountContactsController {

  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts(Id accountId) {
    try {
      return [select Id, Name from Contact where AccountId = :accountId];
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
   
}