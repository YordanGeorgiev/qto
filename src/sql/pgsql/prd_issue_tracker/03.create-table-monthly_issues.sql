-- DROP TABLE IF EXISTS monthly_issues ; 

SELECT 'create the "monthly_issues" table'
; 
   CREATE TABLE monthly_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             integer UNIQUE NOT NULL 
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NULL
    , status         varchar (50) NOT NULL
    , tags           varchar (200)
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , type           varchar (50) NOT NULL DEFAULT 'task'
    , owner          varchar (50) NULL
    , start_time     text NULL
    , stop_time      text NULL
    , planned_hours  decimal (6,2) NULL
    , actual_hours   decimal (6,2) NULL
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_monthly_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_id on monthly_issues (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.monthly_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
