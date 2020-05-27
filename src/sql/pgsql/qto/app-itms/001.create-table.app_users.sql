-- file: src/sql/pgsql/qto/app-itms/001.create-table.app_users.sql
-- v0.8.4

-- \echo 'If necessary, perform DROP TABLE IF EXISTS app_users'

-- \echo '1. Creating the app_users table'

CREATE TABLE public.app_users (
    guid UUID DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    name character varying(100) DEFAULT 'User name'::character varying NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(200) DEFAULT 'Email'::character varying NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    description character varying(200) DEFAULT ''::character varying,
    password character varying(200) DEFAULT 'Password'::character varying NOT NULL,
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now()),
    CONSTRAINT pk_app_users_guid PRIMARY KEY (guid),
    UNIQUE(email)
);



--
-- TOC entry 3348 (class 0 OID 176764)
-- Dependencies: 281

COPY public.app_users (guid, id, name, first_name, last_name, email, status, description, password, update_time) FROM stdin;
2660a6e9-9e6b-4faa-8264-27a92872657b	190707231513	tau	anonymous	 user	test.anonymous.user@gmail.com	1	Test anonymous	{CRYPT}$2a$08$iAmq3xMI4452eOmbexOXFOzccG7/kDVri21RZIainW2kYXq57xbdG	2020-05-01 21:06:10
2660a6e9-9e6b-4faa-8264-27a92872657c	200107231510	trd	test reader	user	test.reader.user@gmail.com	1	Test reader	{CRYPT}$2a$08$/Z3BoSd2cOO1Enb4xckj9Ocl/8dWGzUxlyaI0fDLveDSEPHQh6XiG	2020-05-01 21:06:10
2660a6e9-9e6b-4faa-8264-27a92872657d	200107231511	ted	test editor	user	test.editor.user@gmail.com	1	Test editor	{CRYPT}$2a$08$cbAMAMtbNJthEfglhyj6buI4GL13Yia4QTGIZXFE.9jhuVWZ1p/Ru	2020-05-01 21:06:10
9426c566-0abd-4028-830f-82ed9f91d262	200502001502	pio	product instance	owner user	pio@gmail.com	1	Test product instance owner	{CRYPT}$2a$08$nTM2/kqvQkNS.vuGV.0bG.h67j8Ci1DreZ16KeVPA8N9SwBohv5cm	2020-05-01 21:15:41
\.
                               
-- \echo 'List columns of the created table app_users'

SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_users'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_users
	BEFORE UPDATE ON app_users 
    FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_users'::regclass;

