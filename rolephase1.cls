String csv = 'Name,DeveloperName\n';

// Step 1: Get all existing role names
Set<String> existingRoleNames = new Set<String>();

for (UserRole ur : [
    SELECT Name FROM UserRole WHERE Name != null
]) {
    existingRoleNames.add(ur.Name);
}

// Step 2: Process active users
Set<String> newRoles = new Set<String>();

for (User u : [
    SELECT Id, UserRoleId, User_Key__c 
    FROM User 
    WHERE IsActive = true AND User_Key__c != null
]) {
    String baseName = u.User_Key__c;

    // Must start with number
    if (!Pattern.matches('^[0-9].*', baseName)) {
        continue;
    }

    // Count dashes
    Integer dashCount = baseName.length() - baseName.replace('-', '').length();

    String prefix;

    if (dashCount == 0) prefix = 'NSM';
    else if (dashCount == 1) prefix = 'ZSM';
    else if (dashCount == 2) prefix = 'RSM';
    else if (dashCount == 3) prefix = 'TM';
    else if (dashCount == 4) prefix = 'MDO';
    else continue;

    String roleName = prefix + '-' + baseName;

    // If role doesn't exist → mark for creation
    if (!existingRoleNames.contains(roleName)) {
        newRoles.add(roleName);
    }
}

// Step 3: Build CSV
for (String roleName : newRoles) {
    // DeveloperName must be unique & no spaces
    String devName = roleName.replaceAll('[^a-zA-Z0-9]', '_');

    csv += '"' + roleName + '","' + devName + '"\n';
}

// Step 4: Email CSV
Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
attachment.setFileName('New_UserRoles_To_Insert.csv');
attachment.setBody(Blob.valueOf(csv));
attachment.setContentType('text/csv');

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] { 'siddhardh.nair@appstrail.com' });
mail.setSubject('New Roles to Create');
mail.setPlainTextBody('Attached CSV contains new roles to be inserted.');
mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

System.debug('New Roles CSV sent.');