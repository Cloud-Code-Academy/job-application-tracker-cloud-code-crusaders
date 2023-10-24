// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

    // Create and send email
    Interview__c interviewRecord = [SELECT Interview_Date__c, Company_Name_c FROM Interview__c WHERE Id = 'a01Ho00001kLYOiIAO']; // interviewId is the specific interview record's Id

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(new String[] { 'therontroxel@gmail.com' });
    mail.setSubject('Interview Reminder');
    mail.setPlainTextBody('This is a reminder of your interview scheduled for ' + interviewRecord.Interview_Date__c + ' with ' + interviewRecord.Company_Name_c);
    
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
