INSERT INTO daily_issues SELECT * FROM monthly_issues  WHERE status = '02-todo-copy-to-daily' 
 ;
UPDATE daily_issues set status = '02-todo' where status = '02-todo-copy-to-daily' 
 ;

