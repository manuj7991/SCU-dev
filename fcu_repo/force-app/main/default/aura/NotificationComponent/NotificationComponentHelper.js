({
	findNotifications : function(component) {
 		setTimeout(repeatingFunc, 0);
        function repeatingFunc() {
     		 var action = component.get('c.GetMessages'); 
             var messageList;
             action.setCallback(this, function(a){
                var state = a.getState(); // get the response state
                if(state == 'SUCCESS') {
                    
                    messageList = a.getReturnValue();
                    
                    var listLength = messageList.length;
                    for (var i = 0; i < listLength; i++) {
                         var toastEvent = $A.get("e.force:showToast");
                         
                         toastEvent.setParams({
                            "title": messageList[i].Name,
                            "type": messageList[i].Message_Type__c,
                            "mode": "sticky",
                            "message": messageList[i].Message_Description__c
                        });
                        toastEvent.fire();
                    }
                }
            });
            $A.enqueueAction(action);
            setTimeout(repeatingFunc, 1800000);
            }
    }
})