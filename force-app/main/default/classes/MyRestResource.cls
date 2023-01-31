@RestResource(urlMapping='/pdfcheck')
global with sharing class MyRestResource {

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
   
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
  
  @HttpPost
    global static String doPost() {
            
  
     
       // Blob picture = req.
       //    System.debug('response ***** '+req.requestBody);
       // String str = 'JVBERi0xLjcNCiW1tbW1DQoxIDAgb2JqDQo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFIvTGFuZyhlbi1JTikgL1N0cnVjdFRyZWVSb290IDE0IDAgUi9NYXJrSW5mbzw8L01hcmtlZCB0cnVlPj4vTWV0YWRhdGEgNzAgMCBSL1ZpZXdlclByZWZlcmVuY2VzIDcxIDAgUj4+DQplbmRvYmoNCjIgMCBvYmoNCjw8L1R5cGUvUGFnZXMvQ291bnQgMS9LaWRzWyAzIDAgUl0gPj4NCmVuZG9iag0KMyAwIG9iag0KPDwvVHlwZS9QYWdlL1BhcmVudCAyIDAgUi9SZXNvdXJjZXM8PC9Gb250PDwvRjEgNSAwIFIvRjIgOSAwIFIvRjMgMTEgMCBSPj4vRXh0R1N0YXRlPDwvR1M3IDcgMCBSL0dTOCA4IDAgUj4+L1Byb2NTZXRbL1BERi9UZXh0L0ltYWdl';
       //system.debug('picture ----->'+EncodingUtil.base64Encode(picture));
       // system.debug('picture ----->'+picture);
       // blob x = blob.valueof(str);
       
        
       /* Blob picture = req.requestBody;
        Map<String, String> headers  = req.headers;
        
        for (String str : headers.keySet())
        {
            System.debug ( str + '  ----  '+headers.get(str));
        }
        
         Attachment a = new Attachment (ParentId = '500B0000007bTwkIAE',
                                       Body = picture,
                                       ContentType = 'application/pdf',
                                       Name = 'pdf-1.'+Datetime.now() );
        insert a;
        return a.Id;*/
        
        RestRequest req = RestContext.request;
RestResponse res = Restcontext.response;

// Here we will receive the blob value of the base64 converted pdf data.
Blob picture = req.requestBody;
// Convert the blob data to string to get the base64 response body. do not encode the data to convert // string using EncodingUtils method
String originalString = picture.toString();
system.debug('original string --> '+originalString);

// created a text attachment to see what is the value as the data in the debug logs is turncated.
Attachment a1 = new Attachment (ParentId = '500B0000007bTwkIAE',
Body = Blob.valueOf(originalString),
ContentType = 'text/plain',
Name = 'String');
insert a1;

// Now convert the base64 string to blob using the EncodingUtil.base64Decode(originalString) to get the original form of the Pdf data
Attachment a = new Attachment (ParentId = '500B0000007bTwkIAE',
Body = EncodingUtil.base64Decode(originalString),
ContentType = 'application/pdf',
Name = 'pdf-1.pdf');
insert a;
return a.Id;
        
        /*
        Blob picture = req.requestBody;
        String originalString = picture.toString();
        system.debug('original string --> '+originalString); 
     

  Attachment a1 = new Attachment (ParentId = '500B0000007bTwkIAE',
                                       Body = Blob.valueOf(originalString),
                                       ContentType = 'text/plain',
                                       Name = 'String');
        insert a1;


        Attachment a = new Attachment (ParentId = '500B0000007bTwkIAE',
                                       Body = EncodingUtil.base64Decode(originalString),
                                       ContentType = 'application/pdf',
                                       Name = 'pdf-1.pdf');
        insert a;
        return a.Id;*/
    }
}