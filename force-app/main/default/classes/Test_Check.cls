@isTest(SeeAllData=true)
public class Test_Check {
    
    static testMethod void testContentDocumentLink()
    {
        User u= [Select Id , name from User where id = '005B0000007kv4u'];
        
        System.runAs(u){
        ContentDocumentLink cdl = new ContentDocumentLink();
		cdl.ContentDocumentId = '069B000000AwN84IAF';
		cdl.LinkedEntityId = '500B0000009WUp1IAG';
		cdl.ShareType = 'V';
            insert cdl;
        }
    }

}