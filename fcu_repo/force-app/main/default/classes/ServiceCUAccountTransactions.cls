//
//Generated by AdminBooster
//

public class ServiceCUAccountTransactions{
	public cls_AccountTransactionHistoryResponse AccountTransactionHistoryResponse;
	public class cls_AccountTransactionHistoryResponse {
		@AuraEnabled public cls_Errors Errors;
		@AuraEnabled public cls_RequestNumber RequestNumber;
		@AuraEnabled public String RequestTypeCode;	//7703
		@AuraEnabled public String WasSuccessful;	//true
		@AuraEnabled public String AccountCurrencyCode;	//USD
		@AuraEnabled public String AccountNumber;	//3791546469
		@AuraEnabled public cls_Transactions[] Transactions;
	}
	public class cls_Errors {
	}
	public class cls_RequestNumber {
	}
	public class cls_Transactions {
		@AuraEnabled public String AccountNumber;	//3791546469
		@AuraEnabled public String ActivityDateTime;	//2019-04-30T00:00:00
		@AuraEnabled public cls_ApprovingPersonName ApprovingPersonName;
		@AuraEnabled public cls_ApprovingPersonNumber ApprovingPersonNumber;
		//@AuraEnabled public cls_CheckNumber CheckNumber;
		@AuraEnabled public String CurrentRtxnStatisticsCode;	//C
		@AuraEnabled public String CurrentRtxnStatisticsDescription;	//Completed
		@AuraEnabled public String DebitCredit;	//C
		@AuraEnabled public String EffectiveDate;	//2019-04-30T00:00:00
		@AuraEnabled public cls_ExchTxnGrp ExchTxnGrp;
		@AuraEnabled public String ExternalRtxnDescription;	//DIVIDEND
		@AuraEnabled public String ExternalRtxnDescriptionNumber;	//14
		//@AuraEnabled public cls_HoldAccountNumber HoldAccountNumber;
		@AuraEnabled public cls_ImageID ImageID;
		//@AuraEnabled public cls_InternalRtxnDescription InternalRtxnDescription;
		//@AuraEnabled public String InternalRtxnDescriptionNumber;	//42
		@AuraEnabled public String IsCustomerView;	//true
		@AuraEnabled public cls_IsRecurring IsRecurring;
		@AuraEnabled public String IsReversal;	//false
		@AuraEnabled public cls_OriginatingPersonName OriginatingPersonName;
		@AuraEnabled public cls_OriginatingPersonNumber OriginatingPersonNumber;
		//@AuraEnabled public cls_ParentAccountNumber ParentAccountNumber;
		//@AuraEnabled public cls_ParentRtxnNumber ParentRtxnNumber;
		@AuraEnabled public String PostDate;	//2019-04-30T00:00:00
		@AuraEnabled public cls_PriorAvailableBalance PriorAvailableBalance;
		@AuraEnabled public String RtxnNumber;	//1
		@AuraEnabled public cls_RtxnReasonCd RtxnReasonCd;
		//@AuraEnabled public cls_RtxnSourceCatCd RtxnSourceCatCd;
		//@AuraEnabled public cls_RtxnSourceCd RtxnSourceCd;
		@AuraEnabled public String RtxnTypeCode;	//INT
		@AuraEnabled public String RtxnTypeDescription;	//Credit Dividends
		//@AuraEnabled public cls_RunningBalance RunningBalance;
		@AuraEnabled public cls_SpreadDetails SpreadDetails;
		@AuraEnabled public cls_StandardIndustryClassCode StandardIndustryClassCode;
		@AuraEnabled public cls_StandardIndustrySubClassCode StandardIndustrySubClassCode;
		@AuraEnabled public String TimeUniqueExtension;	//96404765
		//@AuraEnabled public cls_TraceId TraceId;
		//@AuraEnabled public cls_TraceNumber TraceNumber;
		@AuraEnabled public String TransactionAmount;	//139.34
		@AuraEnabled public cls_TransactionAuxNumber TransactionAuxNumber;
		@AuraEnabled public String TransactionReferenceNumber;	//3791546469-1
		@AuraEnabled public cls_WaiveApprPersNbr WaiveApprPersNbr;
	}
	public class cls_ApprovingPersonName {
	}
	public class cls_ApprovingPersonNumber {
	}
	/*public class cls_CheckNumber {
	}*/
	public class cls_ExchTxnGrp {
	}
	/*public class cls_HoldAccountNumber {
	}*/
	public class cls_ImageID {
	}
	/*public class cls_InternalRtxnDescription {
	}*/
	public class cls_IsRecurring {
	}
	public class cls_OriginatingPersonName {
	}
	public class cls_OriginatingPersonNumber {
	}
	/*public class cls_ParentAccountNumber {
	}
	public class cls_ParentRtxnNumber {
	}*/
	public class cls_PriorAvailableBalance {
	}
	public class cls_RtxnReasonCd {
	}
	public class cls_RtxnSourceCatCd {
	}
	public class cls_RtxnSourceCd {
	}
	/*public class cls_RunningBalance {
	}*/
	public class cls_SpreadDetails {
	}
	public class cls_StandardIndustryClassCode {
	}
	public class cls_StandardIndustrySubClassCode {
	}
	/*public class cls_TraceId {
	}
	public class cls_TraceNumber {
	}*/
	public class cls_TransactionAuxNumber {
	}
	public class cls_WaiveApprPersNbr {
	}
	

	
	}