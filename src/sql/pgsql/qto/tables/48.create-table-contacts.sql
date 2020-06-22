-- DROP TABLE IF EXISTS contacts ; 

SELECT 'create the "contacts" table'
; 
   CREATE TABLE contacts (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , email          varchar (60) NOT NULL DEFAULT 'email'
    , mobile         varchar (30) NOT NULL DEFAULT 'mobile'
    , description    varchar (4000)
    , organisation   varchar (50) NOT NULL DEFAULT 'organisation'
    , first_name     varchar (50) NOT NULL DEFAULT 'first_name...'
    , last_name      varchar (50) NOT NULL DEFAULT 'last_name...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_contacts_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_contacts_id on contacts (id);

-- the rank search index
CREATE INDEX idx_rank_contacts ON contacts
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.contacts'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 



--The trigger:
CREATE TRIGGER trg_set_update_time_on_contacts BEFORE UPDATE ON contacts FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'contacts'::regclass;
