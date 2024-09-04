public class SQLExample {
   

    public static void selectQuery() {

        /* 
        
        SELECT Id, Name FROM Account

        SELECT Id, Name FROM Account WHERE Name = 'sForce'

        SELECT Id, Name FROM Account WHERE Name = 'sForce' OR 
          Name = 'GenePoint'

        SELECT Id, Name FROM Account WHERE Name IN ('sForce','GenePoint')
        
        SELECT Id, Name FROM Account WHERE (Name = 'sForce' OR 
          Name = 'GenePoint') AND Id = '001aj00000SWE37AAH'

        SELECT Id, Name, CloseDate FROM Opportunity 
          WHERE CloseDate > 2024-04-01

        SELECT Id, Name, CloseDate FROM Opportunity 
          WHERE CALENDAR_QUARTER(CloseDate) = 2

        SELECT Id, Name FROM Account WHERE Name LIKE 'United%'

        SELECT Id, Name, 
            (SELECT Id, Name, Amount FROM Opportunities) FROM Account

        SELECT Id, Name, Amount, Account.Id, Account.Name FROM Opportunity

        SELECT Id, Amount FROM Opportunity ORDER BY Amount DESC

        SELECT Id, Amount FROM Opportunity WHERE Amount != NULL ORDER BY Amount DESC LIMIT 1

        SELECT Id, Amount FROM Opportunity WHERE Amount != NULL 
            ORDER BY Amount DESC LIMIT 1 OFFSET 10

        */

    }

    public static void queryToObjects() {

        /*
        */

        // Basic Query to List
        /*List<Account> accounts = new List<Account>([SELECT Id, Name, BillingCity FROM Account where Name = 'NONENENENENE']);
        for (Account a : accounts) {
            System.debug(a.BillingCity);
        }
        System.debug(accounts);
        */

        // Single Object Query
        //Account account = [SELECT Id, Name, BillingCity FROM Account LIMIT 1];
        //System.debug(account);

        // Example non found record
        /*List<Account> accounts = new List<Account>([SELECT Id, Name, BillingCity FROM 
            Account where Name = 'NONENENENENE' LIMIT 1]);
        Account a;
        if (!accounts.isEmpty()) {
            a = accounts.get(0);
            // Do whatever with account
        }*/

        // Initialize a Map from Query
        /*Map<Id, Account> accounts = new Map<Id, Account>([select Name FROM Account]);
        System.debug(accounts);
       
        // Sub Query Method
        List<Account> accounts = new List<Account>([SELECT Id, Name, 
            (SELECT Id, Name, Amount FROM Opportunities) FROM Account]);
        System.debug(accounts);    
        for (Account a : accounts) {
            for (Opportunity opp : a.Opportunities) {
                System.debug('OPP ' + opp);
            }
        }
        List<Opportunity> firstAccountsOpps = accounts.get(0).Opportunities;

        // Map Method Query
        List<Opportunity> opps = [SELECT Id, AccountId, Name FROM Opportunity];
        Map<Id, Account> accounts = new Map<Id, Account>([select Name FROM Account]);
        for (Opportunity opp : opps) {
            Account a = accounts.get(opp.AccountId);
        }

        // Child to Parent Object Reference from Query
        List<Opportunity> opps = [SELECT Id, Name, Amount, Account.Id, Account.Name FROM Opportunity];
        for (Opportunity opp : opps) {
            Account a = opp.Account;
        }*/

        // Variable Binds
        /*String accountName = 'sForce';
        List<String> accountNames = new List<String>{ 'sForce', 'Toshiba' };
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name IN :accountNames OR Name = :accountName];
        System.debug(accounts);
        */


    }

    public static void aggregateQuery() {

        /*

        SELECT COUNT(ID) FROM ACCOUNT

        SELECT Account.Name, MAX(Amount) Max FROM Opportunity 
        GROUP BY Account.Name

        SELECT Account.Name, MAX(Amount) Max FROM Opportunity GROUP BY Account.Name HAVING MAX(Amount) >= 100000

        */
        
        AggregateResult[] query = [SELECT Account.Name, MAX(Amount) Max FROM Opportunity GROUP BY Account.Name];
        System.debug(query);

        for (AggregateResult q : query) {
            System.debug((Decimal)q.get('Max'));
        }

    }

    public static void dynamicSOQL() {

       //String query = 'SELECT Id, Name FROM Account';
       String input = 'University of Arizona';
       String badInput = '\' OR Name <> \'';
       String query = 'select Id, Name from Account where Name = :input';

       List<Account> accounts = (List<Account>)Database.query(query);

       System.debug(accounts);


       // String query = 'SELECT Id, Name FROM Account WHERE Name = \'University of Arizona\'';
       // String input = 'University of Arizona'
       // String query = 'SELECT Id, Name FROM Account WHERE Name = \''+input+'\'';
       // String badInput = '\' OR Name <> \'';
       

    }


}