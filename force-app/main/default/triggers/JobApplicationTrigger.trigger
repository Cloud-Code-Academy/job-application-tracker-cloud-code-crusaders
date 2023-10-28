trigger JobApplicationTrigger on Job_Application__c (before insert, before update, after insert, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            // Call the PrimaryContactHandler to update the Primary Contact
            for (Job_Application__c newJob : Trigger.new) {
                Job_Application__c oldJob = Trigger.isUpdate ? Trigger.oldMap.get(newJob.Id) : null;
                PrimaryContactHandler.setPrimaryContact(newJob, oldJob);
            }
        }
    } else if (Trigger.isAfter && Trigger.isUpdate) {
        // Call the JobApplicationTriggerHandler in the AFTER_UPDATE context
        JobApplicationTriggerHandler.updateTask(Trigger.new);
    }
}