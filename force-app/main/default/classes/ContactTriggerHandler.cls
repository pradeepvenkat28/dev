public  with sharing class ContactTriggerHandler {
    
    public static void deactivateAccount()
    {
           List<Account> accList = new List<Account>();
    
    for(Account a : [Select Id , IsCustomerPortal from Account where Id in ('001B000001RthRcIAJ') ])
    {
        a.IsCustomerPortal = false;
        accList.add(a);
    }
    
    if(accList.size() > 0)
        update accList;
    }

}