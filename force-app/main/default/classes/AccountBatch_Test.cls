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
    
    //Add 50 tasks for 50 accounts, from a total of 100 accounts
    @isTest
    static void create50task_for50Accounts_outof100(){
        List<Account> accts =[Select id from Account Where Name Like 'TestAccount%'];
        Set<Id> accId = new Set<id>();
        for(Account currentAccount: accts){
            accId.add(currentAccount.Id);
        }
        System.debug(accts.size());
        List<Task> tasksBefore = new List<Task>();
        for( integer i=0; i<50; i++){
            Task createTask = new Task( Whatid=accts[i].id,
                                       Subject = 'Call',
                                       Priority='Normal',
                                       IsReminderSet = true,
									ReminderDateTime = DateTime.valueOfGMT(String.valueOf(DateTime.now())) + 5
                                       );
            tasksBefore.add(createTask);  
        } insert (tasksbefore);
       	List<Task> taskTest= [SELECT Id FROM Task WHERE WhatId IN :accId];
		//System.assertEquals(50, taskTest.size());
        Test.startTest();
		SchedulableContext sc = null;
        AccountTaskScheduler accountScheduler = new AccountTaskScheduler();
        accountScheduler.execute(sc); 
        Test.stopTest();
        List<Task> totalTasks= [Select id from Task where whatId In :accId ];
       System.assertEquals(100, totalTasks.size());
        
    }

}