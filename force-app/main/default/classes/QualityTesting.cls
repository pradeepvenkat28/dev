public  with sharing class QualityTesting {
   
    public  void testQuality()
    {
        Account acc = [Select Id, Quality__c from Account with SECURITY_ENFORCED limit 1 ];
    }
}