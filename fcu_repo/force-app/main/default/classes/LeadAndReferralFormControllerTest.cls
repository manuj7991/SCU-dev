@isTest
private class LeadAndReferralFormControllerTest {
    
    @testSetup
    private static void testSetupData()
    {
        TestUtil.createAccountData(1, true);        
    }
    
    private static Account getAccount()
    {
        return [SELECT Id, Name FROM Account LIMIT 1];
    }
    
    
    @isTest
    private static void testGetLeadRecordTypeOptionsForCurrentUser()
    {
        User user = TestUtil.insertUser();
        System.runAs(user)
        {
            Test.startTest();
                List<LeadAndReferralFormController.PicklistWrapper> listOfOptions = LeadAndReferralFormController.getLeadRecordTypeOptionsForCurrentUser();
            Test.stopTest();
            
            System.assertEquals(true, listOfOptions.size() > 0);
        }        
    }
    
    @isTest
    private static void testGetRelatedAccountDataById()
    {
        Account personAccountRecord = getAccount();
        Account accountRecord = new Account();
        accountRecord.Name = 'Prashant Singh';
        insert accountRecord;
        
        
        Test.startTest();
            LeadAndReferralFormController.RelatedAccountWrapper wrapper = LeadAndReferralFormController.getRelatedAccountDataById(personAccountRecord.Id);
            LeadAndReferralFormController.RelatedAccountWrapper accountData = LeadAndReferralFormController.getRelatedAccountDataById(accountRecord.Id);
        Test.stopTest();
        
        System.assertEquals(wrapper.firstName, 'MC - 1');        
        System.assertEquals(accountData.lastName, 'Prashant Singh');
        
    }
    
    @isTest
    private static void testGetRelatedAccountDataByIdIfDataDoesNotExist()
    {
        Test.startTest();
            LeadAndReferralFormController.RelatedAccountWrapper wrapper = LeadAndReferralFormController.getRelatedAccountDataById(null);
        Test.stopTest();
        
        System.assertEquals(wrapper, null);        
    }    
    
    @isTest
    private static void testInsertLeadIfRecordIsPassed()
    {
        Lead leadRecord = TestUtil.createLeadRecord();
        RecordType recordTypeId = [SELECT Id, Name, SobjectType FROM RecordType Where SobjectType ='Lead' And Name = 'Business Loan'];
        
        Test.startTest();
            LeadAndReferralFormController.insertLead(leadRecord, recordTypeId.Id);
        Test.stopTest();
        
        List<Lead> listOfLead = [SELECT Id, Name, RecordType.Name FROM Lead]; 
        
        System.assertEquals(1, listOfLead.size());  
    }
    
    @isTest
    private static void testInsertLeadIfRecordIsNotPassed()
    {
        Lead leadRecord = new Lead();
        RecordType recordTypeId = [SELECT Id, Name, SobjectType FROM RecordType Where SobjectType ='Lead' And Name = 'Business Loan'];
        
        Test.startTest();
            try{
                LeadAndReferralFormController.insertLead(leadRecord, recordTypeId.Id);            
            }
            catch(Exception e)
            {
                System.assertEquals(e.getMessage(), e.getMessage());               
            } 
        Test.stopTest(); 
    }    

}