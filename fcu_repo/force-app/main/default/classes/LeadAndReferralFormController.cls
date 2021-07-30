public class LeadAndReferralFormController 
{    
    @AuraEnabled(cacheable=true)
    public static List<PicklistWrapper> getLeadRecordTypeOptionsForCurrentUser()
    {
        List<RecordTypeInfo> listOfRecordTypeOptions = Lead.SObjectType.getDescribe().getRecordTypeInfos();       
        List<PicklistWrapper> listOfOptions = new List<PicklistWrapper>();
        
        for(RecordTypeInfo info : listOfRecordTypeOptions)
        {
            if(info.isAvailable() && info.getdeveloperName() != 'Master')
            { 
                switch on info.getdeveloperName() 
                {
                    when 'Business_Loan' 
                    {
                        listOfOptions.add( new PicklistWrapper(info.getname(),info.getname()));
                    }
                    
                    when 'Consumer_Product' 
                    {
                        listOfOptions.add( new PicklistWrapper(info.getname(),info.getname()));
                    }
                    
                    when 'Mortgage_Loan' 
                    {
                        listOfOptions.add( new PicklistWrapper(info.getname(),info.getname()));
                    }                    
                }
            }
                        
        }   
        
        return listOfOptions;
    }
    
    @AuraEnabled
    public static RelatedAccountWrapper getRelatedAccountDataById(String accountRecordId)
    {
        
        RelatedAccountWrapper wrapper = null;
        
        Account accountRecord = Accounts.getAccountRecordById(accountRecordId);
        
        if(accountRecord != null)
        {
            if(accountRecord.IsPersonAccount)
            {
                wrapper = new RelatedAccountWrapper(accountRecord.FirstName, accountRecord.LastName, 
                                                accountRecord.PersonEmail, accountRecord.PersonHomePhone, accountRecord.PersonMobilePhone, 
                                                accountRecord.PersonMailingStreet, accountRecord.PersonMailingCity, accountRecord.PersonMailingState,
                                                accountRecord.PersonMailingPostalCode, accountRecord.PersonMailingCountry 
                                                );
            }
            else
            {
                wrapper = new RelatedAccountWrapper(accountRecord.FirstName, accountRecord.Name, 
                                                accountRecord.Work_Email__c, accountRecord.Work_Phone__c, accountRecord.Mobile__c, 
                                                accountRecord.Mailing_Street_Business__c, accountRecord.Mailing_City_Business__c, accountRecord.Mailing_State_Business__c,
                                                accountRecord.Mailing_Postal_Code_Business__c, accountRecord.Mailing_Country_Business__c 
                                                );                
            }
            
        }
        
        return wrapper;        
    }
    
    @AuraEnabled
    public static void insertLead(Lead leadRecord, String recordTypeId)
    {
        Database.DMLOptions dmlOption = new Database.DMLOptions();
        
        dmlOption.assignmentRuleHeader.useDefaultRule = true;
        leadRecord.RecordTypeId = recordTypeId;
        leadRecord.setOptions(dmlOption); 
        
        try
        {
            Leads.insertLeads(new List<Lead>{leadRecord});              
        }
        
        catch(Exception e)
        {
            throw new AuraHandledException(e.getMessage());            
        }       
    }
    
    public class PicklistWrapper
    {
        @AuraEnabled
        public String label{get; set;}
        @AuraEnabled
        public String value{get; set;}
    
        public PicklistWrapper(String label, String value)
        {
            this.label = label;
            this.value = value;
        }
    }
    
    public class RelatedAccountWrapper
    {
        @AuraEnabled
        public String firstName {get; set;}
        @AuraEnabled
        public String lastName {get; set;}
        @AuraEnabled
        public String email {get; set;}
        @AuraEnabled
        public String phone {get; set;}
        @AuraEnabled
        public String mobile {get; set;}
        @AuraEnabled
        public String street  {get; set;}
        @AuraEnabled
        public String city  {get; set;}
        @AuraEnabled
        public String state  {get; set;}
        @AuraEnabled
        public String postalCode  {get; set;}
        @AuraEnabled
        public String country  {get; set;}
        
        public RelatedAccountWrapper(String firstName, String lastName, String email, String phone, String mobile, 
                                     String street, String city, String state,
                                     String postalCode, String country )
        {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phone = phone;
            this.mobile = mobile; 
            this.street = street;
            this.city = city;
            this.state = state;
            this.postalCode = postalCode;
            this.country = country; 
        }
    }

}