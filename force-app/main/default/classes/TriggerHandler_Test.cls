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
     
      
  }
}
