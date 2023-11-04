@isTest
global class JoobleCalloutMockGenerator implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"title":"Salesforce Project Manager","location":"Dallas, TX"}');
        res.setStatusCode(200);
        return res;
    }
}