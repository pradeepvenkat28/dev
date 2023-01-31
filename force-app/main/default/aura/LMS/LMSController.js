({
	handleLightningMessage : function(component, event, helper) {
		if (event != null && event.getParam("Type") != null) {
        
                        var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
            "title": "Success!",
            "message": "The message has been subscribed successfully."
            });
            toastEvent.fire();

           
	}
    },
    
    publishMessage : function(component, event, helper) {
		 let payload = {
                              Type: "Video_Invite", 
                              HistoryCreated: "false"
                            }; 
       component.find("SanityChannel").publish(payload); 
	}
})