/*
@Author : Prashant Sachdeva
@CreatedDate : 16th July 2021
@Description : Offer Object Trigger Handler.
*/
public class OfferTriggerHandler implements ITriggerHandler{
     
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
     
    public void beforeInsert(List<sObject> newList) {
        //Following code will update the recordType based on the account
        system.debug('In Before Insert: Offerhndler '+ newList);
        //Fetch all record types
        Map<Id, String> typeMap = New Map<Id, String>();
        for(RecordType rt: [Select DeveloperName, Id From RecordType Where sObjectType = 'Offer__c']) {
            typeMap.put(rt.Id,rt.DeveloperName);
        }
        System.debug(typeMap);
         for (Offer__c c : (List<Offer__C>)newList) {
             //Check if account is associated with Offer
            //if (c.Account__c != ''){
                System.debug('Account exists');
                //Fetch all accont details
                List<Account> accounts=[ select Id, recordtypeId from Account where Id =: c.Account__c limit 1];
                if (accounts.isEmpty() == false){
                    System.debug('Account details on Offer exists');
                    for(Account act:accounts){
                        //if DNA_CUST_KEY contains O means it is a BUsiness Customer
                        string recId;
                       
                         Recordtype rectype;
                       
                            if (act.recordtypeId == Schema.sObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId()){
                                system.debug('Business Account');
                                rectype = [select id, developername from recordtype where sObjectType =:'Offer__c' and developername=: 'Service_CU_Offer_for_Business'];
                                system.debug(rectype);
                                }
                            else{
                                System.debug('Person Account');
                               rectype = [select id, developername from recordtype where sObjectType = 'Offer__c' and developername =:'Service_CU_Offer_for_Person'];
                               system.debug(rectype);
                               }
                               
                               System.debug('Fetch and assign recordtype');
                               //Fetch and assign recordtype.
                               //recordtype rectype = [select id, developername from recordtype where id=:recId];
                               c.RecordTypeId = rectype.Id; 
                        
                    }
                }
           // }
        }
    }
     
    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
         
    }
     
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }
}