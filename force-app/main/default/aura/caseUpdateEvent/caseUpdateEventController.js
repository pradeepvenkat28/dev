({
	handleCaseUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        // record is loaded (render other component which needs record data value)
        if (eventParams.changeType === "LOADED") {
            console.log('Case loaded', component.get("v.case").Owner.Name);
        } else if (eventParams.changeType === "CHANGED") {
            console.log('Fields that are changed: ' + JSON.stringify(eventParams.changedFields));
        }
    }
})