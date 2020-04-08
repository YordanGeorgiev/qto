-- clear from data
TRUNCATE TABLE rep_userstories_doc;

-- copy selected columns from userstories_doc, only when status is set
INSERT INTO rep_userstories_doc (guid,id,status,prio,name,description,update_time)
SELECT guid,id,status,prio,name,description,update_time
FROM userstories_doc
WHERE 1=1 AND status!='status...';

-- make 03-wip standard instead of 03-act and 03-active
UPDATE rep_userstories_doc
SET status='03-wip'
WHERE status ILIKE '03-a%';