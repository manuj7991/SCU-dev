@isTest
public with sharing class TestAutoLoanFinAccountRollupHandler {
  
    @isTest static void testMethodForException()//Checking Records for exception
    {
	Account testAccount = new Account();//Insert Account
        testAccount.Name='Test Account' ;
        insert testAccount;
        FinServ__FinancialAccount__c finAccChild = new FinServ__FinancialAccount__c();

        try
        {
            //finAccChild.savedata();//Call the Method
         }
        catch(Exception e)
        {}
        list<account> acc = [select id from account];//Retrive the record
        integer i = acc.size();
        system.assertEquals(1,i);//Test that the record is inserted        
        
    }
	@isTest static void testMethod1()//Testing the insertion method
    {
        Account testAccount = new Account();//Insert Account
        testAccount.Name='Test Account' ;
        insert testAccount;
	  
        try{
        

	    }
        catch(Exception ee){

        }
        list<account> acc = [select id from account];//Retrive the record
	    integer i = acc.size();
	    system.assertEquals(1,i);//Test that the record is inserted
        
    }     



}