/**
 * @description       : 
 * @author            : Sergiu Laze
 * @group             : 
 * @last modified on  : 06-08-2020
 * @last modified by  : Sergiu Laze
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   06-08-2020   Sergiu Laze   Initial Version
**/
@isTest
public with sharing class TriggerHandler_Test {
  @TestSetup
  static void makeData(){
      //Create two Accounts( One and Two Orders)
      Account accWithOneOrder = new Account(Name ='OneOrder');
      Account accWithTwoOrders = new Account(Name ='TwoOrders');
      insert new Account[]{accWithTwoOrders,accWithOneOrder};

      //Create Contracts for Accounts
     Contract testContract1 = new Contract(AccountId = accWithOneOrder.Id,
                                          ContractTerm =3, 
                                          StartDate = date.today(),
                                          Status= 'Draft');
      
      Contract testContract2 = new Contract(AccountId = accWithTwoOrders.Id,
                                           ContractTerm = 3,
                                           StartDate= date.today(),
                                           Status= 'Draft');
     insert new Contract[]{testContract1, testContract2};
      //Change the status and update
       testContract1.Status = 'Activated';
       testContract2.Status = 'Activated';
      update testContract1;
      update testContract2;
      
      //Insert Orders
      Order orderAccOne = new Order( AccountId = accWithOneOrder.Id, 
                                   Status ='Draft',
                                   EffectiveDate = date.today());
      Order orderAccTwo1 = new Order(AccountId = accWithTwoOrders.Id,
                                    Status= 'Draft',
                                     EffectiveDate = date.today());
      Order orderAccTwo2 = new Order(AccountId = accWithTwoOrders.Id,
                                    Status = 'Draft',
                                    EffectiveDate = date.today());
      
      insert new Order[]{orderAccOne, orderAccTwo1, orderAccTwo2};
      
      
  }
    
    @isTest
    static void deleteOneOrder_fromAccountWithOneOrder(){
        Account acc =[Select Id, Active__c From Account Where Name= 'OneOrder'];
        Test.startTest();
        Order order = [Select Id from Order Where AccountId =: acc.Id];
        delete(order);
        Account accAfter = [Select Id, Active__c From Account Where Name= 'OneOrder'];
        Test.stopTest();
        System.assertEquals(False, accAfter.Active__c );
    }
    
   @isTest
    static void deleteOneOrder_fromAccounWithTwoOrders(){
        Account accBefore = [Select Id, Active__c from Account Where Name ='TwoOrders'];
        Test.startTest();
        List <Order> order = [Select Id from Order Where AccountId =: accBefore.Id];
        delete(order.get(0));
        Account accAfter = [Select Id, Active__c from Account Where Name = 'TwoOrders'];
        Test.stopTest();
        System.assertEquals(true, accAfter.Active__c);
        
    }
    
}