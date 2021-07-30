public class NewLeadDisplayController {
    
    private static final LeadDAO.ILeadDAO leadDAOInstance = new LeadDAO();
    
    @AuraEnabled(cacheable=true)
    public Static List<LeadWrapper> getListOfLead()
    {
        List<LeadWrapper> listOfLeadWrapper = new List<LeadWrapper>();
        List<Lead> getLeadsList = leadDAOInstance.getListOfLeadRecords();
        
        for(Lead leadData:getLeadsList)
        {
            LeadWrapper wrapperData = new LeadWrapper(leadData);
            listOfLeadWrapper.add(wrapperData);
        }
        return listOfLeadWrapper;
    }
    
    public class LeadWrapper
    {
        @AuraEnabled
        public String leadName {get;set;}
        @AuraEnabled
        public String leadStatus {get;set;}
        @AuraEnabled
        public String leadCreatedDate {get;set;}
        @AuraEnabled
        public String leadId {get;set;}        
        
        public LeadWrapper(Lead leadRecord)
        {            
                this.leadId = leadRecord.Id;
                this.leadName = leadRecord.Name;
                this.leadStatus = leadRecord.Status;
                this.leadCreatedDate = leadRecord.CreatedDate.format('MMMM dd, yyyy');        
        }        
    }
}