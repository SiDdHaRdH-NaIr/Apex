Boolean commitChanges = false; // ⚠️ Set to true to execute update

List<User> users = [
    SELECT Id, UserRoleId, ManagerId 
    FROM User 
    WHERE IsActive = true AND UserRoleId != null
];

Set<Id> managerIds = new Set<Id>();

for (User u : users) {
    if (u.ManagerId != null) managerIds.add(u.ManagerId);
}

Map<Id, User> managerMap = new Map<Id, User>([
    SELECT Id, UserRoleId 
    FROM User 
    WHERE Id IN :managerIds
]);

Map<Id, UserRole> roleMap = new Map<Id, UserRole>([
    SELECT Id, ParentRoleId, Name 
    FROM UserRole
]);

// Helper Method: Detects Circular Dependencies
Boolean isDescendant(Id sourceRoleId, Id targetRoleId, Map<Id, UserRole> roles) {
    Id current = targetRoleId;
    while (current != null) {
        if (current == sourceRoleId) return true;
        current = roles.get(current)?.ParentRoleId;
    }
    return false;
}

Map<Id, UserRole> rolesToUpdateMap = new Map<Id, UserRole>();

for (User u : users) {

    if (u.ManagerId == null) continue;

    User manager = managerMap.get(u.ManagerId);

    if (manager == null || manager.UserRoleId == null) continue;

    Id userRoleId = u.UserRoleId;
    Id managerRoleId = manager.UserRoleId;

    if (userRoleId == managerRoleId) continue;

    UserRole currentRole = roleMap.get(userRoleId);

    if (currentRole == null || currentRole.ParentRoleId == managerRoleId) continue;

    // Prevent Circular Dependency
    if (isDescendant(userRoleId, managerRoleId, roleMap)) {
        System.debug('⚠️ Skipping circular dependency for role: ' + currentRole.Name);
        continue;
    }

    if (!rolesToUpdateMap.containsKey(userRoleId)) {
        currentRole.ParentRoleId = managerRoleId;
        rolesToUpdateMap.put(userRoleId, currentRole);
    }
}

System.debug('Total Roles pending hierarchy update: ' + rolesToUpdateMap.size());

if (commitChanges && !rolesToUpdateMap.isEmpty()) {
    update rolesToUpdateMap.values();
    System.debug('✅ Phase 3 Complete: Role Hierarchies synced.');
} else {
    System.debug('⚠️ Dry Run active - No hierarchy updates performed.');
}