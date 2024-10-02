// Execute Batch
//Map<Id, Account> accounts = new Map<Id, Account>([select Id from Account limit 5]);
//Database.executeBatch(new AsyncBatch(accounts.keySet()), 1);

// Queueable
Id jobId = System.enqueueJob(new AsyncQueueable([select Id, CloseDate from Opportunity where IsClosed = true limit 5]));
System.debug(jobId);

// Schedule Apex
AsyncSchedulable scheduledClass = new AsyncSchedulable();
String timeTrigger = '0 1 * * * ?';
String jobID = System.schedule('Async Batch', timeTrigger, scheduledClass);

// Seconds Minutes Hours Day_of_month Month Day_of_week Optional_year
