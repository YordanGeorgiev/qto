-- DROP TABLE IF EXISTS daily_issues ; 

SELECT 'create the "daily_issues" table'
; 
   CREATE TABLE daily_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (50) NOT NULL DEFAULT 'type the status ...'
    , category       varchar (200) NOT NULL DEFAULT 'type the category ...'
    , name           varchar (200) NOT NULL DEFAULT 'type the name ...'
    , description    varchar (4000)
    , type           varchar (50) NOT NULL DEFAULT 'task'
    , owner          varchar (50) NULL
    , start_time     timestamp NOT NULL DEFAULT NOW()
    , stop_time      timestamp NOT NULL DEFAULT NOW()
    , planned_hours  decimal (6,2) NULL
    , actual_hours   decimal (6,2) NULL
    , tags           varchar (200)
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_daily_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_daily_id on daily_issues (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.daily_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
