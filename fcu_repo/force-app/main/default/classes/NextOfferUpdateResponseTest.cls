@istest
public class NextOfferUpdateResponseTest {
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
    private static void submitResponseTest() {
        List<Offer__C> offers =  [SELECT id__c , Account__c , offer_response__C  , Description__c FROM Offer__C  LIMIT 1 ];
        system.debug('Offers:' + offers);
        test.startTest();
        NextOfferUpdateResponse.submitResponse(offers);
        Integer callouts = Limits.getCallouts();
        test.stopTest();
        system.debug('callouts : ' + callouts);
        System.assertEquals(0, callouts, 'No callout was made');
    }

}