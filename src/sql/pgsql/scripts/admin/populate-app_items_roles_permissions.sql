TRUNCATE TABLE app_items_roles_permissions ;
INSERT INTO app_items_roles_permissions ( app_roles_guid,app_items_guid,app_routes_guid,name,description) 
   SELECT app_roles.guid , t2.guid, t3.guid
		, app_roles.name || '__' || t3.name || '__ON__' || t2.name as name
		, 'WHETHER OR NOT THE ' || app_roles.name || ' CAN ' || t3.name || ' THE ' || t2.name as name
   from app_roles
   cross join (
      SELECT app_items.guid , app_items.name 
         FROM app_items
         WHERE 1=1 
         and app_items.name not like 'test_%'
         and app_items.name not like '%_2018%'
         and app_items.name not like '%_2018'
         and app_items.name not like '%_2019%'
         and app_items.name not like '%_2019'
         and app_items.name not like '%_2020%'
         and app_items.name not like '%_2020'
         ) t2
   cross join (
      SELECT app_routes.guid , app_routes.name FROM app_routes) t3
;

-- the query and search routes apply to all the items - should use the all fake item
DELETE FROM app_items_roles_permissions WHERE 1=1 
   AND app_items_guid NOT IN 
   ( SELECT guid from app_items WHERE name = 'all')
   AND app_routes_guid IN 
   ( SELECT guid from app_routes WHERE name IN ('query' , 'search'))
; 
/*
DELETE 0
UPDATE 528
UPDATE 1166
DELETE 0
*/

-- the list-my and select-my make sense only for tables having app_users_guid attribute
DELETE FROM app_items_roles_permissions WHERE 1=1 
   AND app_routes_guid IN 
   ( SELECT guid from app_routes WHERE name IN ('list-my','select-my'))
   AND app_items_guid NOT IN 
   ( SELECT guid from app_items WHERE name IN ('monthly_issues_202005' , 'yearly_issues_2020'))
; 

-- deny anything related to app_roles and users to all but the product instance owner
UPDATE app_items_roles_permissions set allowed=false
WHERE 1=1
AND ( name not like '%userstories%')
AND ( name like '%app_roles%' or name like '%users%' or name like '%app_items_roles_permissions%' 
      or name like '%app_items%' or name like '%app_routes%' 
    )
;

-- the PRODUCT_INSTANCE_OWNER MUST see EVERYTHING
UPDATE app_items_roles_permissions set allowed=true
WHERE 1=1
   AND app_roles_guid IN 
   ( SELECT guid from app_roles WHERE name = 'PRODUCT_INSTANCE_OWNER')
;

-- any combination of view with item not ending with _doc is pointless 
DELETE FROM app_items_roles_permissions 
WHERE 1=1
AND ( name like '%::view%' and name not like '%_doc')
; 

-- and display the "forbidden ones"
SELECT app_roles.name , app_items_roles_permissions.allowed , app_routes.name , app_items.name 
FROM app_items_roles_permissions
LEFT JOIN app_roles ON app_roles.guid = app_roles_guid
LEFT JOIN app_routes ON app_routes.guid = app_routes_guid
LEFT JOIN app_items ON app_items.guid = app_items_guid
WHERE app_items_roles_permissions.allowed = 'false'
;


UPDATE app_items_roles_permissions set allowed=true
WHERE 1=1
   AND app_routes_guid IN 
   ( SELECT guid from app_routes WHERE app_routes.is_open = true)
;
