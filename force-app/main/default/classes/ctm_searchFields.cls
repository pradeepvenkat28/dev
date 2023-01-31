public class ctm_searchFields {
    @AuraEnabled(cacheable=true)
    public static List<string> ctm_searchField(String searchObj){
        List<string> SObjectList = new List<string>();   
        if(searchObj!=NULL && searchObj!='""'){
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(searchObj.replaceAll('"',''));
            if(targetType!=NULL){
                Map<String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();
                for (Schema.SObjectField field : fieldMap.values()) {
                    //SobjectList.add('{"value": "'+field.getDescribe().getName() +'", "label": "'+field.getDescribe().getLabel()+'"}');
                    SobjectList.add('{"value": "'+field.getDescribe().getName() +'", "label": "'+field.getDescribe().getLabel()+'", "required": "'+field.getDescribe().isNillable()+'"}');                    
                }
                if(!SObjectList.isEmpty())
                    return SObjectList;
                else{
                    SObjectList.add('{"value":"notfound","label":"Not Found","required":"false"}');
                    return SObjectList;
                }
            }
            else{
                SObjectList.add('{"value":"notfound","label":"Not Found","required":"false"}');
                return SObjectList;
            }
        }
        else{
            SObjectList.add('{"value":"notfound","label":"Not Found","required":"false"}');
            return SObjectList;
        }
    }
}