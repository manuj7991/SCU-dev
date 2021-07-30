public class GetOfferList {
@AuraEnabled
public static List<Offer__c> GetOffer()
{
List<Offer__c> lstOffer=[Select Id,Name,Account__c,Category__c,Channel__c,End_Date__c,Start_date__c,Is_Priority_Offer__c,Offer_Response__c,Offer_Type__c,Source__c FROM Offer__c where Channel__c='Salesforce' and End_Date__c>=today order by Start_date__c desc];
System.debug(lstOffer.size());

    return lstOffer;
} 
}