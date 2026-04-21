Boolean isDryRun = true; // ⚠️ Set to false to perform the update

List<User> usersToUpdate = new List<User>();
Map<String, Id> roleNameToId = new Map<String, Id>();

for (UserRole ur : [SELECT Id, Name FROM UserRole WHERE Name != null]) {
    roleNameToId.put(ur.Name, ur.Id);
}

for (User u : [
    SELECT Id, Name, UserRoleId, Profile.Name, Company_Code__c, Zone__c, Region__c, Territory__c, MDO_HQ__c 
    FROM User 
    WHERE IsActive = true
]) {

    String expectedRoleName = null;
    String prof = u.Profile.Name;
    String cc = u.Company_Code__c;
    String zone = u.Zone__c;
    String region = u.Region__c;
    String terr = u.Territory__c;
    String mdoHq = u.MDO_HQ__c;

    if (prof == 'National Sales Manager (NSM)' && String.isNotBlank(cc)) {
        expectedRoleName = 'NSM-' + cc;

    } else if (prof == 'Zonal Sales Manager (ZSM)' && String.isNotBlank(cc) && String.isNotBlank(zone)) {
        expectedRoleName = 'ZSM-' + cc + '-' + zone;

    } else if (prof == 'Regional Sales Manager (RSM)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region)) {
        expectedRoleName = 'RSM-' + cc + '-' + zone + '-' + region;

    } else if (prof == 'Territory Manager (TM)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region) && String.isNotBlank(terr)) {
        expectedRoleName = 'TM-' + cc + '-' + zone + '-' + region + '-' + terr;

    } else if (prof == 'Market Demand Officer (MDO)' && String.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(region) && String.isNotBlank(mdoHq)) {
        expectedRoleName = 'MDO-' + cc + '-' + zone + '-' + region + '-' + mdoHq;
    }

    // Skip users who don't match the criteria or are missing geographic data
    if (expectedRoleName == null) continue;

    if (!roleNameToId.containsKey(expectedRoleName)) {
        System.debug('⚠️ Missing Role in System: ' + expectedRoleName + ' for User: ' + u.Name);
        continue;
    }

    Id expectedRoleId = roleNameToId.get(expectedRoleName);

    if (u.UserRoleId == null || u.UserRoleId != expectedRoleId) {
        u.UserRoleId = expectedRoleId;
        usersToUpdate.add(u);
    }
}

System.debug('Total Users pending update: ' + usersToUpdate.size());

if (!isDryRun && !usersToUpdate.isEmpty()) {
    update usersToUpdate;
    System.debug('✅ Phase 2 Complete: Users updated successfully.');
} else {
    System.debug('⚠️ Dry run active - no updates performed.');
}