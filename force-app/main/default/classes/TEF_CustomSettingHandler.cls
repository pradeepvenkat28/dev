public  class TEF_CustomSettingHandler {
    @AuraEnabled(cacheable=true) 
    public static String getCustomSettings(){
        return 'Salesforce';
    }
}