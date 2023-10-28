@isTest
public class PrimaryContactHandlerTest {
    @isTest
    static void testPrimaryContactHandler() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account' );
        insert testAccount;

        // Create a test Contact associated with the test Account
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = testAccount.Id
        );
        insert testContact;

        // Create a test Job_Application__c record with a primary contact and an associated Account
        Job_Application__c oldJob = new Job_Application__c(
            Name = 'TestingTesting',  
            Company_Name__c = testAccount.Id,
            Primary_Contact__c = testContact.Id
        );
        insert oldJob;

        // Create a new Job_Application__c record with a different Account
        Account newTestAccount = new Account(Name = 'New Test Account');
        insert newTestAccount;

        // Create a new Job_Application__c record with a different Account
        Job_Application__c newJob = new Job_Application__c(Name = 'TestingAgain', Company_Name__c = newTestAccount.Id);
        insert newJob;

        // Test Account without a primary contact
        Account accountWithoutPrimaryContact = new Account(Name = 'Account Without Primary Contact');
        insert accountWithoutPrimaryContact;

        // Create a new Job_Application__c record with an Account that doesn't have a primary contact
        Job_Application__c jobWithoutPrimaryContact = new Job_Application__c(Name = 'TestingThirdTime', Company_Name__c = accountWithoutPrimaryContact.Id);
        insert jobWithoutPrimaryContact;

        // Test the handler with Account Name change
        newJob.Company_Name__c = testAccount.Id; // Simulate changing the Account Name
        update newJob;

        // Retrieve the updated Job_Application__c record
        Job_Application__c updatedJob = [SELECT Primary_Contact__c FROM Job_Application__c WHERE Id = :newJob.Id];

        // Verify that the Primary Contact is set to the contact associated with the new Account
        System.assertEquals(testContact.Id, updatedJob.Primary_Contact__c);

        // Test the handler with Account Name change to an Account without a primary contact
        updatedJob.Company_Name__c = accountWithoutPrimaryContact.Id; // Simulate changing the Account Name
        update updatedJob;

        // Retrieve the updated Job_Application__c record
        Job_Application__c updatedJobWithoutPrimaryContact = [SELECT Primary_Contact__c FROM Job_Application__c WHERE Id = :updatedJob.Id];

        // Verify that the Primary Contact is set to null because the new Account doesn't have a primary contact
        System.assertEquals(null, updatedJobWithoutPrimaryContact.Primary_Contact__c);
    }
}