public class PublishEvent {
    
    @AuraEnabled
    public static void publistEventOn()
    {
        List<Test__e> inkEvents = new List<Test__e>();
inkEvents.add(new Test__e(Printer_Model__c='XZO-5', Serial_Number__c='12345'));
inkEvents.add(new Test__e(Printer_Model__c='MN-123', Serial_Number__c='10013'));


// Call method to publish events
	List<Database.SaveResult> results = EventBus.publish(inkEvents);

// Inspect publishing result for each event
	for (Database.SaveResult sr : results) {
    if (sr.isSuccess()) {
        System.debug('Successfully published event.');
    } else {
        for(Database.Error err : sr.getErrors()) {
            System.debug('Error returned: ' + err.getStatusCode() + ' - ' +  err.getMessage());
        }
    }       
}
    }

}