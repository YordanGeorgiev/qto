-- DROP TABLE IF EXISTS deployment_guide_doc CASCADE;

SELECT 'create the "deployment_guide_doc" table'
; 
   CREATE TABLE deployment_guide_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NULL 
    , type           varchar (25) NULL 
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    text NULL
    , src            text NULL
    , formats  text NULL
    , runtime        varchar (20) NULL 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_deployment_guide_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_deployment_guide_doc_id on deployment_guide_doc (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.deployment_guide_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger for the update_time update: 
   CREATE TRIGGER trg_deployment_guide_doc_set_update_time 
   BEFORE UPDATE ON deployment_guide_doc 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

-- START trg_deployment_guide_doc_set_all_seq
CREATE OR REPLACE FUNCTION fnc_deployment_guide_doc_set_all_seq()
    RETURNS TRIGGER
    AS $$
       BEGIN 
         -- src: https://stackoverflow.com/a/29747683/65706
         UPDATE deployment_guide_doc SET seq=col_serial FROM 
         (SELECT guid, row_number() OVER ( ORDER BY seq) AS col_serial FROM deployment_guide_doc ORDER BY seq) AS tmp_deployment_guide_doc 
         WHERE deployment_guide_doc.guid=tmp_deployment_guide_doc.guid;

         RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_deployment_guide_doc_set_all_seq
  AFTER UPDATE OR DELETE ON deployment_guide_doc
  FOR EACH ROW 
  WHEN (pg_trigger_depth() < 1)
  EXECUTE PROCEDURE fnc_deployment_guide_doc_set_all_seq();
-- STOP trg_deployment_guide_doc_set_all_seq

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'deployment_guide_doc'::regclass;
