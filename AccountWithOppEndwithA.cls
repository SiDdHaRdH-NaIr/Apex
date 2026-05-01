public class AccountWithOppEndWithA{
    public static void accountOpp(){
        Set<Id> accId = new Set<Id>();
        List<Opportunity> oppList = [SELECT Id,Name,AccountId FROM Opportunity];
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accId.add(opp.AccountId);
            }
        }
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id,Name FROM Account WHERE Id IN :accId]);
        for (Opportunity opp : oppList) {
            Account acc = accMap.get(opp.AccountId);
            if(acc != null && acc.Name != null && acc.Name.endsWith('a')){
                System.debug(opp.name + '-->' + acc.name);
            }
        }

    }
}