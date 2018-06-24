-- DROP TABLE IF EXISTS yearly_issues ; 

SELECT 'create the "yearly_issues" table'
; 
   CREATE TABLE yearly_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             integer UNIQUE NOT NULL 
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NOT NULL
    , weight         integer NOT NULL
    , status         varchar (50) NOT NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , type           varchar (50) NOT NULL DEFAULT 'task'
    , owner          varchar (50) NULL
    , start_time     text NULL
    , stop_time      text NULL
    , planned_hours  decimal (6,2) NULL
    , actual_hours   decimal (6,2) NULL
    , tags           varchar (200)
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_yearly_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   SELECT 'show the columns of the just created table'
   ; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.yearly_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
