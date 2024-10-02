public with sharing class AsyncOperations {
    
    public static List<Account> complexOperation(List<Account> accounts) {
        for (Account a : accounts) {
            for (Integer i = 0; i < 1000; i++) {
                for (Integer n = 0; n < 1000; n++) {
                    Decimal sqrt = Math.pow(Math.log(i), Math.sqrt(i));
                }
            }
            a.Description = 'Done Calculation';
        }   
        return accounts;
    }

    @future
    public static void asyncComplexOperation(Set<Id> accountIds) {
        List<Account> accounts = complexOperation([select Id from Account where Id in :accountIds]);
        update accounts;
    }

}