({
    invoke : function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    },
    handleSuccess: function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    }
})