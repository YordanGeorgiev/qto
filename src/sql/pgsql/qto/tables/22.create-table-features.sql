               -- DROP TABLE IF EXISTS features CASCADE;

SELECT 'create the "features" table'
; 
   CREATE TABLE features (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (20) NULL 
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    text NULL
    , src            text NULL
    , runtime        varchar (20) NULL 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_features_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_features_id on features (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.features'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger for the update_time update: 
   CREATE TRIGGER trg_features_set_update_time 
   BEFORE UPDATE ON features 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

-- START trg_features_set_all_seq
CREATE OR REPLACE FUNCTION fnc_features_set_all_seq()
    RETURNS TRIGGER
    AS $$
       BEGIN 
         -- src: https://stackoverflow.com/a/29747683/65706
         UPDATE features SET seq=col_serial FROM 
         (SELECT guid, row_number() OVER ( ORDER BY seq) AS col_serial FROM features ORDER BY seq) AS tmp_features 
         WHERE features.guid=tmp_features.guid;

         RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_features_set_all_seq
  AFTER UPDATE OR DELETE ON features
  FOR EACH ROW 
  WHEN (pg_trigger_depth() < 1)
  EXECUTE PROCEDURE fnc_features_set_all_seq();
-- STOP trg_features_set_all_seq

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'features'::regclass;

