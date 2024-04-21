public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {
        
    }

    public static void updateAccountType(List<Account> accountList){
        //lopp through accounts, and update the account type to prosecting if blank.
            for(Account account : accountList){
                if(String.isBlank(account.Type)){
                    account.Type = 'Prospect';
                }
            
            }
    }
    public static void copyAccountShippingAddress(List<Account> accounts){
//loop through accounts, checking if the Shipping address is null. If it is not null, then copy the address to the shipping address
        for(Account acc : accounts){
            if(acc.ShippingStreet == null || acc.ShippingCity == null || acc.ShippingState == null || acc.ShippingPostalCode == null){
                continue;
            }
            else{
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
    }
   public static void setAccountRating(List<Account> accounts){
    for(Account account : accounts){
        if(account.Phone != null && account.Website != null && account.Fax != null){
            account.Rating = 'Hot';
        }
    }
   }
   public static void createNewContact(List<Account> accounts){
    // query accounts created
    List<Contact> contactList = new List<Contact>();
    Account[] accquery = [SELECT Id FROM Account WHERE Id =:accounts WITH SECURITY_ENFORCED];
    //loop through accounts created, create a new contact and assign it to the created account
    for(Account account : accquery){
        Contact contact = new Contact();
        contact.LastName = 'DefaultContact';
        contact.Email = 'default@email.com';
        contact.AccountId = account.Id;
        contactList.add(contact);
 
   }
insert contactList;
}
}   
