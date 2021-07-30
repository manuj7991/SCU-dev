public with sharing class TransactionHistoryController {
   
    @AuraEnabled
    public static List<ServiceCUAccountTransactions.cls_Transactions> getContactList(String financialAccountRecordId,String noOfTxns,String txnsType, string StartDate,string EndDate) {
        System.debug('---financialAccountRecordId---'+financialAccountRecordId+'--'+noOfTxns+'--'+txnsType+'--'+StartDate+'--'+EndDate);
        
        List<FinServ__FinancialAccount__c> listOfFinancialAccountTransaction = [ Select Id, FinServ__FinancialAccountNumber__c From FinServ__FinancialAccount__c WHERE Id = :financialAccountRecordId ];      
        String AccountNumber = listOfFinancialAccountTransaction[0].FinServ__FinancialAccountNumber__c;
        
        System.debug('AccountNumber -->  ' + AccountNumber);       
     
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();     
        gen.writeFieldName('AccountTransactionHistoryRequest');
        
        gen.writeStartObject();
        gen.writeStringField('AccountNumber', AccountNumber);
        gen.writeStringField('DebitCreditOnly', txnsType);
        if(noOfTxns !=''){
            gen.writeStringField('MaximumRows', noOfTxns);
        }
        if(startDate !='' && endDate !=''){
            gen.writeStringField('FromDate',startDate);
            gen.writeStringField('ThroughDate', endDate);
        }
        gen.writeEndObject();   
        
        gen.writeEndObject();
        String jsonRequest = gen.getAsString();
        System.debug('jsonData-' + jsonRequest);
        
       
        ServiceCUAccountTransactions accountTransactionsResponse = DNAMemberAccountProxy.getAccountTransactionHistory(jsonRequest);
       
        List<ServiceCUAccountTransactions.cls_Transactions> lstTrxn = new List<ServiceCUAccountTransactions.cls_Transactions>();
        lstTrxn=   accountTransactionsResponse.AccountTransactionHistoryResponse.Transactions;
        system.debug('----lstTrxn---'+lstTrxn);
          
        
        if(lstTrxn !=null){
            
       
        for(ServiceCUAccountTransactions.cls_Transactions ObjTrxn:lstTrxn)
        {
           
            If(ObjTrxn.DebitCredit =='C')
            {
                ObjTrxn.DebitCredit= 'Credit';
            }
            else	if(ObjTrxn.DebitCredit=='D')
            {
                ObjTrxn.DebitCredit='Debit';
            }
            Date effectivedt = Date.valueOf(ObjTrxn.EffectiveDate);        
            DateTime effectivedtt = DateTime.newinstance(effectivedt.year(), effectivedt.month(), effectivedt.day());      
            String effectivedateOutput = effectivedtt.format('yyyy-MM-dd');       
            ObjTrxn.EffectiveDate = effectivedateOutput;
            
            Date postDt = Date.valueOf(ObjTrxn.PostDate);        
            DateTime postDtt = DateTime.newinstance(postDt.year(), postDt.month(), postDt.day());        	
            String postDateOutput = postDtt.format('yyyy-MM-dd');        
            ObjTrxn.PostDate = postDateOutput;
            
        }
             }
        System.debug('Final resp: '+lstTrxn);
        return lstTrxn;
    }
    
 
   
    
}