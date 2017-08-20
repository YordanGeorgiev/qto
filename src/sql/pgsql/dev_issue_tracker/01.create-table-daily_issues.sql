-- DROP TABLE IF EXISTS daily_issues ; 

SELECT 'create the "daily_issues" table'
; 
   CREATE TABLE daily_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NULL
    , status         varchar (50) NOT NULL
    , tags           varchar (200)
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , start_time     text NULL
    , stop_time      text NULL
    , planned_hours  decimal (6,2) NULL
    , actual_hours   decimal (6,2) NULL
    , type           varchar (50) NOT NULL
    , owner          varchar (50) NULL
    , update_time    timestamp DEFAULT NOW() 
    , CONSTRAINT pk_daily_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.daily_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
