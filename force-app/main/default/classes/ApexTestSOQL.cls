public class ApexTestSOQL {
    
    @TestVisible
    List<Account> acc = [Select id,name from account limit 10];
    
     public  void methodOne()
    {
        System.debug('salesforce test');
        
        List<Account> accIn = this.acc;
    }

}