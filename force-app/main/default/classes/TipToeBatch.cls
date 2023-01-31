global class TipToeBatch implements Database.Batchable<TipToe__c>,Database.Stateful{
     List<TipToe__c> vList = new  List<TipToe__c>();

       
        global Iterable<TipToe__c> start(Database.BatchableContext BC){
            
            for(integer i=0 ; i<5 ; i++)
            {
                TipToe__c t = new TipToe__c();
                t.name = 'tip'+i;
                vList.add(t);
            }
        
            return vList;
        
        }
    
    
        global void execute(Database.BatchableContext BC, List<TipToe__c> scope) {
           
           Database.SaveResult[] srList= Database.insert(scope,false);// inserting the TipToe    
            
            for(Database.SaveResult sr : srList){
            if (sr.isSuccess()) {       
               System.debug(sr.getId());
            }
            else{
               System.debug(sr.getId());
               for(Database.Error err : sr.getErrors()) {
                                       
                    System.debug(err.getMessage()+'Fields that affected this error: ' + err.getFields());
               }     
             
            }
            
            }
          }
    global void finish(Database.BatchableContext BC) {
        
    }  



}