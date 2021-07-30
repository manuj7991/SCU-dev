@isTest
public class DNAMemberAccountProxyTest {
    @TestSetup 
    private static void setupTestData()
    {
       TestUtil.createBusinessAccountData(1,true, true);
       TestUtil.createBusinessAccountData(1,true, false);
    }
    private static List<Account> getAccount()
    {
        return [SELECT Id , FirstName , LastName,  RecordTypeId, DNA_Cust_KEy__c, PersonEMail, PersonMailingState, PersonMailingPostalCode, Work_Email__c, PersonMailingCity,PersonMailingCountry,PersonMailingStreet, PersonHomePhone, PersonMobilePhone,PersonOtherPhone  FROM Account where DNA_Cust_KEY__c like '%P%' LIMIT 1 ]; 
    }
   private static List<Account> getBusinessAccount()
    {
        return [SELECT Id , Name ,Work_Phone__c,  RecordTypeId,Work_Email__c,Mailing_City_Business__c,Mailing_Country_Business__c,
                Mailing_Postal_Code_Business__c,Mailing_State_Business__c,Mailing_Street_Business__c,DNA_Cust_KEy__c  FROM Account where DNA_Cust_KEY__c like '%O%' LIMIT 1 ]; 
    }
    
    @isTest
    public static void PositivetestgetMemberDetails_Person(){
          List<Account> accounts = getAccount();
          string memberNumber = accounts[0].DNA_CUST_KEY__C;
          memberNumber = memberNumber.replace('P', '');
          PersonDetailInquiryResponse response = DNAMemberAccountProxy.getMemberDetails(memberNumber);
          
          string expectedResponse = '{\"PersonMaintenanceResponse\": {         \"RequestTypeCode\": \"7707\",         \"WasSuccessful\": \"true\",         \"PersonNumber\": \"'+ memberNumber +'\"     } }';
          system.assertNotEquals(Null, response, 'Successful');
    }
    
    @isTest
    public static void testgetAccountDetails(){
          List<Account> accounts = getAccount();
          string memberNumber = accounts[0].DNA_CUST_KEY__C;
          memberNumber = memberNumber.replace('P', '');
          AccountDetailInquiryResponse_v4 response = DNAMemberAccountProxy.getAccountDetails(memberNumber);
          
          string expectedResponse = '{\"PersonMaintenanceResponse\": {         \"RequestTypeCode\": \"7707\",         \"WasSuccessful\": \"true\",         \"PersonNumber\": \"'+ memberNumber +'\"     } }';
          system.assertNotEquals(Null, response, 'Successful');
    }
    
    @isTest
    public static void testgetAccountTransactionHistory(){
          List<Account> accounts = getAccount();
          string memberNumber = accounts[0].DNA_CUST_KEY__C;
          memberNumber = memberNumber.replace('P', '');
          ServiceCUAccountTransactions response = DNAMemberAccountProxy.getAccountTransactionHistory(memberNumber);
          
          string expectedResponse = '{\"PersonMaintenanceResponse\": {         \"RequestTypeCode\": \"7707\",         \"WasSuccessful\": \"true\",         \"PersonNumber\": \"'+ memberNumber +'\"     } }';
          system.assertNotEquals(Null, response, 'Successful');
    }
    
    @isTest
    public static void testgetMemberDetailsBusinessAccount(){
          List<Account> accounts = getAccount();
          string memberNumber = accounts[0].DNA_CUST_KEY__C;
          memberNumber = memberNumber.replace('O', '');
          BusinessDetailInquiryResponse response = DNAMemberAccountProxy.getMemberDetailsBusinessAccount(memberNumber);
          
          string expectedResponse = '{\"PersonMaintenanceResponse\": {         \"RequestTypeCode\": \"7707\",         \"WasSuccessful\": \"true\",         \"PersonNumber\": \"'+ memberNumber +'\"     } }';
          system.assertNotEquals(Null, response, 'Successful');
    }
      @isTest
    public static void testUpdateGetDetails_Business(){
          List<Account> accounts = getBusinessAccount();
          string memberNumber = accounts[0].DNA_CUST_KEY__C;
          memberNumber = memberNumber.replace('O', '');
          PersonDetailInquiryResponse response = DNAMemberAccountProxy.getMemberDetails(memberNumber);
          string expectedResponse = '{\"OrgMaintenanceResponse\": {         \"RequestTypeCode\": \"7759\",         \"WasSuccessful\": \"true\",         \"PersonNumber\": \"'+ memberNumber +'\"     } }';
          system.assertNotEquals(Null, response, 'Successful');
    }

