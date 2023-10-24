@isTest
public class JobApplicationStaleTest {

    static testmethod void testJobApplicationStale() {
        List<Job_Application__c> staleJobs = new List<Job_Application__c>();

       // Job_Application__c oldJob = new Job_Application__c(Name = 'Test Job App', Status__c = 'Closed', Follow_up_Date__c = System.Today().addDays(-30));
      //  staleJobs.add(oldJob);

        Job_Application__c oldJob2 = new Job_Application__c(Name = 'Test Job App2', Status__c = 'Applied', Follow_up_Date__c = System.Today().addDays(-30));
        staleJobs.add(oldJob2);

        insert staleJobs;

        //System.assertEquals('Closed', oldJob.Status__c);
        //System.assertEquals('Accepted', oldJob2.Status__c);

        Test.startTest();
        String cronExp = '0 0 0 ? * * *';
        System.schedule('Close Stale Job Applications', cronExp, new JobApplicationStale());
        Test.stopTest();

        List<Job_Application__c> closedJobs = [
            SELECT Name, Status__c
            FROM Job_Application__c
            WHERE Status__c = 'Closed'            
        ];
  
        for (Job_Application__c closedCheck : closedJobs){
            System.assertEquals(1, closedJobs.size(), 'Stale jobs did not close');
        }

       // JobApplicationStale sch = new JobApplicationStale();
        //sch.execute(null);
        
    }
}