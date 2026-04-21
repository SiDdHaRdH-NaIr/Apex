//Querring all the Account Records with Industry IT
public class AccountIndustryIt{
    public static void accountIndustryIt(){
        List<Account> accId = [SELECT Id,Name from Account WHERE Industry = 'IT' AND Name != NULL];
        for(Account acc : accId){
            System.debug('Account with Industry IT : ' + acc.Id + '-' + acc.Name);
        }
    }
}