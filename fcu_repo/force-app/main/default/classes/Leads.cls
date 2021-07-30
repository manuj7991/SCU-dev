public class Leads 
{
    
    private static final LeadDAO.ILeadDAO leadDAOInstance = new LeadDAO();
    
    public static List<Lead> getListOfLeadRecords()
    {
        return leadDAOInstance.getListOfLeadRecords();
    }  
    
    public static List<Lead> insertLeads(List<Lead> listOfLeads)
    {
        return leadDAOInstance.insertLeads(listOfLeads);
    }

}