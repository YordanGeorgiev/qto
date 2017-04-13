-- DROP TABLE IF EXISTS issue ; 


SELECT 'create the "issue" table' ; 
CREATE TABLE issue (
   issue_id    integer NOT NULL
 , prio        integer NULL
 , name        varchar(100) NOT NULL
 , description varchar(1000) NULL
 , status      varchar(50) NOT NULL
 , category    varchar(200) NOT NULL
 , actual      integer NULL
 , daily_date  varchar(50) NOT NULL

 );


SELECT 'and verify that the table issue exits' ; 
select 'table issue' ; 
SELECT EXISTS (
   SELECT 1 
   FROM   pg_tables
   WHERE  schemaname = 'public'
   AND    tablename = 'issue'
 );
