@isTest
private class LoanApplicationControllerTest {
    
    @testSetup
    private static void testSetupData()
    {
        
        Account accountRecord = new Account();
        accountRecord.Name = 'Test Account Name';
        insert accountRecord;
        
        Opportunity opportunityRecord = new Opportunity();
        opportunityRecord.Name = 'Test Opportunity Name';
        opportunityRecord.StageName = 'Closed Won';
        opportunityRecord.CloseDate = System.today();
        opportunityRecord.AccountId = accountRecord.Id;
        insert opportunityRecord;
        
        ResidentialLoanApplication loanRecord = new ResidentialLoanApplication();
        loanRecord.Name = 'Test Loan Name';  
        loanRecord.OpportunityId = opportunityRecord.Id;
        insert loanRecord;        
    }
    
    private static List<ResidentialLoanApplication> getLoan()
    {
        return [SELECT Id, Name FROM ResidentialLoanApplication];
    }
    
    @isTest
    private static void testGetLoanApplicationDataIfDataExist()
    {
        Test.startTest();
            List<LoanApplicationController.LoanApplicationWrapper> listOfLoanData = LoanApplicationController.getLoanApplicationData();
        Test.stopTest();
        
        System.assertEquals(1, listOfLoanData.size());        
    }  
    
    @isTest
    private static void testGetLoanApplicationDataIfDataDoesNotExist()
    {
        List<ResidentialLoanApplication> listOfLoanApplications =  getLoan();
        delete listOfLoanApplications;
        
        Test.startTest();
            List<LoanApplicationController.LoanApplicationWrapper> listOfLoanData = LoanApplicationController.getLoanApplicationData();
        Test.stopTest();
        
        System.assertEquals(null, listOfLoanData);        
    }      
    
}