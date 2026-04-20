Boolean isDryRun = true; // ⚠️ Set to false to perform the upd
ate
List<User> usersToUpdate = new List<User>();
Map<String, Id> roleNameToId = new Map<String, Id>();
for (UserRole ur : [SELECT Id, Name FROM UserRole WHERE Name!= null]) {
 roleNameToId.put(ur.Name, ur.Id);
}
for (User u : [
 SELECT Id, Name, UserRoleId, Profile.Name, Company_Code__
c, Zone__c, Region__c, Territory__c, MDO_HQ__c
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
 if (prof == 'National Sales Manager (NSM)' && String.isNo
tBlank(cc)) {
 expectedRoleName = 'NSM-' + cc;
 } else if (prof == 'Zonal Sales Manager (ZSM)' && String.
isNotBlank(cc) && String.isNotBlank(zone)) {
 expectedRoleName = 'ZSM-' + cc + '-' + zone;
 } else if (prof == 'Regional Sales Manager (RSM)' && Stri
ng.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotB
lank(region)) {
 expectedRoleName = 'RSM-' + cc + '-' + zone + '-' + r
egion;
 } else if (prof == 'Territory Manager (TM)' && String.isN
otBlank(cc) && String.isNotBlank(zone) && String.isNotBlank(r
egion) && String.isNotBlank(terr)) {
 expectedRoleName = 'TM-' + cc + '-' + zone + '-' + re
gion + '-' + terr;} else if (prof == 'Market Demand Officer (MDO)' && Strin
g.isNotBlank(cc) && String.isNotBlank(zone) && String.isNotBl
ank(region) && String.isNotBlank(mdoHq)) {
 expectedRoleName = 'MDO-' + cc + '-' + zone + '-' + r
egion + '-' + mdoHq;
 }
 // Skip users who don't match the criteria or are missing
geographic data
 if (expectedRoleName == null) continue;
 if (!roleNameToId.containsKey(expectedRoleName)) {
 System.debug('⚠️ Missing Role in System: ' + expectedR
oleName + ' for User: ' + u.Name);
 continue;
 }
 Id expectedRoleId = roleNameToId.get(expectedRoleName);
 if (u.UserRoleId == null || u.UserRoleId != expectedRoleI
d) {
 u.UserRoleId = expectedRoleId;
 usersToUpdate.add(u);
 }
}
System.debug('Total Users pending update: ' + usersToUpdate.s
ize());
if (!isDryRun && !usersToUpdate.isEmpty()) {
 update usersToUpdate;
 System.debug('✅ Phase 2 Complete: Users updated successfully.');
} else {
 System.debug('🚫 Dry run active - no updates performed.');
}

