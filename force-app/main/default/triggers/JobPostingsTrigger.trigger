trigger JobPostingsTrigger on Job_Postings__c (after update) {

    switch on Trigger.operationType{

        when AFTER_UPDATE {
            JoobleCallout.postJoobleCallout(Trigger.new);
        }
    }

}