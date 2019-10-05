                -- DROP TABLE IF EXISTS tst_paging ; 

SELECT 'create the "tst_paging" table'
; 
   CREATE TABLE tst_paging (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL
    , name           varchar (200) NOT NULL
    , CONSTRAINT pk_tst_paging_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_tst_paging_uniq_id on tst_paging (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.tst_paging'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
