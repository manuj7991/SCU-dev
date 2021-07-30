public class ServiceCUNextCallout {
    
    @AuraEnabled    
    public static String getCalloutResponseContents(){
        Mulesoft_NEXT_Web_Service_Setting__mdt objMtd=Mulesoft_NEXT_Web_Service_Setting__mdt.getInstance('NEXT_Mulesoft_Config');
        String clientId =objMtd.client_id__c;
        String clientSecret=objMtd.client_secret__c;
        String memberId='P5555';
        String mulesoftNEXTURL=objMtd.URL__c+memberId ;
        ServiceCUNextOffers newOffersInstance;
         
                http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(mulesoftNEXTURL);
                request.setMethod('GET');   
                request.setHeader('Content-Type', 'application/json');
                if(clientId != null && clientSecret != null){
                request.setHeader('client_id', clientId);
                request.setHeader('client_secret', clientSecret);}
                HttpResponse response = new HttpResponse();
                    if(!Test.isRunningTest()){
                        response = http.send(request);
                        String ServiceCUNextOffersJSON = response.getBody();
             		   newOffersInstance = (ServiceCUNextOffers)JSON.deserialize(ServiceCUNextOffersJSON,                                        
                		ServiceCUNextOffers.class);                    
                    System.debug(response.getStatusCode());
                /*if (response.getStatusCode() != 200) {
                    System.debug('The status code returned was not expected: ' +
                                 response.getStatusCode() + ' ' + response.getStatus());
                } 
                else  
                {
                    
                    System.debug(response.getStatusCode()+response.getBody());
                } */
               
          }
          else
          {
              newOffersInstance = mockGetOffers();
          }
        System.debug(newOffersInstance.GetOffersResult);
        ServiceCUNextOffers.Offers ObjOffers =  newOffersInstance.GetOffersResult.Offers;
        String memId =  newOffersInstance.GetOffersResult.MemberID;   
        System.debug('memberId'+memId);
        List<Account> acc = [Select Id, DNA_Cust_Key__c from account where DNA_Cust_Key__c =:memId limit 1];
        List<ServiceCUNextOffers.Offer> InsertlstOffers = new List<ServiceCUNextOffers.Offer>() ;
        List<ServiceCUNextOffers.Offer> lstOffers = ObjOffers.Offer;
        List<Offer__c> lstOffer=new List<Offer__c> ();
        
        for(ServiceCUNextOffers.Offer objOffer : lstOffers){
            system.debug('---1---'+objOffer.ID);
            system.debug('---1---'+objOffer.Name);
            system.debug('---1---'+objOffer.Description);
            system.debug('---1---'+objOffer.Type);
            system.debug('---1---'+acc[0].Id);

            system.debug('---1---'+objOffer.ComplexPresentation.IsPriority);
            Date startdt = Date.valueOf(objOffer.StartDate);
            System.debug(startdt);
            DateTime startdtt = DateTime.newinstance(startdt.year(), startdt.month(), startdt.day());
            System.debug(startdtt);
            String startdateOutput = startdtt.format('yyyy-MM-dd');
            Date enddt = Date.valueOf(objOffer.EndDate);
            System.debug(enddt);
            DateTime enddtt = DateTime.newinstance(enddt.year(), enddt.month(), enddt.day());
            System.debug(enddtt);
            String enddateOutput = enddtt.format('yyyy-MM-dd');
            Offer__c obj = new Offer__c(id__c=objOffer.ID, Name=objOffer.Name, Description__c=objOffer.Description, Account__c=acc[0].Id,Is_Priority_Offer__c=objOffer.ComplexPresentation.IsPriority,Start_date__c=Date.valueof(startdateOutput),End_date__c=Date.valueof(enddateOutput));
           lstOffer.add(obj);          
        }
        try {
        	upsert lstOffer id__c ;
        }
        catch(DmlException e) {
        	System.debug('The following exception has occurred: ' + e.getMessage());
        }    
         return 'Success';		
}	
    
    private static ServiceCUNextOffers mockGetOffers(){
         List<Test_Data_For_JSON_Response__mdt> listOfDta = [SELECT MasterLabel,Id,JSON_Response__c from Test_Data_For_JSON_Response__mdt Where MasterLabel =:'NEXTGETOFFERS'];
         ServiceCUNextOffers newOffersInstance = (ServiceCUNextOffers)JSON.deserialize(listOfDta[0].JSON_Response__c, ServiceCUNextOffers.class);
         return newOffersInstance;
    }
    
    
}