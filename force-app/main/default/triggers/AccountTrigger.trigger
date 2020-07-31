/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-31-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-31-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger AccountTrigger on Order (after delete) {
    List<Order> ordersDeleted = Trigger.old;
    AccountTriggerHandler.deactivateAccounts(ordersDeleted);

}