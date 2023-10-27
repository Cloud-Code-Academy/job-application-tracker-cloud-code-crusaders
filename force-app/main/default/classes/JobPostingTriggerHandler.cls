public with sharing class JobPostingTriggerHandler {
    
  /* public static void createJobsFromJson(String newJobs){

    List<Object> jsonList = (List<Object>)JSON.deserializeUntyped(newJobs);
    List<Job_Postings__c> jobsList =  new List<Job_Postings__c>();
    
    for (Object obj : jsonList) {
        Map<String, Object> jsonMap = (Map<String, Object>)obj;
        //String title = (String) jsonMap.get('title');
        //if (title.toLowerCase().contains('Salesforce')) {
            Job_Postings__c record = new Job_Postings__c();
            record.Title__c = (String) jsonMap.get('title');
            record.Location__c = (String) jsonMap.get('location');
            record.Snippet__c = (String) jsonMap.get('snippet');
            record.Salary__c = (String) jsonMap.get('salary');
            record.Source__c = (String) jsonMap.get('source');
            record.Type__c = (String) jsonMap.get('type');
            record.Link__c = (String) jsonMap.get('link');
            record.Company__c = (String) jsonMap.get('company');
            // record.Updated__c = (Datetime) jsonMap.get('updated');
           // record.External_Job_Id__c = (String) jsonMap.get('id');
        jobsList.add(record);
        }
        insert jobsList;


 /*  List<Job_Postings__c> jobsToCreate = new List<Job_Postings__c>();
   for (Job_Postings__c filterJobs : jobsList) {
            if ((!jobsList.isEmpty()) && (filterJobs.Title__c.contains('Salesforce'))){
            Database.SaveResult[] jobsToCreate = Database.insert(jobsList, false);//jobsToCreate.add(filterJobs);
            }
    }*/
/*for(Database.SaveResult sr : jobsToCreate){
                    if(!sr.isSuccess()){
                        for(Database.Error err : sr.getErrors()){
                            System.debug(err.getMessage());
                        }
                    }*/
                
            }           // insert jobsToCreate;