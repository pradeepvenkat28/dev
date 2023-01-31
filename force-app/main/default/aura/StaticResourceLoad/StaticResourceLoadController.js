({
	myAction : function(component, event, helper) {
		
	},
    
    afterScriptsLoaded : function(component, event, helper) {
		console.log('Static resource loaded'); 
        component.set("v.value", msTeams.init());
	}
})