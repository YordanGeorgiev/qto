-- \echo '-- DROP TABLE IF EXISTS yearly_issues ;'

SELECT 'Creating the yearly_issues table'; 

CREATE TABLE yearly_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , category_guid  uuid DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'::uuid NOT NULL
    , status_guid    uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL
    , prio           integer NOT NULL DEFAULT 0
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , app_users_guid uuid DEFAULT public.gen_random_uuid()
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_yearly_issues_guid PRIMARY KEY (guid)
    );

CREATE unique index idx_uniq_yearly_issues_id
	ON yearly_issues (id);


SELECT 'Display the columns of the just created table'
; 

SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.yearly_issues'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_yearly_issues
	BEFORE UPDATE ON yearly_issues
	FOR EACH ROW
	EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'yearly_issues'::regclass;

