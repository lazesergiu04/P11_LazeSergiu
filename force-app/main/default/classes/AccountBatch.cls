/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-05-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   08-05-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global with sharing class AccountBatch implements Database.Batchable<SObject> {



	global AccountBatch() {
	}

	global Database.QueryLocator start(Database.BatchableContext info) {
		// Query only accounts with no orders (semi join inner selects not allowed with tasks, filter is applied in execute method)
		String query = 'SELECT Id FROM Account WHERE Id NOT IN (SELECT AccountId FROM Order)';
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext info, List<Account> scope) {
		List<Task> Tasks = [SELECT Id, WhatId FROM Task WHERE Subject = 'Call'];
		List<Task> tasksToCreate = new List<Task>();
        Set<Id> taskIdRelatedToAccounts = new Set<Id>();
        
		// Take the tasks id and store it in a new set Id 
		for (Task reminderTask : Tasks) {
			taskIdRelatedToAccounts.add(reminderTask.WhatId);
		}
		// Create the tasks for accounts
		for (Account accountToCheck : scope) {
			if (!taskIdRelatedToAccounts.contains(accountToCheck.Id)) {
				Task reminderTaskToCreate = new Task(	WhatId = accountToCheck.Id, 
														Subject = 'Call', 
														Status = 'Not Started', 
														Priority = 'Normal', 
														IsReminderSet = true,
														ReminderDateTime = DateTime.valueOfGMT(String.valueOf(DateTime.now())) + 5
													);
				tasksToCreate.add(reminderTaskToCreate);
			}
		}
		if (!tasksToCreate.isEmpty()) {
			insert(tasksToCreate);
		}
	}
	
	global void finish(Database.BatchableContext info) {
	}
}


