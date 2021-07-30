public class LoanApplications {
    private static final LoanApplicationDAO.ILoanApplicationDAO loanApplicationDAOInstance = new LoanApplicationDAO();
    public static List<ResidentialLoanApplication> getListOfRecentLoanApplications()
    {
        return loanApplicationDAOInstance.getListOfRecentLoanApplications();
    }
}