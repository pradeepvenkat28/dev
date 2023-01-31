trigger CaseTrigger on Case ( before update , before insert) {
    
    if(trigger.isBefore){
    
        if(trigger.isInsert){
            for(case c: trigger.new)
            {
                c.businessHoursId = '01mB0000000LH1n';
                c.EntitlementId = '550B0000000ZPmRIAW';
            }
        }
    
        if(Trigger.isUpdate){
    
            for(case c: trigger.new)
            {
                
                c.businessHoursId = '01mB0000000LH1n';
                c.EntitlementId = '550B0000000ZPmRIAW';
            }
        }
    }
}