public with sharing class LoanApplicationDAO implements ILoanApplicationDAO 
{
    public interface ILoanApplicationDAO
    {
        List<ResidentialLoanApplication> getListOfRecentLoanApplications();        
    }
    
    public static List<ResidentialLoanApplication> getListOfRecentLoanApplications()
    {        
        return [ SELECT Id, Name, Status, CreatedDate FROM ResidentialLoanApplication ORDER BY CreatedDate DESC LIMIT 2 ];
    }
}