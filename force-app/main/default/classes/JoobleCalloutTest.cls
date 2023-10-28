@isTest
global class JoobleCalloutTest{

    global HTTPResponse respond(HTTPRequest req) {
        string body = '"totalCount":1262,"jobs":{[{"title":"Salesforce Project Manager","location":"Dallas, TX","snippet":"&nbsp;...quality and track project health to ensure customer satisfaction.\n\nKey Responsibilities Include\n\n* Plan, lead and control complex <b>Salesforce </b>projects and related personnel utilizing project methodologies and related tools to bring projects to successful completion,...&nbsp;","salary":"","source":"myjobhelper.com","type":"","link":"https://jooble.org/desc/-5428090040033836274?ckey=Jr+Salesforce+Dev&rgn=45973&pos=1&elckey=2060224854152013037&p=1&aq=4283254144694447683&cid=3047&jobAge=68&relb=175&brelb=115&bscr=4543.904&scr=6914.636521739131","company":"Crowe Horwath","updated":"2023-10-23T12:40:20.2070000","id":-5428090040033836274},{"title":"Lead Salesforce CDP Developer","location":"Irving, TX","snippet":"&nbsp;...-generating and cost-saving results. \r\n Brief Description of Role  : \r\n We are looking for an experienced <b>Salesforce </b>Lead Developer who will play the role as a <b>dev </b>lead and also a hands-on developer to manage the implementation, development, and operations of Salesforce...&nbsp;","salary":"","source":"jobleads.com","type":"","link":"https://jooble.org/desc/815269524476555491?ckey=Jr+Salesforce+Dev&rgn=45973&pos=2&elckey=2060224854152013037&p=1&aq=4283254144694447683&cid=3047&jobAge=44&relb=148&brelb=115&bscr=5072.165&scr=6527.655826086957","company":"Epsilon Data Interactive, Inc.","updated":"2023-10-24T00:00:00.0000000","id":815269524476555491},{"title":"Salesforce Solution Architect","location":"Dallas, TX","snippet":"&nbsp;...difference as we develop scalable solutions to support our global growth, we want to hear from you! \r\n The Opportunity: \r\n \r\n As the <b>Salesforce </b>Solution Architect, you will plan the architecture and solution design of a collection of systems in a large technology ecosystem...&nbsp;","salary":"","source":"jobget.com","type":"","link":"https://jooble.org/desc/4667321285628589135?ckey=Jr+Salesforce+Dev&rgn=45973&pos=3&elckey=2060224854152013037&p=1&aq=4283254144694447683&cid=3047&jobAge=68&relb=148&brelb=115&bscr=4630.4395&scr=5959.174313043479","company":"Fisher Investments","updated":"2023-10-23T00:00:00.0000000","id":4667321285628589135}]}';
       HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        res.setStatusCode(200);

        String results = body;

        return res;
    } 
    
    @isTest
    public static void createJobsFromJsonTest() {
        
        Test.startTest();
        JoobleCallout.createJobsFromJson('Test');
        Test.stopTest();
         
        List<Job_Postings__c> jobsToInsert = [
            SELECT title__c
            FROM Job_Postings__c
            ];
        system.assertEquals(true, !jobsToInsert.isEmpty());
        
    }
}