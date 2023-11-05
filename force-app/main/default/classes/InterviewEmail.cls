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


/**
 * Purpose: Retrieve interviews scheduled for tomorrow and send email reminders to interviewees.
 */
public class InterviewReminder {

    public static List<Event> getTomorrowsInterviews() {
        // Calculate start and end of tomorrow's date
        DateTime startOfTomorrow = DateTime.newInstance(Date.today().addDays(1), Time.newInstance(0, 0, 0, 0));
        DateTime endOfTomorrow = DateTime.newInstance(Date.today().addDays(1), Time.newInstance(23, 59, 59, 0));
        
        // Query events for interviews scheduled for tomorrow
        List<Event> interviews = [SELECT Id, Subject, StartDateTime, EndDateTime, Location, OwnerId
                                  FROM Event 
                                  WHERE StartDateTime >= :startOfTomorrow 
                                  AND StartDateTime <= :endOfTomorrow 
                                  AND Type = 'Interview'];

        return interviews;
    }

    /**
     * Sends email reminders to the interviewees about the scheduled interviews.
     */
    public static void sendEmailReminders(List<Event> interviews) {
        // List to hold the email messages to send
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        // Set to store unique OwnerIds of the interviews
        Set<Id> ownerIds = new Set<Id>();
        for(Event interview : interviews) {
            ownerIds.add(interview.OwnerId);
        }

        // Query to retrieve details of users based on the OwnerIds
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id, Name, Email FROM User WHERE Id IN :ownerIds]);

        // Get the base URL of Salesforce instance
        String baseURL = Url.getSalesforceBaseUrl().toExternalForm();

        // Loop through the interviews to prepare email messages
        for(Event interview : interviews) {
            User eventOwner = usersMap.get(interview.OwnerId);
            
            // Check if the event owner (Interviewee) exists and has an email address
            if(eventOwner != null && eventOwner.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {eventOwner.Email});
                mail.setSubject('Interview Reminder');
            
                String interviewee = (eventOwner != null) ? eventOwner.Name : 'N/A';

                // Prepare the body of the email with interview details
                String body = 'Hello ' + interviewee + ',\n\n' + 
                              'This is a reminder about the interview scheduled at ' + interview.StartDateTime.format() + ' to ' + interview.EndDateTime.format() + '.\n\n' +
                              'For more details, view the interview: (' + baseURL + '/' + interview.Id + ').';
                mail.setPlainTextBody(body);

                // Add the prepared email to the emails list
                emails.add(mail);
            }
        }

        // If there are any emails to send, attempt to send them
        if(emails.size() > 0) {
            Messaging.sendEmail(emails);
        }
    }
}
