@istest
public class AccountsTest {
 @TestSetup 
    private static void setupTestData()
    {
        TestUtil.createAccountData(1,true);
    }
    
    private static List<Account> getAccount()
    {
        return [SELECT Id , Name, RecordTypeId FROM Account]; 
    }
    
    @isTest
    private static void getAccountBasedOnPersonIdTest() {
        Account accountInstance = getAccount().get(0);
        
        Test.startTest();
            Account accountInstance1 = Accounts.getAccountBasedOnId(accountInstance.Id);
        Test.stopTest();

        System.assertEquals('hagmandouglas@gmail.com', accountInstance1.PersonEmail, 'Id does not exist');
    }
    
    @isTest
    private static void getAccountRecordByIdTest() {
        Account accountInstance = getAccount().get(0);
        
        Test.startTest();
           Account listOfAccount = Accounts.getAccountRecordById(accountInstance.Id);
        Test.stopTest();

        System.assertNotEquals(null, accountInstance.Id);
    }
    
    @isTest
    private static void getAccountBasedOnBusinessIdTest() {
       Account acc = new Account();
       acc.Name = 'shiv';
       acc.DNA_Cust_Key__c = 'O5555';
       acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId();
       insert acc;
        
        Test.startTest();
            Account accountInstance1 = Accounts.getAccountBasedOnId(acc.Id);
        Test.stopTest();

        System.assertEquals('asdasda@fiserv.com', accountInstance1.Work_Email__c, 'Id does not exist');
    }
    
   
}