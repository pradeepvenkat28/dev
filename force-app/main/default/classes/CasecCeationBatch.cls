global class CasecCeationBatch implements Database.Batchable<Vendor__c>,Database.Stateful{
    
        global  Set<id> caseids=new Set<id>();
     List<Vendor__c> vList = new  List<Vendor__c>();
    String accountId;
  

    global CasecCeationBatch(String accId){
        this.accountId=accId;         
    }     
        global Iterable<Vendor__c> start(Database.BatchableContext BC){       
             vList = [Select Id, Account__c , GS_Opearting_Unit__c from Vendor__c where account__c =:accountId];      
         return vList;
        }
    
    
        global void execute(Database.BatchableContext BC, List<Vendor__c> scope) {
           List<Case> casList = new List<Case>();
            for(Vendor__c v : scope)
            {
                Case c = new Case();
                c.status='New';
                c.Origin='Web';
                c.AccountId = v.Account__c;
                c.vendor__c = v.Id;
                casList.add(c);
            }
            
           Database.SaveResult[] srList= Database.insert(casList,false);// inserting the cases    
            
            List<case> CaseList1 = casList;
            integer i=0; 
            for(Database.SaveResult sr : srList){
            if (sr.isSuccess()) {       
                caseids.add(sr.getId()); 
            }
            else{
                
               for(Database.Error err : sr.getErrors()) {
                        System.debug('error :  '+err.getFields());
                                           System.debug('error :  '+err.getMessage() +'----fields----  '+ err.fields);
                    err.getFields();
               }     
              
            }
             
           }
                       
          
       }
    global void finish(Database.BatchableContext BC) {
        
    }  

}