-- file: src/sql/pgsql/qto/app-itms/001.create-table.app_users.sql
-- v0.8.4

SELECT 'create the "app_users" table'
; 

CREATE TABLE public.app_users (
    guid uuid DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    name character varying(100) DEFAULT 'name...'::character varying NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(200) DEFAULT 'email...'::character varying NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    description character varying(200) DEFAULT 'description...'::character varying,
    password character varying(200) DEFAULT 'password...'::character varying NOT NULL,
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now()),
    CONSTRAINT pk_app_users_guid PRIMARY KEY (guid)
);



--
-- TOC entry 3348 (class 0 OID 176764)
-- Dependencies: 281

COPY public.app_users (guid, id, name, first_name, last_name, email, status, description, password, update_time) FROM stdin;
2660a6e9-9e6b-4faa-8264-27a92872657b	190707231513	tau	anonymous	 user	test.anonymous.user@gmail.com	1	the test user	{CRYPT}$2a$08$iAmq3xMI4452eOmbexOXFOzccG7/kDVri21RZIainW2kYXq57xbdG	2020-05-01 21:06:10
2660a6e9-9e6b-4faa-8264-27a92872657c	200107231510	trd	test reader	user	test.reader.user@gmail.com	1	the test user	{CRYPT}$2a$08$/Z3BoSd2cOO1Enb4xckj9Ocl/8dWGzUxlyaI0fDLveDSEPHQh6XiG	2020-05-01 21:06:10
2660a6e9-9e6b-4faa-8264-27a92872657d	200107231511	ted	test editor	user	test.editor.user@gmail.com	1	the test user	{CRYPT}$2a$08$cbAMAMtbNJthEfglhyj6buI4GL13Yia4QTGIZXFE.9jhuVWZ1p/Ru	2020-05-01 21:06:10
9426c566-0abd-4028-830f-82ed9f91d262	200502001502	pio	product instance	owner user	pio@gmail.com	1	description...	{CRYPT}$2a$08$nTM2/kqvQkNS.vuGV.0bG.h67j8Ci1DreZ16KeVPA8N9SwBohv5cm	2020-05-01 21:15:41
\.

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_users'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

   CREATE TRIGGER trg_set_update_time_on_app_users BEFORE UPDATE ON app_users 
      FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time()
   ;

   select tgname
   from pg_trigger
   where not tgisinternal
   and tgrelid = 'app_users'::regclass
   ;


