public class LontextController {

        public case openPartOrder{get; set;}
    
    public LontextController(){
        
        openPartOrder = [SELECT Id,Latitude__c, Biography__c  FROM Case where id = '500B0000007bTwkIAE'];
        
    }
    
    public PageReference populateShippingInstructions(){  
        
            Case partsOrdRed = new Case(Id = OpenPartOrder.id); 
                update partsOrdRed;
            
            return null;
                      
    }
    
     public PageReference partsOrderingOnLoad(){
         PageReference redirectPage ;
         
                 openPartOrder = [SELECT Id,Latitude__c, Biography__c  FROM Case where id = '500B0000007bTwkIAE'];

         return redirectPage;
     
     }

}