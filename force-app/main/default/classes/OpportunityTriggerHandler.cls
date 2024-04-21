public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }

    public static void oppAmountValidate(List<Opportunity> opportunities){
        //loop through opp list, create condition if less than 5000 to give the error message
        for (Opportunity opp : opportunities) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
    }
}

public static void preventOppDeletion(List<Opportunity> opportunities) {
    //get account ids from the opportunity list, Ids must be unique so put in a set.
    Set<Id> accountIds = new Set<Id>();
    for(Opportunity opp : opportunities) {
        accountIds.add(opp.AccountId);
    }
    //get the accounts and industries and Ids with a Map only from the Acc ID set, I tried putting everything on the same line
    Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIds]);
    //loop through the list, filter only Opportunities Closed Won and Banking, if condition met give an error message.
    for(Opportunity opp : opportunities) {
        if(opp.StageName == 'Closed Won' && accountsMap.get(opp.AccountId).Industry == 'Banking') {
            opp.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }
}
 public static void updateOpp (List<Opportunity> opportunities){
    //loop through opp list and gather the Account Ids from the Opp and add to Set for unique Ids.
    Set<Id> accIds = new Set<Id>();
    for(Opportunity opp : opportunities) {
        accIds.add(opp.AccountId);
    }
    // create a map to store Ids and Contacts, need to find all contacts and Ids that have the same account as the opportunities in the list.
    Map<Id, Contact> accCeoContacts = new Map<Id, Contact>();
    //loop through a query and put the id, value in the map. Query will find the contact in the account of the opportunity and pull ONLY CEO
    for(Contact contact : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds AND Title = 'CEO']) {
        accCeoContacts.put(contact.AccountId, contact);
    }
    //loopp through opp list and if the id is found from the map, have the contact be the Primary contact of the opportunity.
    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    for (Opportunity opp : opportunities) {
        if (accCeoContacts.containsKey(opp.AccountId)) {
            opp.Primary_Contact__c = accCeoContacts.get(opp.AccountId).Id;
    
        }
    }
    
}
}