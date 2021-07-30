@isTest
public class SubmitOfferRequestTest {
	 @TestSetup 
    private static void setupTestData()
    {
      	TestUtil.createAccountData(1, true);
        List<Account> acct = [SELECT Id , Name ,  RecordTypeId, DNA_Cust_KEy__c FROM Account where DNA_Cust_KEy__c like '%P%' LIMIT 1 ];
        Offer__c offer = new Offer__C();
        offer.Account__c = acct[0].id;
        offer.id__c = '01234567';
        offer.Offer_Response__c = 'Yes';
        offer.Description__c = 'Offer Accepted';
        OfferTriggerHandler.TriggerDisabled = true;
        insert offer;
        OfferTriggerHandler.TriggerDisabled = false;
    }
   
    @isTest
    private static void submitOfferRequestTest() {
        String json=		'{'+
		'    \"Request\": {'+
		'        \"SessionID\": \"450ea625-e236-46dc-b905-c43a865f486b\",'+
		'        \"MemberID\": \"P12345\",'+
		'        \"OfferID\": \"1\",'+
		'        \"PresentationID\": \"1\",'+
		'        \"ResponseCode\": \"Yes Fulfill\",'+
		'        \"Details\": \"Call Consumer after 5 PM at 555-1212\",'+
		'        \"ContactDetails\": {'+
		'            \"Name\": \"John Doe\",'+
		'            \"Address1\": \"123 Street\",'+
		'            \"Address2\": \"Apt 123\",'+
		'            \"Address3\": null,'+
		'            \"City\": \"Test City\",'+
		'            \"State\": \"IL\",'+
		'            \"Zip\": \"10001\",'+
		'            \"Phone\": \"111-222-3333\",'+
		'            \"Email\": \"test@test.com\"'+
		'        }'+
		'    }'+
		'}'+
		'';
        SubmitOfferRequest obj = SubmitOfferRequest.parse(json);
		System.assert(obj != null);
	}
    
    @isTest
    private static void submitOfferRequestTest2() {
        List<Offer__C> offers =  [SELECT id__c , Account__c , offer_response__C  , Description__c FROM Offer__C  LIMIT 1 ];
        SubmitOfferRequest sor = new SubmitOfferRequest(offers[0], 'P2123');
		System.debug(sor);
	}
    
    
    
}