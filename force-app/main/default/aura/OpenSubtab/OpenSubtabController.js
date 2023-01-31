({
    
    invoke : function(component, event, helper) {
       // Do something, like open another browser tab
       // with a specified URL
    },
    openTabWithSubtab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
            recordId: '003B000000JBaMqIAL',
            focus: true
        }).then(function(response) {
            workspaceAPI.openSubtab({
                parentTabId: response,
                recordId: '003B000000JBaMqIAL',
                focus: true
            });
        })
        .catch(function(error) {
            console.log(error);
        });
    },
    
    openTab : function(component, event, helper) {
   
        var redirect = $A.get("e.force:navigateToSObject");
        console.log('redirect');
        // Pass the record ID to the event
        redirect.setParams({
            "recordId": "003B000000JBaMqIAL"
        });
        
        // Open the record
        redirect.fire();
        
       
		
	},
    getEnclosingTabId : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        console.log('workspaceAPI1--'+workspaceAPI);
        workspaceAPI.getAllTabInfo().then(function(response) {
            console.log('tab info---'+response);
       })
        .catch(function(error) {
            console.log(error);
        });
    }
    
  
})