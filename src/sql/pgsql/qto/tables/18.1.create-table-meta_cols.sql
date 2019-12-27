DROP TABLE IF EXISTS meta_cols ; 

SELECT 'create the "meta_cols" table'
; 
   CREATE TABLE meta_cols (
      guid              UUID NOT NULL DEFAULT gen_random_uuid()
    , id                bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , table_name        varchar (100) NOT NULL DEFAULT 'src_table_name...'
    , prio              integer NOT NULL DEFAULT 1
    , ordinal_number    integer NOT NULL DEFAULT 1
    , src_table_name        varchar (100) NOT NULL DEFAULT 'src_table_name...'
    , tgt_table_name        varchar (100) NOT NULL DEFAULT 'tgt_table_name...'
    , name              varchar (100) NOT NULL DEFAULT 'col-name...'
    , json_file         varchar (100) NOT NULL DEFAULT 'json_file...'
    , json_expression   varchar (100) NOT NULL DEFAULT 'json_expression...'
    , description       varchar (4000)
    , update_time       timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_meta_cols_guid PRIMARY KEY (guid)
    , CONSTRAINT uc_table_column unique (table_name, name)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_meta_cols_id on meta_cols (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.meta_cols'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_meta_cols 
   BEFORE UPDATE ON meta_cols FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'meta_cols'::regclass;

