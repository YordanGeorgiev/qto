-- DROP TABLE IF EXISTS test_item_hierarchy ; 

SELECT 'create the "test_item_hierarchy" table'
; 
   CREATE TABLE test_item_hierarchy (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , fuid           UUID NOT NULL 
    , level          integer NULL
    , seq            integer NOT NULL DEFAULT 1
    , lft            integer NULL
    , rgt            integer NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_test_item_hierarchy_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_test_item_hierarchy_id on test_item_hierarchy (id);


ALTER TABLE test_item_hierarchy
  ADD FOREIGN KEY (fuid) REFERENCES test_item(guid);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_item_hierarchy'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_test_item_hierarchy BEFORE UPDATE ON test_item_hierarchy FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'test_item_hierarchy'::regclass;

