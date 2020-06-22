-- DROP TABLE IF EXISTS his_quinquennially_issues ; 

SELECT 'create the "his_quinquennially_issues" table'
; 
   CREATE TABLE his_quinquennially_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISSMS') as bigint) 
    , hguid          UUID NOT NULL DEFAULT gen_random_uuid()
    , hid            bigint NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , action_type    varchar (30) NOT NULL DEFAULT 'UPDATE'
    , category       varchar (30) NOT NULL DEFAULT 'category...'
    , type           varchar (30) NOT NULL DEFAULT 'task...'
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , prio           integer NOT NULL DEFAULT 1
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (1000)
    , start_time     text NOT NULL DEFAULT to_char(date_trunc('minute', now()::time),'HH24:MI')
    , stop_time      text NOT NULL DEFAULT to_char(date_trunc('minute', now()::time),'HH24:MI')
    , owner          varchar (100) NOT NULL DEFAULT 'none'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_his_quinquennially_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_his_quinquennially_issues_id on his_quinquennially_issues (id);



SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.his_quinquennially_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


