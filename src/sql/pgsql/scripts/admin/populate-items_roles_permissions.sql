TRUNCATE TABLE items_roles_permissions ;
INSERT INTO items_roles_permissions ( roles_guid,meta_tables_guid,meta_routes_guid,name) 
   SELECT roles.guid , t2.guid, t3.guid , roles.name || '::' || t3.name || '->'|| t2.name
   from roles
   cross join (
      SELECT meta_tables.guid , meta_tables.name 
         FROM meta_tables
         WHERE 1=1 and meta_tables.name not like 'test_%'
         ) t2
   cross join (
      SELECT meta_routes.guid , meta_routes.name FROM meta_routes) t3
;

-- deny anything related to roles and users to all but the product instance owner
UPDATE items_roles_permissions set allowed=false
WHERE 1=1
AND (name not like '%userstories%')
AND (name like '%roles%' or name like '%users%')
AND (name not like '%PI_OWNER%')
;

-- any combination of view with item not ending with _doc is pointless 
DELETE FROM items_roles_permissions 
WHERE 1=1
AND ( name like '%::view%' and name not like '%_doc')
; 

-- and display the "forbidden ones"
SELECT roles.name , meta_routes.name , meta_tables.name , items_roles_permissions.allowed
FROM items_roles_permissions
LEFT JOIN roles ON roles.guid = roles_guid
LEFT JOIN meta_routes ON meta_routes.guid = meta_routes_guid
LEFT JOIN meta_tables ON meta_tables.guid = meta_tables_guid
WHERE items_roles_permissions.allowed = 'false'
;
