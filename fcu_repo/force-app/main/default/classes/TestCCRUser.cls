@IsTest
public with sharing class TestCCRUser {
    
   @isTest
   static void testFunc(){

       user currUsr = [SELECT Id from User where Id = '0051k000005mRoB'];


       System.runAs(currUsr){

        Test.startTest();
        //EmailMessageHandler.insertEM( currUsr.Id );
        EmailMessageHandler.sendEM();
        Test.stopTest();
 

       } 




   }


}