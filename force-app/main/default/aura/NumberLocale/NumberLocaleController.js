({
    doInit : function(cmp, event, helper) {
        var action = cmp.get("c.getCaseDetail");
        action.setParams(
            { caseId : '500B0000007bTwkIAE' });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.CaseObj",response.getReturnValue());
           
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                }
            }
        
        });
        $A.enqueueAction(action);
    },
    
	saveCase : function(cmp, event, helper) {
		var action = cmp.get("c.saveCaseDetail");
        action.setParams(
            { c : cmp.get("v.CaseObj") });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
            console.log( response.getReturnValue());
                
                var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Success!",
        "message": "The record has been updated successfully."
    });
    toastEvent.fire();
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                }
            }
        
        });
        $A.enqueueAction(action);
    }
                           
})