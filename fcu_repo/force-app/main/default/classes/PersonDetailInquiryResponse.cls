public class PersonDetailInquiryResponse{
    public cls_PersonDetailInquiryResponse PersonDetailInquiryResponse;
    public Account AccountInformation;
    public class cls_PersonDetailInquiryResponse {
        public cls_PersonDetailInquiryResponse PersonDetailInquiryResponse;
        public cls_Errors Errors;
        public String RequestNumber;
        public String RequestTypeCode;
        public String WasSuccessful;
        public cls_Addresses[] Addresses;
        public String DateLastMaintained;
        public cls_Demographics Demographics;
        public cls_Documents[] Documents;
        public cls_ElectronicAddresses[] ElectronicAddresses;
        public cls_ForeignTaxTds[] ForeignTaxTds;
        public String MemberNumber;
        public cls_Name Name;
        public cls_Orgs[] Orgs;
        public cls_PersExtOrgIds[] PersExtOrgIds;
        public cls_PersIds[] PersIds;
        public cls_PersTyps[] PersTyps;
        public String PersonNumber;
        public cls_Phones[] Phones;
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
        public String AddressNumber;
        public String AddressUseCode;
        public String CensusTractNumber;
        public String CityName;
        public String CountryCode;
        public String CountrySubdivisionCode;
        public String IsElectronic;
        public String MailCode;
        public String SMSANumber;
        public String SeasonalAddress;
        public String StateCode;
        public String ZipCode;
        public String ZipSuffix;
    }
    class cls_AddressLines {
        public String AddressLineNumber;
        public String AddressLineText;
        public String AddressLineTypeCode;
    }
    class cls_Demographics {
        public String AddDate;
        public String CreditRatingCode;
        public String CreditReportCode;
        public String CustomerKeyword;
        public String CustomerTypeCode;
        public String CustomerTypeDescription;
        public String DateOfBirth;
        public String DateOfDeath;
        public String EducationLevel;
        public String ForeignCertExpireDate;
        public String GraduationDate;
        public String IncomeLevel;
        public String IsAllowPromCallsMsgs;
        public String IsValid;
        public String MailTypeCode;
        public String MemberGroupCode;
        public String NumberOfDependents;
        public String Occupation;
        public String OwnOrRent;
        public String PreferredLocaleCode;
        public String PrivacyRequested;
        public String PurgeFlag;
        public String RemoteDepositRisk;
        public String Report1042sFlag;
        public String ShareAccountNumber;
        public String SpousePersonNumber;
        public String TaxCountryCode;
        public String TaxCountryDescription;
        public String TaxId;
        public String TaxIdApplyDate;
        public String TaxIdCertDate;
        public String TaxIdDisplay;
        public String TaxIdIsMasked;
    }
    class cls_Documents {
        public String DocumentDescription;
        public String DocumentNumber;
        public String DocumentTitle;
        public String DocumentTypeCode;
        public String EffectiveDate;
    }
    class cls_ElectronicAddresses {
        public String AddressNumber;
        public String AddressUseCode;
        public cls_ElectronicAddressLines[] ElectronicAddressLines;
        public String IsElectronic;
    }
    class cls_ElectronicAddressLines {
        public String AddressLineLastUpdatedDate;
        public String AddressLineNumber;
        public String AddressLineText;
        public String AddressLineTypeCode;
    }
    class cls_ForeignTaxTds {
        public String CountryCode;
        public String TaxIDTyp;
        public String TaxIdApplyDate;
        public String TaxIdCertDate;
        public String TaxIdNbr;
    }
    class cls_Name {
        public String FirstName;
        public String LastName;
        public String MiddleInitial;
        public String MiddleName;
        public String NickName;
        public String SalutationCode;
        public String Suffix;
    }
    class cls_Orgs {
        public cls_Addresses[] Addresses;
        public String MemberNumber;
        public String OrgName;
        public String OrgNumber;
        public String OrgPersonRoles;
        public String OrgTypeCode;
        public String OrgTypeDescription;
        public cls_Phones[] Phones;
        
    }
    class cls_Phones {
        public String AreaCode;
        public String CountryCode;
        public String Exchange;
        public String ForeignPhoneNumber;
        public String IsPreferred;
        public String PhoneCode;
        public String PhoneExtension;
        public String PhoneLastUpdatedDate;
        public String PhoneNumber;
        public String PhoneSequenceNumber;
        public String PhoneUseCode;
    }
    class cls_PersExtOrgIds {
        public String EffectiveDate;
        public String ExternalId;
        public String ExternalIdTypeCode;
        public String ExternalOrgNumber;
    }
    class cls_PersIds {
        public String CountryCode;
        public String CountrySubdivisionCode;
        public String Description;
        public String ExpireDate;
        public String IdValue;
        public String IssueDate;
        public String LastVerificationDate;
        public String PersIdTypeCode;
        public String StateCode;
    }
    class cls_PersTyps {
        public String TypeCode;
    }
    public class cls_UserFields {
        public String UserFieldCode;
        public String UserFieldDescription;
        public String UserFieldValueDescription;
        public String Value;
        public String ValueLastUpdatedDate;
    }
    public PersonDetailInquiryResponse(){}
    public static PersonDetailInquiryResponse parse(String json){
		return (PersonDetailInquiryResponse) System.JSON.deserialize(json, PersonDetailInquiryResponse.class);
	}

    public PersonDetailInquiryResponse(cls_PersonDetailInquiryResponse PersonDetailInquiryWrapper, String ExternalIdKey, String AccountId){
        system.debug('hello1111');
        Account accRecord = new Account();
        PersonDetailInquiryResponse = new cls_PersonDetailInquiryResponse();
        PersonDetailInquiryResponse.Name = new cls_Name();
        PersonDetailInquiryResponse.Demographics = new cls_Demographics();
        accRecord.Deceased_Indicator__c = false;
        If(PersonDetailInquiryResponse.Demographics.DateOfDeath != null){
            accRecord.Deceased_Indicator__c = true;
        }
        accRecord.Privacy_Indicatory__c = PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Demographics.PrivacyRequested != NULL ? PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Demographics.PrivacyRequested : null;
        accRecord.PersonDoNotCall = PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Demographics.IsAllowPromCallsMsgs != NULL ? Boolean.ValueOf(PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Demographics.IsAllowPromCallsMsgs) : null;
        PersonDetailInquiryResponse.ElectronicAddresses = new List<cls_ElectronicAddresses>();
        //PersonDetailInquiryResponse.ElectronicAddresses.ElectronicAddressLines = new List<cls_ElectronicAddressLines>();
        If(PersonDetailInquiryWrapper.PersonDetailInquiryResponse.ElectronicAddresses!= null){
            for(cls_ElectronicAddresses emailAddresses:PersonDetailInquiryWrapper.PersonDetailInquiryResponse.ElectronicAddresses){
                system.debug('hello11116');
                If(emailAddresses.ElectronicAddressLines!= null){
                    For(cls_ElectronicAddressLines emailAddress:emailAddresses.ElectronicAddressLines){
                        accRecord.PersonEmail = emailAddress.AddressLineText;
                    }
                }
            }
        }
        PersonDetailInquiryResponse.Phones = new List<cls_Phones>();
        
        If(PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Phones != null){
            for(cls_Phones Phone:PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Phones){
                String CompletePhone = '';
                If(!string.isBlank(Phone.PhoneUseCode) && Phone.PhoneUseCode == 'PER'){
                    CompletePhone = Phone.AreaCode + Phone.Exchange + Phone.PhoneNumber;
                    accRecord.PersonHomePhone = CompletePhone != NULL ? CompletePhone : null;
                }
                If(!string.isBlank(Phone.PhoneUseCode) && Phone.PhoneUseCode == 'CELL'){
                    CompletePhone = Phone.AreaCode + Phone.Exchange + Phone.PhoneNumber;
                    accRecord.PersonMobilePhone = CompletePhone != NULL ? CompletePhone : null;
                } 
                If(!string.isBlank(Phone.PhoneUseCode) && (Phone.PhoneUseCode == 'CELL' || Phone.PhoneUseCode == 'PER') && Phone.IsPreferred == 'true'){
                    CompletePhone = Phone.AreaCode + Phone.Exchange + Phone.PhoneNumber;
                    accRecord.Contact_Preference_Phone__c = CompletePhone != NULL ? CompletePhone : null;
                } 
            }
        }
        PersonDetailInquiryResponse.Orgs = new List<cls_Orgs>();
        If(PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Orgs!= null){
            for(cls_Orgs Org:PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Orgs){
                String CompleteBusinessPhone = '';
                If(Org.Phones!= null){
                    For(cls_Phones phoneBus:Org.Phones){
                        CompleteBusinessPhone = '';
                        If(!string.isEmpty(phoneBus.PhoneUseCode) && phoneBus.PhoneUseCode == 'BUS'){
                            CompleteBusinessPhone = phoneBus.AreaCode + phoneBus.Exchange + phoneBus.PhoneNumber;
                            accRecord.Work_Phone__c = CompleteBusinessPhone != NULL ? CompleteBusinessPhone : null;
                            System.debug('accRecord.Work_Phone__c-> ' +accRecord.Work_Phone__c);
                        }
                    }
                }
            }
        }
        PersonDetailInquiryResponse.Addresses = new List<cls_Addresses>();
         If(PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Addresses != null){
            for(cls_Addresses Addrs:PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Addresses){
                If(Addrs.AddressLines!= null){
                    String StreetAddr = '';
                    For(cls_AddressLines Addr:Addrs.AddressLines){
                        StreetAddr = StreetAddr +' '+ Addr.AddressLineText;
                    }
                    accRecord.PersonMailingStreet = StreetAddr != NULL ? StreetAddr:null;
                     accRecord.PersonMailingCity = Addrs.CityName != NULL ? Addrs.CityName:null;
                            accRecord.PersonMailingCountry = Addrs.CountryCode != NULL ? Addrs.CountryCode:null;
                            accRecord.FinServ__CountryOfResidence__pc = Addrs.CountryCode != NULL ? Addrs.CountryCode:null;
                            accRecord.PersonMailingState = Addrs.StateCode != NULL ? Addrs.StateCode:null;
                            accRecord.PersonMailingPostalCode = Addrs.ZipCode != NULL ? Addrs.ZipCode:null;
                /*    for(cls_Addresses addressDetails:PersonDetailInquiryWrapper.PersonDetailInquiryResponse.Addresses){
                            accRecord.PersonMailingCity = addressDetails.CityName != NULL ? addressDetails.CityName:null;
                            accRecord.PersonMailingCountry = addressDetails.CountryCode != NULL ? addressDetails.CountryCode:null;
                            accRecord.FinServ__CountryOfResidence__pc = addressDetails.CountryCode != NULL ? addressDetails.CountryCode:null;
                            accRecord.PersonMailingState = addressDetails.StateCode != NULL ? addressDetails.StateCode:null;
                            accRecord.PersonMailingPostalCode = addressDetails.ZipCode != NULL ? addressDetails.ZipCode:null;
                    }*/
                }
            }
        }
        accRecord.DNA_Cust_Key__c = ExternalIdKey;
        accRecord.Id = AccountId;
        system.debug('hello11116');
        this.AccountInformation = accRecord;
    }
    
    
    public static Map<String,String> getMemberQuestions(cls_UserFields[] UserFields){
        
        Map<String,String> challQusMap = new Map<String,String>();
        Map<String,String> challAnsMap = new Map<String,String>();
        Set<String> quesColl = new Set<String>();
        Map<String,String> quesAnsMap = new Map<String,String>();
        
        for(cls_UserFields itr:UserFields){
            
            if(itr.UserFieldCode.contains('CHA') ){
                
                challAnsMap.put(itr.UserFieldCode,itr.Value);
            }
            else if(itr.UserFieldCode.contains('CHQ')){
                
                challQusMap.put(itr.UserFieldCode,itr.UserFieldValueDescription); 
                quesColl.add(itr.Value);
            }
            else if(itr.UserFieldCode == 'PASS'){
                
                quesAnsMap.put('Verbal Password',itr.Value);
            }
            
        }
        
        if(!quesColl.isEmpty()){
            
            for(Integer i=1;i<=quesColl.size();i++){
                
                quesAnsMap.put(challQusMap.get('CHQ'+i),challAnsMap.get('CHA'+i));
            }
            
        }
        
        return quesAnsMap;  
    }
}