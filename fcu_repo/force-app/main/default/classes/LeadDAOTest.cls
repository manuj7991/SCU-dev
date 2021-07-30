@isTest
private class LeadDAOTest {
    
    @testSetup
    private static void testSetupData()
    {
        
        TestUtil.insertLeadRecord();         
    }
    
    private static List<Lead> getLead()
    {
        return [SELECT Id, Name FROM Lead];
    }    
    
    @isTest
    private static void testGetListOfLeadRecordsIfListExists()
    {
        Test.startTest();
            List<Lead> listOfLeads = LeadDAO.getListOfLeadRecords();
        Test.stopTest();
        
        System.assertEquals(1, listOfLeads.size());
    }
    
    @isTest
    private static void testGetListOfLeadRecordsIfListDoesNotExist()
    {
        List<Lead> listOfLeads =  getLead();
        delete listOfLeads;
        Test.startTest();
            List<Lead> result = LeadDAO.getListOfLeadRecords();
        Test.stopTest();
        
        System.assertEquals(0, result.size());
    }      

}