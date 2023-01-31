public class CaseHelper {
     
    public void updateCase(List<Case> casList)
   
  
    {
    
    List<Case> c= new List<Case>();
    
        for(Case cas : casList)
        {
            if(cas.Status == 'Working')
            {
                cas.SLA_Status__c = 'abc';
            }
            
            else 
            {
            
             cas.SLA_Status__c = 'New';
            c.add(cas);
            
            
            }
            
         
        }
        system.debug(c);
        
    }

}