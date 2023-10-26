@isTest
private class InterviewEmailTest {
    @isTest
    static void testSendReminderEmail() {
        // Create a test Interview record with a date one day ahead
        Interview__c interviewRecord = new Interview__c(
            Name = 'Test Interview 1',
            Interview_Date__c = Date.today().addDays(1),
            Company_Name__c = 'Test Company XYZ'
        );
        insert interviewRecord;

        Test.startTest();
        // Schedule the batch job
        InterviewEmail job = new InterviewEmail();
        String jobId = System.schedule('Test InterviewEmail', '0 0 1 1 * ?', job);

        Test.stopTest();

        // Assert that the job was scheduled
        System.assertNotEquals(null, jobId);

        // You can add more assertions here to verify expected behavior
        // Clean up test data
        delete interviewRecord;
    }
}
