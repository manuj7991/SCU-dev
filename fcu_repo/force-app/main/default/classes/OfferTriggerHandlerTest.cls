@isTest
public class OfferTriggerHandlerTest {
  @TestSetup 
    private static void setupTestData()
    {
        TestUtil.createBusinessAccountData(1,true, true);
        List<Account> acc = [SELECT Id , Name ,  RecordTypeId, DNA_Cust_KEy__c FROM Account where DNA_Cust_KEy__c like '%P%' LIMIT 1 ]; 
        Offer__c offer = new Offer__c();
        OfferTriggerHandler.TriggerDisabled = true;
        System.debug('acc:'+acc[0]);
        offer.Account__c =acc[0].Id;
        offer.End_Date__c = System.today() - 1;       
     	offer.Name='TestOffer';
    	offer.id__c ='1';
    	system.debug('offer data: '+offer);
        insert offer;
        
    }
    @isTest
    public static void TestBeforeUpdateMethod(){
         OfferTriggerHandler offerHandler = new  OfferTriggerHandler();
        OfferTriggerHandler.TriggerDisabled = false;
        List<Offer__c> offer = [Select id,Name,Account__c from Offer__c where Name='TestOffer'];
        //offer[0].Name ='TestOfferUpdate';
        Test.startTest();
        offerHandler.beforeInsert(offer);
        offerHandler.afterInsert(offer,null);
        offerHandler.beforeUpdate(offer,null,null,null);
        offerHandler.afterUpdate(offer,null,null,null);
        offerHandler.beforeDelete(offer,null);
        offerHandler.afterDelete(offer,null);
        offerHandler.afterUnDelete(offer,null);
        
        Test.stopTest();
        
    }
}