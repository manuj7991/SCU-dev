public class GetNotificationMessages {

    @AuraEnabled
    public static List<Notification_Message__c> GetMessages()
    {
        List<Notification_Message__c> lstmessages =[Select Id,Name,start_Date__c,End_Date__c, Message_Description__C, Message_Type__c FROM Notification_Message__c where End_Date__c > today];
        System.debug(lstmessages.size());
        return lstmessages;
    } 

}