@isTest
private class JoobleCalloutTest{

    @isTest 
    static void testCallout(){

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"title":"Salesforce Project Manager","location":"Dallas, TX"}');
        res.setStatusCode(200);
        
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new JoobleCalloutMockGenerator());

        JoobleCallout.postJoobleCallout();      
        Test.stopTest();

        System.assertEquals(200, res.getStatusCode());
    
    }
}

