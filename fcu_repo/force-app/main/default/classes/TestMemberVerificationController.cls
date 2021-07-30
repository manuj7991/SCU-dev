@isTest
public with sharing class TestMemberVerificationController {


   @isTest
   public static void testControllerMethod(){

    Account testAcc = new Account(LastName='test persons acc',DNA_Cust_Key__c='P100008',RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId());
    insert testAcc;
    FinServ__FinancialAccount__c finAcct1 = new FinServ__FinancialAccount__c(FinServ__FinancialAccountNumber__c='9687741600',FinServ__PrimaryOwner__c=testAcc.Id);
    FinServ__FinancialAccount__c finAcct2 = new FinServ__FinancialAccount__c(FinServ__FinancialAccountNumber__c='1040340',FinServ__PrimaryOwner__c=testAcc.Id);
    insert finAcct1;
    insert finAcct2;
    Case testCase = new Case(AccountId=testAcc.Id,Origin = 'Web',Reason = 'International Bill Payments',Priority = 'High',Status = 'New');
    //insert testCase;
    String respLog = [SELECT Id,JSON_Response__c  FROM Test_Data_For_JSON_Response__mdt where DeveloperName='Verification_Response'][0].JSON_Response__c;

    Test.startTest();
      List<Member_Verification_Question__mdt> metRes = MemberVerificationController.fetchQuestions(); 
      Map<String,String> memSecQues = MemberVerificationController.fetchMemSecureQuestions(testAcc.Id);
      List<Sobject> ansRes = MemberVerificationController.fetchAnswers('FinServ__MotherMaidenName__pc','Account',testAcc.Id,'');
      List<Sobject> ansFinRes = MemberVerificationController.fetchAnswers('FinServ__FinancialAccountNumber__c','FinServ__FinancialAccount__c',testAcc.Id,'FinServ__PrimaryOwner__c');
      List<MemberVerificationController.AccountDetailsInquiryWrapper> memIDs = MemberVerificationController.fetchMemberAccountIDS('Account',testAcc.Id);
      List<MemberVerificationController.AccountDetailsInquiryWrapper> memFinIDs = MemberVerificationController.fetchMemberAccountIDS('FinServ__FinancialAccount__c',testAcc.Id);
      String resString = MemberVerificationController.recordLogs(respLog,testAcc.Id,false);
    Test.stopTest();
  
    List<Member_Verification_Logs__c> logAcc = [SELECT Id from Member_Verification_Logs__c where Account__c = :testAcc.Id];
    system.assertNotEquals(true, logAcc.isEmpty());
   }
 

}