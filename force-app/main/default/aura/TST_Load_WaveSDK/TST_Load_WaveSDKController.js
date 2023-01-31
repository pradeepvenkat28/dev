({
	doInit : function(component, event, helper) {
		console.log('doInit: START');
	/*
        setTimeout(() => {
			console.log('doInit: fetching dashboards');
            let analyticsSDK = component.find("analyticsSDK");
			console.log('doInit: analyticsSDK found',analyticsSDK);
       
        	analyticsSDK.invokeMethod(
            	{apiVersion: "52"},
            	"listDashboards",
            	{"sort": "Name"},
            	$A.getCallback(function(dbErr, dbData) { 
					console.log('doInit: dashboard list response received');
              		if (dbErr !== null) {
                    	console.error("doInit: END KO / dashboard ID fetch error: ", dbErr);
              		}
                	else {
						console.log("doInit: dbData received ",JSON.stringify(dbData));
                        let dbList = JSON.parse(JSON.serialize(dbData.dashboards));
						console.log("doInit: dbList cloned ",JSON.stringify(dbList));
                        component.set("v.dbList",dbList);
						console.log("doInit: END OK ");  
                	}
                }));
			console.log('doInit: dashboard list request sent');
        
        }, 5000);*/
		console.log('doInit: END');
	},
    fetchDashboards : function(component, event, helper) {
		console.log('fetchDashboards: START');
        
        let dbList = component.get("v.dbList");
        if ((dbList) && (dbList.length > 0)) {
			console.log('fetchDashboards: END - list already fetched');
            return;
        }
        else {
			console.log('fetchDashboards: fetching dashboards');
            
            let analyticsSDK = component.find("analyticsSDK");
			console.log('fetchDashboards: analyticsSDK found',analyticsSDK);
       
        	analyticsSDK.invokeMethod(
            	{apiVersion: 48},
            	"listDashboards",
                {"sort": "LastModified", "pageSize" : 200},
            	$A.getCallback(function(dbErr, dbData) { 
					console.log('fetchDashboards: dashboard list response received');
              		if (dbErr !== null) {
                    	console.error("fetchDashboards: END KO / dashboard list fetch error: ", dbErr);
              		}
                	else {
						console.log("fetchDashboards: dbData received ",JSON.stringify(dbData));
                        let dbList = JSON.parse(JSON.stringify(dbData.dashboards));
						console.log("fetchDashboards: dbList cloned ",JSON.stringify(dbList));
                        component.set("v.dbList",dbList);
                        component.set("v.isReady",true);
						console.log("fetchDashboards: END OK ");  
                	}
                }));
			console.log('fetchDashboards: dashboard list request sent');
        }
    },
    searchDashboard : function(component, event, helper) {
		console.log('searchDashboard: START');
        
        let selectId = event.currentTarget.id;
        console.log('searchDashboard: selectId fetched', selectId);
        component.set("v.selectedDb",selectId);
        let dbList = component.get("v.dbList");
        let listDetails = dbList.find(item => {return item.id === selectId});
        console.log('searchDashboard: listDetails found', JSON.stringify(listDetails));
        component.set("v.listDetails",JSON.stringify(listDetails));
        component.set("v.selectedDetails","searching");
        
        let eId = selectId.toString();
        
        let analyticsSDK = component.find("analyticsSDK");
		console.log('searchDashboard: analyticsSDK found',analyticsSDK);
        
        analyticsSDK.invokeMethod(
			{apiVersion: "52"},
			"listDashboards",
			{"ids":eId},
			$A.getCallback(function(dbErr, dbData) { 
				console.log('searchDashboard: dashboard response received');
				if (dbErr !== null) {
					console.error("searchDashboard: END KO / dashboard ID fetch error: ", dbErr);
                    component.set("v.selectedDetails","search failed: " + JSON.stringify(dbErr));
				}
				else {
					console.log("searchDashboard: END dashboard details received ",JSON.stringify(dbData));
					component.set("v.selectedDetails",JSON.stringify(dbData));
				}
			}));
		console.log('searchDashboard: fetching dashboard details');
    }
})