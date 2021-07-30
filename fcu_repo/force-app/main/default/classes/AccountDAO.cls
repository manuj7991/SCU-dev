public with sharing class AccountDAO implements IAccountDAO{
    public interface IAccountDAO
    {
        List<Account> getAccountBasedOnId(String AccountId);
        Account updateAccountBasedOnExternalId(Account AccountRecordToUpdate);
     }
    public List<Account> getAccountBasedOnId(String AccountId){
        List<Account> listOfAccountRecords = [SELECT Id, DNA_Cust_Key__c, RecordTypeId, RecordType.name, Name, FirstName, LastName,
                                              IsPersonAccount, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, 
                                              PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonMailingCountry,
                                              Work_Email__c, Work_Phone__c, Mobile__c, Mailing_Street_Business__c, Mailing_City_Business__c,
                                              Mailing_State_Business__c, Mailing_Postal_Code_Business__c, Mailing_Country_Business__c
                                              FROM Account WHERE Id =:AccountId LIMIT 1];
        return listOfAccountRecords;
    }
    
    public Account updateAccountBasedOnExternalId(Account AccountRecordToUpdate){
      // Upsert AccountRecordToUpdate DNA_Cust_Key__c;
      update AccountRecordToUpdate;
        return AccountRecordToUpdate;
    }
    
}