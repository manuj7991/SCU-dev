public with sharing class DNAHttpClient {
    
    public static HttpRequest buildHttpRequestInstance(String httpMethod, String dnaProxyURL){
       
        HttpRequest request = new HttpRequest();
        if(dnaProxyURL == null){
            request.setEndpoint(Label.DNAPROXY_API_URL);
        }else{
            request.setEndpoint(dnaProxyURL);
        }
        request.setMethod(httpMethod);
        request.setHeader('client_secret', Label.DNA_PROXY_CLIENT_SECRET);
        request.setHeader('client_id', Label.DNA_PROXY_CLIENT_ID);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        return request;
    }


    public static HttpResponse getAPI(String dnaGETURL){
        Http http = new Http();
        HttpRequest request = DNAHttpClient.buildHttpRequestInstance('GET', dnaGETURL);
        system.debug('request:'+ request);
        HttpResponse response = http.send(request);
        system.debug('Response Body:'+ response.getBody());
        return response;
    }        
    
     public static HttpRequest buildRequest(String requestType, string jSonBody, String dnaProxyURL){
        HttpRequest request = new HttpRequest();
        if(dnaProxyURL == null){
            request.setEndpoint(Label.DNAPROXY_API_URL);
        }else{
            request.setEndpoint(dnaProxyURL);
        }
        request.setMethod(requestType);
        request.setHeader('client_secret', Label.DNA_PROXY_CLIENT_SECRET);
        request.setHeader('client_id', Label.DNA_PROXY_CLIENT_ID);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(jSonBody);
         system.debug('request'+request);
        return request;
    }


    public static HttpResponse CallDNAAPI(String dnaProxyURL, string jSonBody, string requestType){
        System.debug('Called u');
        Http http = new Http();
        HttpRequest request = DNAHttpClient.buildRequest(requestType, jSonBody, dnaProxyURL);
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