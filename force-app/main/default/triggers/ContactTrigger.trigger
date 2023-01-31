trigger ContactTrigger on Contact (after update) {
    
    
    if(Trigger.isAfter && Trigger.isUpdate){
       ContactTriggerHandler.deactivateAccount();
    }
    
  

}