public with sharing class LeadDAO implements ILeadDao {
    public Interface ILeadDao {
      List<Lead> getListOfLeadRecords();
      List<Lead> insertLeads(List<Lead> listOfLeads);
    }
    public static List<Lead> getListOfLeadRecords()
    {
        List<Lead> listOfLead = new List<Lead>();
        listOfLead = [SELECT Id,Name,status,CreatedDate From Lead ORDER BY CreatedDate DESC LIMIT 2];
        return listOfLead;
    }
    
    public static List<Lead> insertLeads(List<Lead> listOfLeads)
    {
        insert listOfLeads;
        return listOfLeads;
    }
}