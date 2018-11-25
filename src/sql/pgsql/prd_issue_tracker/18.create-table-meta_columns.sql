-- DROP TABLE IF EXISTS meta_columns ; 

SELECT 'create the "meta_columns" table'
; 
   CREATE TABLE meta_columns (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , table_name     varchar (100) NOT NULL DEFAULT 'table name ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , skip_in_list   boolean null default false
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_meta_columns_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_meta_columns_id on meta_columns (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.meta_columns'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_meta_columns BEFORE UPDATE ON meta_columns FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'meta_columns'::regclass;


insert into meta_columns ( table_name , name ) values ( 'monthly_issues','name');
