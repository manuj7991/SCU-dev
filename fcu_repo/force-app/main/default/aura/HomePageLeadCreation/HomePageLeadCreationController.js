/*({
    init : function (component)
    {
    	 
        var flow = component.find("flowData1");
    	flow.startFlow("Create_Lead_on_Account");
    },
    
    ShowFlow : function(component, event, helper) {
    $A.util.addClass(component.find("btnLead"), "slds-hide");
    var elements = document.getElementsByClassName("clsFlow");
    elements[0].style.display = 'block';
    }, 
       
}); */
({
    doInit: function(component, event, helper){
        alert(component.get('v.testAttr'));
        const flow = component.find("flowData");
        flow.startFlow("Create_Loan_Application_From_Home_Page");
    }
});