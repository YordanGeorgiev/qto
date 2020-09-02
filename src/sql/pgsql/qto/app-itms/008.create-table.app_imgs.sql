-- \echo 'If necessary, perform DROP TABLE IF EXISTS app_imgs CASCADE'

-- \echo '8. Creating the app_imgs table'

CREATE TABLE app_imgs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) NOT NULL DEFAULT 'Image figure title'
    , relative_path  varchar (1000) NOT NULL DEFAULT 'src/perl/qto/public/dat/img/qto/...'
    , http_path      varchar (4000) NOT NULL DEFAULT 'https://raw.githubusercontent.com/YordanGeorgiev/qto/master/doc/img/..'
    , style          varchar (100) NOT NULL DEFAULT 'width: 800px; height: 600x'
    , item_id        bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint)
    , description    varchar (4000) NOT NULL DEFAULT 'Alt text' 
    , item_name      varchar (200) NOT NULL DEFAULT 'item_name...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_imgs_guid PRIMARY KEY (guid)
    );


CREATE UNIQUE INDEX idx_uniq_app_imgs_id
	ON app_imgs (id);

-- \echo 'List columns of the created table app_imgs'

SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_imgs'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_imgs
	BEFORE UPDATE ON app_imgs
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_imgs'::regclass;
