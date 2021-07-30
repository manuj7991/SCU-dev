({   
      onInit : function( component, event, helper ) {
        
        var interval = setInterval($A.getCallback(function () {
            var progress = component.get('v.progress');
            var prgBar = component.find("prgBar");
            if(progress >= 0){
                $A.util.addClass(prgBar,'slds-is-low');
            }
            if(progress >= 75){
                $A.util.removeClass(prgBar,'slds-is-high');
                $A.util.addClass(prgBar,'slds-is-critical');
             }
             component.set('v.progress', progress === 100 ? clearInterval(interval) : progress + 50);
            }), 500);
    

        let objectName = component.get("v.sObjectName");
        let actionName = '';
        switch(objectName)
        {
            case 'Account':
                actionName= "c.updateAccountFromDNA";
                break;
            case 'FinServ__Card__c':
                actionName="c.updateMemberCardFromDNA";
                break;
        }
        let action = component.get( actionName );  
        action.setParams({  
            recId: component.get( "v.recordId" )
        });  
        action.setCallback(this, function(response) {  
            $A.get('e.force:closeQuickAction').fire();
            let state = response.getState();  
            
            if ( state === "SUCCESS" ) {  
                
               
                $A.get('e.force:refreshView').fire();   
                component.find('notify').showToast({
                    "variant": "success",
                    "title": "Sync Update",
                    "message": "Record updated successfully"
                });
            }  else {
                $A.get('e.force:closeQuickAction').fire();
                component.find('notify').showToast({
                    "variant": "Error",
                    "title": "Sync Update",
                    "message": "Record Not Updated due to error.Please try again.."
                });
                
            }
        });  
        $A.enqueueAction(action);         
    }
    
})