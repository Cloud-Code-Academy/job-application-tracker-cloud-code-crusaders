public with sharing class JoobleCallout {

 // @Future(callout=true)

    public static String postJoobleCallout(){
        
            List<Contact> jobList = new List <Contact>();
        
            Http postCall = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3');
            request.setHeader ('Content-type', 'application/json');
            request.setMethod('POST');
            request.setBody('{"keywords": "Jr Salesforce Dev", "location": "Dallas, TX"}');
            
            HttpResponse response = postCall.send(request);

            String newJobs= response.getbody().replaceAll('\n','').replaceAll('\r',''); //scrubs job posting of illegal characters
           return newJobs;
    }

    
    public static String createJobsFromJson(){
    String newJobs;
        List<Object> jsonList = (List<Object>)JSON.deserializeUntyped(newJobs);
        List<Job_Postings__c> jobsToCreate =  new List<Job_Postings__c>();
        
        for (Object obj : jsonList) {
            Map<String, Object> jsonMap = (Map<String, Object>)obj;
            Job_Postings__c record = new Job_Postings__c();
            record.Title__c = (String) jsonMap.get('title');
            record.Location__c = (String) jsonMap.get('location');
            record.Snippet__c = (String) jsonMap.get('snippet');
           // record.Salary__c = (String) jsonMap.get('salary');
            record.Source__c = (String) jsonMap.get('source');
            record.Type__c = (String) jsonMap.get('type');
            record.Link__c = (String) jsonMap.get('link');
            record.Company__c = (String) jsonMap.get('company');
            record.Updated__c = (Datetime) jsonMap.get('updated');
           // record.External_Job_Id__c = (String) jsonMap.get('id');
            jobsToCreate.add(record);
    }

            if(!jobsToCreate.isEmpty()){
            insert jobsToCreate;
            }
            return null;

        }
}


    
     