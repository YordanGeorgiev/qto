-- DROP TABLE IF EXISTS test_runs ; 

SELECT 'create the "test_runs" table'
; 
   CREATE TABLE test_runs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             integer UNIQUE NOT NULL 
    , seq            integer NULL
    , prio           integer NULL
    , files_num      integer NULL
    , status         varchar (50) NOT NULL
    , test_num       varchar (20) NOT NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , expected_result varchar (4000)
    , actual_result  varchar (4000)
    , log_output     varchar (4000)
    , tester         varchar (50) NULL
    , start_time     text NULL
    , stop_time      text NULL
    , duration_sec   decimal (6,2) NULL
    , duration_min   decimal (6,2) NULL
    , update_time    timestamp DEFAULT NOW() 
    , CONSTRAINT pk_test_runs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_runs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
