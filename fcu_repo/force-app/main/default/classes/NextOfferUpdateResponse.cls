Public class NextOfferUpdateResponse{
@InvocableMethod
    Public static void submitResponse(list<offer__c> offers){
     System.debug('Submit Response Called');
        
        if (offers != null){
            for(Offer__c offer : offers ){
             System.debug('Offer object from the call:'+ offer);
             Account acc = [Select Id, DNA_Cust_Key__c from account where Id =:offer.Account__c limit 1];
             NextOfferProxy.SubmitOfferToDNAResponse(offer.id, acc.DNA_Cust_Key__c);
            }
          }
        }
    }