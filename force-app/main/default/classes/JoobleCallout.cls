public with sharing class JoobleCallout {

   @Future(callout=true)

    public static void postJoobleCallout(){
        
            Http postCall = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3');
            request.setHeader ('Content-type', 'application/json');
            request.setMethod('POST');
            request.setBody('{"keywords": "Jr Salesforce Dev", "location": "Dallas, TX"}');
            
            HttpResponse response = postCall.send(request);

            String newJobs = (response.getBody());

           // return newJobs;
        }

public static fromJSON parse(String newJobs){
    return (fromJSON) System.JSON.deserialize(newJobs, fromJSON.class);
}

}

    

   /* public static Job_Postings__c createJobsFromJson(String newJobs) {
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(newJobs);
        


        Job_Postings__c newJob = new Job_Postings__c();
            newJob.Title__c = (String) jsonMap.get('title');
            newJob.Location__c = (String) jsonMap.get('location');
            newJob.Snippet__c = (String) jsonMap.get('snippet');
            newJob.Salary__c = (Decimal) jsonMap.get('salary');
            newJob.Source__c = (String) jsonMap.get('source');
            newJob.Type__c = (String) jsonMap.get('type');
            newJob.Link__c = (String) jsonMap.get('link');
            newJob.Company__c = (String) jsonMap.get('company');
            newJob.Updated__c = (Datetime) jsonMap.get('updated');
            newJob.External_Job_Id__c = (String) jsonMap.get('id');
            
            return newJob;
    }

    for(Job_Posting__c jobsToPost : newJob)
    
    if {
        
    }

}*/


    
     