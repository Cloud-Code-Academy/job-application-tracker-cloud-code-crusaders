@isTest
public class JobApplicationStaleTest {

    static testmethod void testJobApplicationStale() {
        List<Job_Application__c> staleJobs = new List<Job_Application__c>();

        Job_Application__c oldJob = new Job_Application__c(Name = 'Test Job App', Status__c = 'Closed', Follow_up_Date__c = System.Today().addDays(-30));
        staleJobs.add(oldJob);

        Job_Application__c oldJob2 = new Job_Application__c(Name = 'Test Job App2', Status__c = 'Accepted', Follow_up_Date__c = System.Today().addDays(-30));
        staleJobs.add(oldJob2);

        insert staleJobs;

        System.assertEquals('Closed', oldJob.Status__c);
        System.assertEquals('Accepted', oldJob2.Status__c);

        JobApplicationStale sch = new JobApplicationStale();
        sch.execute(null);
        
    }
}