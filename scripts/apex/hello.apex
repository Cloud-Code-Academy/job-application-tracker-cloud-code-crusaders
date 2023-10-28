List<Job_Application__c> staleJobs = [
            SELECT Id, Status__c, LastModifiedDate, Name, Follow_up_Date__c
            FROM Job_Application__c
            WHERE (Status__c <> 'Closed' AND Status__c <> 'Accepted' AND Status__c <> 'Saved') 
            AND Follow_up_Date__c < LAST_N_DAYS:30
        ];

System.debug(staleJobs);

       if(!staleJobs.isEmpty()){

            List<Job_Application__c> closedJobs = new List<Job_Application__c>();

            for (Job_Application__c updateJobs : staleJobs){
                updateJobs.Status__c = 'Closed';
                updateJobs.Notes__c = 'This Job Application has not been updated in more than 30 days and was closed by an automation.';
                closedJobs.add(updateJobs);    
            }

                update closedJobs;
                System.debug(closedJobs);
        }

<<<<<<< HEAD
=======
            Interview__c interview = new Interview__c(
            Name = 'Test Interview 10-26-23',
            Interview_Date__c = System.today().addDays(1),
            Company_Name__c = 'Test Company'
        );
        insert interview;
        

        Date interviewDate = Date.today().addDays(1);
        List<Interview__c> interviews = [SELECT Id, Name, Interview_Date__c, Company_Name__c, Owner.Email FROM Interview__c WHERE Interview_Date__c = :interviewDate];
    
        // Check if there are interviews scheduled for tomorrow
        if (!interviews.isEmpty()) {
            for (Interview__c interview : interviews) {
                // Get the email address from the Owner's Email field
                String recipientEmail = (interview.Owner != null) ? interview.Owner.Email : null;
    
                try {
                    // Create and send email
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] { 'therontroxel@gmail.com' });
                    mail.setSubject('Interview Reminder');
                    mail.setPlainTextBody('This is a reminder of your interview scheduled for ' + interview.Interview_Date__c + ' at ' + interview.Company_Name__c);
    
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
                } catch (Exception e) {
                    System.debug('Error sending email: ' + e.getMessage());
                }
            }
        }
    
>>>>>>> f3e86954d49d09f2feec5f23ef803e688f435042
