@isTest
public with sharing class TestLoanApplicationSSNHandler {
    

    static testMethod void validateApplication() {
    
        Account testAcc = new Account(FirstName='test',LastName='account 1',FinServ__TaxId__pc ='555',RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId());
        //Account testAcc2 = new Account(Name='test account2',FinServ__TaxId__pc ='333',RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId());
        ResidentialLoanApplication insertLoanApp = new ResidentialLoanApplication(Name='test loan app',Tax__c=555,RecordTypeId=Schema.SObjectType.ResidentialLoanApplication.getRecordTypeInfosByName().get('Vehicle Loan').getRecordTypeId());

        Test.startTest();
        insert testAcc;
        insert insertLoanApp;
        Test.stopTest();
        Id loanacctId= [SELECT AccountId FROM ResidentialLoanApplication WHERE Id =:insertLoanApp.Id][0].AccountId;
         
        // Test that the trigger correctly updated the price
        System.assertEquals(loanacctId, testAcc.Id);

        /*insertLoanApp.Tax__c = 333;
        update insertLoanApp;
        loanacctId= [SELECT AccountId FROM ResidentialLoanApplication WHERE Id =:insertLoanApp.Id][0].AccountId;
         
        // Test that the trigger correctly updated the price
        System.assertEquals(loanacctId, testAcc2.Id);*/
        
         
        // Retrieve the record
    }
}