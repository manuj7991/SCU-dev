global class UpdateContactDetailsInDNA{
@InvocableMethod
    global static List<UpdateContactDetailsInDNAResult> UpdateMemberContactDetails(List<Account> accounts){
      List<string> error = new List<string>();
      
      List<UpdateContactDetailsInDNAResult> responseWrapper= new List<UpdateContactDetailsInDNAResult>();
      UpdateContactDetailsInDNAResult responseObj = new UpdateContactDetailsInDNAResult();
    
     System.debug('UpdateMemberContactDetails Called');
        if (accounts!= null){
            for(Account acct: accounts){
                 System.debug('Inisde For Loop');
                 if(!Test.isRunningTest()){
                     
                    string updateMemberDetailResponse = DNAMemberAccountProxy.updateMemberDetails(acct);
                    if (acct.DNA_Cust_Key__c.substring(0,1) == 'O'){
                        UpdateBusinessResponseWrapper businessResponseWrapper = UpdateBusinessResponseWrapper.parse(updateMemberDetailResponse);
                        system.debug(businessResponseWrapper);
                        if (businessResponseWrapper.OrgMaintenanceResponse.WasSuccessful == 'true')
                        {
                            responseObj.WasSuccessful = true;
                            responseObj.errorMessages = new List<string>{};
                        }
                        else
                        {
                            responseObj.WasSuccessful = false;
                            responseObj.errorMessages = new List<string>{businessResponseWrapper.OrgMaintenanceResponse.Errors.Error.ErrorNumber + ':'+ businessResponseWrapper.OrgMaintenanceResponse.Errors.Error.ErrorMessage};
                        }
                    }
                    else{
                        UpdatePersonResponseWrapper personResponseWrapper = UpdatePersonResponseWrapper.parse(updateMemberDetailResponse);
                        System.debug('personResponseWrapper : ' + personResponseWrapper);
                         if (personResponseWrapper.PersonMaintenanceResponse.WasSuccessful == 'true')
                        {
                            responseObj.WasSuccessful = true;
                            responseObj.errorMessages = new List<string>{};
                        }
                        else
                        {
                            responseObj.WasSuccessful = false;
                            responseObj.errorMessages = new List<string>{personResponseWrapper.PersonMaintenanceResponse.Errors.Error.ErrorNumber + ':' +personResponseWrapper.PersonMaintenanceResponse.Errors.Error.ErrorMessage};
                        }
                    }
                    system.debug('responseObj :' + responseObj);
                    responseWrapper.add(responseObj);
                }
                else
                {
                   System.debug('Mock response created');
                   responseObj.WasSuccessful = true;
                   responseWrapper.add(responseObj);
                }
            }
        }
        return responseWrapper;  
    }
 
  global class UpdateContactDetailsInDNAResult {
    @InvocableVariable
    global boolean WasSuccessful;
    @InvocableVariable
    global List<string> errorMessages;
}
}