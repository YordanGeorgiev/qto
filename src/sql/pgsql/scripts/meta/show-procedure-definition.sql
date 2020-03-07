-- call by: psql -d dev_qto -v PROCEDURE_NAME=func_get_all_users_roles < src/sql/pgsql/scripts/meta/show-procedure-definition.sql
SELECT      p.proname AS procedure_name,
--            p.pronargs AS num_args,
--            t1.typname AS return_type,
--            a.rolname AS procedure_owner,
--           l.lanname AS language_type,
--            p.proargtypes AS argument_types_oids,
            prosrc AS body
     FROM   pg_proc p
LEFT JOIN   pg_type t1 ON p.prorettype=t1.oid   
LEFT JOIN   pg_authid a ON p.proowner=a.oid 
LEFT JOIN   pg_language l ON p.prolang=l.oid
-- WHERE       proname = ':PROCEDURE_NAME' -- nope
--WHERE       proname like 'func%'
WHERE       proname = 'func_get_all_users_roles' --ok
;
