/**
 * Created by g.dorandini on 19/12/2019.
 */

public with sharing class FromEmailComponentController {


    private class LightningResponse {
        public List<E2C_Settings__c> emailOptions = new List<E2C_Settings__c>();
        public String defaultSelection = '';

        public lightningResponse(List<E2C_Settings__c> emailOptions, String defaultSelection) {
            this.emailOptions = emailOptions;
            this.defaultSelection = defaultSelection;
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getStoreEmailsList(String caseId) {

        Case cse = queryCase(caseId);
        cse.Origin = 'Web';

        List<E2C_Settings__c> filteredEmails = new List<E2C_Settings__c>();
        List<String> emails = new List<String>();
        String defaultEmail = '';

        User user = queryCurrentUserInfo();

        LightningResponse response = new lightningResponse(new List<E2C_Settings__c>(), defaultEmail);

        for(E2C_Settings__c e2c : queryE2CSettings()) {
                    defaultEmail = e2c.Email__c;
            

          /*  if (isRelevantEmail2Case(e2c, cse, user) && emails.contains(e2c.Email__c) == false) {
                if (defaultEmail == '' && cse.RecordType.Name =='Personal Shopper Case')
                    defaultEmail = e2c.Email__c;
                filteredEmails.add(e2c);
                emails.add(e2c.Email__c);
            }*/
        }
        response = new lightningResponse(filteredEmails, defaultEmail);

        response = addUserEmailSelection(response, cse.RecordType.Name, user);

        return JSON.serialize(response);
    }

    private static Case queryCase(String caseId) {
        return [SELECT Id, CaseNumber, RecordType.Name, AccountId
                FROM Case
                WHERE Id = :caseId];
    }


    private static List<E2C_Settings__c> queryE2CSettings() {
        return [SELECT Id, Display_Name__c, Case_Origin__c, Store_Alias__c, Recordtype_Name__c,
                            Email__c, Is_Default__c, Department__c, Personal_Shopper_Email__c
                FROM E2C_Settings__c
                WHERE Case_Origin__c != NULL
                ORDER BY Email__c];
    }

    private static Boolean isDefaultEmail2Case(String defaultEmail, E2C_Settings__c e2c, Case cse) {

        return
        (((
            e2c.Department__c == 'Personal Shopping'
        ) && (
            defaultEmail == ''
            && e2c.Case_Origin__c == cse.Origin
            && e2c.Is_Default__c == true
        )) || (
            cse.Origin == 'PORTER Subscriptions'
            
        ));
    }

   
    
    private static LightningResponse addUserEmailSelection(LightningResponse response, String recordTypeName, User user){
            response = addTheUserEmail(response, user);
        

        return response;
    }

    private static User queryCurrentUserInfo() {
        return [SELECT Name, Email, Profile.Name, UserRole.Name, Department
        FROM User
        WHERE Id = :System.UserInfo.getUserId()];
    }

   
  

    private static LightningResponse addTheUserEmail(LightningResponse response, User user) {
        E2C_Settings__c userE2C = new E2C_Settings__c(
                Display_Name__c = user.Name,
                Email__c = user.Email
        );

        response.emailOptions.add(userE2C);

        return response;
    }
}