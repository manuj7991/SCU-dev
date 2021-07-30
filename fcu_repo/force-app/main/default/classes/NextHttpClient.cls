public with sharing class NextHttpClient {
    
    public static HttpRequest buildNextRequest(String requestType, string jSonBody, String method){
        Mulesoft_NEXT_Web_Service_Setting__mdt objMtd=Mulesoft_NEXT_Web_Service_Setting__mdt.getInstance('NEXT_Real_TIME_API');
        String clientId =objMtd.client_id__c;
        String clientSecret=objMtd.client_secret__c;
        String mulesoftNEXTURL=objMtd.MulesoftNextURL__c;
        if (requestType == 'SendOffer')
            mulesoftNEXTURL = mulesoftNEXTURL +'/offers/reply';
        http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(mulesoftNEXTURL);
        request.setMethod(method);   
        request.setHeader('Content-Type', 'application/json');
        if(clientId != null && clientSecret != null){
        request.setHeader('client_id', clientId);
        request.setHeader('client_secret', clientSecret);}
        request.setbody(jSonBody);
        return request;
    }


    public static HttpResponse CallNextAPI(String requestType, string jSonBody){
        
        Http http = new Http();
        HttpRequest request = NextHttpClient.buildNextRequest(requestType, jSonBody, 'POST');
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
        } 
        else {   
            System.debug('Call successful');
            System.debug(response.getBody());
        }
        return response;
    }
        
    
}