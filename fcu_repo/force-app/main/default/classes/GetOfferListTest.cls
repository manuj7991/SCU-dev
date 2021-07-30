@istest
public class GetOfferListTest {
    @testsetup
    Public static void AddofferTest(){
        OfferTriggerHandler.TriggerDisabled = true;
        Offer__C off = new offer__c(id__C='1', Name = 'Myoffer',RecordTypeId=Schema.SObjectType.Offer__c.getRecordTypeInfosByName().get('Service CU Offer for Business').getRecordTypeId());
        insert off;
    }
    @isTest
    private static void GetOffertest() {
        test.startTest();
        List<offer__c> off_lst = GetOfferList.GetOffer();
        test.stopTest();
        system.assertEquals(0, off_lst.size());
    } 
    
}