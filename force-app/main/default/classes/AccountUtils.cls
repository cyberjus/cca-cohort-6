public with sharing class AccountUtils {


    public static Account getSingleAccountWithTestContacts(Id accountId) {
        return getAccountWithTestContacts(new Set<Id> { accountId } ).get(accountId);
    }
   
    public static Map<Id, Account> getAccountWithTestContacts(Set<Id> accountIds) {
        return getAccountWithDynamicName(accountIds, 'Test', 'test@test.com');
    }

    public static Map<Id, Account> getAccountWithDynamicName(Set<Id> accountIds, String name, String email) {
        return new Map<Id, Account>(
            [
              SELECT
                Id,
                (
                  SELECT Id, FirstName, LastName
                  FROM Contacts
                  WHERE Email = :email AND FirstName = :name
                )
              FROM Account
              WHERE Id IN :accountIds
            ]
          );
    }


}