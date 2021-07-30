@isTest
public class DeleteRedundantNEXTOffersTest {
    
    @TestSetup 
    private static void setupTestData()
    {
        TestUtil.createBusinessAccountData(1,true, true);
        List<Account> acc = [SELECT Id , Name ,  RecordTypeId, DNA_Cust_KEy__c FROM Account where DNA_Cust_KEy__c like '%P%' LIMIT 1 ]; 
        //RecordType rectype = [select id, developername from recordtype where sObjectType = 'Offer__c' and developername =:'Service_CU_Offer_for_Person'];
        Offer__c offer = new Offer__c();
        OfferTriggerHandler.TriggerDisabled = true;
        System.debug('acc:'+acc[0]);
        offer.Account__c =acc[0].Id;
        offer.End_Date__c = System.today() - 1;
       // offer.RecordTypeId = rectype.Id;
     	offer.Name='TestOffer';
    	offer.id__c ='1';
    	system.debug('offer data: '+offer);
        insert offer;
        
        ResidentialLoanApplication loanApp = new ResidentialLoanApplication();
        loanApp.Offer__c = offer.Id;
        loanApp.AccountId =offer.Account__c;
        loanApp.Name = 'ResidentialLoan';
        
        insert loanApp;
            
        
    }
    @isTest
	 public static void DeleteRedundantNEXTOffersMethod() {        
         test.starttest();
         DeleteRedundantNEXTOffers scClass = new DeleteRedundantNEXTOffers();   
         String chron = '0 0 23 * * ?';        
         system.schedule('Test Sched', chron, scClass);
         test.stopTest();
    }
}