trigger AccountTrigger on Account (before insert, after insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        //Update Account Type
            AccountTriggerHandler.updateAccountType(Trigger.new);
            AccountTriggerHandler.copyAccountShippingAddress(Trigger.new);
            AccountTriggerHandler.setAccountRating(Trigger.new);
}
if(Trigger.isAfter && Trigger.isInsert){
    AccountTriggerHandler.createNewContact(Trigger.new);
}
}