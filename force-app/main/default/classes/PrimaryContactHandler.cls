public with sharing class PrimaryContactHandler {
    public static void setPrimaryContact(Job_Application__c job, Job_Application__c oldJob) {
        // Check if both job and oldJob are not null
        if (job != null && oldJob != null) {
            // Check if the Account Name has changed
            if (job.Company_Name__c != oldJob.Company_Name__c) {
                // Clear the Primary Contact on the triggered Job Application
                job.Primary_Contact__c = null;

                // Check if there is a new associated Account (Company)
                if (job.Company_Name__c != null) {
                    Id primaryContactId = null;

                    // Query the related Account and retrieve the Primary_Contact__c field
                    Account relatedAccount = [SELECT Id, Primary_Contact__c FROM Account WHERE Id = :job.Company_Name__c LIMIT 1];
                    if (relatedAccount != null) {
                        primaryContactId = relatedAccount.Primary_Contact__c;
                    }

                    // If the Account doesn't have a primary contact, find the first contact from the Contacts related list
                    if (primaryContactId == null) {
                        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :job.Company_Name__c LIMIT 1];
                        if (!contacts.isEmpty()) {
                            primaryContactId = contacts[0].Id;
                        }
                    }

                    // If a primary contact is found, set it as the Primary Contact on the triggered Job Application
                    if (primaryContactId != null) {
                        job.Primary_Contact__c = primaryContactId;
                    }
                }
            }
        }
    }
}
