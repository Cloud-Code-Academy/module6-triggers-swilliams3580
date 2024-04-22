trigger OpportunityTrigger on Opportunity (before update, after delete) {
    //Opp Triggers
if(Trigger.isBefore && Trigger.isUpdate){
    OpportunityTriggerHandler.oppAmountValidate(Trigger.new);
    OpportunityTriggerHandler.updateOpp(Trigger.new);
}
if(Trigger.isAfter && Trigger.isDelete){
    OpportunityTriggerHandler.preventOppDeletion(Trigger.old);

}
 

}