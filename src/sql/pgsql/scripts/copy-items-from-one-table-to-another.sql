INSERT INTO daily_issues SELECT * FROM monthly_issues  WHERE status = '02-todo-copy-to-daily' 
 ;
UPDATE daily_issues set status = '02-todo' where status = '02-todo-copy-to-daily' 
 ;

INSERT INTO monthly_issues SELECT * FROM daily_issues  WHERE 1=1
ON CONFLICT (id) DO UPDATE
SET guid = excluded.guid ,id = excluded.id ,level = excluded.level ,seq = excluded.seq ,prio = excluded.prio ,weight = excluded.weight ,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner ,start_time = excluded.start_time ,stop_time = excluded.stop_time ,planned_hours = excluded.planned_hours ,actual_hours = excluded.actual_hours ,tags = excluded.tags ,update_time = excluded.update_time
;
--#Secondly, we want to say what happens when we update. In our case, we want the first name and last name to be overwritten:
INSERT INTO weekly_issues SELECT * FROM daily_issues  WHERE 1=1
ON CONFLICT (id) DO UPDATE
SET guid = excluded.guid ,id = excluded.id ,level = excluded.level ,seq = excluded.seq ,prio = excluded.prio ,weight = excluded.weight ,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner ,start_time = excluded.start_time ,stop_time = excluded.stop_time ,planned_hours = excluded.planned_hours ,actual_hours = excluded.actual_hours ,tags = excluded.tags ,update_time = excluded.update_time
;


first_name = excluded.first_name, last_name = excluded.last_name

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name   = 'monthly_issues'  ;
