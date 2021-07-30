@isTest
private class NewLeadDisplayControllerTest {
    
    @testSetup
    private static void testSetupData()
    {
        
        Lead leadRecord = new Lead();
        leadRecord.LastName = 'Test Lead LastName';
        leadRecord.Title = 'Test Lead Title';
        insert leadRecord;      
    }
    
    private static List<Lead> getLead()
    {
        return [SELECT Id, Name FROM Lead];
    }       
    
    @isTest
    private static void testGetListOfLeadIfDataExist()
    {
        Test.startTest();
            List<NewLeadDisplayController.LeadWrapper> listOfLeadData = NewLeadDisplayController.getListOfLead();
        Test.stopTest();
        
        System.assertEquals(1, listOfLeadData.size());        
    } 
    
    @isTest
    private static void testGetListOfLeadIfDataDoesNotExist()
    {
        List<Lead> listOfLeads =  getLead();
        delete listOfLeads;
        Test.startTest();
            List<NewLeadDisplayController.LeadWrapper> listOfLeadData = NewLeadDisplayController.getListOfLead();
        Test.stopTest();
        
        System.assertEquals(0, listOfLeadData.size());        
    }     

}