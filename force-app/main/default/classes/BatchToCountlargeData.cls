public class BatchToCountlargeData implements Database.Batchable<sObject>,Database.Stateful{

    Map<String,Integer> groupRecordsCount = new map<String,Integer>{'empty'=>0};
    public final string Query;
 public Integer totalAmtOfRecords = 0; 

    public BatchToCountlargeData(String queryToGetCount){
			this.Query=queryToGetCount; 
    }
   

   public Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext BC, List<Account> scope){
       
       for( Account acc : scope){
           
           if(String.isEmpty(acc.Rating))
           {
               groupRecordsCount.put('empty', groupRecordsCount.get('empty')+1);
           }else if(groupRecordsCount.get(acc.Rating) ==null)
           {
              groupRecordsCount.put(acc.Rating,1);
           }else
           {
                groupRecordsCount.put(acc.Rating, groupRecordsCount.get(acc.Rating)+1);
           }
       }       
     totalAmtOfRecords += scope.size();
       
    }

   public void finish(Database.BatchableContext BC){
         system.debug('Total amount of records processed :' + totalAmtOfRecords); 
                system.debug('Total amount of records processed in a map :' + groupRecordsCount); 
       
       String records = '';
       for(String key: groupRecordsCount.keySet())
       {
           records = records+ ' ' +key+' --> '+ groupRecordsCount.get(key)+ '\n';
       }
       
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'pradeep.m@salesforce.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject(' Count of records by country  ');
            mail.setPlainTextBody('*******Count of records by country*****'+records);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}