global class InterviewEmail implements Schedulable {
    global void execute(SchedulableContext sc) {
        sendReminderEmail();
    }

    public static void sendReminderEmail() {
        // Query the Interview records with Interview Date one day before today
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
                    mail.setToAddresses(new String[] { recipientEmail });
                    mail.setSubject('Interview Reminder');
                    mail.setPlainTextBody('This is a reminder of your interview scheduled for ' + interview.Interview_Date__c + ' at ' + interview.Company_Name__c);
    
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
                } catch (Exception e) {
                    System.debug('Error sending email: ' + e.getMessage());
                }
            }
        }
    }
    
}

