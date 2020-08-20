@isTest
public class AccountBatch_Test {
    @testSetup
    static void setup(){
        List<Account> acc = new List<Account>();
        //Create 100 Accounts
        for( Integer i=0; i< 100; i++){
            acc.add(new Account(Name = 'TestAccount' + i));
        }
        insert acc;     
    }
    
    @isTest
    static void create100Tasks_for100Accounts(){
        
        Test.startTest();
        SchedulableContext sc = null;
        AccountTaskScheduler accountScheduler = new AccountTaskScheduler();
        accountScheduler.execute(sc);
        Test.stopTest();
        Set<Id> accId = new Set<Id>();
        List<Account> accAfter = [Select Id from Account Where Name Like'TestAccount%'];
        for(Account acc: accAfter){
            accId.add(acc.Id);
        }
        List<Task> tasks = [Select Id from Task Where WhatId In :accId];
        System.assertEquals(100, tasks.size());
    }

}