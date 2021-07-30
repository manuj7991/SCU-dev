@isTest
public with sharing class TestMemberProductHoldingUpdate {
   
  @IsTest
  public static void testGetMemberProductDetails(){

    Account testAcc = new Account(Name='test account',Tax_Id__c='555');
    insert testAcc;
    FinServ__FinancialAccount__c finAcct = new FinServ__FinancialAccount__c(FinServ__FinancialAccountNumber__c='887797268',FinServ__PrimaryOwner__c=testAcc.Id); //[SELECT Id from FinServ__FinancialAccount__c where FinServ__FinancialAccountNumber__c ='887797268'];
    insert finAcct;
    
    Test.startTest();
    String result = MemberProductHoldingUpdatev2.getMemberProductDetails(finAcct.Id);
    AccountDetailInquiryResponse_v4.testParse();
    Test.stopTest();

    System.assert(result == 'Success');

  }

}