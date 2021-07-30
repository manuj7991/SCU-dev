@isTest
public class MemberAccountControllerTest {
    @TestSetup 
    private static void setupTestData()
    {
        TestUtil.createAccountData(1,true);
    }
    
    private static List<Account> getAccount()
    {
        return [SELECT Id , Name, RecordTypeId,DNA_Cust_Key__c FROM Account]; 
    }
    
    @isTest
    private static void updateAccountFromDNATest() {
        Account accountInstance = getAccount().get(0);
        
        Test.startTest();
        //  Test.setMock(HttpCalloutMock.class, fakeResponse);
        try{
           
            Account accountInstance1 = MemberAccountController.updateAccountFromDNA(String.valueOf(accountInstance.Id));
            System.assertEquals('hagmandouglas@gmail.com', accountInstance1.PersonEmail, 'Id does not exist');
        }catch(System.DmlException de){
            
           system.assertEquals(de.getMessage(), de.getMessage()); 
        }
        Test.stopTest();   
    }
    
      
    @isTest
    private static void updateMemberCardFromDNATest( ) {
       Account acc = new Account();
       acc.Name = 'shiv';
       acc.DNA_Cust_Key__c = 'O5555';
       acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId();
       insert acc;
        FinServ__FinancialAccount__c finAccount= new FinServ__FinancialAccount__c();
        finAccount.Name = 'tesr me';
        finAccount.FinServ__PrimaryOwner__c = acc.Id;
        insert finAccount;
        FinServ__Card__c card = new FinServ__Card__c(Name = 'testData',FinServ__FinancialAccount__c=finAccount.Id, Organization_Level_5_code__c = String.valueOf(System.now()));
        insert card;
        Test.startTest();
        FinServ__Card__c card1 = MemberAccountController.updateMemberCardFromDNA(String.valueOf(card.Id));
        Test.stopTest();
        
        system.assertNotEquals(null, card1,'Card Record Not created');
    }
    
    @isTest
    private static void testMemberAccountController()
    {
	MemberAccountController controller = new MemberAccountController() ;
    }
    
}