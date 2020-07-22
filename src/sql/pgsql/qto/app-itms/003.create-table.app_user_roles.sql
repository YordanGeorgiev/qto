-- \echo 'If necessary, perform -- DROP TABLE IF EXISTS app_user_roles;'

-- \echo '2. Creating the app_user_roles table'

CREATE TABLE app_user_roles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , app_users_guid     UUID NOT NULL DEFAULT '2660a6e9-9e6b-4faa-8264-27a92872657b'
    , app_roles_guid     UUID NOT NULL DEFAULT '71eea083-d818-4557-89fe-29eb950881ab'
    , name           varchar (100) NOT NULL DEFAULT 'Role name'
    , description    varchar (200) NULL DEFAULT ''
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_user_roles_guid PRIMARY KEY (guid)
    );

CREATE UNIQUE INDEX idx_app_user_roles_uniq_id
	ON app_user_roles (id);


-- \echo 'If necessary, perform ALTER TABLE public.app_user_roles -- DROP CONSTRAINT fk_app_users_guid;'

ALTER TABLE public.app_user_roles
   ADD CONSTRAINT fk_app_users_guid 
   FOREIGN KEY (app_users_guid)
   REFERENCES app_users(guid) 
   ON DELETE CASCADE;
;
	
ALTER TABLE public.app_user_roles
   ADD CONSTRAINT fk_app_roles_guid 
   FOREIGN KEY (app_roles_guid)
   REFERENCES app_roles(guid) 
   ON DELETE CASCADE;
;

-- \echo 'List columns of the created table app_user_roles');

SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_user_roles'::regclass
   AND    attnum>0
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_user_roles
	BEFORE UPDATE ON app_user_roles 
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_user_roles'::regclass;

--
-- TOC entry 3355 (class 0 OID 137804)
-- Dependencies: 282
-- Data for Name: app_user_roles; Type: TABLE DATA; Schema: public; Owner: usrdevqtoadmin
--

COPY public.app_user_roles (guid, id, app_users_guid, app_roles_guid, name, description, update_time) FROM stdin;
6f036963-52cc-4d49-ae36-984c75d14bb2	200411160810	2660a6e9-9e6b-4faa-8264-27a92872657c	71eea083-d818-4557-89fe-29eb950881ad	trd must be reader	Test reader user has reader role	2020-05-01 21:13:48
0fb84503-0d7a-4cdc-889b-4e4a8f6aac53	200410220814	2660a6e9-9e6b-4faa-8264-27a92872657d	71eea083-d818-4557-89fe-29eb950881ac	ted must be editor	Test editor user has editor role	2020-05-01 21:14:01
460cc595-7db7-4211-a271-d825b3801d1e	200224195828	2660a6e9-9e6b-4faa-8264-27a92872657b	71eea083-d818-4557-89fe-29eb950881ab	tau must be anonymous	Test anonymous user has anonymous role	2020-05-01 21:14:11
472cbd25-d8a5-4828-85f3-556387aea673	200502001551	9426c566-0abd-4028-830f-82ed9f91d262	71eea083-d818-4557-89fe-29eb950881aa	pio must be product instance owner	Test product instance owner has instance owner role	2020-05-01 21:19:21
\.
