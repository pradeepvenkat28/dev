global with sharing class HRM_BPHREmailCasesHandler implements Messaging.InboundEmailHandler {
    
    
    /*global Boolean parentCaseCloseFlag = False; //Sindhura 13-Feb-2020: created variable for logic as part of HRSO - 7120
    
    global static Id getCaseIdFromEmailThreadIdentifier(String caseThreadId){
        return caseThreadId.mid(12,5) + '00000' + caseThreadId.mid(17,5);
    }
    
    
    //This method will search for the country in Email body & create a parent case & child case with details 
    //based on the matching country value using Email service
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope) {                   
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        List<String> toEmailAddress = new List<String>();
        for(String eAdd: email.toAddresses){
            toEmailAddress.add(eAdd);
        }
         String EmailBody= (string)email.plainTextBody;
            System.debug('INSIDE TRY BLOCK');
            //Create a list of attachments
            //String caseThreadId=EmailBody.Substring(EmailBody.indexof('ref:')+4,EmailBody.indexof(':ref'));
           // System.debug('caseThreadId'+caseThreadId);
            //ID caseIdFE = Cases.getCaseIdFromEmailThreadId(caseThreadId);
           // System.debug('caseId'+caseIdFE);
            System.debug('Email Header' + email.headers );
        
        for(Messaging.InboundEmail.Header head : email.headers )
        {
            system.debug(head);
            system.debug(head.Name + '   '+head.Value);
            
        }
        
        String caseId = Cases.getCaseIdFromEmailHeaders(email.headers);
        System.debug('caseId : '+caseId);
        If(email.inReplyTo != null && caseId == null)
        {
             System.debug('in reply to -- '+email.inReplyTo);
         String inreply = String.valueOf(email.inReplyTo);
        System.debug('reference header -- '+email.references);
        caseId = inreply.substring(1,16);
        System.debug('in reply to caseId : '+ caseId);   
        }
                String fromEmailAddress = email.fromAddress;
        List<Contact> vCon = [SELECT Id, Name, Email FROM Contact WHERE Email = :fromEmailAddress LIMIT 1];
        
        Account acc = [Select Id,Customer_Id__c ,Name from Account limit 1];
      
       if(caseId == null){  

             //create new case and Attach email to parent cases.s
			 List<case> caseList = new List<Case>();
             case cas = new case();
            cas.Subject = 'case created from the apex handler';
            cas.Origin = 'Email';
            cas.status = 'New';
            cas.ContactId = vCon[0].Id;
            cas.OwnerId = '00GB0000004aGMY';
        caseList.add(cas);
            Database.DMLOptions dlo = new Database.DMLOptions();
			dlo.EmailHeader.triggerAutoResponseEmail = true;

			 Database.insert(caseList,dlo);
 
             EmailMessage emMessage = new EmailMessage(); 
                emMessage.ParentId = cas.Id; 
             emMessage.relatedToId = cas.Id; 
                emMessage.fromAddress = email.fromAddress; 
                emMessage.fromName = vCon[0].Name;
                emMessage.subject = email.subject;
                emMessage.HtmlBody = email.htmlBody;
                emMessage.Incoming = True; // Added by Murthy as part of HRSO-21696
                emMessage.ToAddress=email.fromAddress;       
               insert emMessage;
            
        
        System.debug('new EmailMessageId --> '+emMessage);
            

    
        }
        else {
            //Attach email to parent cases
                EmailMessage emMessage = new EmailMessage(); 
                emMessage.ParentId = caseId; 
                emMessage.fromAddress = email.fromAddress; 
                emMessage.fromName = vCon[0].Name;
                emMessage.subject = email.subject;
                emMessage.HtmlBody = email.htmlBody;
                emMessage.Incoming = True; // Added by Murthy as part of HRSO-21696
                emMessage.ToAddress=email.fromAddress;       
                insert emMessage;
            
            System.debug(emMessage.id);
        
        System.debug('EmailMessageId --> '+emMessage);
        }
       
            return result;
    
    }
    
    
    ********************
  */       
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
         Messaging.InboundEmail.textAttachment[] tAttachments = email.TextAttachments;
        Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.BinaryAttachments;
          
          System.debug('text ---- '+tAttachments);
          System.debug('binary ---- '+bAttachments);
        
        String csvbody = '';
        
        String csvAsString = '';
        if(tAttachments != null){
            for (Messaging.Inboundemail.TextAttachment file : email.TextAttachments) 
            {
                csvAsString = file.Body;
            }
        }
        else if(bAttachments != null){
            for (Messaging.Inboundemail.BinaryAttachment file : email.BinaryAttachments) 
            {
                if(file.fileName.contains('csv')){
                    csvAsString = file.Body.toString();
                }
                
            }
        }
          
          return null;
            
      } 
}