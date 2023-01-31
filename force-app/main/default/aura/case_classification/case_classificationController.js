({ init: function(component, event, helper) {
    console.log(component.get("v.recordId"));
},
	 handleCaseUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if (eventParams.changeType === "CHANGED") {
            // get the fields that are changed for this record
           
            
            var changedFields = eventParams.changedFields;
            
            Object.keys(changedFields).forEach(function (key){
    			console.log('Owner - changed fields --' +JSON.stringify(changedFields['OwnerId']));
                console.log('Owner - changed fields --' +JSON.stringify(changedFields['ContactId']));
                console.log('Owner - changed fields --' +JSON.stringify(changedFields['AccountId']));
});
         
           // changedFields.forEach(function(value, key) {
	//console.log(key + " = " + value);
//})
            console.log('Fields that are changed: ' + JSON.stringify(changedFields));
            // record is changed so refresh the component (or other component logic)
        }
    }
})