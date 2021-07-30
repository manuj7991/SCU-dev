public with sharing class NextOfferProxy{

   
    @future(callout=true)
    public static void SubmitOfferToDNAResponse(string offerid, string memberId){
         System.debug('Next Offer Proxy SubmitOfferResponse called');
        boolean isSuccess = false;
  		
        Offer__C offer = [SELECT id, id__C, presentation_Id__C, Session_ID__c, account__C, offer_Response__c, Description__C from Offer__c where id =: offerid];
        system.debug('Offer object from db:' + offer);
        offer.offer_Response__c = 'Yes Fulfill' ;
      	offer.Presentation_Id__c = '1';
        offer.Session_Id__c = '450ea625-e236-46dc-b905-c43a865f486b';
        SubmitOfferRequest request = new SubmitOfferRequest(offer);
        string jsonS = JSON.serialize(request);
        System.debug('myjoson:' + jsonS);
        SubmitOfferResponse offerResponseFromDNA;
        if(!Test.isRunningTest()){
        HttpResponse response = NextHttpClient.CallNextAPI('SendOffer', jsonS);
        system.debug('Response from HTTP Call:'+ response);
            if (response.getStatusCode() == 200) {
           		system.debug('Call successful');
                system.debug(response.getBody());
                
                SubmitOfferResponse newSubmitOfferResponse = (SubmitOfferResponse)JSON.deserialize(response.getBody(),                                        
        SubmitOfferResponse.class);
                system.debug(newSubmitOfferResponse.SendOfferReplyResult.Status.StatusDesc);
               if (newSubmitOfferResponse.SendOfferReplyResult.Status.StatusDesc.trim() == 'Success.')
               {
                   isSuccess = true;
               }
            }
        }
        else
        {
           
            isSuccess = true;
        }
        System.debug('isSuccess :' + isSuccess);
        if (isSuccess == false)
        {
            CalloutException e = new CalloutException();
			e.setMessage('Could not Submit Next Response.');
			throw e;
        }
       
       
    }

}