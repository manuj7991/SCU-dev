@istest
public class PersonDetailEnquiryResponseTest {
@TestSetup 
    private static void setupTestData()
    {
        TestUtil.createAccountData(1,true);
    }
    
    private static List<Account> getAccount()
    {
        return [SELECT Id , Name,DNA_Cust_Key__c, RecordTypeId FROM Account]; 
    }
	static testMethod void testParse() {
		String json=		'{'+
		'  "PersonDetailInquiryResponse": {'+
		'    "PersonDetailInquiryResponse": {'+
		'      "Errors": null,'+
		'      "RequestNumber": null,'+
		'      "RequestTypeCode": "7711",'+
		'      "WasSuccessful": "true",'+
		'      "Addresses": ['+
		'        {'+
		'          "AddressLines": ['+
		'            {'+
		'              "AddressLineNumber": "1",'+
		'              "AddressLineText": "PO Box 803",'+
		'              "AddressLineTypeCode": "POBN"'+
		'            }'+
		'          ],'+
		'          "AddressNumber": "47634",'+
		'          "AddressUseCode": "PRI",'+
		'          "CensusTractNumber": null,'+
		'          "CityName": "Somersworth",'+
		'          "CountryCode": "USA",'+
		'          "CountrySubdivisionCode": null,'+
		'          "IsElectronic": "false",'+
		'          "MailCode": null,'+
		'          "SMSANumber": null,'+
		'          "SeasonalAddress": null,'+
		'          "StateCode": "NH",'+
		'          "ZipCode": "03878",'+
		'          "ZipSuffix": "0803"'+
		'        }'+
		'      ],'+
		'      "DateLastMaintained": "2021-04-28T00:00:00",'+
		'      "Demographics": {'+
		'        "AddDate": "2018-04-25T00:00:00",'+
		'        "CreditRatingCode": null,'+
		'        "CreditReportCode": null,'+
		'        "CustomerKeyword": "MANN",'+
		'        "CustomerTypeCode": null,'+
		'        "CustomerTypeDescription": null,'+
		'        "DateOfBirth": "1974-06-07T00:00:00",'+
		'        "DateOfDeath": "1974-06-07T00:00:00",'+
		'        "EducationLevel": null,'+
		'        "ForeignCertExpireDate": null,'+
		'        "GraduationDate": null,'+
		'        "IncomeLevel": null,'+
		'        "IsAllowPromCallsMsgs": "false",'+
		'        "IsValid": "true",'+
		'        "MailTypeCode": null,'+
		'        "MemberGroupCode": "MEMB",'+
		'        "NumberOfDependents": null,'+
		'        "Occupation": null,'+
		'        "OwnOrRent": null,'+
		'        "PreferredLocaleCode": null,'+
		'        "PrivacyRequested": "false",'+
		'        "PurgeFlag": "false",'+
		'        "RemoteDepositRisk": null,'+
		'        "Report1042sFlag": "false",'+
		'        "ShareAccountNumber": "4605113400",'+
		'        "SpousePersonNumber": null,'+
		'        "TaxCountryCode": "USA",'+
		'        "TaxCountryDescription": "United States",'+
		'        "TaxId": "001-64-9934",'+
		'        "TaxIdApplyDate": null,'+
		'        "TaxIdCertDate": "2018-04-25T00:00:00",'+
		'        "TaxIdDisplay": "001-64-9934",'+
		'        "TaxIdIsMasked": "false"'+
		'      },'+
		'      "Documents": ['+
		'        {'+
		'          "DocumentDescription": null,'+
		'          "DocumentNumber": null,'+
		'          "DocumentTitle": null,'+
		'          "DocumentTypeCode": null,'+
		'          "EffectiveDate": null'+
		'        }'+
		'      ],'+
		'      "ElectronicAddresses": ['+
		'        {'+
		'          "AddressNumber": "602770",'+
		'          "AddressUseCode": "EML",'+
		'          "ElectronicAddressLines": ['+
		'            {'+
		'              "AddressLineLastUpdatedDate": null,'+
		'              "AddressLineNumber": "1",'+
		'              "AddressLineText": "hagmandouglas@gmail.com",'+
		'              "AddressLineTypeCode": "ATTN"'+
		'            }'+
		'          ],'+
		'          "IsElectronic": "true"'+
		'        }'+
		'      ],'+
		'      "ForeignTaxTds": ['+
		'        {'+
		'          "CountryCode": null,'+
		'          "TaxIDTyp": null,'+
		'          "TaxIdApplyDate": null,'+
		'          "TaxIdCertDate": null,'+
		'          "TaxIdNbr": null'+
		'        }'+
		'      ],'+
		'      "MemberNumber": "46051134",'+
		'      "Name": {'+
		'        "FirstName": "Douglas",'+
		'        "LastName": "Hagman",'+
		'        "MiddleInitial": "E",'+
		'        "MiddleName": null,'+
		'        "NickName": null,'+
		'        "SalutationCode": null,'+
		'        "Suffix": null'+
		'      },'+
		'      "Orgs": ['+
		'        {'+
		'          "Addresses": ['+
		'            {'+
		'              "AddressLines": ['+
		'                {'+
		'                  "AddressLineNumber": "1",'+
		'                  "AddressLineText": "PO Box 803",'+
		'                  "AddressLineTypeCode": "POBN"'+
		'                }'+
		'              ],'+
		'              "AddressNumber": "47634",'+
		'              "AddressUseCode": "PRI",'+
		'              "CensusTractNumber": null,'+
		'              "CityName": "Somersworth",'+
		'              "CountryCode": "USA",'+
		'              "CountrySubdivisionCode": null,'+
		'              "IsElectronic": "false",'+
		'              "MailCode": null,'+
		'              "SMSANumber": null,'+
		'              "SeasonalAddress": null,'+
		'              "StateCode": "NH",'+
		'              "ZipCode": "03878",'+
		'              "ZipSuffix": "0803"'+
		'            }'+
		'          ],'+
		'          "MemberNumber": null,'+
		'          "OrgName": null,'+
		'          "OrgNumber": null,'+
		'          "OrgPersonRoles": null,'+
		'          "OrgTypeCode": null,'+
		'          "OrgTypeDescription": null,'+
		'          "Phones": ['+
		'            {'+
		'              "AreaCode": "603",'+
		'              "CountryCode": "USA",'+
		'              "Exchange": "380",'+
		'              "ForeignPhoneNumber": null,'+
		'              "IsPreferred": "false",'+
		'              "PhoneCode": null,'+
		'              "PhoneExtension": null,'+
		'              "PhoneLastUpdatedDate": "2020-07-17T00:00:00",'+
		'              "PhoneNumber": "4427",'+
		'              "PhoneSequenceNumber": "3843",'+
		'              "PhoneUseCode": "BUS"'+
		'            }'+
		'          ]'+
		'        }'+
		'      ],'+
		'      "PersExtOrgIds": ['+
		'        {'+
		'          "EffectiveDate": null,'+
		'          "ExternalId": null,'+
		'          "ExternalIdTypeCode": null,'+
		'          "ExternalOrgNumber": null'+
		'        }'+
		'      ],'+
		'      "PersIds": ['+
		'        {'+
		'          "CountryCode": null,'+
		'          "CountrySubdivisionCode": null,'+
		'          "Description": null,'+
		'          "ExpireDate": null,'+
		'          "IdValue": null,'+
		'          "IssueDate": null,'+
		'          "LastVerificationDate": null,'+
		'          "PersIdTypeCode": null,'+
		'          "StateCode": null'+
		'        }'+
		'      ],'+
		'      "PersTyps": ['+
		'        {'+
		'          "TypeCode": "CUST"'+
		'        }'+
		'      ],'+
		'      "PersonNumber": "20601",'+
		'      "Phones": ['+
		'        {'+
		'          "AreaCode": "603",'+
		'          "CountryCode": "USA",'+
		'          "Exchange": "380",'+
		'          "ForeignPhoneNumber": null,'+
		'          "IsPreferred": "false",'+
		'          "PhoneCode": null,'+
		'          "PhoneExtension": null,'+
		'          "PhoneLastUpdatedDate": "2020-07-17T00:00:00",'+
		'          "PhoneNumber": "4427",'+
		'          "PhoneSequenceNumber": "3843",'+
		'          "PhoneUseCode": "PER"'+
		'        },'+
        '{'+
		'          "AreaCode": "603",'+
		'          "CountryCode": "USA",'+
		'          "Exchange": "380",'+
		'          "ForeignPhoneNumber": null,'+
		'          "IsPreferred": "true",'+
		'          "PhoneCode": null,'+
		'          "PhoneExtension": null,'+
		'          "PhoneLastUpdatedDate": "2020-07-17T00:00:00",'+
		'          "PhoneNumber": "4427",'+
		'          "PhoneSequenceNumber": "3843",'+
		'          "PhoneUseCode": "CELL"'+
		'        }'+
		'      ],'+
		'      "UserFields": ['+
		'        {'+
		'          "UserFieldCode": "CHA1",'+
		'          "UserFieldDescription": "Challenge Answer 1",'+
		'          "UserFieldValueDescription": null,'+
		'          "Value": "KENNETT",'+
		'          "ValueLastUpdatedDate": "2021-05-23T00:00:00"'+
		'        },'+
		'        {'+
		'          "UserFieldCode": "CHA2",'+
		'          "UserFieldDescription": "Challenge Answer 2",'+
		'          "UserFieldValueDescription": null,'+
		'          "Value": "PATRIOTS",'+
		'          "ValueLastUpdatedDate": "2021-05-23T00:00:00"'+
		'        },'+
		'        {'+
		'          "UserFieldCode": "CHQ1",'+
		'          "UserFieldDescription": "Challenge Question 1",'+
		'          "UserFieldValueDescription": "What High School did you attend?",'+
		'          "Value": "A",'+
		'          "ValueLastUpdatedDate": "2021-05-23T00:00:00"'+
		'        },'+
		'        {'+
		'          "UserFieldCode": "CHQ2",'+
		'          "UserFieldDescription": "Challenge Question 2",'+
		'          "UserFieldValueDescription": "What is your favorite sports team?",'+
		'          "Value": "D",'+
		'          "ValueLastUpdatedDate": "2021-05-23T00:00:00"'+
		'        },'+
		'        {'+
		'          "UserFieldCode": "GNDR",'+
		'          "UserFieldDescription": "GENDER",'+
		'          "UserFieldValueDescription": null,'+
		'          "Value": "Unspecified",'+
		'          "ValueLastUpdatedDate": "2021-05-01T00:00:00"'+
		'        }'+
		'      ]'+
		'    }'+
		'  }'+
		'}';
        PersonDetailInquiryResponse obj1 = new PersonDetailInquiryResponse();
		PersonDetailInquiryResponse obj = PersonDetailInquiryResponse.parse(json);
        Account accountInstance = getAccount().get(0);
        system.assertNotEquals(null, new PersonDetailInquiryResponse(obj.PersonDetailInquiryResponse,accountInstance.DNA_Cust_Key__c,accountInstance.Id).AccountInformation, 'Wrapper Assignment of Person Account Failed');
		//System.assertEquals(PersonDetailInquiryResponse.parse(json) != null,true,'response is null');
		Map<String,String> quesMap = PersonDetailInquiryResponse.getMemberQuestions(obj.PersonDetailInquiryResponse.PersonDetailInquiryResponse.UserFields);
        system.assertNotEquals(null,quesMap);
	}
}