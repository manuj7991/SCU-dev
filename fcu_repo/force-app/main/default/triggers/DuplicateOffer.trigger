trigger DuplicateOffer on ResidentialLoanApplication(before insert, before update)
{

    Set<String> setOffer = new Set<String>();
    Set<String> setIds = new Set<String>();
    For (ResidentialLoanApplication app : trigger.new)
    {
        if (app.offer__c != null) {
            setOffer.add(app.offer__c);
          }
        if (app.Id != null)
        {
            setIds.add(app.Id);
        }
    }
    
    if(setOffer.size() > 0 )
    {
        List<ResidentialLoanApplication> lstResidentialLoanApplication = [select Offer__c ,id from ResidentialLoanApplication where offer__c in :setOffer and Id not in: setIds ];
        
        Map<String ,ResidentialLoanApplication> mapNameWiseOffer = new Map<String,ResidentialLoanApplication>();
        For(ResidentialLoanApplication loanapp: lstResidentialLoanApplication)
        {
            mapNameWiseOffer.put(loanapp.Offer__c ,loanapp);
        }
        
        For(ResidentialLoanApplication acc : trigger.new)
        {
            if(mapNameWiseOffer.containsKey(acc.Offer__c))
            {
                acc.Offer__c.addError('Offer is already associated with another application.');
            }
        }
        
    }
}