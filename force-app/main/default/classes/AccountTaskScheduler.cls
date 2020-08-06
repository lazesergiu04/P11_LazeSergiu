/**
 * @description       : 
 * @author            : Sergiu Laze
 * @group             : 
 * @last modified on  : 06-08-2020
 * @last modified by  : Sergiu Laze
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   08-05-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global with sharing class AccountTaskScheduler  implements Schedulable{
    
   global void execute(SchedulableContext sc){
       AccountBatch ab = new AccountBatch();
       Database.executeBatch(ab);
   }
}
