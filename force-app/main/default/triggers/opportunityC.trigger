trigger opportunityC on Opportunity (after insert,after update, after delete) {
    

    if (trigger.IsUpdate || trigger.IsInsert){
    OpportunityHandler.updateVendor(Trigger.New);
            }
    
    if(trigger.IsDelete)
    {
       OpportunityHandler.updateVendor(Trigger.old); 
    }

}