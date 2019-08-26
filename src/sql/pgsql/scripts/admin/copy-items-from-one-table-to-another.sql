-- how-to move issues from one time frame to another 
INSERT INTO monthly_issues (guid,id,prio,status,category,name,description,type,owner,update_time )
SELECT guid,id,prio,status,category,name,description,type,owner,update_time 
FROM release_issues  
WHERE 1=1 AND status='09-done'
ON CONFLICT (id) DO UPDATE
SET guid = excluded.guid ,id = excluded.id ,prio = excluded.prio ,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner ,update_time = excluded.update_time
;

-- and then delete them from the source table 
DELETE FROM release_issues 
WHERE 1=1
AND status='09-done'
; 


SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name   = 'monthly_issues'
;
INSERT INTO daily_issues SELECT * FROM monthly_issues  WHERE status = '02-todo-copy-to-daily' 
;
UPDATE daily_issues set status = '02-todo' where status = '02-todo-copy-to-daily' 
;
