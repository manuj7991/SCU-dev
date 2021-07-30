@isTest
public class TransactionHistoryControllerTest {
    
    @TestSetup 
    private static void setupTestData()
    {
        List<Account> accounts=TestUtil.createBusinessAccountData(1,true, true);
        
		FinServ__FinancialAccount__c financialAccount = new FinServ__FinancialAccount__c();
        financialAccount.FinServ__FinancialAccountNumber__c = '3791546469';
        financialAccount.FinServ__Managed__c = true;
        financialAccount.FinServ__PrimaryOwner__c = accounts[0].Id;
        insert financialAccount;
    }   
    
    private static List<FinServ__FinancialAccount__c> getFinancialAccount()
    {
        return [ Select Id, FinServ__FinancialAccountNumber__c From FinServ__FinancialAccount__c WHERE FinServ__FinancialAccountNumber__c = '3791546469' ]; 
    }
    
    @isTest
    public static void testAccountTransactionHistory(){
        List<FinServ__FinancialAccount__c> accounts = getFinancialAccount();
        System.debug('account:'+accounts+'---'+accounts[0].Id);
        List<ServiceCUAccountTransactions.cls_Transactions> resp= TransactionHistoryController.getContactList(accounts[0].Id, ' ', 'D', '2020-07-01', '2021-07-20');
        System.debug(resp);
        system.assertEquals(resp.size(), 11); 
    }
}