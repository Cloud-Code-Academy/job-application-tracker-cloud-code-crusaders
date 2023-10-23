global class JobApplicationStale implements Schedulable {

    global void execute (SchedulableContext Sc) {
        List<Job_Application__c> staleJobs = [
            SELECT Id, Status__c, LastModifiedDate, Name, Follow_up_Date__c
            FROM Job_Application__c
            WHERE (Status__c != 'Closed' OR Status__c = 'Accepted') 
            AND Follow_up_Date__c > LAST_N_DAYS:30
        ];

        if(!staleJobs.isEmpty()){

            List<Job_Application__c> closedJobs = new List<Job_Application__c>();

            for (Job_Application__c updateJobs : staleJobs){
                updateJobs.Status__c = 'Closed';
                updateJobs.Notes__c = 'This Job Application has not been updated in more than 30 days and was closed by an automation.';
                }

                update closedJobs;
        }
    }

}
