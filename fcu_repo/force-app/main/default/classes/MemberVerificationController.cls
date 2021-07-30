public without sharing class MemberVerificationController {
    

    @AuraEnabled(cacheable=true)  
    public static List<Member_Verification_Question__mdt> fetchQuestions() {
        
        return [ SELECT Id, MasterLabel, Question_Label__c,Field_Name__c, Level__c, Order__c, Sobject_Type__c,Response_Attribute__c,Type__c,Account_Relation_Field__c  FROM Member_Verification_Question__mdt  ORDER BY Order__c];        
    }

    /*@AuraEnabled(cacheable=true)  
    public static List<Member_Verification_Question__mdt> fetchRealTimeQuestions() {
        
        return [ SELECT Id, MasterLabel, Question_Label__c,Field_Name__c, Level__c, Order__c, Sobject_Type__c,Type__c  FROM Member_Verification_Question__mdt where Type__c = 'Real-Time' ORDER BY Order__c];        
    }*/

    @AuraEnabled(cacheable=true)  
    public static Map<String,String> fetchMemSecureQuestions(String accId) {
        
        //List<MemberSecurityQuestionWrapper> queWrap = new List<MemberSecurityQuestionWrapper>();
        Map<String,String> quesAnsMap = new Map<String,String>(); 
        Id check = (Id)accId;

        if( check.getSObjectType().getDescribe().getName() != 'Account' ){

              accId = [SELECT Id,AccountId from Case where Id=:accId][0].AccountId;                 
        }


        
        Account acc = [SELECT Id,DNA_Cust_Key__c from Account where Id = :accId];
        PersonDetailInquiryResponse result = DNAMemberAccountProxy.getMemberDetails(acc.DNA_Cust_Key__c);

        if(result.PersonDetailInquiryResponse != NULL){
           
           if(result.PersonDetailInquiryResponse.PersonDetailInquiryResponse.UserFields != NULL){
 
                    quesAnsMap = PersonDetailInquiryResponse.getMemberQuestions(result.PersonDetailInquiryResponse.PersonDetailInquiryResponse.UserFields);
           }                       
        }
        
        
        return quesAnsMap;
    }


    @AuraEnabled(cacheable=true)  
    public static List<Sobject> fetchAnswers(String fieldAPIName, String Sobjectname, String recId, String acctRelField) {
        
        Id check = (Id)recId;

        if( check.getSObjectType().getDescribe().getName() != 'Account' ){

            recId = [SELECT Id,AccountId from Case where Id=:recId][0].AccountId;                 
        }
  
       
       if(Sobjectname == 'Account'){

           return Database.query('SELECT '+ fieldAPIName +' from '+Sobjectname+' where Id = :recId' );
       }
       /*else if(Sobjectname == 'FinServ__FinancialAccount__c'){

           return Database.query('SELECT Name,'+ fieldAPIName +' from '+Sobjectname+' where FinServ__PrimaryOwner__c = :recId AND '+fieldAPIName+' != NULL' );
       }
       else{

           return Database.query('SELECT Name,'+ fieldAPIName +' from '+Sobjectname+' where Primary_Owner__c = :recId AND '+fieldAPIName+' != NULL' );       
       }*/
       else if(Sobjectname == 'Vehicle Loan'){

           //return Database.query('SELECT Name,'+ fieldAPIName +' from FinServ__FinancialAccount__c where Primary_Owner__c = :recId AND Sub_Product_Name__c LIKE \'%Vehicle%\'' );
           return Database.query('SELECT Name,'+ fieldAPIName +' from FinServ__FinancialAccount__c where FinServ__PrimaryOwner__c = :recId AND Sub_Product_Name__c LIKE \'%Vehicle%\'');
       }  
       else{

           return Database.query('SELECT Name,'+ fieldAPIName +' from '+Sobjectname+' where '+ acctRelField +'= :recId AND '+fieldAPIName+' != NULL' );
       }
    }   

    @AuraEnabled(cacheable=true)  
    public static List<AccountDetailsInquiryWrapper> fetchMemberAccountIDS(String Sobjectname, String recId) {
        
       List<Sobject> data = new List<SObject>();
       List<AccountDetailsInquiryWrapper> result = new List<AccountDetailsInquiryWrapper>();

       Id check = (Id)recId;

       if( check.getSObjectType().getDescribe().getName() != 'Account' ){

            recId = [SELECT Id,AccountId from Case where Id=:recId][0].AccountId;                 
       }

       if(Sobjectname == 'Account'){

         data = Database.query('SELECT DNA_Cust_Key__c from '+Sobjectname+' where Id = :recId' );
       }
       else{

         data = Database.query('SELECT Name,FinServ__FinancialAccountNumber__c from '+Sobjectname+' where FinServ__PrimaryOwner__c = :recId AND FinServ__FinancialAccountNumber__c != NULL' );
       }

       if(!data.isEmpty()){

           for(sObject li : data){
                switch on li {
                    when FinServ__FinancialAccount__c cr {
                        AccountDetailInquiryResponse_v4 res = DNAMemberAccountProxy.getAccountDetails(cr.FinServ__FinancialAccountNumber__c);
                        AccountDetailsInquiryWrapper itr = new AccountDetailsInquiryWrapper();

                        if(res.AccountDetailInquiryResponse != NULL){

                            itr.resp = JSON.serialize(res.AccountDetailInquiryResponse);
                        }
                        result.add(itr); 
                    }
                    when Account cr {
                        PersonDetailInquiryResponse res = DNAMemberAccountProxy.getMemberDetails(cr.DNA_Cust_Key__c);
                        AccountDetailsInquiryWrapper itr = new AccountDetailsInquiryWrapper();
                        if(res.PersonDetailInquiryResponse != NULL){
                            itr.resp = JSON.serialize(res.PersonDetailInquiryResponse.PersonDetailInquiryResponse);
                        }
                        result.add(itr); 
                    }
                }
          }

       } 


       return result;
    }   

       
    /*@AuraEnabled(cacheable=true)  
    public static void fetchRealTimeAnswers(String Sobjectname, String recId,String attribute) {
           
          //system.debug('Field :'+fieldAPIName);
          system.debug('Type :'+Sobjectname);
          system.debug('RecId :'+recId);
   
   
          if(Sobjectname == 'Account'){
   
            Account acc = [SELECT Id,DNA_Cust_Key__c from Account where Id = :recId];
            PersonDetailInquiryResponse result = DNAMemberAccountProxy.getMemberDetails(acc.DNA_Cust_Key__c);
            //if(result.PersonDetailInquiryResponse.PersonDetailInquiryResponse.attribute != NULL){

                                

            //}

             //return Database.query('SELECT '+ fieldAPIName +' from '+Sobjectname+' where Id = :recId' );
          }
          else{
   
           //return Database.query('SELECT Name,'+ fieldAPIName +' from '+Sobjectname+' where FinServ__PrimaryOwner__c = :recId' );
          }   


    }*/


    
    @AuraEnabled 
    public static String recordLogs(String respLog, String recId, Boolean verified) {
        
       //system.debug('APEX RESPONSE'+respLog);
       Map<String,Object> deserial = (Map<String,Object>)JSON.deserializeUntyped(respLog);
       List<Map<String, Object>> values = new List<Map<String, Object>>();
       List<Member_Verification_Logs__c> insLogs = new List<Member_Verification_Logs__c>();
       
       Id check = (Id)recId;

       if( check.getSObjectType().getDescribe().getName() != 'Account' ){

            recId = [SELECT Id,AccountId from Case where Id=:recId][0].AccountId;                 
       }
       
       Member_Verification_Logs__c logStatus = new Member_Verification_Logs__c(Account__c=recId,Verified__c=verified,RecordTypeId=Schema.SObjectType.Member_Verification_Logs__c.getRecordTypeInfosByName().get('Verification Status').getRecordTypeId());
       insert logStatus;

       

       for (Object obj : deserial.values()) {
        
         values.add((Map<String, Object>) obj);
       }

       for(Map<String,Object> obiMap:values){

            Member_Verification_Logs__c newLog = new Member_Verification_Logs__c();
            newLog.recordtypeId = Schema.SObjectType.Member_Verification_Logs__c.getRecordTypeInfosByName().get('Verification Responses').getRecordTypeId();
            //newLog.Account__c = recId;
            newLog.Status_Log__c = logStatus.Id;
            for(String key:obiMap.keyset()){
    
                switch on key {
                    when 'fieldName' {		
                        newLog.FieldName__c = (String)obiMap.get(key);
                    }	
                    when 'ques' {		
                        newLog.Question__c = (String)obiMap.get(key);
                    }
                    when 'response' {	
                        newLog.Response__c = (String)obiMap.get(key);
                    }
                    when 'verified' {
                        newLog.Verification_Status__c = (String)obiMap.get(key);
                    }
                }
            }

            insLogs.add(newLog);  
        }
  
       insert insLogs;
       return 'Success'; 
      
    }




    public class AccountDetailsInquiryWrapper{

        @AuraEnabled
        public String resp{get;set;}

    }


}