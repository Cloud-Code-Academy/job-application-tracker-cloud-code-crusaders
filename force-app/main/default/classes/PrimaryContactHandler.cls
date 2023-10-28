public with sharing class PrimaryContactHandler {
    public static void setPrimaryContact(Job_Application__c job, Job_Application__c oldJob) {
        if (job != null && oldJob != null) {
            if (job.Company_Name__c != oldJob.Company_Name__c) {
                job.Primary_Contact__c = null;
                if (job.Company_Name__c != null) {
                    Id primaryContactId = null;
                    //move SOQL queries out of the for loop and save the values
                    Map<Id, Account> accountMap = new Map<Id, Account>();
                    Map<Id, Contact> contactMap = new Map<Id, Contact>();
                    List<Account> relatedAccounts = [SELECT Id, Primary_Contact__c FROM Account WHERE Id IN :new Set<Id>{job.Company_Name__c}];
                    for (Account acc : relatedAccounts) {
                        accountMap.put(acc.Id, acc);
                        if (acc.Primary_Contact__c != null) {
                            primaryContactId = acc.Primary_Contact__c;
                        }
                    }
                    if (primaryContactId == null) {
                        //move SOQL out of four loop and save values
                        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId = :job.Company_Name__c LIMIT 1];
                        for (Contact con : contacts) {
                            contactMap.put(con.AccountId, con);
                            primaryContactId = con.Id;
                        }
                    }
                    if (primaryContactId != null) {
                        job.Primary_Contact__c = primaryContactId;
                    }
                }
            }
        }
    }
}
