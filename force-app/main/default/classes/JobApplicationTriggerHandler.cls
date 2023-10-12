public with sharing class JobApplicationTriggerHandler {
    
    public static void updateTask(List<Job_Application__c> newJobList){
        
        List<Task> taskUpdates = new List<Task>();

        if(newJobList.size()> 0){
        for (Job_Application__c jobs : newJobList){
            {
                if (jobs.Status__c == 'Saved'){
                    Task tsk = new Task();
                    tsk.Subject = 'New Saved Job Posting for review!';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Check if the job description aligns with your interests and values.' +'\n' + 'Review the highlighted skills to see if the role is a good fit.' + '\n' + 'Research the company or role and update the priority.';
                    tsk.Priority = 'Normal';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(3);
                    taskUpdates.add(tsk);
                    }
                if (jobs.Status__c == 'Applying'){
                    Task tsk = new Task();
                    tsk.Subject = 'Apply to this Job Posting!';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Find and research someone who works at the company and add them as a contact.' + '\n' +
                    'Set up an informational interview to learn more about the role/company.' + '\n' + 
                    'Identify potential referrals to help get your application on the top of the pile.' + '\n' +
                    'Customize your work achievements using the job description keywords.' + '\n' +
                    'Submit your application on the company website if possible.';
                    tsk.Priority = 'High';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(1);
                    taskUpdates.add(tsk);
                }
                if (jobs.Status__c == 'Applied'){
                    Task tsk = new Task();
                    tsk.Subject = 'Follow up after Job Application submission.';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Reach out to the hiring manager or recruiter.' + '\n' + 'Follow up on your application via email weekly.' + '\n' + 'Continue identifying and saving similar job opportunities.' + '\n' + 'Set up weekly networking calls to explore similar companies/roles.';
                    tsk.Priority = 'High';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(5);
                    taskUpdates.add(tsk);
                }
                if (jobs.Status__c == 'Interviewing'){
                    Task tsk = new Task();
                    tsk.Subject = 'Prepare for upcoming interview';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Prepare your blurb or “tell me about yourself” response.' +'\n' + 'Practice answering behavioral interview questions.' + '\n' + 'Research the company and your interviewers.' + '\n' + 'Set up your virtual interview space and test your tech.' + '\n' + 'Send thank you emails within 24 hours.';
                    tsk.Priority = 'High';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(5);
                    taskUpdates.add(tsk);
                }
                if (jobs.Status__c == 'Negotiating'){
                    Task tsk = new Task();
                    tsk.Subject = 'Review job offer.';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Research your market value and know your numbers.' + '\n' + 'Prepare your negotiation scripts.' + '\n' + 'Evaluate your offer and decline or accept.';
                    tsk.Priority = 'High';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(2);
                    taskUpdates.add(tsk);
                }
                if (jobs.Status__c == 'Accepted'){
                    Task tsk = new Task();
                    tsk.Subject = 'Celebrate and prepare for your new job!';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Plan your resignation if applicable.' + '\n' + 'Take some time to relax and recharge.' + '\n' + 'Prepare for your first day of onboarding.';
                    tsk.Priority = 'Normal';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(10);
                    taskUpdates.add(tsk);
                }
                if (jobs.Status__c == 'Closed'){
                    Task tsk = new Task();
                    tsk.Subject = 'Follow up after application denial';
                    tsk.Status = 'Not Started';
                    tsk.Description = 'Send a follow-up email thanking the interviewer and asking for feedback, if applicable.' + '\n' + 'Review your notes and reflect on areas of improvement.';
                    tsk.Priority = 'Low';
                    tsk.WhatId = jobs.Id;
                    tsk.OwnerId = jobs.OwnerId;
                    tsk.ActivityDate = Date.today().addDays(3);
                    taskUpdates.add(tsk);
                }    
            }
        }
                if(taskUpdates != null && taskUpdates.size()>0)

                insert taskUpdates;
        }
    }

}
