public with sharing class JoobleCallout {

   // @Future(callout=true)
    public static String postJoobleCallout(){
        
            Http postCall = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3');
            request.setHeader ('Content-type', 'application/json');
            request.setMethod('POST');
            request.setBody('{"keywords": "Jr Salesforce Dev", "location": "Dallas, TX"}');
            
            HttpResponse response = postCall.send(request);

            String newJobs = (response.getBody());

            return newJobs;
        }
    

    public static Job_Application__c createJobsFromJson(String newJobs) {
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(newJobs);

        List<Map<String, Object>> allMaps = new List<Map<String, Object>>();
        for (Object jobPost : jobList){
            allMaps.add()
        }

        Job_Application__c newJob = new Job_Application__c();
            newJob.Position_Title__c = (String) jsonMap.get('title');
            newJob.Work_Location__c = (String) jsonMap.get('location');
            newJob.Description__c = (String) jsonMap.get('snippet');
            newJob.Salary__c = (Decimal) jsonMap.get('salary');
            newJob.Website_Posting__c = (String) jsonMap.get('source');
            newJob.Notes__c = (String) jsonMap.get('type');
            newJob.Link__c = (String) jsonMap.get('link');
            newJob.Company_Name__c = (String) jsonMap.get('company');
            newJob.Job_Posted_Date__c = (Datetime) jsonMap.get('updated');
            newJob.External_Job_Id__c = (String) jsonMap.get('id');
            
        return newJob;
    }

}


    
     