/**
 * @description       : 
 * @author            : Sergiu Laze
 * @group             : 
 * @last modified on  : 05-08-2020
 * @last modified by  : Sergiu Laze
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-29-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountTriggerHandler {

    public static void deactivateAccounts (List<Order> orders)  {
        List<Account> accountsToDeactivate = new List<Account>();
        Set<Id> accountsIdWithDeteledOrders = new Set<Id>();
        Set<Id> accountWithRemainingOrders = new Set<Id>();
       

        //Add the AccountId of the order in a set
        for( Order currentOrder : orders){
            if( String.isNotBlank(currentOrder.AccountId)){
                accountsIdWithDeteledOrders.add(currentOrder.AccountId);
            System.debug(accountsIdWithDeteledOrders + 'accountsID with deleted orders');
            }
        }
        //Retrive the Accounts with orders 
        List<Account> accountsWithOrders = [Select Id From Account Where Id in :accountsIdWithDeteledOrders];
        //Retrive Orders with Account Id
        List<Order> ordersWithAccountId = [Select AccountId, Id From Order Where AccountId in :accountsIdWithDeteledOrders];
        
        //Add the order Account id in a set to check the accounts with orders after deletion
        for (Order ord : ordersWithAccountId) {
            accountWithRemainingOrders.add(ord.AccountId);
            
        }
        //if the account id is not in the set with accounts that have orders, change the status of Active field
        for(Account acc : accountsWithOrders){
            if(!accountWithRemainingOrders.contains(acc.Id)){
                acc.Active__c = false;
                accountsToDeactivate.add(acc);

            }

        }update(accountsToDeactivate);



    }
}