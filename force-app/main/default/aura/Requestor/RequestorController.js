({
	handleRefresh : function(component, event, helper) {
		console.log('handle refresh...')
	},
    
    doInit : function(component, event, helper) {
		console.log('handle init...')
    
     var pickListValuesList = [];
                
                    pickListValuesList.push({value:'Value1', key:'key1'});
        pickListValuesList.push({value:'Value2', key:'key2'});
        pickListValuesList.push({value:'Value3', key:'key3'});
         component.set("v.modulePickList", pickListValuesList);            
    }
})