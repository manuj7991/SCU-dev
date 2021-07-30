@isTest
public class AccountDAOTest {
    private static final AccountDAO.IAccountDAO accountDAOInstance = new AccountDAO();
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
    private static void getAccountBasedOnIdTest() {
        Account accountInstance = getAccount().get(0);
        
        Test.startTest();
            List<Account> accountInstance1 = accountDAOInstance.getAccountBasedOnId(accountInstance.Id);
        Test.stopTest();

        System.assertEquals(accountInstance.Name, accountInstance1[0].Name, 'Id does not exist');
    }
    
    @isTest
    private static void updateAccountBasedOnExternalIdTest() {
        Account accountInstance = new Account();
        accountInstance.Name = 'shiv'; 
        accountInstance.Work_Email__c = 'NY@gmn.com';
        insert accountInstance;
        accountInstance.Work_Email__c = 'asd@gmn.com';
        Test.startTest();
           Account  accountInstance1 = accountDAOInstance.updateAccountBasedOnExternalId(accountInstance);
        Test.stopTest();

        System.assertEquals('asd@gmn.com', accountInstance1.Work_Email__c, 'Value should not be different.');
    }
   
}