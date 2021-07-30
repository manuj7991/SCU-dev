global class DeleteRedundantNEXTOffers implements Schedulable{
global void execute(SchedulableContext SC) {
    Map<Id,Id> mapOfferWithoutApp=new Map<Id,Id>();
    List<Id> lstEndDatePassedOffersNoApp=new List<Id>();
    List<Offer__c> lstEndDatePassedOffers = [select Id FROM Offer__c WHERE End_Date__c <Today];
    System.debug('lstEndDatePassedOffers'+lstEndDatePassedOffers);
    for(ResidentialLoanApplication objApp:[Select id,offer__c from ResidentialLoanApplication where offer__c IN :lstEndDatePassedOffers]){
    mapOfferWithoutApp.put(objApp.offer__c,objApp.id);}
    System.debug('mapOfferWithoutApp'+mapOfferWithoutApp);

    for(offer__c objOffer:lstEndDatePassedOffers){
    if(mapOfferWithoutApp.get(objOffer.id)==null){
        lstEndDatePassedOffersNoApp.add(objOffer.id);
    }}
    System.debug('lstEndDatePassedOffersNoApp'+lstEndDatePassedOffersNoApp);
    lstEndDatePassedOffers.clear();
    List<offer__c> RedundantOffers =[Select id from offer__c where id IN :lstEndDatePassedOffersNoApp];
    if(!RedundantOffers.isEmpty())
        delete RedundantOffers;
    }
}