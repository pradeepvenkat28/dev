public class ContentDocumentHelper {

    public static void processAfterInsert(Map<Id, ContentDocumentLink> cdlMap) {
       
        try{
            map<Id,Id> caseIdWithContDocId=new  map<Id,Id>();
            Map<Id, Id> mapContentDocXEmailMessage = new Map<Id, Id>();
            //adding ContentDocumentLink Id and LinkedEntityId to mapContentDocXEmailMessage
            for (ContentDocumentLink cdl : cdlMap.values()) {
                mapContentDocXEmailMessage.put(cdl.Id, cdl.LinkedEntityId);
            }
            //Collecting list of EmailMessage where Email Message Id is equal to ContentDocumentLink Id 
            //Collecting list of EmailMessage where Email Message Id is equal to ContentDocumentLink LinkedEntityId
            List<EmailMessage> emList = [
                SELECT id, ParentID, FromAddress, FromName, HasAttachment, Headers, Subject, ActivityID, ToAddress
                FROM EmailMessage
                WHERE id = :mapContentDocXEmailMessage.values()  WITH SECURITY_ENFORCED
            ];
            Map<Id, EmailMessage> mapCaseXEmailMessage = new Map<Id, EmailMessage>(emList);
            List<ContentDocumentLink> cdlupd = new List<ContentDocumentLink>();
            //adding ContentDocumentLink record to ContentDocumentLink list
            for (ContentDocumentLink cdl : cdlMap.values()) {
                if (mapContentDocXEmailMessage.ContainsKey(cdl.Id)) {
                    Id emailMessageId = mapContentDocXEmailMessage.get(cdl.Id);
                    if (mapCaseXEmailMessage.ContainsKey(emailMessageId) && caseIdWithContDocId.get( mapCaseXEmailMessage.get(emailMessageId).ParentId)!=cdl.ContentDocumentId ) {
                        EmailMessage obj = mapCaseXEmailMessage.get(emailMessageId);
                        ContentDocumentLink c = new ContentDocumentLink();
                        c.ContentDocumentId = cdl.ContentDocumentId;
                        c.LinkedEntityId = obj.ParentID;
                        c.ShareType = 'I'; // Inferred permission. User's permission is determined by related record.
                        c.Visibility = cdl.Visibility;
                        caseIdWithContDocId.put(obj.ParentID,cdl.ContentDocumentId);
                        cdlupd.Add(c);
                    }
                }
            }
            //adding contentDocumentLink,if it is empty 
            if(!cdlupd.isEmpty() && Schema.sObjectType.ContentDocumentLink.isCreateable()){
                insert cdlupd;
            }
        }
        catch(Exception e){
            System.debug(e);}
    } 
}