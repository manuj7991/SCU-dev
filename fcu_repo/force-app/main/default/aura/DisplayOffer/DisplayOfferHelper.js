({
getOfferList: function(component) {
var action = component.get('c.GetOffer');
// Set up the callback
var self = this;
action.setCallback(this, function(actionResult) {
component.set('v.lstOffer', actionResult.getReturnValue());
});
$A.enqueueAction(action);
}
})