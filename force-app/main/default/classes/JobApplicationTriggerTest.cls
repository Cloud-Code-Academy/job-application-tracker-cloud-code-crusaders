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

        List <Job_Application__c> jobsList = new List <Job_Application__c>();
          jobsList.add(new Job_Application__c(
          Name = 'Test 1',
          Status__c = 'Applying'
        ));
        jobsList.add(new Job_Application__c(
          Name = 'Test 2',
          Status__c = 'Applied'
        ));
        jobsList.add(new Job_Application__c(
          Name = 'Test 3',
          Status__c = 'Interviewing'
        ));
        jobsList.add(new Job_Application__c(
          Name = 'Test 4',
          Status__c = 'Closed'
        ));
        jobsList.add(new Job_Application__c(
          Name = 'Test 5',
          Status__c = 'Accepted'
        ));
        jobsList.add(new Job_Application__c(
          Name = 'Test 6',
          Status__c = 'Negotiating'
        ));

        insert jobsList;

        List<Job_Application__c> updateJobList = [
          SELECT Name, Status__c
          FROM Job_Application__c
          WHERE Status__c = 'Closed'
        ];

        for (Job_Application__c updateCheck : updateJobList){
          if (updateCheck.Name == 'Test 3' ){
              updateCheck.Status__c = 'Closed';
          }
        }
          update updateJobList;

          List<Task> newTasksList = [
            SELECT WhatId, Subject
            FROM Task
            WHERE WhatId
            IN :updateJobList
        ];
  
        for (Task updateTaskCheck : newTasksList){
          System.assertEquals(1, newTasksList.size(), 'Task did not update');
        }
      }
    }