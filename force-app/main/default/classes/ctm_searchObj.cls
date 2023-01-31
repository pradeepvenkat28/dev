public class ctm_searchObj {
    @AuraEnabled(cacheable=true)
    public static List<string> ctm_searchObject(String searchKeyword){
        List<string> SObjectList = new List<string>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String label = objTyp.getDescribe().getLabel();
            String name = objTyp.getDescribe().getName();
            if(label.startsWithIgnoreCase(searchKeyword) || name.startsWithIgnoreCase(searchKeyword))
            {      
                SobjectList.add('{"label": "'+label+'", "value": "'+name+'"}');
            }
        }
        if(!SObjectList.isEmpty())
            return SObjectList;
        else{
            SObjectList.add('{"label":"Not Found","value":"notfound"}');
            return SObjectList;
        }
    }
}