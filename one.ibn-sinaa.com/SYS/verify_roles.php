<?php

require("db.php");
function hasRole($db, $userId, $roleName) {
    $stmt = $db->prepare("SELECT COUNT(*) FROM user_roles ur JOIN roles r ON ur.role_id = r.id WHERE ur.user_id = ? AND r.name = ?");
    $stmt->execute([$userId, $roleName]);
    return $stmt->fetchColumn() > 0;
}

function hasPermission($db, $userId, $permissionName) {
    $stmt = $db->prepare("
        SELECT COUNT(*) 
        FROM user_roles ur 
        JOIN role_permissions rp ON ur.role_id = rp.role_id 
        JOIN permissions p ON rp.permission_id = p.id 
        WHERE ur.user_id = ? AND p.name = ?");
    
    $stmt->execute([$userId, $permissionName]);
    return $stmt->fetchColumn() > 0;
}
