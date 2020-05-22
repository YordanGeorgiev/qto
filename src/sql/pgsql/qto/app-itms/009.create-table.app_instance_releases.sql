CREATE TABLE app_instance_releases (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , app_ver        varchar (10) NOT NULL DEFAULT '0.0.0'
    , app_git_ref    varchar (9) NOT NULL DEFAULT ''
    , db_ver         varchar (10) NOT NULL DEFAULT '0.0.0'
    , db_git_ref     varchar (9) NOT NULL DEFAULT ''
    , env            varchar (3) NOT NULL DEFAULT 'dev'
    , proj_db_name   varchar (20) NOT NULL DEFAULT 'qto'
    , dns_name       varchar (20) NOT NULL DEFAULT 'qto.fi'
    , name           varchar (200) NOT NULL DEFAULT 'release title ...'
    , description    varchar (4000) NOT NULL DEFAULT 'release description add links to issues etc.' 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_instance_releases_guid PRIMARY KEY (guid)
    );


CREATE UNIQUE INDEX idx_uniq_app_instance_releases_id
	ON app_instance_releases (id);

-- \echo 'List columns of the created table app_instance_releases'

SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_instance_releases'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_instance_releases
	BEFORE UPDATE ON app_instance_releases
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_instance_releases'::regclass;
