public with sharing class JoobleCallout {
   
    private final static String authToken = '2a3be2fb-3555-410e-924b-8e2c964de9d3';
    private final static String sEndpoint = 'callout:Jooble_Job_Board';
    private final static Integer iTimeout = 20000;


    public static String searchCallout(String sParameter, String sResource){
        String theEndpoint = sEndpoint + '/+' + authToken;
        HttpRequest theRequest = new HttpRequest();
        theRequest.setMethod('POST');
        theRequest.setEndpoint(theEndpoint + '&query=' +
        EncodingUtil.urlEncode(sParameter, 'UTF-8'));
        theRequest.setTimeout(iTimeout);
        
        // perform the callout
        Http oHttp = new Http();
        HttpResponse theResponse = new HttpResponse();
        theResponse = oHttp.send(theRequest);
        return theResponse.getBody();
   }
}


   