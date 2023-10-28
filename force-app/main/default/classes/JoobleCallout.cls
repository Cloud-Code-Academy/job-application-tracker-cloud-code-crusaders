public with sharing class JoobleCallout {

@future(callout=true)

        public static void postJoobleCallout(){
                
                Http postCall = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3');
                request.setHeader ('Content-type', 'application/json');
                request.setMethod('POST');
                request.setBody('{"keywords": "Jr Salesforce Dev", "location": "Dallas, TX"}');
                
                HttpResponse response = postCall.send(request);
                
                if (response.getStatusCode() == 200){    

                String newJobs = response.getbody();
                }
        }

       public static List<Job_Postings__c> createJobsFromJson(String newJobs){
                Map<String, Object> parsedJobs = (Map<String,Object>)JSON.deserializeUntyped(newJobs);
                List<Job_Postings__c> jobsToInsert =  new List<Job_Postings__c>();
                if(parsedJobs.containsKey('jobs')){
                         List<Object> jobsList = (List<Object>)parsedJobs.get('jobs');

                for (Object obj : jobsList) {
                        if(obj instanceof Map<String,Object>){
                Map<String, Object> jsonMap = (Map<String, Object>)obj;
                        Job_Postings__c record = new Job_Postings__c();
                        record.Title__c = (String) jsonMap.get('title');
                        record.Location__c = (String) jsonMap.get('location');
                        record.Snippet__c = (String) jsonMap.get('snippet');
                        record.Salary__c = (String) jsonMap.get('salary');
                        record.Source__c = (String) jsonMap.get('source');
                        record.Type__c = (String) jsonMap.get('type');
                        record.Link__c = (String) jsonMap.get('link');
                        record.Company__c = (String) jsonMap.get('company');
                        jobsToInsert.add(record);
                        }
                }
        
        
                if (!jobsToInsert.isEmpty()){

                insert jobsToInsert;
                }     
        }
                 return jobsToInsert;

        }
}

    



    
     