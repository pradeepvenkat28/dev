global class CaseBatch  implements Database.Batchable<Case>,Database.Stateful{
    
    global Iterable<Case> start(Database.BatchableContext BC)
    {
        List<case> casList = new List<Case>();
        for(integer i = 0; i<200 ;i++)
        {
            
            if(Math.mod(i,2)==0)
            {
            Case cas = new Case();
			cas.Origin = 'Email';
			cas.status = 'New';
                cas.SLA_status__c = 'New';
                casList.add(cas);
            }
            else
            {
              Case cas = new Case();
			cas.Origin = 'Email';
			cas.status = 'Working ';
                cas.SLA_status__c = 'New';  
                casList.add(cas);
            }
        }
        
        return casList;
    }    
        global void execute(Database.BatchableContext BC, List<Case> scope) { 
            
           Database.SaveResult[] srList= Database.insert(scope,false);// inserting the cases          
               String errString;        
            List<case> CaseList = scope;
            integer i=0; 
            for(Database.SaveResult sr : srList){
            if (sr.isSuccess()) {       
               }
            else{
                String str;
               for(Database.Error err : sr.getErrors()) {
                                       
                    str = err.getMessage()+'<br>Fields that affected this error: ' + err.getFields();
               }     
               errString += str;
            }
            
            }
        }
        
        global void finish(Database.BatchableContext BC) {
            
        }

}