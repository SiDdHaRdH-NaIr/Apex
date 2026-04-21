String sendToEmail = 'siddhardh.nair@appstrail.com'; 
List<String> csvLines = new List<String>{'Name,DeveloperName'};
// 1. Get existing roles
Set<String> existingRoleNames = new Set<String>();
for (UserRole ur : [SELECT Name FROM UserRole WHERE Name != null]) {
    existingRoleNames.add(ur.Name);
}
// 2. Process active users
Set<String> newRoles = new Set<String>();
for (User u : [
    SELECT Id, Profile.Name, Company_Code__c, Zone__c, Region__c, Territory__c, MDO_HQ__c 
    FROM User 
    WHERE IsActive = true
]) {

    String roleName = null;
    String prof = u.Profile.Name;
    String cc = u.Company_Code__c;
    String zone = u.Zone__c;
    String region = u.Region__c;
    String terr = u.Territory__c;
    String mdoHq = u.MDO_HQ__c;

    // Construct role name based on Profile and ensure required fields are populated
    if (prof == 'National Sales Manager (NSM)' && String.isNotBlank(cc)) {
        roleName = 'NSM-' + cc;

    } else if (prof == 'Zonal Sales Manager (ZSM)' && String.isNotBlank(cc) && String.isNotBlank(zone)) {
        roleName = 'ZSM-' + cc + '-' + zone;

    } else if (prof == 'Regional Sales Manager (RSM)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region)) {
        roleName = 'RSM-' + cc + '-' + zone + '-' + region;

    } else if (prof == 'Territory Manager (TM)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region) && String.isNotBlank(terr)) {
        roleName = 'TM-' + cc + '-' + zone + '-' + region + '-' + terr;

    } else if (prof == 'Market Demand Officer (MDO)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region) && String.isNotBlank(mdoHq)) {
        roleName = 'MDO-' + cc + '-' + zone + '-' + region + '-' + mdoHq;
    }

    // If role logic matched and role doesn't exist, queue for creation
    if (roleName != null && !existingRoleNames.contains(roleName)) {
        newRoles.add(roleName);
    }
}
// 3. Build and send CSV
for (String roleName : newRoles) {
    String devName = roleName
    .replaceAll('[^a-zA-Z0-9]', '_')   // replace special chars
    .replaceAll('_+', '_')             // collapse multiple underscores
    .replaceAll('^_|_$', '');          // remove leading/trailing underscores
    csvLines.add('"' + roleName + '","' + devName + '"');
}
Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
attachment.setFileName('New_UserRoles_To_Insert.csv');
attachment.setBody(Blob.valueOf(String.join(csvLines, '\n')));
attachment.setContentType('text/csv');
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] { sendToEmail });
mail.setSubject('Action Required: New Roles to Create');
mail.setPlainTextBody('Attached CSV contains new roles to be inserted via Data Loader.');
mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
System.debug('Phase 1 Complete: Roles CSV dispatched.');