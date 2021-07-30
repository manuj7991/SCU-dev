public class LeadConvertController {
    
  @InvocableMethod(label='Convert Leads' description='Convert the leads based on Ids')
  public static void convertLeads(List<Id> ids) 
  {
       Id userId = UserInfo.getUserId();
       LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus 
                                           WHERE  IsConverted=true Limit 1];
      Lead leadRecod = [Select Name, FinServ__RelatedAccount__c From Lead Where Id In :ids];
      
        List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert>();
        for(id currentlead : ids)
        {
                Database.LeadConvert Leadconvert = new Database.LeadConvert();
                Leadconvert.setLeadId ( currentlead ); 
                Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
                Leadconvert.setDoNotCreateOpportunity(TRUE);
                //Leadconvert.setRelatedPersonAccountId('0011k00000rii1yAAA');
               
                Leadconvert.setAccountId(leadRecod.FinServ__RelatedAccount__c);
                Leadconvert.setOwnerId(userId); 
                MassLeadconvert.add(Leadconvert);
        }
        
        if (!MassLeadconvert.isEmpty()) 
        {
            List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
            System.debug('lcr-> ' + lcr);
            Id accountId = lcr[0].getAccountId();
            System.debug('accountId is here --> ' + accountId);          
        }
    }
     
}