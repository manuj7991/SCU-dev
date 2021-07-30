public class Accounts {
    private static final AccountDAO.IAccountDAO accountDAOInstance = new AccountDAO();
    public static Account getAccountBasedOnId(String AccountId){
        List<Account> listOfAccountForUpdate = new List<Account>();
        List<Account> listOfAccount = accountDAOInstance.getAccountBasedOnId(AccountId);
        System.debug('Hii1'+AccountId);
        if(!String.isBlank(AccountId)){
            
            System.debug('Hii'+listOfAccount);
            if(!listOfAccount.isEmpty() && listOfAccount[0].RecordType.name == 'Person Account' && !string.isEmpty(listOfAccount[0].DNA_Cust_Key__c)){
                PersonDetailInquiryResponse personDetailResponse = DNAMemberAccountProxy.getMemberDetails(listOfAccount[0].DNA_Cust_Key__c);
                If(personDetailResponse.PersonDetailInquiryResponse.PersonDetailInquiryResponse.WasSuccessful == 'true'){
                listOfAccountForUpdate.add(new PersonDetailInquiryResponse(personDetailResponse.PersonDetailInquiryResponse,listOfAccount[0].DNA_Cust_Key__c,AccountId).AccountInformation);
                system.debug('listOfAccountForUpdate'+listOfAccountForUpdate);
                }}
            if(!listOfAccount.isEmpty() && listOfAccount[0].RecordType.name == 'Business'  && !string.isEmpty(listOfAccount[0].DNA_Cust_Key__c)){
                BusinessDetailInquiryResponse BusinessDetailResponse = DNAMemberAccountProxy.getMemberDetailsBusinessAccount(listOfAccount[0].DNA_Cust_Key__c);
                If(BusinessDetailResponse.OrgDetailInquiryResponse.WasSuccessful == 'true'){
                listOfAccountForUpdate.add(BusinessDetailInquiryResponse.BusinessDetailInquiryResponse(BusinessDetailResponse.OrgDetailInquiryResponse,listOfAccount[0].DNA_Cust_Key__c,AccountId));
                system.debug('listOfAccountForUpdate'+listOfAccountForUpdate);
                } 
            }
            if(!listOfAccountForUpdate.isEmpty()){
                accountDAOInstance.updateAccountBasedOnExternalId(listOfAccountForUpdate[0]);
            }
            
        }
        if(!listOfAccountForUpdate.isEmpty()){
            return listOfAccountForUpdate[0];
        }
        else{
            return null;
        }
    }
    
    public static Account getAccountRecordById(String accountId)
    {
        List<Account> listOfAccounts = accountDAOInstance.getAccountBasedOnId(accountId);
        if(!listOfAccounts.isEmpty())
        {
            return listOfAccounts[0];
        }
        else
        {
            return null;
        }
        
    }
    /*    public static void getAccountBasedOnId(String AccountId){
System.debug('Hii1'+AccountId);
if(!String.isBlank(AccountId)){
List<Account> listOfAccountForUpdate = new List<Account>();
List<Account> listOfAccount = accountDAOInstance.getAccountBasedOnId(AccountId);
System.debug('Hii'+listOfAccount);
if(!listOfAccount.isEmpty()){
MemberTestJSON personDetailResponse = DNAMemberAccountProxy.getMemberDetails(listOfAccount[0].DNA_Cust_Key__c);
listOfAccountForUpdate.add(new MemberTestJSON(personDetailResponse,listOfAccount[0].DNA_Cust_Key__c,AccountId).AccountInformation);
system.debug('listOfAccountForUpdate'+listOfAccountForUpdate);
}
if(!listOfAccountForUpdate.isEmpty()){
accountDAOInstance.updateAccountBasedOnExternalId(listOfAccountForUpdate[0]);
}

}
}*/
}