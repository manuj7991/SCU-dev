({    invoke : function(component, event, helper) {
   // Get the record ID attribute
   var record = component.get("v.recordId");
   
   // Get the Lightning event that opens a record in a new tab
   var redirect = $A.get("e.force:navigateToList");
   
   // Pass the record ID to the event
   redirect.setParams({
      "scope": "Lead"
   });
        
   // Open the record
   redirect.fire();  
}})