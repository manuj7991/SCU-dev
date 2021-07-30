public class BusinessDetailInquiryResponse{
    public cls_OrgDetailInquiryResponse OrgDetailInquiryResponse;
    public Account AccountInformation;
    public class cls_OrgDetailInquiryResponse {
        public cls_Errors Errors;
        //   public cls_RequestNumber RequestNumber;
        public String RequestNumber;
        public String RequestTypeCode;	//7727
        public String WasSuccessful;	//true
        public cls_Addresses[] Addresses;
        public String CurrRouteNbr;
        public String CustomerTypeCode;
        public String CustomerTypeDescription;
        public String DateLastMaintained;	//2021-07-05T00:00:00
        public cls_ElectronicAddresses[] ElectronicAddresses;
        public String ForeignCertExpDate;
        public cls_ForeignTaxTds[] ForeignTaxTds;
        public String HSAdata;
        public String MemberAgreementNumber;	//38006410
        public String MemberGroupCode;	//MEMB
        public String MemberGroupDescription;	//Member
        public String NAICSNumber;
        public String NAICSTypeCode;
        public String NAICSTypeDescription;
        public String OrgName;	//The Paul And Janet Reed Joint Revocable Trust
        public String OrgNumber;	//5132
        public cls_OrgTaxIds[] OrgTaxIds;
        public String OrgTypeCode;	//TRST
        public String OrgTypeDescription;	//Trust
        public cls_Phones[] Phones;
        public String PrivacyRequested;	//false
        public String RemoteDepositRisk;
        public String SICCode;
        public String SICDescription;
        public String SICSubCode;
        public String SICSubDescription;
        public String ShareAccountNumber;	//3800641000
        public String ShouldReport1099Interest;	//true
        public cls_UserFields[] UserFields;
    }
    
    class cls_Errors {
        public cls_Error Error;
    }
    class cls_Error {
        public String ErrorMessage;
        public String ErrorNumber;
    }
    
    class cls_Addresses {
        public cls_AddressLines[] AddressLines;
        public String AddressNumber;	//566226
        public String AddressUseCode;	//PRI
        public String CensusTractNumber;
        public String CityName;	//SanMary
        public String CountryCode;	//USA
        public String CountrySubdivisionCode;
        public String IsElectronic;	//false
        public String MailCode;
        public String SMSANumber;
        public String SeasonalAddress;
        public String StateCode;	//FL
        public String ZipCode;	//32808
        public String ZipSuffix;
    }
    class cls_AddressLines {
        public String AddressLineNumber;	//1
        public String AddressLineText;	//12 ABC STREET
        public String AddressLineTypeCode;	//ST
    }
    
    class cls_ElectronicAddresses {
        public String AddressNumber;	//954395
        public String AddressUseCode;	//EBUS
        public cls_ElectronicAddressLines[] ElectronicAddressLines;
        public String IsElectronic;	//true
    }
    class cls_ElectronicAddressLines {
        public String AddressLineLastUpdatedDate;	//2021-07-05T00:00:00
        public String AddressLineNumber;	//1
        public String AddressLineText;	//asdasda@fiserv.com
        public String AddressLineTypeCode;	//ATTN
    }
    
    class cls_ForeignTaxTds {
        public String CountryCode;
        public String TaxIDTyp;
        public String TaxIdApplyDate;
        public String TaxIdCertDate;
        public String TaxIdNbr;
    }
    
    class cls_OrgTaxIds {
        public String DateTaxCertified;	//1992-10-06T00:00:00
        public String DateTaxIdApply;
        public String TaxId;	//02-3426671
        public String TaxIdDisplay;	//02-3426671
        public String TaxIdDisplayIsMasked;	//false
        public String TaxIdTypeCode;	//FEIN
        public String TaxIdTypeDescription;	//Federal Employer Tax Id
    }
    
    class cls_Phones {
        public String AreaCode;	//888
        public String CountryCode;	//USA
        public String Exchange;	//888
        public String ForeignPhoneNumber; /////// BUS walla lena hai
        public String IsPreferred;	//false
        public String PhoneCode;
        public String PhoneExtension;
        public String PhoneLastUpdatedDate;	//2021-07-05T00:00:00
        public String PhoneNumber;	//8888
        public String PhoneSequenceNumber;	//1
        public String PhoneUseCode;	//BUS
    }
    
    class cls_UserFields {
        public String UserFieldCode;	//8EDC
        public String UserFieldDescription;	//Entity Date of Last Contact
        public cls_UserFieldValueDescription UserFieldValueDescription;
        public String Value;	//2021-06-19
        public String ValueLastUpdatedDate;	//2021-06-19T00:00:00
    }
    class cls_UserFieldValueDescription {
    }
    public static BusinessDetailInquiryResponse parse(String json){
        return (BusinessDetailInquiryResponse) System.JSON.deserialize(json, BusinessDetailInquiryResponse.class);
    }
    
    public static Account BusinessDetailInquiryResponse(cls_OrgDetailInquiryResponse BusinessDetailInquiryWrapper, String ExternalIdKey, String AccountId){
        Account accountRecord = new Account();
        if(BusinessDetailInquiryWrapper.ElectronicAddresses != null){
            for(cls_ElectronicAddresses addressess:BusinessDetailInquiryWrapper.ElectronicAddresses){
                accountRecord.Mail_Indicator__c = addressess.IsElectronic;
                For(cls_ElectronicAddressLines addressline:addressess.ElectronicAddressLines){
                    accountRecord.Work_Email__c =  addressline.AddressLineText != NULL ? addressline.AddressLineText : null;
                    
                }
            }
            for(cls_Phones Phone:BusinessDetailInquiryWrapper.Phones){
                String combinedPhoneNumber = Phone.AreaCode + Phone.Exchange + Phone.PhoneNumber;
                If (Phone.PhoneUseCode == 'BUS' && !String.isEmpty(combinedPhoneNumber)){
                    accountRecord.Work_Phone__c = combinedPhoneNumber;
                    If(Phone.IsPreferred == 'true'){
                        accountRecord.Contact_Preference_Phone__c = combinedPhoneNumber;
                    }
                }
            }
            accountRecord.Privacy_Indicatory__c = BusinessDetailInquiryWrapper.PrivacyRequested != NULL ? BusinessDetailInquiryWrapper.PrivacyRequested : null;
        }
        
        if(BusinessDetailInquiryWrapper.Addresses != null){
            for(cls_Addresses addressess:BusinessDetailInquiryWrapper.Addresses){
                String StreetAddr = '';
                For(cls_AddressLines addressline:addressess.AddressLines){
                    System.debug('addressline'+addressline.AddressLineText);
                    StreetAddr = StreetAddr +' '+ addressline.AddressLineText;
                }
                accountRecord.Mailing_Street_Business__c = StreetAddr != NULL ? StreetAddr:null;
                accountRecord.Mailing_City_Business__c = addressess.CityName != NULL ? addressess.CityName:null;
                accountRecord.Mailing_Country_Business__c = addressess.CountryCode != NULL ? addressess.CountryCode:null;
                accountRecord.Mailing_State_Business__c = addressess.StateCode != NULL ? addressess.StateCode:null;
                accountRecord.Mailing_Postal_Code_Business__c = addressess.ZipCode != NULL ? addressess.ZipCode:null;
            }
        }
        
        
        /*    BusinessDetailInquiryWrapper.Addresses = new List<cls_Addresses>();
system.debug('hell12'+BusinessDetailInquiryWrapper.Addresses);
If(BusinessDetailInquiryWrapper.Addresses != null){
system.debug('hell1');
for(cls_Addresses Addrs:BusinessDetailInquiryWrapper.Addresses){
system.debug('hell14');
If(Addrs.AddressLines!= null){
system.debug('hell13');
String StreetAddr = '';
For(cls_AddressLines Addr:Addrs.AddressLines){
StreetAddr = StreetAddr +' '+ Addr.AddressLineText;
}
accountRecord.Mailing_Street_Business__c = StreetAddr != NULL ? StreetAddr:null;
for(cls_Addresses addressDetails:BusinessDetailInquiryWrapper.Addresses){
accountRecord.Mailing_City_Business__c = addressDetails.CityName != NULL ? addressDetails.CityName:null;
accountRecord.Mailing_Country_Business__c = addressDetails.CountryCode != NULL ? addressDetails.CountryCode:null;
accountRecord.FinServ__CountryOfResidence__pc = addressDetails.CountryCode != NULL ? addressDetails.CountryCode:null;
accountRecord.Mailing_State_Business__c = addressDetails.StateCode != NULL ? addressDetails.StateCode:null;
accountRecord.Mailing_Postal_Code_Business__c = addressDetails.ZipCode != NULL ? addressDetails.ZipCode:null;
}
}
}
}*/
        accountRecord.DNA_Cust_Key__c = ExternalIdKey;
        accountRecord.Id = AccountId;
        return accountRecord;   
    }
    
    
}