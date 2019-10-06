--DROP TABLE IF EXISTS imgs CASCADE;

SELECT 'create the "imgs" table'
; 
   CREATE TABLE imgs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) NOT NULL DEFAULT 'image figure title ...'
    , relative_path  varchar (1000) NOT NULL DEFAULT 'src/perl/qto/public/dat/img/qto/...'
    , http_path      varchar (1000) NOT NULL DEFAULT 'https://raw.githubusercontent.com/YordanGeorgiev/qto/dev/doc/img/..'
    , style          varchar (100) NOT NULL DEFAULT 'width: 800px; height: 600x'
    , item_guid      UUID NOT NULL DEFAULT gen_random_uuid()
    , description    varchar (4000) NOT NULL DEFAULT 'txt to appear on alt ...' 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_imgs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_imgs_id on imgs (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.imgs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_imgs 
   BEFORE UPDATE ON imgs 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'imgs'::regclass;

