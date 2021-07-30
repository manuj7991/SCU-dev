@istest
public class BusinessDetailEnquiryResponseTest {
static testMethod void testParse() {
		String json='{'+
		'  "OrgDetailInquiryResponse": {'+
		'    "Errors": null,'+
		'    "RequestNumber": null,'+
		'    "RequestTypeCode": "7727",'+
		'    "WasSuccessful": "true",'+
		'    "Addresses": ['+
		'      {'+
		'        "AddressLines": ['+
		'          {'+
		'            "AddressLineNumber": "1",'+
		'            "AddressLineText": "216 Marlboro St",'+
		'            "AddressLineTypeCode": "ST"'+
		'          }'+
		'        ],'+
		'        "AddressNumber": "568221",'+
		'        "AddressUseCode": "PRI",'+
		'        "CensusTractNumber": null,'+
		'        "CityName": "Keene",'+
		'        "CountryCode": "USA",'+
		'        "CountrySubdivisionCode": null,'+
		'        "IsElectronic": "false",'+
		'        "MailCode": null,'+
		'        "SMSANumber": null,'+
		'        "SeasonalAddress": null,'+
		'        "StateCode": "NH",'+
		'        "ZipCode": "03431",'+
		'        "ZipSuffix": "4162"'+
		'      }'+
		'    ],'+
		'    "CurrRouteNbr": null,'+
		'    "CustomerTypeCode": null,'+
		'    "CustomerTypeDescription": null,'+
		'    "DateLastMaintained": "2021-04-28T00:00:00",'+
		'    "ElectronicAddresses": ['+
		'      {'+
		'        "AddressNumber": "956003",'+
		'        "AddressUseCode": "EBUS",'+
		'        "ElectronicAddressLines": ['+
		'          {'+
		'            "AddressLineLastUpdatedDate": null,'+
		'            "AddressLineNumber": "1",'+
		'            "AddressLineText": "TLCKEENE@YAHOO.COM",'+
		'            "AddressLineTypeCode": "ATTN"'+
		'          }'+
		'        ],'+
		'        "IsElectronic": "true"'+
		'      }'+
		'    ],'+
		'    "ForeignCertExpDate": null,'+
		'    "ForeignTaxIds": null,'+
		'    "HSAdata": null,'+
		'    "MemberAgreementNumber": "28623417",'+
		'    "MemberGroupCode": "MEMB",'+
		'    "MemberGroupDescription": "Member",'+
		'    "NAICSNumber": "1356",'+
		'    "NAICSTypeCode": "INAT",'+
		'    "NAICSTypeDescription": "National Industry",'+
		'    "OrgName": "Turning Leaf Consignment LLC",'+
		'    "OrgNumber": "7132",'+
		'    "OrgTaxIds": ['+
		'      {'+
		'        "DateTaxCertified": "2017-05-09T00:00:00",'+
		'        "DateTaxIdApply": null,'+
		'        "TaxId": "47-4629966",'+
		'        "TaxIdDisplay": "47-4629966",'+
		'        "TaxIdDisplayIsMasked": "false",'+
		'        "TaxIdTypeCode": "FEIN",'+
		'        "TaxIdTypeDescription": "Federal Employer Tax Id"'+
		'      }'+
		'    ],'+
		'    "OrgTypeCode": "LLC",'+
		'    "OrgTypeDescription": "Limited Liability Company",'+
		'    "Phones": ['+
		'      {'+
		'        "AreaCode": "603",'+
		'        "CountryCode": "USA",'+
		'        "Exchange": "903",'+
		'        "ForeignPhoneNumber": null,'+
		'        "IsPreferred": "false",'+
		'        "PhoneCode": null,'+
		'        "PhoneExtension": null,'+
		'        "PhoneLastUpdatedDate": null,'+
		'        "PhoneNumber": "3449",'+
		'        "PhoneSequenceNumber": "1",'+
		'        "PhoneUseCode": "CELL"'+
		'      },'+
		'      {'+
		'        "AreaCode": "603",'+
		'        "CountryCode": "USA",'+
		'        "Exchange": "903",'+
		'        "ForeignPhoneNumber": null,'+
		'        "IsPreferred": "false",'+
		'        "PhoneCode": null,'+
		'        "PhoneExtension": null,'+
		'        "PhoneLastUpdatedDate": null,'+
		'        "PhoneNumber": "3449",'+
		'        "PhoneSequenceNumber": "1",'+
		'        "PhoneUseCode": "PER"'+
		'      }'+
		'    ],'+
		'    "PrivacyRequested": "false",'+
		'    "RemoteDepositRisk": null,'+
		'    "SICCode": null,'+
		'    "SICDescription": null,'+
		'    "SICSubCode": null,'+
		'    "SICSubDescription": null,'+
		'    "ShareAccountNumber": "2862341700",'+
		'    "ShouldReport1099Interest": "true",'+
		'    "UserFields": ['+
		'      {'+
		'        "UserFieldCode": "8EDC",'+
		'        "UserFieldDescription": "Entity Date of Last Contact",'+
		'        "UserFieldValueDescription": null,'+
		'        "Value": "2021-06-19",'+
		'        "ValueLastUpdatedDate": "2021-06-19T00:00:00"'+
		'      },'+
		'      {'+
		'        "UserFieldCode": "CF56",'+
		'        "UserFieldDescription": "Home Banking",'+
		'        "UserFieldValueDescription": null,'+
		'        "Value": "Y",'+
		'        "ValueLastUpdatedDate": "2021-05-29T00:00:00"'+
		'      },'+
		'      {'+
		'        "UserFieldCode": "CF57",'+
		'        "UserFieldDescription": "HB and Bill Pay",'+
		'        "UserFieldValueDescription": null,'+
		'        "Value": "Y",'+
		'        "ValueLastUpdatedDate": "2021-05-29T00:00:00"'+
		'      },'+
		'      {'+
		'        "UserFieldCode": "CF75",'+
		'        "UserFieldDescription": "Mobile Banking",'+
		'        "UserFieldValueDescription": null,'+
		'        "Value": "Y",'+
		'        "ValueLastUpdatedDate": "2021-05-29T00:00:00"'+
		'      }'+
		'    ]'+
		'  }'+
		'}';
    Account acc = new Account();
    acc.Name = 'shiv';
    acc.DNA_Cust_Key__c = 'O5555';
    insert acc;
		BusinessDetailInquiryResponse obj = BusinessDetailInquiryResponse.parse(json);
        system.assertNotEquals(null, BusinessDetailInquiryResponse.BusinessDetailInquiryResponse(obj.OrgDetailInquiryResponse,acc.DNA_Cust_Key__c,string.valueOf(acc.Id)), 'Wrapper Assignment of Person Account Failed');
	}
}