@isTest
public class TestUtil {
public static List<Account> createAccountData(Integer count, Boolean isInsert)
    {
        List<Account> listOfAccount = new List<Account>();
        for (integer i = 0; i < count; i++) {
            Account acc = new Account();
            acc.FirstName = 'MC - '+ count;
            acc.LastName = 'MC - '+ count;
            acc.PersonMailingCity='DEEP DRIVER';
            acc.PersonMailingCountry='USA';
            acc.PersonMailingState='CA';
            acc.PersonMailingStreet='202 S ST';
            acc.PersonMailingPostalCode='12345';
            acc.DNA_Cust_Key__c='P106173';
            acc.PersonEmail = 'personalemail_' + count + '@work.com';
            acc.Work_Email__c = 'workemail_' + count + '@work.com';
            acc.PersonHomePhone = '9876542340';
            acc.PersonMobilePhone = '9876542340';
            acc.PersonOtherPhone = '9876542340';
            acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
            listOfAccount.add(acc);
        }
        if (isInsert) {
            insert listOfAccount; 
        }
        return listOfAccount;
    }
    public static List<Account> createBusinessAccountData(Integer count, Boolean isInsert, boolean isPerson)
    {
        if (isPerson)
     		return  createAccountData(count, isInsert);
        else
        {
        List<Account> listOfAccount = new List<Account>();
        for (integer i = 0; i < count; i++) {
            Account acc = new Account();
            acc.Name = 'Business_' + count;
            acc.Mailing_City_Business__c='DEEP DRIVER';
            acc.Mailing_Country_Business__c='United States';
            acc.Mailing_State_Business__c='CA';
            acc.Mailing_Street_Business__c='202 S ST';
            acc.Mailing_Postal_Code_Business__c='12345';
            acc.DNA_Cust_Key__c='O165173';
            acc.Work_Email__c = 'workemail_' + count + '@work.com';
            acc.Work_Phone__c = '9876543210';
            acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId();
            listOfAccount.add(acc);
        }
        if (isInsert) {
            insert listOfAccount;
        }
        return listOfAccount;
        }
    }
    
    public static User insertUser()
    {
        String userName = 'TestUser' + DateTime.now().getTime() + '@test.com';
        Profile userProfile = [SELECT Id FROM Profile WHERE Name='SCU Contact Centre'];
        User user = new User();  
        user.Alias = 'ccr'; 
        user.Email='ccrUser@testorg.com'; 
        user.EmailEncodingKey='UTF-8';
        user.LastName='Testing'; 
        user.LanguageLocaleKey='en_US'; 
        user.LocaleSidKey='en_US'; 
        user.ProfileId = userProfile.Id; 
        user.TimeZoneSidKey='America/Los_Angeles'; 
        user.UserName = userName;
        
        insert user;
        return user;
    }
    
    public static Lead createLeadRecord()
    {
        Lead leadRecord = new Lead();
        leadRecord.LastName = 'Test Lead LastName';
        leadRecord.Title = 'Test Lead Title';
        return leadRecord;
    }
    
    public static Lead insertLeadRecord()
    {
        Lead leadRecord = new Lead();
        leadRecord.LastName = 'Test Lead LastName';
        leadRecord.Title = 'Test Lead Title';
         
        insert leadRecord;
        return leadRecord;
    }    
    
}