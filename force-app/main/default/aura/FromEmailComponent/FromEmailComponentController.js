({
    doInit : function(cmp, event, helper) {
        let action = cmp.get("c.getStoreEmailsList");
        let caseRecordId = cmp.get('v.recordId');
        action.setParam('caseId', caseRecordId);
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                let fromEmailList = JSON.parse(response.getReturnValue());
                
                console.log(fromEmailList);
                cmp.set('v.fromEmailList', fromEmailList);

                if (fromEmailList && fromEmailList.defaultSelection) {
                    let actionAPI = cmp.find("quickActionAPI");
                    let selectedValue = fromEmailList.defaultSelection;

                    let fields = {FromAddress: {value: selectedValue}};
                    let args = {actionName: "Case.EmailLightning", targetFields: fields};
                    actionAPI.setActionFieldValues(args);
                }
            }
        });
        $A.enqueueAction(action);
    },

    selectFromEmail : function(cmp, event, helper) {
        let actionAPI = cmp.find("quickActionAPI");
        let selectedValue = cmp.find('select').get('v.value');

        let fields = {FromAddress :{value :selectedValue} };
        let args = {actionName: "Case.EmailLightning", targetFields: fields};
        actionAPI.setActionFieldValues(args);
    }
});