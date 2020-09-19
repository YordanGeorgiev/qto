-- move data from the release_issues table to the monthly_issues
INSERT INTO monthly_issues (guid, id, type, category, status, prio, name, description, owner, update_time) SELECT guid, id, type, category, status, prio, name, description, owner, update_time FROM release_issues  WHERE 1=1 and status = '09-done' ON CONFLICT (id) DO UPDATE SET guid = excluded.guid ,id = excluded.id, prio = excluded.prio,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner , update_time = excluded.update_time


-- move data from the release_issues table to the monthly_issues
INSERT INTO monthly_issues (guid, id, type, category, status, prio, name, description, owner, update_time) SELECT guid, id, type, category, status, prio, name, description, owner, update_time FROM release_issues  WHERE 1=1 and type = 'task' ON CONFLICT (id) DO UPDATE SET guid = excluded.guid ,id = excluded.id, prio = excluded.prio,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner , update_time = excluded.update_time

psql -d dev_qto -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO usrdevqtoapp; GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO usrdevqtoapp;"

IFS='' read -r -d '' sql_code << EOF_SQL_CODE
		SELECT users.id, email, password, roles.name as roles
		FROM users
		LEFT JOIN user_roles ON (users.guid = user_roles.users_guid)
		LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
		WHERE 1=1
		AND status > 0
		AND email='AdminEmail';
EOF_SQL_CODE
psql -d "$postgres_app_db" -c "$sql_code"

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA schema_name TO usr;

# copy paste me into bash shell directly
clear; IFS='' read -r -d '' sql_code << 'EOF_SQL_CODE'
CREATE OR REPLACE FUNCTION func_get_all_users_roles()
-- define the return type of the result set as table
-- those datatypes must match the ones in the src
RETURNS TABLE (
     id           bigint
   , email        varchar(200)
   , password     varchar(200)
   , roles        varchar(100)) AS
$func$
BEGIN
RETURN QUERY 
-- start the select clause
SELECT users.id, users.email, users.password, roles.name as roles
FROM user_roles
LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
LEFT JOIN users ON (users.guid = user_roles.users_guid)
-- stop the select clause
;
END
$func$  LANGUAGE plpgsql;
EOF_SQL_CODE
# create the function
psql -d db_name -c "$sql_code"; 

# call the function 
psql -d db_name -c "select * from func_get_all_users_roles() "



-- Start a transaction
   BEGIN;SELECT func_get_users_roles(refcursor); FETCH ALL IN "refcursor";COMMIT;


# how-to export 
while read -r t ; do psql -d prd_veldan -t  -c \
"SELECT 
table_name,column_name from information_schema.columns 
where 1=1 
and table_catalog='prd_veldan' and table_name='"$t"' order by 1;" ; \
done < <(psql -d prd_veldan -t -c "SELECT \
table_name FROM information_schema.tables \
WHERE 1=1 and table_schema='public' ORDER BY 1" ) \
| perl -ne 's/\s+\|\s+/;/g; print $_ if /[a-z]/g '>/vagrant/list.csv

-- Grant CONNECT to the database:
GRANT CONNECT ON DATABASE database_name TO usr;

-- Grant USAGE on schema:
GRANT USAGE ON SCHEMA schema_name TO usr;

-- Grant on all tables for DML statements: SELECT, INSERT, UPDATE, DELETE:
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA schema_name TO usr;

-- Grant all privileges on all tables in the schema:
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA schema_name TO usr;

-- Grant all privileges on all sequences in the schema:
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA schema_name TO usr;

-- Grant all privileges on the database:
GRANT ALL PRIVILEGES ON DATABASE database_name TO usr;

-- Grant permission to create database:
ALTER USER usr CREATEDB;

-- Make a user superuser:
ALTER USER myuser WITH SUPERUSER;

-- Remove superuser status:
ALTER USER usr WITH NOSUPERUSER;

-- Those statements above only affect the current existing tables. To apply to newly created tables, you need to use alter default. For example:

ALTER DEFAULT PRIVILEGES
FOR USER usr
IN SCHEMA schema_name
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usr;

