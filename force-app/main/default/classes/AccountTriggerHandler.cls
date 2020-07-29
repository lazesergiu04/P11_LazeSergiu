/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-29-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-29-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountTriggerHandler {

    public void deactivateAccounts (List<Order> orders)  {
        Set<Id> accountsIdToDeactivate = new Set<Id>();
        Set<Id> accountWithRemainingOrders = new Set<Id>();

        //Add the AccountId of the order in a set
        for( Order currentOrder : orders){
            if( String.isNotBlank(currentOrder.AccountId)){
                accountsIdToDeactivate.add(currentOrder.AccountId);
            System.debug('Test');
            }
        }
        //Retrive the Accounts with orders
        List<Account> accountsWithOrders = [Select Id From Account Where Id in :accountsIdToDeactivate];
        List<Order> ordersWithAccountId = [Select AccountId, Id From Order Where AccountId in :accountsIdToDeactivate];
        for(Order ord : ordersWithAccountId){

        }

        for(Account acc : accountsWithOrders){

        }



    }
}
