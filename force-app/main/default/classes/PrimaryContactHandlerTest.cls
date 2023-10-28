@isTest
public class PrimaryContactHandlerTest {
    @isTest
    static void testPrimaryContactHandler() {
        Account testAccount = new Account(Name = 'Test Account' );
        insert testAccount;
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = testAccount.Id
        );
        insert testContact;
        Job_Application__c oldJob = new Job_Application__c(
            Name = 'TestingTesting',  
            Company_Name__c = testAccount.Id,
            Primary_Contact__c = testContact.Id
        );
        insert oldJob;
        Account newTestAccount = new Account(Name = 'New Test Account');
        insert newTestAccount;
        Job_Application__c newJob = new Job_Application__c(Name = 'TestingAgain', Company_Name__c = newTestAccount.Id);
        insert newJob;
        Account accountWithoutPrimaryContact = new Account(Name = 'Account Without Primary Contact');
        insert accountWithoutPrimaryContact;
        Job_Application__c jobWithoutPrimaryContact = new Job_Application__c(Name = 'TestingThirdTime', Company_Name__c = accountWithoutPrimaryContact.Id);
        insert jobWithoutPrimaryContact;
        jobWithoutPrimaryContact.Company_Name__c = testAccount.Id;
        update jobWithoutPrimaryContact;
        Job_Application__c updatedJobWithoutPrimaryContact = [SELECT Primary_Contact__c FROM Job_Application__c WHERE Id = :jobWithoutPrimaryContact.Id];
        System.assertEquals(null, updatedJobWithoutPrimaryContact.Primary_Contact__c);
        }
  
    @isTest
    static void testPrimaryContactHandlerWithAccountChange() {
        Account testAccount = new Account(Name = 'Test Account' );
        insert testAccount;
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = testAccount.Id
        );
        insert testContact;
        Account newTestAccount = new Account(Name = 'New Test Account');
        insert newTestAccount;
        Job_Application__c newJob = new Job_Application__c(Name = 'TestingAgain', Company_Name__c = newTestAccount.Id);
        insert newJob;
        newJob.Company_Name__c = testAccount.Id;
        update newJob;
        Job_Application__c updatedJob = [SELECT Primary_Contact__c FROM Job_Application__c WHERE Id = :newJob.Id];
        System.assertEquals(testContact.Id, updatedJob.Primary_Contact__c);
    }
}
