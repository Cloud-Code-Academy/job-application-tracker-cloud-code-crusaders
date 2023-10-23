//System.debug(JoobleCallout.postJoobleCallout());


String newJobs = '[{"title":"Salesforce Project Manager","location":"Dallas, TX","snippet":"&nbsp;...quality and track project health to ensure customer satisfaction.\n\nKey Responsibilities Include\n\n* Plan, lead and control complex <b>Salesforce </b>projects and related personnel utilizing project methodologies and related tools to bring projects to successful completion,...&nbsp;","salary":"","source":"myjobhelper.com","type":"","link":"https://jooble.org/desc/-4077849807177910900?ckey=Jr+Salesforce+Dev&rgn=45973&pos=1&elckey=-6836077299002331819&p=1&aq=7565889655831231429&cid=3047&jobAge=116&relb=175&brelb=115&bscr=4455.166&scr=6779.600434782609","company":"Crowe Horwath","updated":"2023-10-18T00:00:00.0000000","id":-4077849807177910900},{"title":"Learning and Dev Consultant","location":"Dallas, TX","snippet":" Press Tab to Move to Skip to Content Link \r\n Category: Corporate and Professional Jobs \r\n Job Type: Day \r\n Schedule Type: Full-Time \r\n Requisition ID: 932516 \r\n Interested in a career with both meaning and growth? Whether your abilities are in direct patient care or one...","salary":"","source":"jobleads.com","type":"","link":"https://jooble.org/desc/4454806295033274670?ckey=Jr+Salesforce+Dev&rgn=45973&pos=2&elckey=-6836077299002331819&p=1&aq=7565889655831231429&cid=3047&jobAge=20&relb=147&brelb=115&bscr=5224.6206&scr=6678.428071304348","company":"Parkland Health & Hospital System","updated":"2023-10-22T00:00:00.0000000","id":4454806295033274670},{"title":"Dev Ops Business Systems Analyst","location":"Dallas, TX","snippet":"&nbsp;...Location:  Dallas, TX \r\n Salary:  Negotiable \r\n Description:  Our client is currently seeking a Business Systems Analyst who has worked in <b>Dev </b>Ops with CI/CD experience. . Work can be done in Dallas or Chicago. This is a 6 month + contract. \r\n Please call me at (***) ***-****...&nbsp;","salary":"","source":"appcast.io","type":"","link":"https://jooble.org/desc/-4119063153471256214?ckey=Jr+Salesforce+Dev&rgn=45973&pos=3&elckey=-6836077299002331819&p=1&aq=7565889655831231429&cid=3047&jobAge=92&relb=162&brelb=115&bscr=4734.4634&scr=6669.418006956522","company":"The Judge Group","updated":"2023-10-19T00:00:00.0000000","id":-4119063153471256214},{"title":"Salesforce Engineer","location":"University Park, TX","snippet":"&nbsp;...Job Summary: \r\n\r\n Dexian is seeking a <b>Salesforce </b>Engineer ( Hybrid 2 days) for an opportunity with a client in University Park Texas. \r\n\r\n Responsibilities: \r\n Meeting with project managers to determine CRM needs \r\n Developing customized solutions within the Salesforce...&nbsp;","salary":"","source":"Careerbuilder.com","type":"","link":"https://jooble.org/desc/-6722983532279012374?ckey=Jr+Salesforce+Dev&rgn=45973&pos=4&elckey=-6836077299002331819&p=1&aq=7565889655831231429&cid=3047&jobAge=478&relb=167&brelb=115&bscr=4543.855&scr=6598.4676956521735","company":"Dexian - Signature Consultants","updated":"2023-10-02T21:19:43.8989401+00:00","id":-6722983532279012374}]';

String scrubbedJobs= newJobs.replaceAll('\n','').replaceAll('\r',''); //scrubs job posting of illegal characters

//System.debug(scrubbedJobs);

//System.debug(JoobleCallout.createJobsFromJSON(scrubbedJobs));


        List<Object> jsonList = (List<Object>)JSON.deserializeUntyped(scrubbedJobs);
        List<Job_Postings__c> jobsToCreate =  new List<Job_Postings__c>();
        
        for (Object obj : jsonList) {
            Map<String, Object> jsonMap = (Map<String, Object>) obj;
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
            //record.External_Job_Id__c = (String) jsonMap.get('id');
            jobsToCreate.add(record);
    }

            if(!jobsToCreate.isEmpty()){
            insert jobsToCreate;
            }
