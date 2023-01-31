public with sharing class DM_SandboxHelper {

    
    public static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();// DM_ToolingService.fetchUserSessionId();// UserInfo.getSessionId();
        return service;
    }

    public static String handleDataResults(Database.SaveResult[] srList) {
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
        return '';                
            }
            else {
                List<String> messages = new List<String>();
                messages.add((sr.getErrors().size() == 1 ? 'Error ' : 'Errors ') + 'occured processing component ' + sr.getId() + '.');
                for(Database.Error err : sr.getErrors()) {  
                    messages.add(
                        err.getMessage() + ' (' + err.getStatusCode() + ').' + 
                        (err.getFields() != null && err.getFields().size() > 0 ? ' Fields ' + String.join(err.getFields(), ',') + '.' : '') 
                    );                    
                }
                return String.join(messages, ' ')  + '\n';
            }
        }
        return ''; 
    }
    
    public static String handleSaveResults(MetadataService.SaveResult saveResult) {
        if(saveResult==null || saveResult.success)
            return '';
        if(saveResult.errors!=null) {
            List<String> messages = new List<String>();
            messages.add((saveResult.errors.size() == 1 ? 'Error ' : 'Errors ') + 'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(error.message + ' (' + error.statusCode + ').' + ( error.fields!=null && error.fields.size() > 0 ? ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            
            if(messages.size()>0)
                return String.join(messages, ' ') + '\n';
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            return '';
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }

    public class MetadataServiceExamplesException extends Exception { }
}