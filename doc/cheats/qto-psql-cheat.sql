-- move data from the release_issues table to the monthly_issues
INSERT INTO monthly_issues (guid, id, type, category, status, prio, name, description, owner, update_time) SELECT guid, id, type, category, status, prio, name, description, owner, update_time FROM release_issues  WHERE 1=1 and status = '09-done' ON CONFLICT (id) DO UPDATE SET guid = excluded.guid ,id = excluded.id, prio = excluded.prio,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner , update_time = excluded.update_time


-- move data from the release_issues table to the monthly_issues
INSERT INTO monthly_issues (guid, id, type, category, status, prio, name, description, owner, update_time) SELECT guid, id, type, category, status, prio, name, description, owner, update_time FROM release_issues  WHERE 1=1 and type = 'task' ON CONFLICT (id) DO UPDATE SET guid = excluded.guid ,id = excluded.id, prio = excluded.prio,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner , update_time = excluded.update_time

psql -d dev_qto -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO usrdevqtoapp; GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO usrdevqtoapp;"
