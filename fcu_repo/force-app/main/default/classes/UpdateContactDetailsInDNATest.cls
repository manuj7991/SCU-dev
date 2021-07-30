@isTest
public class UpdateContactDetailsInDNATest {
    //private static final UpdateContactDetailsInDNA updateContactDetailsInDNA = new UpdateContactDetailsInDNA();
    
    
    @TestSetup 
    private static void setupTestData()
    {
       TestUtil.createBusinessAccountData(1,true, true);
       TestUtil.createBusinessAccountData(1,true, false);
    }
    private static List<Account> getAccount()
    {
        return [SELECT Id , Name ,  RecordTypeId, DNA_Cust_KEy__c FROM Account where DNA_Cust_KEy__c like '%P%' LIMIT 1 ]; 
    }
   private static List<Account> getBusinessAccount()
    {
        return [SELECT Id , Name ,  RecordTypeId, DNA_Cust_KEy__c FROM Account where DNA_Cust_KEy__c like '%O%' LIMIT 1 ]; 
    }

    @isTest
    private static void PositiveTest_PersonAccount_UpdateMemberContactDetailsTest() {
        List<Account> accounts = getAccount();
        List<Account> accounts2 = getAccount();
        accounts[0].Description = 'PositiveTest_PersonAccount_UpdateMemberContactDetailsTest';
        accounts2[0].Description = 'NigativeTest_PersonAccount_UpdateMemberContactDetailsTest';
        accounts2[0].DNA_Cust_Key__c='P67890';
        List<Account> newaccounts = new List<Account>();
        newaccounts.add(accounts[0]);
        newaccounts.add(accounts2[0]);
        System.debug('Account list created');
        List<UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult> results ;
        Test.startTest();
        System.debug('Test Started');
        results = UpdateContactDetailsInDNA.UpdateMemberContactDetails(accounts);
        System.debug(results);
        Test.stopTest();
        System.assertEquals(((UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult)results[0]).WasSuccessful, true, 'Success');
      
    }
    
    @isTest
     private static void NegativeTest_PersonAccount_UpdateMemberContactDetailsTest() {
        List<Account> accounts = getAccount();
        
        accounts[0].PersonMailingPostalCode = '12312312312';
        accounts[0].Description = 'NegativeTest_PersonAccount_UpdateMemberContactDetailsTest';
        //UpdateContactDetailsInDNA updatecontact = new UpdateContactDetailsInDNA();
        List<Account> invalidaccounts = new List<Account>();
        invalidaccounts.add(accounts[0]);
        List<UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult> results;
        Test.startTest();
        results = UpdateContactDetailsInDNA.UpdateMemberContactDetails(invalidaccounts);
        Test.stopTest();
        System.assertEquals(((UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult)results[0]).WasSuccessful, true, 'Success');
      
    }
    
     @isTest
    private static void PositiveTest_BusinessAccount_UpdateMemberContactDetailsTest() {
        List<Account> accounts = getBusinessAccount();
        accounts[0].Description = 'PositiveTest_BusinessAccount_UpdateMemberContactDetailsTest';
        List<Account> newaccounts = new List<Account>();
        newaccounts.add(accounts[0]);
        
        List<UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult> results;
        Test.startTest();
         results = UpdateContactDetailsInDNA.UpdateMemberContactDetails(newaccounts);
        Test.stopTest();
        System.assertEquals(((UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult)results[0]).WasSuccessful, true, 'Success');
      
    }
    
    @isTest
    private static void NegativeTest_BusinessAccount_UpdateMemberContactDetailsTest() {
        List<Account> accounts = getBusinessAccount();
        accounts[0].Mailing_Postal_Code_Business__c = '12312312312';
        accounts[0].Description = 'NegativeTest_BusinessAccount_UpdateMemberContactDetailsTest';
        List<Account> invalidaccounts = new List<Account>();
        invalidaccounts.add(accounts[0]);
        List<UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult> results;
        Test.startTest();
        results = UpdateContactDetailsInDNA.UpdateMemberContactDetails(invalidaccounts);
        Test.stopTest();
        System.assertEquals(((UpdateContactDetailsInDNA.UpdateContactDetailsInDNAResult)results[0]).WasSuccessful, true, 'Success');
      
    }
    
}