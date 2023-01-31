public class PRA_CalTotalAmountOnAccountHandler {

    public static void calculateAmount(List<Opportunity> newOppoRec){
        List<Account> accList = new List<Account>();
        Map<Id,List<Opportunity>> accOppMap = new Map<Id,List<Opportunity>>();
        List<String> oppIds = new List<String>();
        for(Opportunity opp : newOppoRec){
            
            if(!oppIds.contains(opp.Id)){
            if(!accOppMap.containsKey(opp.AccountId)){
                List<Opportunity> oppList = new List<Opportunity>{opp};
                accOppMap.put(opp.AccountId, oppList);
            }else
            {
                accOppMap.get(opp.AccountId).add(opp);
            }
                //Adding opportunity id to the list so that if there are duplicate opportunity records in the newOppoRec list we can get avoid adding them again. 
              oppIds.add(opp.Id);  
           }

        }

        for(Account acc : [SELECT id, Total_Amount__c FROM Account WHERE id IN :accOppMap.keySet()]){

            List<Opportunity> oppo = accOppMap.get(acc.Id);

            System.debug('Total Oppo'+oppo.size());

            Decimal amt = 0;

            for(Opportunity opport : oppo){

                amt += opport.Amount;

            }

            System.debug('Amount'+amt);

            acc.Total_Amount__c = amt;
            
            // add the record to account list.
           accList.add(acc); 

        }
        if(accList.size()>0){ update accList;}
       

    }

}