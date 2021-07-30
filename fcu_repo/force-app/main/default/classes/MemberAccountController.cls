public class MemberAccountController {
    public MemberAccountController() {
        
    }
    @AuraEnabled  
    public static Account updateAccountFromDNA(String recId ) {
        Account accountRecord = new Account();
        try{
            accountRecord = Accounts.getAccountBasedOnId(recId);
            
        }
        catch(System.DmlException de)
        {
            throw new AuraHandledException(de.getMessage());
        }
        
        return accountRecord;
    }
    
    @AuraEnabled  
    public static FinServ__Card__c updateMemberCardFromDNA(String recId ) {
        FinServ__Card__c cardRecord = new FinServ__Card__c( Id = recId, Organization_Level_5_code__c = String.valueOf(System.now()));
        update cardRecord;
        return cardRecord;
            }
    
}