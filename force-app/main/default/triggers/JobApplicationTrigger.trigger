trigger JobApplicationTrigger on Job_Application__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            for (Job_Application__c newJob : Trigger.new) {
                Job_Application__c oldJob = Trigger.oldMap.get(newJob.Id);
                
                
                PrimaryContactHandler.setPrimaryContact(newJob, oldJob);
            }
        }
    }
}

