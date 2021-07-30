public class DNAMemberAccountProxy{
    
    
    public static PersonDetailInquiryResponse getMemberDetails(String memberNumber){
        System.debug(' Start Time :'  + System.now());
        String API_URL = Label.DNAPROXY_API_URL + '/member/' + memberNumber;
        system.debug('API_URL'+API_URL);
       if(!Test.isRunningTest()){
            HttpResponse response = DNAHttpClient.getAPI(API_URL);
            system.debug('response'+response.getStatusCode());
            if (response.getStatusCode() == 200) {
                system.debug('response'+response);
                PersonDetailInquiryResponse personDetailResponse = (PersonDetailInquiryResponse)JSON.deserialize(response.getBody() , PersonDetailInquiryResponse.class);
                system.debug('personDetailResponse1'+personDetailResponse);
                 System.debug(' End Time :'  + System.now());
                return personDetailResponse;
           } 
            else{
                return null;        		
            }
        }else{
            return mockPersonDetailInquiryResponse();
        }
    }
    
    public static BusinessDetailInquiryResponse getMemberDetailsBusinessAccount(String memberNumber){
        String API_URL = Label.DNAPROXY_API_URL + '/member/' + memberNumber;
        system.debug('API_URL'+API_URL);
        if(!Test.isRunningTest()){
            HttpResponse response = DNAHttpClient.getAPI(API_URL);
            system.debug('response'+response.getStatusCode());
            if (response.getStatusCode() == 200) {
                system.debug('response'+response);
                BusinessDetailInquiryResponse BusinessDetailResponse = (BusinessDetailInquiryResponse)JSON.deserialize(response.getBody() , BusinessDetailInquiryResponse.class);
                system.debug('BusinessDetailResponse1'+BusinessDetailResponse);
                return BusinessDetailResponse;
            } 
            else{
                return null;        		
            }
        }else{
            return mockBusinessDetailInquiryResponse();
        }
    }
    
    public static string updateMemberDetails(Account acct){
        String myUrl = Label.DNAPROXY_API_URL + '/member';
        system.debug('API_URL'+myUrl);
        //Account acct = [SELECT Id, FirstName, LastName, DNA_Cust_Key__c, PersonEmail, Work_Email__c, PersonHomePhone, PersonMobilePhone,Work_Phone__c, PersonMailingStreet,PersonMailingCity,PersonMailingCountry, PersonMailingState, PersonMailingPostalCode FROM Account where ID = '0011k00000qU5fvAAC' LIMIT 1];
        string jsonBody = '';
        string errorJson = '';
        system.debug(acct);
        system.debug('First Char = ' + acct.DNA_Cust_Key__c.substring(0,1) );
        if (acct.DNA_Cust_Key__c.substring(0,1) == 'O')
        {
            System.debug('Business Account');
            jsonBody = BuildJsonForBusinessAccount_updateMemberDetails(acct);
            errorJson = '{\"OrgMaintenanceResponse\": {         \"Errors\": {             \"Error\": {                 \"ErrorMessage\": \"<GET__STATUS>\",                 \"ErrorNumber\": \"<GET__STATUSCODE>\",                 \"OraErrorMessage\": \"User-Defined Exception\"             }         },         \"RequestTypeCode\": \"7759\",         \"WasSuccessful\": \"false\"     } }';
        }else{
            System.debug('Person Account');
            jsonBody = BuildJsonForPersonAccount_updateMemberDetails(acct);
            errorJson = '{\"PersonMaintenanceResponse\": {         \"Errors\": {             \"Error\": {                 \"ErrorMessage\": \"<GET__STATUS>\",                 \"ErrorNumber\": \"<GET__STATUSCODE>\" }         },         \"RequestTypeCode\": \"7759\",         \"WasSuccessful\": \"false\"     } }';
        }
        
        system.debug(jsonBody);
        if(!Test.isRunningTest()){
            
         
        
            HttpResponse response1 = DNAHttpClient.CallDNAAPI(myUrl, jsonBody, 'PATCH');
            system.debug('response'+response1.getStatusCode());
        
            if (response1.getStatusCode() == 200) {
               
                String jsonStr = response1.getBody();
                system.debug('jsonstr :'+jsonStr);
                return  jsonStr;
            }
            else
            {
               errorJson = errorJson.replace('<GET__STATUS>', response1.getStatus());
               errorJson = errorJson.replace('<GET__STATUSCODE>',  String.valueOf(response1.getStatusCode()));
               return errorJson;
            }
        }
        else{
            jsonBody = 'fakeResponse';
            return jsonBody;
        }
    }
    
    @TestVisible private static string BuildJsonForBusinessAccount_updateMemberDetails(Account acct){
        system.debug('INSIDE BuildJsonForPersonAccount_updateMemberDetails');
        string jsonBody = '{\"RequestBase\": {         <ACCOUNT__ADDRESSES> \"IsValid\": \"true\",         \"MemberNumber\": \"<ACCOUNT__MEMBERNUMBER>\"         <ACCOUNT__PHONES>              } }';
        jsonBody = jsonBody.replace('<ACCOUNT__MEMBERNUMBER>', acct.DNA_Cust_Key__c);
        system.debug(jsonBody);
        string templateEmailAddress = '\"Addresses\": { <ACCOUNT_ADDRESS>} ';
        
        boolean primaryEmailExists = false;
        boolean businessEmailExists = false;
        string emailAddress1 = '';
        string businessAddress2 ='';
        if (string.isBlank(acct.Work_Email__c) == false){
            primaryEmailExists = true;
            emailAddress1 = '\"Address\": {             \"AddressLines\": {                 \"AddressLine\": {                     \"AddrLineTypCd\": \"ATTN\",                     \"Value\": \"'+acct.Work_Email__c +'\"                 }             },             \"CityName\": \"dummy\",             \"CountryCode\": \"USA\",             \"State\": null,             \"UseCode\": \"EBUS\",             \"ZipCode\": null         }';
        }
        
        if ((string.isBlank(acct.Mailing_City_Business__c) == false) && (string.isBlank(acct.Mailing_Country_Business__c) == false) && (string.isBlank(acct.Mailing_Street_Business__c) == false)){
            businessEmailExists = true;
            businessAddress2 = '\"Address\": {             \"AddressLines\": {                 \"AddressLine\": {                     \"AddrLineTypCd\": \"ST\",                     \"Value\": \"'+ acct.Mailing_Street_Business__c +'\"                 }             },             \"CityName\": \"'+ acct.Mailing_City_Business__c +'\",             \"CountryCode\": \"'+ acct.Mailing_Country_Business__c +'\",             \"MailCode\": \"",\"State\": \"<BUSINESS__STATE>\",             \"UseCode\": \"PRI\",             \"ZipCode\": \"<BUSINESS__ZIP>\",             \"ZipSuffix\": \"\"         }';
            if (string.isBlank(acct.Mailing_State_Business__c) ==  false)
                businessAddress2 = businessAddress2.replace('<BUSINESS__STATE>', acct.Mailing_State_Business__c);
            if (string.isBlank(acct.Mailing_Postal_Code_Business__c) ==  false)
                businessAddress2 = businessAddress2.replace('<BUSINESS__ZIP>', acct.Mailing_Postal_Code_Business__c);
            
        }
        
        if (primaryEmailExists & businessEmailExists)
            emailAddress1 = emailAddress1 + ',';
        
        if (businessEmailExists)
        {emailAddress1 = emailAddress1 +  businessAddress2;} 
        
        if (businessEmailExists || primaryEmailExists)
        {
            templateEmailAddress = templateEmailAddress.replace('<ACCOUNT_ADDRESS>', emailAddress1) + ',';
        }
        else
        {
            templateEmailAddress = '';
        }
        
        
        system.debug(emailAddress1);        
        
        
        system.debug(templateEmailAddress);
        jsonBody = jsonBody.replace('<ACCOUNT__ADDRESSES>', templateEmailAddress);
        system.debug(jsonBody);
        
        string templatePhones = ', \"Phones\": {             			\"Phone\": [                 		{                     			\"AreaCode\": \"<BUSACCOUNT__AREACODE>\",                     			\"CountryCode\": \"USA\",                     			\"Exchange\": \"<BUSACCOUNT__EXCHANGE>\",                     			\"IsPreferred\": \"false\",                     			\"Number\": \"<BUSACCOUNT__NUMBER>\",                     			\"ShouldDelete\": \"<PHONE__BUS__SHOULDDELETE>\",                     			\"ShouldUpdate\": \"<PHONE__BUS__SHOULDUPDATE>\",                     			\"UsageCode\": \"BUS\"                 		}             			]         		} ';
        if (String.isBlank(acct.Work_Phone__c)){
            templatePhones = templatePhones.replace('<PHONE__BUS__SHOULDDELETE>', 'true');
            templatePhones = templatePhones.replace('<PHONE__BUS__SHOULDUPDATE>', 'false');
            templatePhones = templatePhones.replace('<BUSACCOUNT__NUMBER>', '1111');
            templatePhones = templatePhones.replace('<BUSACCOUNT__AREACODE>', '111');
            templatePhones = templatePhones.replace('<BUSACCOUNT__EXCHANGE>', '111');
        }else{
            string plainOtherPhone = acct.Work_Phone__c;
            plainOtherPhone = plainOtherPhone.replaceAll('[^0-9]', '');
            string busareacode = plainOtherPhone.substring(0,3);
            string busexchange = plainOtherPhone.substring(3,6);
            string busphone = plainOtherPhone.substring(6,10);
            system.debug(busphone);
            templatePhones = templatePhones.replace('<BUSACCOUNT__NUMBER>', busphone);
            templatePhones = templatePhones.replace('<PHONE__BUS__SHOULDDELETE>', 'false');
            templatePhones = templatePhones.replace('<PHONE__BUS__SHOULDUPDATE>', 'true');
            templatePhones = templatePhones.replace('<BUSACCOUNT__AREACODE>', busareacode);
            templatePhones = templatePhones.replace('<BUSACCOUNT__EXCHANGE>', busexchange);
        }
        
        
        jsonBody = jsonBody.replace('<ACCOUNT__PHONES>', templatePhones);
        
        system.debug(jsonBody);
        
        
        return jsonBody;
    }
    
    @TestVisible private static string BuildJsonForPersonAccount_updateMemberDetails(Account acct){
        system.debug('INSIDE BuildJsonForPersonAccount_updateMemberDetails');
        string jsonBody = '{\"RequestBase\": {         <PERSONACCOUNT__ADDRESSES>         <PERSONACCOUNT__EMAILADDRESS>         \"IsValid\": \"true\",         \"Name\": {             \"FirstName\": \"<PERSONACCOUNT__FIRSTNAME>\",             \"LastName\": \"<PERSONACCOUNT__LASTNAME>\"         },         \"MemberNumber\": \"<PERSONACCOUNT__MEMBERNUMBER>\"         <PERSONACCOUNT__PHONES>              } }';
        jsonBody = jsonBody.replace('<PERSONACCOUNT__MEMBERNUMBER>', acct.DNA_Cust_Key__c);
        jsonBody = jsonBody.replace('<PERSONACCOUNT__FIRSTNAME>', acct.FirstName);
        jsonBody = jsonBody.replace('<PERSONACCOUNT__LASTNAME>', acct.LastName);
        system.debug(jsonBody);
        
        string templateEmailAddress = '\"EmailAddresses\":{\"EmailAddress\":[<EMAILADDRESSES__C>]},';
        boolean primaryEmailExists = false;
        boolean businessEmailExists = false;
        string emailAddress2 = '';
        string emailAddress1 = '';
        if (string.isBlank(acct.PersonEmail) == false){
            primaryEmailExists = true;
            emailAddress1 = '{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"'+ acct.PersonEmail +'\"}},\"IsDelete\":\"false\",\"addrUseCode\":\"EML\"}';
        }
        else
        {
            primaryEmailExists = true;
            emailAddress1 = '{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"dummyEmail@email.com\"}},\"IsDelete\":\"true\",\"addrUseCode\":\"EML\"}';
        }
        if (string.isBlank(acct.Work_Email__c) == false){
            businessEmailExists = true;
            emailAddress2 = '{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"'+ acct.Work_Email__c +'\"}},\"IsDelete\":\"false\",\"addrUseCode\":\"EBUS\"}';
        }else
        {
            businessEmailExists = true;
            emailAddress2 = '{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"dummyemail@email.com\"}},\"IsDelete\":\"true\",\"addrUseCode\":\"EBUS\"}';
        }
        
        if (primaryEmailExists & businessEmailExists)
            emailAddress1 = emailAddress1 + ',';
        
        if (businessEmailExists)
        {emailAddress1 = emailAddress1 +  emailAddress2;} 
        
        if (businessEmailExists || primaryEmailExists)
        {
            templateEmailAddress = templateEmailAddress.replace('<EMAILADDRESSES__C>', emailAddress1);
        }
        else
        {
            templateEmailAddress = '';
        }
        
        system.debug(templateEmailAddress);
        jsonBody = jsonBody.replace('<PERSONACCOUNT__EMAILADDRESS>', templateEmailAddress);
        system.debug(jsonBody);
        
        string templateAddresses = '\"Addresses\": { <ACCOUNT_ADDRESS>},';
        string personAddress2 = '';
        boolean personAddressExists = false;
        
        if ((string.isBlank(acct.PersonMailingCity) == false) && (string.isBlank(acct.PersonMailingCountry) == false) && (string.isBlank(acct.PersonMailingStreet) == false)){
            personAddressExists = true;
            personAddress2 = '\"Address\": {             \"AddressLines\": {                 \"AddressLine\": {                     \"AddrLineTypCd\": \"ST\",                     \"Value\": \"'+ acct.PersonMailingStreet +'\"                 }             },             \"CityName\": \"'+ acct.PersonMailingCity +'\",             \"CountryCode\": \"'+ acct.PersonMailingCountry +'\",             \"MailCode\": \"",\"State\": \"<PERSON__STATE>\",             \"UseCode\": \"PRI\",             \"ZipCode\": \"<Person__ZIP>\",             \"ZipSuffix\": \"\"         }';
            if (string.isBlank(acct.PersonMailingState) ==  false){
                system.debug('inside state condition');
                system.debug(acct.PersonMailingState);
                personAddress2 = personAddress2.replace('<PERSON__STATE>', acct.PersonMailingState);
            }
            if (string.isBlank(acct.PersonMailingPostalCode) ==  false)
                personAddress2 = personAddress2.replace('<Person__ZIP>', acct.PersonMailingPostalCode);
            
        }
        system.debug(personAddress2);
        if (personAddressExists)
        {
            templateAddresses = templateAddresses.replace('<ACCOUNT_ADDRESS>', personAddress2);
            jsonBody = jsonBody.replace('<PERSONACCOUNT__ADDRESSES>', templateAddresses);
        }
        else
        {
            jsonBody = jsonBody.replace('<PERSONACCOUNT__ADDRESSES>', '');
        }
        system.debug(jsonBody);
        
        string templatePhones = ', \"Phones\": {             \"Phone\": [                 {                     \"AreaCode\": \"<PERSONPHONE__AREACODE>\",                     \"CountryCode\": null,                     \"Exchange\": \"<PERSONPHONE_EXCHANGE>\",                     \"IsPreferred\": \"false\",                      \"Number\": \"<PERSONACCOUNT__PHONE__PERSONAL>\",                     \"ShouldDelete\": \"<PERSONACCOUNT__PHONE__PERSONAL__SHOULDDELETE>\",                      \"ShouldUpdate\": \"<PERSONACCOUNT__PHONE__PERSONAL__SHOULDUPDATE>\",                      \"UsageCode\": \"PER\"                  },                 {                    \"AreaCode\": \"<PERSON_CELL_AREACODE>\",                     \"CountryCode\": null,                     \"Exchange\": \"<PERSON_CELL_EXCHANGE>\",                     \"IsPreferred\": \"false\",                      \"Number\": \"<PERSONACCOUNT__PHONE__CELL>\",                     \"ShouldDelete\": \"<PERSONACCOUNT__PHONE__CELL__SHOULDDELETE>\",                      \"ShouldUpdate\": \"<PERSONACCOUNT__PHONE__CELL__SHOULDUPDATE>\",                      \"UsageCode\": \"CELL\"                  },                 {                     \"AreaCode\": \"<PERSON_BUSINESS_AREACODE>\",                     \"CountryCode\": null,                     \"Exchange\": \"<PERSON_BUSINESS_EXCHANGE>\",                     \"IsPreferred\": \"false\",                      \"Number\": \"<PERSONACCOUNT__PHONE__BUS>\",                     \"ShouldDelete\": \"<PERSONACCOUNT__PHONE__BUS__SHOULDDELETE>\",                      \"ShouldUpdate\": \"<PERSONACCOUNT__PHONE__BUS__SHOULDUPDATE>\",                      \"UsageCode\": \"BUS\"                 }             ]         }  ';
        
        if (String.isBlank(acct.PersonHomePhone)){
            
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL__SHOULDDELETE>', 'true');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL__SHOULDUPDATE>', 'false');
            templatePhones = templatePhones.replace('<PERSONPHONE__AREACODE>', '111');
            templatePhones = templatePhones.replace('<PERSONPHONE_EXCHANGE>', '111');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL>', '1111');
        }else{
            string plainPersonHomePhone = acct.PersonHomePhone;
            plainPersonHomePhone = plainPersonHomePhone.replaceAll('[^0-9]', '');
            string areacode = plainPersonHomePhone.substring(0,3);
            string exchange = plainPersonHomePhone.substring(3,6);
            string phone = plainPersonHomePhone.substring(6,10);
            system.debug(phone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL>', phone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL__SHOULDDELETE>', 'false');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL__SHOULDUPDATE>', 'true');
            templatePhones = templatePhones.replace('<PERSONPHONE__AREACODE>', areacode);
            templatePhones = templatePhones.replace('<PERSONPHONE_EXCHANGE>', exchange);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__PERSONAL>', phone);
        }
        
        if (String.isBlank(acct.PersonMobilePhone)){
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL__SHOULDDELETE>', 'true');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL__SHOULDUPDATE>', 'false');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL>', '1111');
            templatePhones = templatePhones.replace('<PERSON_CELL_AREACODE>', '111');
            templatePhones = templatePhones.replace('<PERSON_CELL_EXCHANGE>', '111');
        }else{
            string plainPersonMobilePhone = acct.PersonMobilePhone;
            plainPersonMobilePhone = plainPersonMobilePhone.replaceAll('[^0-9]', '');
            string mobileareacode = plainPersonMobilePhone.substring(0,3);
            string mobileexchange = plainPersonMobilePhone.substring(3,6);
            string mobilephone = plainPersonMobilePhone.substring(6,10);
            system.debug(mobilephone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL>', mobilephone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL__SHOULDDELETE>', 'false');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__CELL__SHOULDUPDATE>', 'true');
            templatePhones = templatePhones.replace('<PERSON_CELL_AREACODE>', mobileareacode);
            templatePhones = templatePhones.replace('<PERSON_CELL_EXCHANGE>', mobileexchange);
        }
        system.debug('acct.PersonOtherPhone'+acct.PersonOtherPhone);
        if (String.isBlank(acct.PersonOtherPhone)){
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS__SHOULDDELETE>', 'true');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS__SHOULDUPDATE>', 'false');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS>', '1111');
            templatePhones = templatePhones.replace('<PERSON_BUSINESS_AREACODE>', '111');
            templatePhones = templatePhones.replace('<PERSON_BUSINESS_EXCHANGE>', '111');
        }else{
            string plainPersonOtherPhone = acct.PersonOtherPhone;
            plainPersonOtherPhone = plainPersonOtherPhone.replaceAll('[^0-9]', '');
            string busareacode = plainPersonOtherPhone.substring(0,3);
            string busexchange = plainPersonOtherPhone.substring(3,6);
            string busphone = plainPersonOtherPhone.substring(6,10);
            system.debug(busphone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS>', busphone);
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS__SHOULDDELETE>', 'false');
            templatePhones = templatePhones.replace('<PERSONACCOUNT__PHONE__BUS__SHOULDUPDATE>', 'true');
            templatePhones = templatePhones.replace('<PERSON_BUSINESS_AREACODE>', busareacode);
            templatePhones = templatePhones.replace('<PERSON_BUSINESS_EXCHANGE>', busexchange);
        }
        
        system.debug(templatePhones);
        jsonBody = jsonBody.replace('<PERSONACCOUNT__PHONES>', templatePhones);
        system.debug(jsonBody);
        
        return jsonBody;
    }
    
    /*  public static MemberTestJSON getMemberDetails(String memberNumber){
String API_URL = Label.DNAPROXY_API_URL + '/member/' + memberNumber;
system.debug('API_URL'+API_URL);
if(!Test.isRunningTest()){
HttpResponse response = DNAHttpClient.getAPI(API_URL);
system.debug('response'+response.getStatusCode());
if (response.getStatusCode() == 200) {
system.debug('response'+response);
MemberTestJSON personDetailResponse = (MemberTestJSON)JSON.deserialize(response.getBody() , MemberTestJSON.class);
system.debug('personDetailResponse1'+personDetailResponse);
return personDetailResponse;
} 
else{
return null;        		
}
}else{
return null;
}


}*/
    
    public static AccountDetailInquiryResponse_v4 getAccountDetails(String accountNumber){
        String API_URL = Label.DNAPROXY_API_URL + '/account/' + accountNumber;
        
        if(!Test.isRunningTest()){
            HttpResponse response = DNAHttpClient.getAPI(API_URL);
            if (response.getStatusCode() == 200) {
                system.debug('BODY' + response.getBody() );
                AccountDetailInquiryResponse_v4 accDetailResponse = (AccountDetailInquiryResponse_v4)JSON.deserialize(response.getBody() , AccountDetailInquiryResponse_v4.class);
                return accDetailResponse;
            } 
            else{
                return mockAccountDetailInquiryResponse();        		
            }
        }else{
            return mockAccountDetailInquiryResponse();
        }
        
        
    }
    
    public static ServiceCUAccountTransactions getAccountTransactionHistory(String requestBody){       
        String API_URL = Label.DNAPROXY_API_URL + '/account/transaction';
        system.debug('API_URL'+API_URL);
       if(!Test.isRunningTest()){
            HttpResponse response = DNAHttpClient.CallDNAAPI(API_URL,requestBody,'POST');
            system.debug('response code'+response.getStatusCode());
            if (response.getStatusCode() == 200) {
                system.debug('response body'+response.getBody());
                ServiceCUAccountTransactions accountTransactionHistory = (ServiceCUAccountTransactions)JSON.deserialize(response.getBody() , ServiceCUAccountTransactions.class);
                return accountTransactionHistory;
           } 
            else{
                return null;        		
            }
        }else{
            return mockAccountTransactionHistory();
        }
    }
    
    private static PersonDetailInquiryResponse mockPersonDetailInquiryResponse(){
        List<Test_Data_For_JSON_Response__mdt> listOfDta = [SELECT MasterLabel,Id,JSON_Response__c from Test_Data_For_JSON_Response__mdt Where MasterLabel =:'Person Data Response Account'];
         PersonDetailInquiryResponse personDetailResponse = (PersonDetailInquiryResponse)JSON.deserialize(listOfDta[0].JSON_Response__c , PersonDetailInquiryResponse.class);
         return personDetailResponse;
    }
    
    private static BusinessDetailInquiryResponse mockBusinessDetailInquiryResponse(){
        List<Test_Data_For_JSON_Response__mdt> listOfDta = [SELECT Id,Business_Json_Response__c,MasterLabel from Test_Data_For_JSON_Response__mdt Where MasterLabel =:'Person Data Response Account'];
         BusinessDetailInquiryResponse BusinessDetailResponse = (BusinessDetailInquiryResponse)JSON.deserialize(listOfDta[0].Business_Json_Response__c , BusinessDetailInquiryResponse.class);
         return BusinessDetailResponse;
    }
    
    private static AccountDetailInquiryResponse_v4 mockAccountDetailInquiryResponse(){
       
        List<Test_Data_For_JSON_Response__mdt> listOfDta = [SELECT Id,Business_Json_Response__c,MasterLabel,Account_Data_Response_JSON__c from Test_Data_For_JSON_Response__mdt Where MasterLabel =:'Person Data Response Account'];
        AccountDetailInquiryResponse_v4 acctDetailResp = (AccountDetailInquiryResponse_v4)JSON.deserialize(listOfDta[0].Account_Data_Response_JSON__c , AccountDetailInquiryResponse_v4.class);
        return acctDetailResp; // Return logical JSON        
    }
    
    private static ServiceCUAccountTransactions mockAccountTransactionHistory(){
         List<Test_Data_For_JSON_Response__mdt> listOfDta = [SELECT MasterLabel,Id,JSON_Response__c from Test_Data_For_JSON_Response__mdt Where MasterLabel =:'AccountTransactironHistory'];
         ServiceCUAccountTransactions accountTransactionHistoryResponse = (ServiceCUAccountTransactions)JSON.deserialize(listOfDta[0].JSON_Response__c , ServiceCUAccountTransactions.class);
         return accountTransactionHistoryResponse;
    }
    
}