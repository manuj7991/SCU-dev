@isTest
public class ServiceCUNextCalloutTest {
    
     @TestSetup 
    private static void setupTestData()
    {
         	Account acc = new Account();
            acc.FirstName = 'MC';
            acc.LastName = 'MC';
            acc.PersonMailingCity='DEEP DRIVER';
            acc.PersonMailingCountry='USA';
            acc.PersonMailingState='CA';
            acc.PersonMailingStreet='202 S ST';
            acc.PersonMailingPostalCode='12345';
            acc.DNA_Cust_Key__c='5555';
            acc.PersonEmail = 'personalemail' + '@work.com';
            acc.Work_Email__c = 'workemail' + '@work.com';
            acc.PersonHomePhone = '9876542340';
            acc.PersonMobilePhone = '9876542340';
            acc.PersonOtherPhone = '9876542340';
            acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        	insert acc;
    }   
    
     @isTest
    public static void TestGetCalloutResponseContents(){
       system.debug('Inside TestGetCalloutResponseContents');
       OfferTriggerHandler.TriggerDisabled = true;
       test.startTest();
       
       string response = ServiceCUNextCallout.getCalloutResponseContents();
        test.stopTest();
        OfferTriggerHandler.TriggerDisabled = false;
       system.debug('response: ' + response); 
       System.assert(response == 'Success');
    }
    
}