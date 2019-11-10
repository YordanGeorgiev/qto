-- DROP TABLE IF EXISTS items_doc CASCADE;

SELECT 'create the "items_doc" table'
; 
   CREATE TABLE items_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , type           varchar (10) NOT NULL DEFAULT 'doc'
    , url            varchar (50) NOT NULL DEFAULT '#' -- 2048 is the absolute max
    , title          varchar (50) NOT NULL DEFAULT 'link-title...'
    , name           varchar (100) NOT NULL DEFAULT 'doc-title...'
    , status         varchar (10) NOT NULL DEFAULT '02-todo'
    , description    varchar (4000)
    , item_id        integer NULL -- the future hook for the table name in the url
    , prio           integer NOT NULL DEFAULT 1
    , src            varchar (4000)
    , formats        text NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_items_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_items_doc_id on items_doc (id);

-- insert into items_doc ( id , level , seq , lft , rgt , name) values ( 0 , 0, 1, 1, 8, 'ITEMS DOC' );
-- insert into items_doc ( id , level , seq , lft , rgt , name) values ( 1 , 1, 2, 2, 3, 'lists' );
-- insert into items_doc ( id , level , seq , lft , rgt , name) values ( 2 , 1, 3, 4, 5, 'docs' );
-- insert into items_doc ( id , level , seq , lft , rgt , name) values ( 3 , 1, 4, 6, 7, 'labels' );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.items_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_items_doc 
   BEFORE UPDATE ON items_doc 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'items_doc'::regclass;

