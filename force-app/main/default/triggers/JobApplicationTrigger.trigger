trigger JobApplicationTrigger on Job_Application__c (after insert, after update) {

    /* Creates automation on the Job_Application__c object with the following requirements:
        Application Status Automation
            Create automation to create tasks when job application status is changed. Each task should have a due date, subject, and priority, making it easier to track what needs to be done and when. 

            Generate the following task records based on the application status
            SAVED
            Check if the job description aligns with your interests and values
            Review the highlighted skills to see if the role is a good fit
            Research the company or role and mark your excitement level
            APPLYING
            Find and research someone who works at the company and add them as a contact
            Set up an informational interview to learn more about the role/company
            Identify potential referrals to help get your application on the top of the pile
            Customize your work achievements using the job description keywords
            Submit your application on the company website if possible
            APPLIED
            Reach out to the hiring manager or recruiter
            Follow up on your application via email weekly
            Continue identifying and saving similar job opportunities
            Set up weekly networking calls to explore similar companies/roles
            INTERVIEWING
            Prepare your blurb or “tell me about yourself” response
            Practice answering behavioral interview questions
            Research the company and your interviewers
            Set up your virtual interview space and test your tech
            Send thank you emails within 24 hours
            NEGOTIATING
            Research your market value and know your numbers
            Prepare your negotiation scripts
            Evaluate your offer and decline or accept
            ACCEPTED
            Plan your resignation if applicable
            Take some time to relax and recharge
            Prepare for your first day of onboarding
            CLOSED
            Send a follow-up email thanking the interviewer and asking for feedback
            Review your notes and reflect on areas of improvement */

        JobApplicationTriggerHandler.updateTask(Trigger.new);

}