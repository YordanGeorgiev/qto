-- DROP TABLE IF EXISTS tech ; 


select 'create the "tech" table' ; 
CREATE TABLE tech (
   tech_id     integer NOT NULL
 , name        varchar(200) NOT NULL
);

select 'and verify that the table "tech" exists' ; 
select 'table tech' ; 
SELECT EXISTS (
   SELECT 1 
   FROM   pg_tables
   WHERE  schemaname = 'public'
   AND    tablename = 'tech'
 );
