({
	closeModal:function(component,event,helper) 
    {
        component.set("v.isOpen", false);
    },

    doInit: function(component,event,helper) 
    {
        component.set('v.isOpen', true);
        const flow = component.find("flowData");
        flow.startFlow("New_Person_Lead_and_Referral"); 
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop'); 
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');    
     },
    
    handleStatusChange : function (component, event) 
    {
         if(event.getParam("status") === "FINISHED") 
         {       
             component.set("v.isOpen", false);   
         }
    }
    
});