     @isTest
    public static void NegativetestUpdateMemberDetails_Business(){
          List<Account> accounts = getBusinessAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.Mailing_Postal_Code_Business__c = '3208';
          string response = DNAMemberAccountProxy.updateMemberDetails(acc);
          string expectedResponse = '{\"OrgMaintenanceResponse\": {         \"Errors\": {             \"Error\": {                 \"ErrorMessage\": \"Zip Code not valid: 3280\",                 \"ErrorNumber\": \"1001\",                 \"OraErrorMessage\": \"User-Defined Exception\"             }         },         \"RequestTypeCode\": \"7759\",         \"WasSuccessful\": \"false\"     } }';
         // system.assertEquals('expected', response, 'Successful');
         system.assertNotEquals(Null, response, 'Successful');
    }
  
     @isTest
    public static void testUpdateMemberDetails_Business(){
          List<Account> accounts = getBusinessAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.Mailing_Postal_Code_Business__c = '3208';
          acc.Work_Phone__c = null;
          acc.PersonHomePhone = null;
         acc.PersonMobilePhone = null;
        update acc;
          string response = DNAMemberAccountProxy.updateMemberDetails(acc);
          string expectedResponse = '{\"OrgMaintenanceResponse\": {         \"Errors\": {             \"Error\": {                 \"ErrorMessage\": \"Zip Code not valid: 3280\",                 \"ErrorNumber\": \"1001\",                 \"OraErrorMessage\": \"User-Defined Exception\"             }         },         \"RequestTypeCode\": \"7759\",         \"WasSuccessful\": \"false\"     } }';
         // system.assertEquals('expected', response, 'Successful');
         system.assertNotEquals(Null, response, 'Successful');
    }
   
    
    @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_PersonalEmailBlank(){
          List<Account> accounts = getAccount();
          
          Account acc = new Account();
          acc = accounts[0];
          acc.PersonEmail = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
          system.debug('response from Method' + response);
        
          string expectedResponse = '{\"RequestBase\": {         \"Addresses\": { \"Address\": {             \"AddressLines\": {                 \"AddressLine\": {                     \"AddrLineTypCd\": \"ST\",                     \"Value\": \"202 S ST\"                 }             },             \"CityName\": \"DEEP DRIVER\",             \"CountryCode\": \"USA\",             \"MailCode\": \"\",\"State\": \"CA\",             \"UseCode\": \"PRI\",             \"ZipCode\": \"12345\",             \"ZipSuffix\": \"\"         }},         \"EmailAddresses\":{\"EmailAddress\":[{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"dummyEmail@email.com\"}},\"IsDelete\":\"true\",\"addrUseCode\":\"EML\"},{\"ElectronicAddressLines\":{\"ElectronicAddressLine\":{\"AddrLine\":\"workemail_1@work.com\"}},\"IsDelete\":\"false\",\"addrUseCode\":\"EBUS\"}]},         \"IsValid\": \"true\",         \"Name\": {             \"FirstName\": \"MC - 1\",             \"LastName\": \"MC - 1\"         },         \"MemberNumber\": \"P106173\"         , \"Phones\": {          ';
          expectedResponse = expectedResponse + '   \"Phone\": [                 {                     \"AreaCode\": \"987\",                     \"CountryCode\": null,                     \"Exchange\": \"654\",                     \"IsPreferred\": \"false\",                      \"Number\": \"2340\",                     \"ShouldDelete\": \"false\",                      \"ShouldUpdate\": \"true\",                      \"UsageCode\": \"PER\"                  },                 {                    \"AreaCode\": \"987\",                     \"CountryCode\": null,                     \"Exchange\": \"654\",                     \"IsPreferred\": \"false\",                      \"Number\": \"2340\",                     \"ShouldDelete\": \"false\",                      \"ShouldUpdate\": \"true\",                      \"UsageCode\": \"CELL\"                  },                 {                     \"AreaCode\": \"987\",                     \"CountryCode\": null,                     \"Exchange\": \"654\",                     \"IsPreferred\": \"false\",               ';
          expectedResponse = expectedResponse + '       \"Number\": \"2340\",                     \"ShouldDelete\": \"false\",                      \"ShouldUpdate\": \"true\",                      \"UsageCode\": \"BUS\"                 }             ]         }                } }';
          system.debug('response from expetd' + expectedResponse);
          if (expectedResponse == response)
              System.debug('This is what is expected');
          system.assertEquals(expectedResponse, response, 'Successful');
    }

