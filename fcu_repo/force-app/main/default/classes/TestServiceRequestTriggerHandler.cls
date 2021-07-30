@isTest
public with sharing class TestServiceRequestTriggerHandler {
    
    @TestSetup 
    private static void setupTestData()
    {
     
           List<RecordType> accounttypes = [Select Id, Name, sobjecttype from RecordType where sobjectType = 'Account' and Name ='Business' Limit 1];
           RecordType accounttype = accounttypes[0];	
           ServiceRequestTriggerHandler.TriggerDisabled = true;
           Account acct = new Account(Name='SFDC Account');
           acct.RecordTypeId = accounttype.Id;
           insert acct;
           ID acctID = acct.ID;
           System.debug('account Created :' + acct.ID);
        
           List<RecordType> types = [Select Id, Name, sobjecttype from RecordType where sobjectType = 'Case' and Name ='Foreign Exchange' Limit 1];
           RecordType recordt = types[0];	
         List<RecordType> contacttypes = [Select Id, Name, sobjecttype from RecordType where sobjectType = 'Contact' and Name ='Business' Limit 1];
           RecordType contacttype = contacttypes[0];	

            // Add a contact to this account.
            Contact con = new Contact(
                FirstName='Joe',
                LastName='Smith',
                Phone='415.555.1212',
                RecordTypeId=contacttype.Id,
                AccountId=acctID);
            insert con;
        	System.debug('Contact  Created :' + con.ID);
        
        	/*
        	AccountContactRelation acr = new AccountContactRelation();
        	acr.AccountId = acctID;
        	acr.ContactId = con.Id;
        	acr.IsActive = true;
        	acr.Roles = 'Beneficiary';
        	acr.FinServ__IncludeInGroup__c = true;
        	insert acr;
        	system.debug(acr);	
        */
        
        	List<SlaProcess> processes = [Select Id, Name from slaProcess where Name = 'SCU Foreign Exchange Entitlement'];
        	SlaProcess process = processes[0];
            System.debug('Process' + process);
        
        
        	Entitlement ent = new Entitlement();
        	ent.SlaProcessId = process.Id;
        	ent.Name = 'Test entitlement';
        	ent.AccountId = acctID;
            insert ent;
        	System.debug('Entitlement Created :' + ent.ID);
        
        	Case cas = new Case();
        	cas.AccountId = acctId;
        	cas.ContactId = con.Id;
        	cas.Origin = 'Web';
        	cas.Reason = 'International Bill Payments';
        	cas.Priority = 'High';
        	cas.Status = 'New';
        	cas.Description = '123456789';
        	cas.RecordTypeId = types[0].Id;
        	cas.EntitlementId = ent.Id;
        	insert cas;      
        	System.debug('Case Created :' + cas.ID);
        	system.debug('Entitlement Id' + cas.EntitlementId);
        	System.debug(cas);
                
        
   	}
    //Test Methods for Before Insert
      @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseCardServicesWithNoAccountTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Card Services' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].accountId = null;
        srs[0].entitlementId = null;
        update srs[0];
       test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        system.assert(srs[0].entitlementId == null);
        System.debug('Method test completed');
        
    }
      @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseCardServicesWithAccountTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Card Services' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].entitlementId = null;
        update srs[0];
       test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        system.assert(srs[0].entitlementId != null);
        System.debug('Method test completed');
        
    }
      @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseConsumerLendingWithAccountTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Card Services' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].entitlementId = null;
        update srs[0];
        test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        //system.assert(srs[0].entitlementId == null);
        System.debug('Method test completed');
        
    }
    
     @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseForeignExchangesWithNoAccountTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Foreign Exchange' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId, reason from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].accountId = null;
        srs[0].entitlementId = null;
        update srs[0];
       test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        system.assert(srs[0].entitlementId == null);
        System.debug('Method test completed');
        
    }
    
    @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseForeignExchangesWithAccountWIthDIffReasonTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Foreign Exchange' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId, reason from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].Reason = '';
        srs[0].entitlementId = null;
        update srs[0];
       test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        system.assert(srs[0].entitlementId == null);
        System.debug('Method test completed');
        
    }
    
    
      @isTest
    public static void ServiceRequestTriggerHandler_BeforeInsertCaseForeignExchangeWithAccountTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        //Get Card Services recordTypeId
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name =: 'Foreign Exchange' LIMIT 1];
        system.debug('rt' + rt);
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId, recordTypeId, accountId, reason from case Limit 1];
        System.debug(srs[0]);
        srs[0].recordtypeid = rt.id;
        srs[0].entitlementId = null;
        update srs[0];
        test.startTest();
        System.debug(srs[0]);
        svhandler.beforeInsert(srs);
        test.stopTest();
        system.assert(srs[0].entitlementId != null);
        System.debug('Method test completed');
        
    }
    
    //Test Methods for After Update
      @isTest
    public static void ServiceRequestTriggerHandler_afterUpdateCaseOpenTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId from case Limit 1];
        System.debug(srs[0]);
        test.startTest();
        svhandler.afterUpdate(srs, null, null, null);
        System.debug(srs[0]);
        test.stopTest();
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate from CaseMilestone where caseId =: srs[0].Id limit 1];
        System.debug('cmsToUpdate :' + cmsToUpdate);
        system.assert(cmsToUpdate[0].completionDate == null);
        System.debug('Method test completed');
        
    }
     @isTest
    public static void ServiceRequestTriggerHandler_afterUpdateCaseNoEntitlementTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId from case Limit 1];
        System.debug(srs[0]);
        srs[0].status = 'Closed';
        srs[0].entitlementId = null;
        test.startTest();
        svhandler.afterUpdate(srs, null, null, null);
        System.debug(srs[0]);
        test.stopTest();
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate from CaseMilestone where caseId =: srs[0].Id limit 1];
        System.debug('cmsToUpdate :' + cmsToUpdate);
        system.assert(cmsToUpdate[0].completionDate == null);
        System.debug('Method test completed');
        
    }    
     @isTest
    public static void ServiceRequestTriggerHandler_afterUpdateCaseTest(){
        ServiceRequestTriggerHandler.TriggerDisabled = true;
        ServiceRequestTriggerHandler svhandler = new ServiceRequestTriggerHandler();
        
        system.debug('Main Method');
        List<Case> srs = [Select  Id,  status, casenumber, isclosed, entitlementId from case Limit 1];
        System.debug(srs[0]);
        srs[0].status = 'Closed';
        test.startTest();
        svhandler.afterUpdate(srs, null, null, null);
        System.debug(srs[0]);
        test.stopTest();
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate from CaseMilestone where caseId =: srs[0].Id limit 1];
        System.debug('cmsToUpdate :' + cmsToUpdate);
        system.assert(cmsToUpdate[0].completionDate != null);
        System.debug('Method test completed');
        
    } 
}