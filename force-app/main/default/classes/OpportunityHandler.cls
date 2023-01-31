public class OpportunityHandler {

    public static void updateVendor(List<Opportunity> oppList)
    {
         for(Opportunity opp : oppList){
        if(opp.Vendor__c != null)
        {
             List<AggregateResult> slResult =  [Select count(id) , Vendor__c, sum(Amount) slSum from opportunity where Vendor__c =:opp.Vendor__c group by Vendor__c ];
            if(slResult.size()>0) 
            {
                Vendor__c v = new Vendor__c();
                v.Id = (Id)slResult[0].get('Vendor__c');
                v.Total_Amount__c = (Decimal)slResult[0].get('slSum');
               update v;
            }else
            {
                Vendor__c v = new Vendor__c();
                v.Id = opp.Vendor__c;
                v.Total_Amount__c = 0;
               update v;
            } 
        }
            
            }
    }
}