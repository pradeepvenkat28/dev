trigger TipToe on Tiptoe__c (before insert) {
    
    List<Tiptoe__c> tList = new List<Tiptoe__c>();
   
    for(integer i=1;i<= Trigger.New.size();i++)
    {
        if(Math.mod(i,5)!=0)
        {
            System.debug('BEFORE VALUE : '+Trigger.New[i-1]);
            Trigger.New[i-1].Taste__c = 'Sour';
            System.debug('AFTER VALUE : '+Trigger.New[i-1]);
        }
        
    }
    
    for(Tiptoe__c t : Trigger.New)
    {
        System.debug('Check  -- '+t.Taste__C);
    }

}