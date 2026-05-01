public class AccountOpp{
    public static void accOpp(){
          List<Opportunity> oppList = [
            SELECT Id, Name, Account.Name
            FROM Opportunity
            WHERE Account.Name LIKE 'A%' AND Name LIKE '%Test%'
        ];
        for (Opportunity opp : oppList) {
            System.debug(opp.Account.Name + '-->' + opp.Name);
        }
    }
    public static void oppAcc(){
        List<Opportunity> oppList = [SELECT Id,Name,Account.Name FROM Opportunity WHERE Name LIKE '%Deal' AND Account.Name LIKE '%Tech%'];
        for (Opportunity opp : oppList) {
            if (opp.Account != null) {
                System.debug(opp.Name + '-->' + opp.Account.Name);
            }
        }
    }
    public static void accountOpp(){
        List<Opportunity> oppList = [
            SELECT Id,Name,Account.Name 
            FROM Opportunity 
            WHERE Account.Name LIKE 'S%' AND Name LIKE '%2024'
        ];
        for(Opportunity opp : oppList){
            System.debug(opp.Name + ' --> ' + opp.Account.Name);
        }
    }
    public static void oppAccount(){
        List<Opportunity> oppList = [
            SELECT Id,Name,Account.Name
            FROM Opportunity
            WHERE Name LIKE '%Test%'
        ];
        for (Opportunity opp : oppList) {
            if (opp.Account != null) {
                System.debug(opp.Name + ' ---> ' + opp.Account.Name);
            }
            else {
            System.debug(opp.Name + ' --> No Account');
            }
        }
    }
    public static void accountOppList(){
    List<Opportunity> oppList = [
        SELECT Id, Name, Account.Name
        FROM Opportunity
        WHERE Account.Name LIKE 'A%' 
        AND NOT Name LIKE '%Test%'
    ];

    for (Opportunity opp : oppList) {
        System.debug(opp.Account.Name + ' --> ' + opp.Name);
    }
 }
    public static void oppAccountList(){
        List<Opportunity> oppList = [
            SELECT Id,Name,Account.Name
            FROM Opportunity
            WHERE Account.Name LIKE '%Crop%'
        ];
    }
}