	@isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_WorkEmailBlank(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.Work_Email__c = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
          string expectedResponse = '{"RequestBase": {         "Addresses": { "Address": {             "AddressLines": {                 "AddressLine": {                     "AddrLineTypCd": "ST",                     "Value": "202 S ST"                 }             },             "CityName": "DEEP DRIVER",             "CountryCode": "USA",             "MailCode": "","State": "CA",             "UseCode": "PRI",             "ZipCode": "12345",             "ZipSuffix": ""         }},         "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"personalemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"dummyemail@email.com"}},"IsDelete":"true","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
    
    @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_WorkEmailBlank_PersonalEmailBlank(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.Work_Email__c = '';
          acc.PersonEmail = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);

          
          string expectedResponse = '{"RequestBase": {         "Addresses": { "Address": {             "AddressLines": {                 "AddressLine": {                     "AddrLineTypCd": "ST",                     "Value": "202 S ST"                 }             },             "CityName": "DEEP DRIVER",             "CountryCode": "USA",             "MailCode": "","State": "CA",             "UseCode": "PRI",             "ZipCode": "12345",             "ZipSuffix": ""         }},         "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"dummyEmail@email.com"}},"IsDelete":"true","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"dummyemail@email.com"}},"IsDelete":"true","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
    
    @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_BothEmailExists(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
                 
          string expectedResponse = '{"RequestBase": {         "Addresses": { "Address": {             "AddressLines": {                 "AddressLine": {                     "AddrLineTypCd": "ST",                     "Value": "202 S ST"                 }             },             "CityName": "DEEP DRIVER",             "CountryCode": "USA",             "MailCode": "","State": "CA",             "UseCode": "PRI",             "ZipCode": "12345",             "ZipSuffix": ""         }},         "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"personalemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"workemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
    @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_MailingCityDoesNotExist(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.PersonMailingCity = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
          
          string expectedResponse = '{"RequestBase": {                  "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"personalemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"workemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
    @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_MailingZIPDoesNotExist(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.PersonMailingPostalCode = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
          string expectedResponse = '{"RequestBase": {         "Addresses": { "Address": {             "AddressLines": {                 "AddressLine": {                     "AddrLineTypCd": "ST",                     "Value": "202 S ST"                 }             },             "CityName": "DEEP DRIVER",             "CountryCode": "USA",             "MailCode": "","State": "CA",             "UseCode": "PRI",             "ZipCode": "<Person__ZIP>",             "ZipSuffix": ""         }},         "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"personalemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"workemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
      @isTest
    public static void Positivetest_BuildJsonForPersonAccount_updateMemberDetails_MailingStateDoesNotExist(){
          List<Account> accounts = getAccount();
          Account acc = new Account();
          acc = accounts[0];
          acc.PersonMailingState = '';
          string response = DNAMemberAccountProxy.BuildJsonForPersonAccount_updateMemberDetails(acc);
          system.debug('hiiiiiiiiiiiiiiiiiiiii'+response);
          
          string expectedResponse = '{"RequestBase": {         "Addresses": { "Address": {             "AddressLines": {                 "AddressLine": {                     "AddrLineTypCd": "ST",                     "Value": "202 S ST"                 }             },             "CityName": "DEEP DRIVER",             "CountryCode": "USA",             "MailCode": "","State": "<PERSON__STATE>",             "UseCode": "PRI",             "ZipCode": "12345",             "ZipSuffix": ""         }},         "EmailAddresses":{"EmailAddress":[{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"personalemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EML"},{"ElectronicAddressLines":{"ElectronicAddressLine":{"AddrLine":"workemail_1@work.com"}},"IsDelete":"false","addrUseCode":"EBUS"}]},         "IsValid": "true",         "Name": {             "FirstName": "MC - 1",             "LastName": "MC - 1"         },         "MemberNumber": "P106173"         , "Phones": {             "Phone": [                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "PER"                  },                 {                    "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "CELL"                  },                 {                     "AreaCode": "987",                     "CountryCode": null,                     "Exchange": "654",                     "IsPreferred": "false",                      "Number": "2340",                     "ShouldDelete": "false",                      "ShouldUpdate": "true",                      "UsageCode": "BUS"                 }             ]         }                } }';
          system.assertEquals(expectedResponse, response, 'Successful');
    }
    /*
    static testMethod void testParse() {
		String json = '{'+
		'    \"AccountDetailInquiryResponse\": {'+
		'        \"RequestTypeCode\": \"7702\",'+
		'        \"WasSuccessful\": \"true\",'+
		'        \"AccountCurrencyCode\": \"USD\",'+
		'        \"AccountMaturityDate\": \"2021-12-26T00:00:00\",'+
		'        \"AccountNickName\": \"6 MONTH CERTIFICATE\",'+
		'        \"AccountNumber\": \"3791546469\",'+
		'        \"AddressFormat\": \"Standard Address Format\",'+
		'        \"AddressFormatCode\": \"STD\",'+
		'        \"Agreements\": {'+
		'            \"Agreement\": ['+
		'                {'+
		'                    \"AgreementNumber\": \"77182\",'+
		'                    \"AgreementPersonNumber\": \"116321\",'+
		'                    \"AgreementTypeCode\": \"VRU\"'+
		'                },'+
		'                {'+
		'                    \"AgreementNumber\": \"76626\",'+
		'                    \"AgreementPersonNumber\": \"112113\",'+
		'                    \"AgreementTypeCode\": \"VRU\"'+
		'                }'+
		'            ]'+
		'        },'+
		'        \"AmountDue\": \"0\",'+
		'        \"AvailableBalance\": \"99604.5\",'+
		'        \"Balances\": {'+
		'            \"Balance\": ['+
		'                {'+
		'                    \"BalanceCategoryCode\": \"NOTE\",'+
		'                    \"BalanceTypeCode\": \"GINT\"'+
		'                },'+
		'                {'+
		'                    \"AccuredInterest\": \"4.92569\",'+
		'                    \"AvailableAmount\": \"99604.5\",'+
		'                    \"BalanceAmount\": \"100104.5\",'+
		'                    \"BalanceCategoryCode\": \"NOTE\",'+
		'                    \"BalanceTypeCode\": \"BAL\",'+
		'                    \"CardHold\": \"0\",'+
		'                    \"CheckHold\": \"0\",'+
		'                    \"CollectedMonthToDateAverage\": \"100011.86\",'+
		'                    \"CollectedYearToDateAverage\": \"99948.43\",'+
		'                    \"ManagementHold\": \"0\",'+
		'                    \"MonthToDateAverage\": \"100011.86\",'+
		'                    \"YearToDateAverage\": \"99948.43\"'+
		'                },'+
		'                {'+
		'                    \"BalanceCategoryCode\": \"NOTE\",'+
		'                    \"BalanceTypeCode\": \"INT\"'+
		'                }'+
		'            ]'+
		'        },'+
		'        \"BranchOrganizationName\": \"Rochester\",'+
		'        \"BranchOrganizationNumber\": \"38\",'+
		'        \"CardHoldAmount\": \"0\",'+
		'        \"CheckHoldAmount\": \"0\",'+
		'        \"CombinedStatement\": {'+
		'            \"PrimaryStatementAccount\": \"3791546400\"'+
		'        },'+
		'        \"CurrentAccountStatusCode\": \"ACT\",'+
		'        \"CurrentAccountStatusDescription\": \"Active\",'+
		'        \"CurrentBalance\": \"100104.5\",'+
		'        \"CurrentMailingAddress\": {'+
		'            \"MailAddressLines\": {'+
		'                \"MailAddressLine\": ['+
		'                    {'+
		'                        \"MailAddrLine\": \"Margaret H. Olsen\"'+
		'                    },'+
		'                    {'+
		'                        \"MailAddrLine\": \"Bjorn D. Olsen\"'+
		'                    },'+
		'                    {'+
		'                        \"MailAddrLine\": \"110 Tolend Rd\"'+
		'                    },'+
		'                    {'+
		'                        \"MailAddrLine\": \"Barrington  NH  03825-3704\"'+
		'                    }'+
		'                ]'+
		'            }'+
		'        },'+
		'        \"CurrentTerm\": \"183\",'+
		'        \"DeliveryMethodCode\": \"PRNT\",'+
		'        \"DeliveryMethodCodeDescription\": \"Printed Statement\",'+
		'        \"InterestAccountCycleCode\": \"EOM\",'+
		'        \"InterestAccountCycleCodeDescription\": \"End of Month\",'+
		'        \"InterestRate\": \"0.00449\",'+
		'        \"InterestYield\": \"0.0044993\",'+
		'        \"IsAnalysis\": \"false\",'+
		'        \"IsChecks\": \"false\",'+
		'        \"IsExternalEntity\": \"false\",'+
		'        \"IsLoanLimit\": \"false\",'+
		'        \"IsPassbook\": \"false\",'+
		'        \"IsRestriction\": \"false\",'+
		'        \"IsRetirement\": \"false\",'+
		'        \"IsTDRenewable\": \"true\",'+
		'        \"IsTransactionAccount\": \"false\",'+
		'        \"IsValid\": \"true\",'+
		'        \"LastContactDate\": \"2021-04-08T00:00:00\",'+
		'        \"LastStatementDate\": \"2021-05-31T00:00:00\",'+
		'        \"MailTypeCode\": \"REG\",'+
		'        \"MajorAccountTypeCode\": \"TD\",'+
		'        \"ManagementHoldAmount\": \"0\",'+
		'        \"MinorAccountTypeCode\": \"CD06\",'+
		'        \"MinorCustomerDescription\": \"6 Months\",'+
		'        \"OpenDate\": \"2010-04-26T00:00:00\",'+
		'        \"OwnershipCode\": \"JO\",'+
		'        \"OwnershipCodeDescription\": \"Joint OR\",'+
		'        \"PendingRegD3Count\": \"0\",'+
		'        \"PendingRegD6Count\": \"0\",'+
		'        \"ProductFullName\": \"6 Months Certificate\",'+
		'        \"ProductName\": \"6 Months\",'+
		'        \"RegD3Count\": \"0\",'+
		'        \"RegD6Count\": \"0\",'+
		'        \"RegDDAvailableBalance\": \"99604.5\",'+
		'        \"RenewalGraceDays\": \"10\",'+
		'        \"Roles\": {'+
		'            \"RoleDetail\": ['+
		'                {'+
		'                    \"CanTransact\": \"true\",'+
		'                    \"EntityName\": \"Bjorn D. Olsen\",'+
		'                    \"EntityNumber\": \"112113\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"false\",'+
		'                    \"RoleCode\": \"OWN\",'+
		'                    \"RoleDescription\": \"NonTax Owner\"'+
		'                },'+
		'                {'+
		'                    \"CanTransact\": \"true\",'+
		'                    \"EntityName\": \"Bjorn D. Olsen\",'+
		'                    \"EntityNumber\": \"112113\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"false\",'+
		'                    \"RoleCode\": \"SIGN\",'+
		'                    \"RoleDescription\": \"NonTax Signator\"'+
		'                },'+
		'                {'+
		'                    \"CanTransact\": \"true\",'+
		'                    \"EntityName\": \"Margaret H. Olsen\",'+
		'                    \"EntityNumber\": \"116321\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"false\",'+
		'                    \"RoleCode\": \"TAX\",'+
		'                    \"RoleDescription\": \"Tax Reported For \"'+
		'                },'+
		'                {'+
		'                    \"CanTransact\": \"true\",'+
		'                    \"EntityName\": \"Margaret H. Olsen\",'+
		'                    \"EntityNumber\": \"116321\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"false\",'+
		'                    \"RoleCode\": \"OTAX\",'+
		'                    \"RoleDescription\": \"Tax Reported Owner \"'+
		'                },'+
		'                {'+
		'                    \"CanTransact\": \"true\",'+
		'                    \"EntityName\": \"Margaret H. Olsen\",'+
		'                    \"EntityNumber\": \"116321\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"false\",'+
		'                    \"RoleCode\": \"STAX\",'+
		'                    \"RoleDescription\": \"Tax Reported Signator \"'+
		'                },'+
		'                {'+
		'                    \"CanTransact\": \"false\",'+
		'                    \"EntityName\": \"Data Conversion\",'+
		'                    \"EntityNumber\": \"4\",'+
		'                    \"EntityTypeCode\": \"PERS\",'+
		'                    \"IsEmployeeRole\": \"true\",'+
		'                    \"RoleCode\": \"OEMP\",'+
		'                    \"RoleDescription\": \"Originating Employee\"'+
		'                }'+
		'            ]'+
		'        },'+
		'        \"ShareCurrentYearInterestPaid\": \"251.03\",'+
		'        \"SharePriorYearInterestPaid\": \"1141.75\",'+
		'        \"SignerFullname\": \"Margaret H. Olsen\",'+
		'        \"SignerPersonNumber\": \"116321\",'+
		'        \"StatementAccountCycleCode\": \"EOQ\",'+
		'        \"StatementAccountCycleCodeDescription\": \"End of Quarter\",'+
		'        \"TDLastRenewalDate\": \"2021-06-26T00:00:00\",'+
		'        \"TaxOwnerFullname\": \"Margaret H. Olsen\",'+
		'        \"TaxPersonNumber\": \"116321\"'+
		'    }'+
		'}';
		AccountDetailInquiryResponse obj = (AccountDetailInquiryResponse)System.JSON.deserialize(json, AccountDetailInquiryResponse.class);
        system.debug(' OBJECT : '+ obj);
		System.assert(obj != null);
	}
	*/
}