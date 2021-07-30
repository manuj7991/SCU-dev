public class AccountDetailInquiryResponse_v4 {
    
    public cls_AccountDetailInquiryResponse AccountDetailInquiryResponse;
	public static FinServ__FinancialAccount__c finAcct;
	public class cls_AccountDetailInquiryResponse {
		//public String Errors;
		public cls_Errors Errors;
		public String RequestNumber;
		public String RequestTypeCode;
		public String WasSuccessful;
		public String AccountClassDescription;
		public cls_AccountCollateralAccounts[] AccountCollateralAccounts;
		public String AccountCurrencyCode;
		public cls_AccountExternalOrganizationIds[] AccountExternalOrganizationIds;
		public cls_AccountLoanLimitHistoryRecords[] AccountLoanLimitHistoryRecords;
		public String AccountLoanRepricingPlans;
		public String AccountMaturityDate;
		public String AccountNickName;
		public String AccountNumber;
		public cls_AccountRiskRatings[] AccountRiskRatings;
		public String AddressFormat;
		public String AddressFormatCode;
		public cls_Agreements[] Agreements;
		public String AmortizationFirstDueDate;
		public String AmortizationLeadDays;
		public String AmountDue;
		public String AmountToPayCurrent;
		public String AvailableBalance;
		public String AvailableCredit;
		public String AvailableToDraw;
		public cls_Balances[] Balances;
		public String BillingLeadDaysOverride;
		public String BorrowerAvailable;
		public String BranchOrganizationName;
		public String BranchOrganizationNumber;
		public String CardHoldAmount;
		public String CheckHoldAmount;
		public String ClassNumber;
		public String CloseReasonCode;
		public String CloseReasonCodeDescription;
		public String ContractDate;
		public String CreditLimit;
		public String CurrentAccountStatusCode;
		public String CurrentAccountStatusDescription;
		public String CurrentBalance;
		public cls_CurrentMailingAddress[] CurrentMailingAddress;
		public String CurrentTerm;
		public String CurrentYearInterestPaid;
		public String DeliveryMethodCode;
		public String DeliveryMethodCodeDescription;
		public String DueDate;
		public String EscrowBalance;
		public String EscrowCurrentlyDue;
		public String ExternalAmount;
		public String ExternalAmountEffectiveDate;
		public String ExternalAnnualCost;
		public String ExternalEntityId;
		public String ExternalEntityOrganizationNumber;
		public String ExternalInterestRate;
		public String ExternalOrganizationName;
		public String ExternalProductTypeCode;
		public String ExternalProductTypeCodeDescription;
		public String FeesCurrentlyDue;
		public String ForbearanceBalance;
		public cls_HSAEvents[] HSAEvents;
		public String InterestAccountCycleCode;
		public String InterestAccountCycleCodeDescription;
		public String InterestBalance;
		public String InterestCurrentlyDue;
		public String InterestDate;
		public String InterestPaidToDate;
		public String InterestRate;
		public String InterestYield;
		public String IsAnalysis;
		public String IsChecks;
		public String IsExternalEntity;
		public String IsFamily;
		public String IsImminentDefault;
		public String IsLoanLimit;
		public String IsNewAccountClass;
		public String IsPassbook;
		public String IsPrinSurplusProc;
		public String IsRepricingPlanAllowed;
		public String IsRestriction;
		public String IsRestrictionExists;
		public String IsRetirement;
		public String IsRevolvingLoan;
		public String IsTDRenewable;
		public String IsTransactionAccount;
		public String IsValid;
		public String LastContactDate;
		public String LastDepositDate;
		public String LastInterestCreditAmount;
		public String LastInterestCreditDate;
		public String LastInterestRateChangeDate;
		public String LastPaymentAmount;
		public String LastPaymentDate;
		public String LastRenewalDate;
		public String LastStatementDate;
		public String LateChargesCurrentlyDue;
		public String LoanBranchOrganizationNumber;
		public String LoanInterestRate;
		public String LoanMaturityDate;
		public String LoanNickName;
		public String MLAggregateBalance;
		public String MailAddressUseCode;
		public String MailTypeCode;
		public String MajorAccountTypeCode;
		public String ManagementHoldAmount;
		public String MaturityAnticipatedPayoffDate;
		public String MinorAccountTypeCode;
		public String MinorCustomerDescription;
		public String NSFToleranceAmount;
		public String NetLoanInProcessBalance;
		public String NextPaymentDueDate;
		public String OpenDate;
		public String OperatingFundAccruedInt;
		public String OperatingFundBalance;
		public String OperatingFundIntRate;
		public cls_OrgPersons[] OrgPersons;
		public String OriginalLoanAmount;
		public String OrignalLTVRatio;
		public String OwnershipCode;
		public String OwnershipCodeDescription;
		public String PayDownBalance;
		public String PaymentMethodCode;
		public String PaymentStatus;
		public String PayoffBalance;
		public String PayoffBalanceAsOfDate;
		public String PendingRegD3Count;
		public String PendingRegD6Count;
		public cls_PersonOrganizationUserFields[] PersonOrganizationUserFields;
		public cls_PmtCalPeriods[] PmtCalPeriods;
		public String PrincipalBalance;
		public String PrincipalCurrentlyDue;
		public String PriorInterestRate;
		public String PriorYearInterestPaid;
		public String ProductFullName;
		public String ProductName;
		public String RegD3Count;
		public String RegD6Count;
		public String RegDDAvailableBalance;
		public String RegEODOptional;
		public String RegularPaymentAmount;
		public String RelatedBalance;
		public String RemainingPayments;
		public String RenewalGraceDays;
		public String RetirementAccountNumber;
		public String RetirementPlanCategory;
		public String RetirementPlanType;
		public String RiskRatingCode;
		public String RiskRatingDescription;
		public cls_Roles[] Roles;
		public String ShareCurrentYearInterestPaid;
		public String SharePriorYearInterestPaid;
		public String SignerFullname;
		public String SignerPersonNumber;
		public String SourceCode;
		public String SourceCodeDescription;
		public String StatementAccountCycleCode;
		public String StatementAccountCycleCodeDescription;
		public String TDLastRenewalDate;
		public String TaxOrganizationNumber;
		public String TaxOwnerFullname;
		public String TaxPersonNumber;
		public cls_TaxReportingOverrides[] TaxReportingOverrides;
		public String TermMaturityDate;
		public String TotalAmountCurrentlyDue;
		public String TotalPerDiem;
		public String UCFToleranceAmount;
		public String WholesaleInterestRate;
	}
	public class cls_AccountCollateralAccounts {
		public String CollateralAccountNumber;
		public String CollateralEffectiveDate;
		public String CollateralInactiveDate;
		public String CollateralMajorAccountTypeCode;
		public String CollateralMajorAccountTypeDescription;
		public String CollateralMinorAccountTypeCode;
		public String CollateralMinorAccountTypeDescription;
		public String HoldAmount;
		public String HoldPercentage;
		public String SequenceNumber;
	}
	public class cls_AccountExternalOrganizationIds {
		public String AccountExternalOrganizationName;
		public String EffectiveDate;
		public String ExternalAccountNumber;
		public String ExternalAccountOrganizationNumber;
		public String ExternalAmount;
		public String ExternalAmountEffectiveDate;
		public String ExternalIdTypeCode;
		public String ExternalIdTypeCodeDescription;
		public String InActiveDate;
	}
	public class cls_AccountLoanLimitHistoryRecords {
		public String CreditLimitAmount;
		public String EffectiveDate;
		public String InactiveDate;
	}
	public class cls_AccountRiskRatings {
		public String BalanceCategoryCode;
		public String BalanceTypeCode;
		public String EffectiveDate;
		public String RiskRatingCode;
		public String RiskRatingDescription;
	}
	public class cls_Agreements {
		public String AgreementNumber;
		public String AgreementPersonNumber;
		public String AgreementTypeCode;
	}
	public class cls_Balances {
		public String AccuredInterest;
		public String AvailableAmount;
		public String BalanceAmount;
		public String BalanceCategoryCode;
		public String BalanceTypeCode;
		public String CardHold;
		public String CheckHold;
		public String CollectedMonthToDateAverage;
		public String CollectedYearToDateAverage;
		public String ManagementHold;
		public String MonthToDateAverage;
		public String ParticipantAgreementNumber;
		public String YearToDateAverage;
	}
	public class cls_CurrentMailingAddress {
		public String MailAddrLine;
	}
	public class cls_HSAEvents {
		public String EventCodeDescription;
		public String HSAEffectiveDate;
		public String HSAEventCode;
		public String HSAEventCodeDescription;
	}
	public class cls_OrgPersons {
		public String FullName;
		public String OrgPersonRoles;
		public String PersonNumber;
	}
	public class cls_PersonOrganizationUserFields {
		public String UserFieldCode;
		public String UserFieldDescription;
		public String UserFieldValueDescription;
		public String Value;
		public String ValueLastUpdatedDate;
	}
	public class cls_PmtCalPeriods {
		public String PaymentAmount;
		public String PaymentCalculationPeriod;
		public String PaymentCalculationPeriodCode;
		public String PaymentTypeCode;
	}
	public class cls_Roles {
		public String CanTransact;
		public String EntityName;
		public String EntityNumber;
		public String EntityTypeCode;
		public String IsEmployeeRole;
		public String RoleCode;
		public String RoleDescription;
	}
	public class cls_TaxReportingOverrides {
		public String AccountRoleCode;
		public String EntityNumber;
		public String EntityTypeCode;
		public String TaxReportingTypeCode;
	}
	public static AccountDetailInquiryResponse_v4 parse(String json){
		return (AccountDetailInquiryResponse_v4) System.JSON.deserialize(json, AccountDetailInquiryResponse_v4.class);
	}
	public class cls_Error  {  
		public String ErrorMessage;        
		public String ErrorNumber;    
	}

	public class cls_Errors {
		public cls_Error Error;
	}




	public static void testParse() {
		String json=		'{'+
		'    "AccountDetailInquiryResponse": {'+
		'        "Errors": null,'+
		'        "RequestNumber": null,'+
		'        "RequestTypeCode": "7702",'+
		'        "WasSuccessful": "true",'+
		'        "AccountClassDescription": null,'+
		'        "AccountCollateralAccounts": null,'+
		'        "AccountCurrencyCode": "USD",'+
		'        "AccountExternalOrganizationIds": null,'+
		'        "AccountLoanLimitHistoryRecords": null,'+
		'        "AccountLoanRepricingPlans": null,'+
		'        "AccountMaturityDate": null,'+
		'        "AccountNickName": "DIVIDEND CHECKING",'+
		'        "AccountNumber": "9352794609",'+
		'        "AccountRiskRatings": null,'+
		'        "AddressFormat": "Standard Address Format",'+
		'        "AddressFormatCode": "STD",'+
        '        "temp": "123",'+             
		'        "Agreements": ['+
		'            {'+
		'                "AgreementNumber": "94091",'+
		'                "AgreementPersonNumber": "140667",'+
		'                "AgreementTypeCode": "VRU"'+
		'            },'+
		'            {'+
		'                "AgreementNumber": "26311",'+
		'                "AgreementPersonNumber": "257397",'+
		'                "AgreementTypeCode": "VRU"'+
		'            },'+
		'            {'+
		'                "AgreementNumber": "508011",'+
		'                "AgreementPersonNumber": "140667",'+
		'                "AgreementTypeCode": "DBT"'+
		'            }'+
		'        ],'+
		'        "AmortizationFirstDueDate": null,'+
		'        "AmortizationLeadDays": null,'+
		'        "AmountDue": "0",'+
		'        "AmountToPayCurrent": null,'+
		'        "AvailableBalance": "41859.82",'+
		'        "AvailableCredit": null,'+
		'        "AvailableToDraw": null,'+
		'        "Balances": ['+
		'            {'+
		'                "AccuredInterest": "0.17203",'+
		'                "AvailableAmount": "41859.82",'+
		'                "BalanceAmount": "41859.82",'+
		'                "BalanceCategoryCode": "NOTE",'+
		'                "BalanceTypeCode": "BAL",'+
		'                "CardHold": "0",'+
		'                "CheckHold": "0",'+
		'                "CollectedMonthToDateAverage": "41859.82",'+
		'                "CollectedYearToDateAverage": "40095.36",'+
		'                "ManagementHold": "0",'+
		'                "MonthToDateAverage": "41859.82",'+
		'                "ParticipantAgreementNumber": null,'+
		'                "YearToDateAverage": "40095.36"'+
		'            },'+
		'            {'+
		'                "AccuredInterest": null,'+
		'                "AvailableAmount": null,'+
		'                "BalanceAmount": null,'+
		'                "BalanceCategoryCode": "NOTE",'+
		'                "BalanceTypeCode": "INT",'+
		'                "CardHold": null,'+
		'                "CheckHold": null,'+
		'                "CollectedMonthToDateAverage": null,'+
		'                "CollectedYearToDateAverage": null,'+
		'                "ManagementHold": null,'+
		'                "MonthToDateAverage": null,'+
		'                "ParticipantAgreementNumber": null,'+
		'                "YearToDateAverage": null'+
		'            },'+
		'            {'+
		'                "AccuredInterest": null,'+
		'                "AvailableAmount": null,'+
		'                "BalanceAmount": null,'+
		'                "BalanceCategoryCode": "COFF",'+
		'                "BalanceTypeCode": "BAL",'+
		'                "CardHold": null,'+
		'                "CheckHold": null,'+
		'                "CollectedMonthToDateAverage": null,'+
		'                "CollectedYearToDateAverage": null,'+
		'                "ManagementHold": null,'+
		'                "MonthToDateAverage": null,'+
		'                "ParticipantAgreementNumber": null,'+
		'                "YearToDateAverage": null'+
		'            },'+
		'            {'+
		'                "AccuredInterest": null,'+
		'                "AvailableAmount": null,'+
		'                "BalanceAmount": null,'+
		'                "BalanceCategoryCode": "NOTE",'+
		'                "BalanceTypeCode": "GINT",'+
		'                "CardHold": null,'+
		'                "CheckHold": null,'+
		'                "CollectedMonthToDateAverage": null,'+
		'                "CollectedYearToDateAverage": null,'+
		'                "ManagementHold": null,'+
		'                "MonthToDateAverage": null,'+
		'                "ParticipantAgreementNumber": null,'+
		'                "YearToDateAverage": null'+
		'            }'+
		'        ],'+
		'        "BillingLeadDaysOverride": null,'+
		'        "BorrowerAvailable": null,'+
		'        "BranchOrganizationName": "Falmouth",'+
		'        "BranchOrganizationNumber": "40",'+
		'        "CardHoldAmount": "0",'+
		'        "CheckHoldAmount": "0",'+
		'        "ClassNumber": null,'+
		'        "CloseReasonCode": null,'+
		'        "CloseReasonCodeDescription": null,'+
		'        "ContractDate": null,'+
		'        "CreditLimit": null,'+
		'        "CurrentAccountStatusCode": "ACT",'+
		'        "CurrentAccountStatusDescription": "Active",'+
		'        "CurrentBalance": "41859.82",'+
		'        "CurrentMailingAddress": ['+
		'            {'+
		'                "MailAddrLine": "Jordan H. May"'+
		'            },'+
		'            {'+
		'                "MailAddrLine": "Sabaheta Jakupovic-May"'+
		'            },'+
		'            {'+
		'                "MailAddrLine": "3 Captain Paine Rd"'+
		'            },'+
		'            {'+
		'                "MailAddrLine": "East Sandwich  MA  02537"'+
		'            }'+
		'        ],'+
		'        "CurrentTerm": null,'+
		'        "CurrentYearInterestPaid": null,'+
		'        "DeliveryMethodCode": "WWW",'+
		'        "DeliveryMethodCodeDescription": "Electronic Banking",'+
		'        "DueDate": null,'+
		'        "EscrowBalance": null,'+
		'        "EscrowCurrentlyDue": null,'+
		'        "ExternalAmount": null,'+
		'        "ExternalAmountEffectiveDate": null,'+
		'        "ExternalAnnualCost": null,'+
		'        "ExternalEntityId": null,'+
		'        "ExternalEntityOrganizationNumber": null,'+
		'        "ExternalInterestRate": null,'+
		'        "ExternalOrganizationName": null,'+
		'        "ExternalProductTypeCode": null,'+
		'        "ExternalProductTypeCodeDescription": null,'+
		'        "FeesCurrentlyDue": null,'+
		'        "ForbearanceBalance": null,'+
		'        "HSAEvents": null,'+
		'        "InterestAccountCycleCode": "EOM",'+
		'        "InterestAccountCycleCodeDescription": "End of Month",'+
		'        "InterestBalance": null,'+
		'        "InterestCurrentlyDue": null,'+
		'        "InterestDate": null,'+
		'        "InterestPaidToDate": null,'+
		'        "InterestRate": "0.0015",'+
		'        "InterestYield": "0.001501",'+
		'        "IsAnalysis": "false",'+
		'        "IsChecks": "true",'+
		'        "IsExternalEntity": "false",'+
		'        "IsFamily": null,'+
		'        "IsImminentDefault": null,'+
		'        "IsLoanLimit": "false",'+
		'        "IsNewAccountClass": null,'+
		'        "IsPassbook": "false",'+
		'        "IsPrinSurplusProc": null,'+
		'        "IsRepricingPlanAllowed": null,'+
		'        "IsRestriction": "false",'+
		'        "IsRestrictionExists": null,'+
		'        "IsRetirement": "false",'+
		'        "IsRevolvingLoan": null,'+
		'        "IsTDRenewable": "false",'+
		'        "IsTransactionAccount": "true",'+
		'        "IsValid": "true",'+
		'        "LastContactDate": "2021-06-24T00:00:00",'+
		'        "LastDepositDate": null,'+
		'        "LastInterestCreditAmount": null,'+
		'        "LastInterestCreditDate": null,'+
		'        "LastInterestRateChangeDate": null,'+
		'        "LastPaymentAmount": null,'+
		'        "LastPaymentDate": null,'+
		'        "LastRenewalDate": null,'+
		'        "LastStatementDate": "2021-05-31T00:00:00",'+
		'        "LateChargesCurrentlyDue": null,'+
		'        "LoanBranchOrganizationNumber": null,'+
		'        "LoanInterestRate": null,'+
		'        "LoanMaturityDate": null,'+
		'        "LoanNickName": null,'+
		'        "MLAggregateBalance": null,'+
		'        "MailAddressUseCode": null,'+
		'        "MailTypeCode": "REG",'+
		'        "MajorAccountTypeCode": "CK",'+
		'        "ManagementHoldAmount": "0",'+
		'        "MaturityAnticipatedPayoffDate": null,'+
		'        "MinorAccountTypeCode": "CK04",'+
		'        "MinorCustomerDescription": "DD+ Dividend",'+
		'        "NSFToleranceAmount": null,'+
		'        "NetLoanInProcessBalance": null,'+
		'        "NextPaymentDueDate": null,'+
		'        "OpenDate": "1994-12-07T00:00:00",'+
		'        "OperatingFundAccruedInt": null,'+
		'        "OperatingFundBalance": null,'+
		'        "OperatingFundIntRate": null,'+
		'        "OrgPersons": null,'+
		'        "OriginalLoanAmount": null,'+
		'        "OrignalLTVRatio": null,'+
		'        "OwnershipCode": "JO",'+
		'        "OwnershipCodeDescription": "Joint OR",'+
		'        "PayDownBalance": null,'+
		'        "PaymentMethodCode": null,'+
		'        "PaymentStatus": null,'+
		'        "PayoffBalance": null,'+
		'        "PayoffBalanceAsOfDate": null,'+
		'        "PendingRegD3Count": "0",'+
		'        "PendingRegD6Count": "0",'+
		'        "PersonOrganizationUserFields": ['+
		'            {'+
		'                "UserFieldCode": "DIRD",'+
		'                "UserFieldDescription": "Direct Deposit",'+
		'                "UserFieldValueDescription": null,'+
		'                "Value": "Y",'+
		'                "ValueLastUpdatedDate": "2021-04-27T00:00:00"'+
		'            },'+
		'            {'+
		'                "UserFieldCode": "IBAN",'+
		'                "UserFieldDescription": "International Banking Number",'+
		'                "UserFieldValueDescription": null,'+
		'                "Value": "DE18540300110093527946",'+
		'                "ValueLastUpdatedDate": "2021-05-01T00:00:00"'+
		'            },'+
		'            {'+
		'                "UserFieldCode": "MICR",'+
		'                "UserFieldDescription": "MICR Number",'+
		'                "UserFieldValueDescription": null,'+
		'                "Value": "2000000907010",'+
		'                "ValueLastUpdatedDate": "2021-04-27T00:00:00"'+
		'            },'+
		'            {'+
		'                "UserFieldCode": "PSMX",'+
		'                "UserFieldDescription": "In Od Program YN",'+
		'                "UserFieldValueDescription": null,'+
		'                "Value": "Y",'+
		'                "ValueLastUpdatedDate": "2021-05-13T00:00:00"'+
		'            },'+
		'            {'+
		'                "UserFieldCode": "PSOD",'+
		'                "UserFieldDescription": "Od Program Status",'+
		'                "UserFieldValueDescription": "Account Active in Program",'+
		'                "Value": "1",'+
		'                "ValueLastUpdatedDate": "2021-05-13T00:00:00"'+
		'            }'+
		'        ],'+
		'        "PmtCalPeriods": null,'+
		'        "PrincipalBalance": null,'+
		'        "PrincipalCurrentlyDue": null,'+
		'        "PriorInterestRate": null,'+
		'        "PriorYearInterestPaid": null,'+
		'        "ProductFullName": "DD+ Dividend Checking",'+
		'        "ProductName": "DD+ Dividend",'+
		'        "RegD3Count": "0",'+
		'        "RegD6Count": "0",'+
		'        "RegDDAvailableBalance": "41859.82",'+
		'        "RegEODOptional": "false",'+
		'        "RegularPaymentAmount": null,'+
		'        "RelatedBalance": null,'+
		'        "RemainingPayments": null,'+
		'        "RenewalGraceDays": null,'+
		'        "RetirementAccountNumber": null,'+
		'        "RetirementPlanCategory": null,'+
		'        "RetirementPlanType": null,'+
		'        "RiskRatingCode": null,'+
		'        "RiskRatingDescription": null,'+
		'        "Roles": ['+
		'            {'+
		'                "CanTransact": "true",'+
		'                "EntityName": "Sabaheta Jakupovic-May",'+
		'                "EntityNumber": "257397",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "false",'+
		'                "RoleCode": "OWN",'+
		'                "RoleDescription": "NonTax Owner"'+
		'            },'+
		'            {'+
		'                "CanTransact": "true",'+
		'                "EntityName": "Sabaheta Jakupovic-May",'+
		'                "EntityNumber": "257397",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "false",'+
		'                "RoleCode": "SIGN",'+
		'                "RoleDescription": "NonTax Signator"'+
		'            },'+
		'            {'+
		'                "CanTransact": "true",'+
		'                "EntityName": "Jordan H. May",'+
		'                "EntityNumber": "140667",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "false",'+
		'                "RoleCode": "TAX",'+
		'                "RoleDescription": "Tax Reported For "'+
		'            },'+
		'            {'+
		'                "CanTransact": "true",'+
		'                "EntityName": "Jordan H. May",'+
		'                "EntityNumber": "140667",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "false",'+
		'                "RoleCode": "OTAX",'+
		'                "RoleDescription": "Tax Reported Owner "'+
		'            },'+
		'            {'+
		'                "CanTransact": "true",'+
		'                "EntityName": "Jordan H. May",'+
		'                "EntityNumber": "140667",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "false",'+
		'                "RoleCode": "STAX",'+
		'                "RoleDescription": "Tax Reported Signator "'+
		'            },'+
		'            {'+
		'                "CanTransact": "false",'+
		'                "EntityName": "Data Conversion",'+
		'                "EntityNumber": "4",'+
		'                "EntityTypeCode": "PERS",'+
		'                "IsEmployeeRole": "true",'+
		'                "RoleCode": "OEMP",'+
		'                "RoleDescription": "Originating Employee"'+
		'            }'+
		'        ],'+
		'        "ShareCurrentYearInterestPaid": "28.54",'+
		'        "SharePriorYearInterestPaid": "31.54",'+
		'        "SignerFullname": "Jordan H. May",'+
		'        "SignerPersonNumber": "140667",'+
		'        "SourceCode": null,'+
		'        "SourceCodeDescription": null,'+
		'        "StatementAccountCycleCode": "EOM",'+
		'        "StatementAccountCycleCodeDescription": "End of Month",'+
		'        "TDLastRenewalDate": null,'+
		'        "TaxOrganizationNumber": null,'+
		'        "TaxOwnerFullname": "Jordan H. May",'+
		'        "TaxPersonNumber": "140667",'+
		'        "TaxReportingOverrides": null,'+
		'        "TermMaturityDate": null,'+
		'        "TotalAmountCurrentlyDue": null,'+
		'        "TotalPerDiem": null,'+
		'        "UCFToleranceAmount": null,'+
		'        "WholesaleInterestRate": null'+
		'    }'+
		'}';
		AccountDetailInquiryResponse_v4 obj = parse(json);
		System.assert(obj != null);
		System.debug(obj);
	}

	public static FinServ__FinancialAccount__c getFinAcct(String recId,cls_AccountDetailInquiryResponse resp){

        finAcct = new FinServ__FinancialAccount__c();
		
		if(Boolean.valueof(resp.WasSuccessful) == true){
				
				//system.debug('Current Balance : '+resp.CurrentBalance);
	 
				if(resp.Balances != null){

					for(cls_Balances blc:resp.Balances){

						if(blc.MonthToDateAverage != null){
	
							finAcct.FinServ__AverageBalance__c =+  Decimal.valueOf(blc.MonthToDateAverage);
							//system.debug(blc.MonthToDateAverage);
						}
						if(blc.BalanceCategoryCode =='NOTE' && blc.BalanceTypeCode =='BAL'){
	
							finAcct.Note_Balance__c =+ Decimal.valueOf(blc.BalanceAmount);
						} 
					}
				}

				if(resp.Agreements != null){

					for(cls_Agreements agr:resp.Agreements){

						if(agr.AgreementTypeCode == 'DBT' && finAcct.Active_debit_card_agreement__c != 'Y'){
		 
						   finAcct.Active_debit_card_agreement__c = 'Y';  
						}	 
						else if(agr.AgreementTypeCode == 'VRU' && finAcct.Active_VRU_Agreement__c != 'Y'){
		 
						   finAcct.Active_VRU_Agreement__c = 'Y';  
						}
						else if(agr.AgreementTypeCode == 'WWW' && finAcct.Active_Internet_Agreement__c != 'Y'){

						    finAcct.Active_Internet_Agreement__c = 'Y';	
						}
						else if(finAcct.Active_ATM_Agreement__c != 'Y'){
 
							finAcct.Active_ATM_Agreement__c = 'Y'; 	
						}
					 }	 
				}

				if(resp.PmtCalPeriods != null){

					for(cls_PmtCalPeriods pmtCal:resp.PmtCalPeriods){

						finAcct.FinServ__PaymentFrequency__c = (!Test.isRunningTest()) ? pmtCal.PaymentCalculationPeriod.replaceAll( '\\s+', '') : null; 
					}
				}

                finAcct.Term__c = resp.CurrentTerm != NULL ? resp.CurrentTerm : null ;
	            finAcct.FinServ__TotalCreditLimit__c = resp.CreditLimit != NULL ? Decimal.valueOf(resp.CreditLimit) : null;
				finAcct.FinServ__AvailableCredit__c = resp.AvailableCredit != NULL ? Decimal.valueOf(resp.AvailableCredit) : null; 
				finAcct.FinServ__InterestRate__c = resp.InterestRate != NULL ? Decimal.valueOf(resp.InterestRate) : null; 
				finAcct.Next_Payment_Date__c = resp.NextPaymentDueDate != NULL ? Date.valueOf(resp.NextPaymentDueDate) : null;
                finAcct.Maturity_Date__c = resp.AccountMaturityDate != NULL ? Date.valueOf(resp.AccountMaturityDate) : null; 
				finAcct.Risk_Rating__c = resp.RiskRatingCode != NULL ? resp.RiskRatingCode : null;
                finAcct.FinServ__OverdraftProtection__c = resp.RegEODOptional != NULL ? true : false;
				finAcct.FinServ__Balance__c = resp.CurrentBalance != NULL ? Decimal.valueOf(resp.CurrentBalance) : null;
				finAcct.Account_State__c = (resp.CurrentAccountStatusCode!= NULL) ? (resp.CurrentAccountStatusCode.contains('ACT') ? 'Open' : 'Closed') : null;
				finAcct.Id = recId;				
		}
            
	    
		return finAcct;
	}

}