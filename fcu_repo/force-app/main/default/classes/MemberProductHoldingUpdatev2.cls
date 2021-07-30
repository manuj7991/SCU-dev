public without sharing class MemberProductHoldingUpdatev2 {
    

  @AuraEnabled
  public static String getMemberProductDetails(String recId){

    FinServ__FinancialAccount__c acctNo = [SELECT Id,FinServ__FinancialAccountNumber__c from FinServ__FinancialAccount__c where Id =:recId][0];

    AccountDetailInquiryResponse_v4 result = DNAMemberAccountProxy.getAccountDetails(acctNo.FinServ__FinancialAccountNumber__c);
    
    //system.debug(result);
    acctNo = AccountDetailInquiryResponse_v4.getFinAcct(recId,result.AccountDetailInquiryResponse);//updateFinAcctDetails(recId,result);

    if(acctNo != NULL){

        update acctNo;
        return 'Success';
    }
    else{

        return 'Failure';
    }
      
  } 
}