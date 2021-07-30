public class ServiceRequestTriggerHandler implements ITriggerHandler{
     
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
     
    public void beforeInsert(List<sObject> newList) {
    
               for (Case c : (List<Case>)newList) {
                   Set<String> mypicklistValues = new Set<String>{'International Bill Payments', 'Euro ACH STOPs', 'Euro ACH Recalls', 'V PAY Card Maintenance', 'Banknotes', 'Foreign Check Processing'};
                   RecordType rtForeignExchange = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'Foreign Exchange' LIMIT 1];
                   
                   //Code to Handle 'Card Services'
                   if (c.RecordTypeId == getRecordTypeId('Card Services') && c.accountId != null)
                   {
                       System.Debug('RecordType Matched');
                       string id = getEntitlementId('SCU Card Services Entitlement', c.accountId, 'Card Services');
                       System.Debug('Entitlement Id returned ' + id);
                       c.entitlementId = id;
                   }
                   
                    //Code to Handle 'Business Services'
                   if (c.RecordTypeId == getRecordTypeId('Business Services') && c.accountId != null)
                   {
                       System.Debug('RecordType Matched');
                       string id = getEntitlementId('SCU Business Services Entitlement', c.accountId, 'Business Services');
                       System.Debug('Entitlement Id returned ' + id);
                       c.entitlementId = id;
                   }
                   
                   //Code to handle 'Foreign Exchange'
                   if (c.RecordTypeId == getRecordTypeId('Foreign Exchange') && mypicklistValues.Contains(c.Reason) && c.accountId != null)
                   {
                       System.Debug('RecordType Matched for Foreign Exchange');
                       string id = getEntitlementId('SCU Foreign Exchange Entitlement', c.accountId, 'Foreign Exchange');
                       System.Debug('Entitlement Id returned ' + id);
                       c.entitlementId = id;
                   }
                   
                   //Code to be removed as part of US 353
                    //Code to Handle 'Consumer Lending'
                    /*
                   if (c.RecordTypeId == getRecordTypeId('Consumer Loan Modification') && c.accountId != null)
                   {
                       System.Debug('RecordType Matched');
                       string id = getEntitlementId('SCU Consumer Lending Entitlement', c.accountId, 'Consumer Loan Modification');
                       System.Debug('Entitlement Id returned ' + id);
                       c.entitlementId = id;
                   }
                   */
             
            }
}
             
     
    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
         
    }
     
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
           DateTime completionDate = system.now();
           List<Id> updateCases = new List<Id>();
           List<Id> updatePriorityCases = new List<Id>();
        for(Case c:(List<Case>) newList){
                System.Debug(c.casenumber);
                
                if(((c.isClosed==true)||(c.Status=='Closed'))&&(c.EntitlementId!=null))
                updateCases.add(c.Id);
            
            	if((c.Status!='Closed')&&(c.EntitlementId!=null)&&(c.Priority=='High'))
                updatePriorityCases.add(c.Id);
        }
        System.Debug(updateCases);
		System.Debug(updatePriorityCases);
        if(updateCases.isEmpty()==false){
            List<CaseMilestone>cmsToUpdate=[ select Id, completionDate from CaseMilestone where caseId in: updateCases and completionDate=null ];
            if(cmsToUpdate.isEmpty()==false){
                for(CaseMilestone cm: cmsToUpdate){
                    cm.completionDate = completionDate;
                }
                update cmsToUpdate;
            }
        }
        
        if(updatePriorityCases.isEmpty()==false){
            List<CaseMilestone> cmsToUpdatePriority=[ select Id, completionDate from CaseMilestone where caseId in: updatePriorityCases and completionDate=null and MilestoneType.Name = 'Upgrade Priority'];
            system.debug('casemilestone to be updated:' + cmsToUpdatePriority);
            if(cmsToUpdatePriority.isEmpty()==false){
                for(CaseMilestone cm: cmsToUpdatePriority){
                    cm.completionDate = completionDate;
                }
                update cmsToUpdatePriority;
            }
        }
   }
     
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }
    
    //Private Methods
    private string getRecordTypeId(string recordTypeName){
        system.debug('Inside getRecordTypeId');
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: recordTypeName LIMIT 1];
        return rt.Id;
    }
    
    private string getEntitlementId(string processName, string accountId, string recordType){
         SlaProcess  process = [Select s.Id, s.Name From SlaProcess s Where s.Name = : processName and s.IsActive =: true];
         string returnValue = '';
         if(process.Id != null){
                List <Entitlement> entls = [Select e.StartDate, e.Id, e.EndDate, 
                                            e.AccountId, e.AssetId
                                            From Entitlement e
                                           Where e.AccountId =:  accountId And e.EndDate >= Today 
                                            And e.StartDate <= Today and slaProcessId = : process.Id];
                                            
                                            
                if(entls.isEmpty()==false){
                     for(Entitlement e:entls){
                         if(e.AccountId==accountId)
                                returnValue  = e.Id;
                     }
                }
                else{    
                    string entitlementName = 'Entitlement_' ;
                    Account a = [Select FirstName, LastName, Name from Account where id = :accountId];
                    if(a.Name == null)
                        entitlementName = entitlementName +  a.FirstName + ' ' + a.LastName + '_' + recordType;
                    else
                        entitlementName = entitlementName +a.Name + '_' + recordType;
                                   
                                 
                                        Entitlement e = new Entitlement();
                                        e.AccountId = accountId;
                                        e.Name = entitlementName ;
                                        e.StartDate= system.Today();
                                        e.EndDate = e.StartDate +365;
                                        e.slaprocessId = process.Id;
                                        insert e;
                                        returnValue = e.Id;
                                   
                            }
                                            
                                            
          }
          return returnValue ;
    
    }
    
}