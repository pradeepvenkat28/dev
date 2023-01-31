public class NumberLocaleController {

    @AuraEnabled
    public static Case getCaseDetail(String caseId )
    {
        Case cas  = [select Id , Latitude__c from case where id =: caseId];
        return cas;
    }
    
@AuraEnabled
    public static String saveCaseDetail(case c)
    {
        SYSTEM.debug(C);
        system.debug('lattitude ' + c.Latitude__c );
        
        update c;
        return c.Id;
    }

}