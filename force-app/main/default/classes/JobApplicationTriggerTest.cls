@istest
public with sharing class JobApplicationTriggerTest {
    
 @istest
    public static void testJobApplicationTrigger_updateTask(){
        //Bulk test data preparation
        Account bulkTestAccount = new Account( 
            Name = 'Test Job Co'
        );
        insert bulkTestAccount;

        // Bulk create new Job Applications
      List<Job_Application__c> bulkTaskTest = new List<Job_Application__c>();
        for (Integer i = 0; i < 300; i++) {
            bulkTaskTest.add(new Job_Application__c(
                Name = 'Bulk Test' + i, 
                Status__c = 'Saved',
                Company_Name__c = bulkTestAccount.Id
            ));
        }
        insert bulkTaskTest;

        List<Task> newTasks = [
            SELECT WhatId, Subject
            FROM Task
            WHERE WhatId
            IN :bulkTaskTest
        ];
  
        for (Task bulkTaskCheck : newTasks){
        System.assertEquals(300, newTasks.size(), 'Bulk Tasks did not update');
        }
      }
    }
