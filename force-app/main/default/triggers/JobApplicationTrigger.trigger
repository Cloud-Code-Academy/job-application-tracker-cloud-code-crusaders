trigger JobApplicationTrigger on Job_Application__c (after insert, after update) {
    switch on Trigger.operation.Type {

        when AFTER_INSERT {
            JobApplicationTriggerHandler.updateTask(Trigger.new);

        }

        when AFTER_UPDATE {
            JobApplicationTriggerHandler.updateTask(Trigger.new);
        }
    }
        
}