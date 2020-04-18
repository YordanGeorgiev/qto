-- DROP TABLE IF EXISTS app_user_roles ; 

SELECT 'create the "app_user_roles" table'
; 
   CREATE TABLE app_user_roles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , app_users_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , app_roles_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_user_roles_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_app_user_roles_uniq_id on app_user_roles (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_user_roles'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_app_user_roles BEFORE UPDATE ON app_user_roles 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'app_user_roles'::regclass;

--
-- TOC entry 3355 (class 0 OID 137804)
-- Dependencies: 282
-- Data for Name: app_user_roles; Type: TABLE DATA; Schema: public; Owner: usrdevqtoadmin
--

COPY public.app_user_roles (guid, id, app_users_guid, app_roles_guid, name, description, update_time) FROM stdin;
caa37277-5f81-473d-a4f3-5f43c8efa533	200418123923	2660a6e9-9e6b-4faa-8264-27a92872657b	71eea083-d818-4557-89fe-29eb950881ab	anonymous	the test anonymous user has the anonymous role	2020-04-18 09:39:54
53fc5912-8193-4e10-a6ed-c77a61e0c4a9	200418123958	2660a6e9-9e6b-4faa-8264-27a92872657c	71eea083-d818-4557-89fe-29eb950881ad	reader	the test reader user has the reader role	2020-04-18 09:40:13
3645f65a-628b-4cf5-b30c-8386f9547cd0	200418093842	02d16010-20af-4b0d-be86-cdf116a7d8c7	71eea083-d818-4557-89fe-29eb950881aa	product instance owner	the test product instance user has the product instance role 	2020-04-18 09:40:37
f24f92a7-b378-45a3-9847-dcf9c149dbcb	200418124015	2660a6e9-9e6b-4faa-8264-27a92872657d	71eea083-d818-4557-89fe-29eb950881ac	editor	the editor user has the editor role	2020-04-18 09:40:46
\.
