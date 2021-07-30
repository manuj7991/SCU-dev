({
	doInit : function(component, event, helper) {

       var appEvt = $A.get("e.lightning:nextBestActionsRefresh");

       appEvt.setParam("recordId", component.get("v.myRecordId"));

       appEvt.fire();
    }
})