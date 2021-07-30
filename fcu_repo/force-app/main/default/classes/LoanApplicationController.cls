public class LoanApplicationController {
    
    @AuraEnabled(cacheable = true)
    public static List<LoanApplicationWrapper> getLoanApplicationData()
    {
        List<ResidentialLoanApplication> listOfLoanApplications = LoanApplications.getListOfRecentLoanApplications();
        List<LoanApplicationWrapper> listOfLoanData = null;
        
        if(!listOfLoanApplications.isEmpty())
        {
            listOfLoanData = new List<LoanApplicationWrapper>();
            for(ResidentialLoanApplication loanRecord : listOfLoanApplications)
            {                
                LoanApplicationWrapper wrapper = new LoanApplicationWrapper(loanRecord);
                listOfLoanData.add(wrapper);
            }
        }
        
        return listOfLoanData;
    }
    
    public class LoanApplicationWrapper
    {
        @AuraEnabled
        public String loanApplicationName {get;set;}
        @AuraEnabled
        public String loanApplicationStatus {get;set;}
        @AuraEnabled
        public String loanApplicationCreatedDate {get;set;}
        @AuraEnabled
        public String loanId {get;set;}        
        
        public LoanApplicationWrapper(ResidentialLoanApplication loanApplicationRecord)
        {            
                this.loanId = loanApplicationRecord.Id;
                this.loanApplicationName = loanApplicationRecord.Name;
                this.loanApplicationStatus = loanApplicationRecord.Status;
                this.loanApplicationCreatedDate = loanApplicationRecord.CreatedDate.format('MMMM dd, yyyy');        
        }        
    }

}