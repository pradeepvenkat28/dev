public with sharing class ChatHandler {
   
        @AuraEnabled
        public static String getChatResult(String searchString)
        {
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +searchString+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 1}';
            System.debug('Query '+searchString+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.openai.com/v1/completions');
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes('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').trim());
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(reqBody);
            HttpResponse response = http.send(request);

            return response.getBody();

        }

    
}