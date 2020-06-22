-- DROP TABLE IF EXISTS category ; 

SELECT 'create the "category" table'
; 
   CREATE TABLE category (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (4000)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_category_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_category_id on category (id);

-- the rank search index
CREATE INDEX idx_rank_category ON category
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.category'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--
-- TOC entry 3299 (class 0 OID 53411)
-- Dependencies: 268
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: usrtstqtoadmin
--

COPY public.category (guid, id, name, description, update_time) FROM stdin;
cb989a12-d0b8-46e4-b2cc-5e2a974b5d29	200226071624	e2e	end-to-end 	2020-02-27 16:46:24
ed1bde66-694f-4e4d-816f-de594df31f48	200227185617	setup	the setup category	2020-02-27 16:46:33
9831b05b-5b54-4926-a08a-ac2b749d7bfb	200227185625	ui	The User Interface category	2020-02-27 16:46:47
9791074b-37f3-47b2-9af9-b2645a38e806	200227185640	provisioning	The provisioning category	2020-02-27 16:47:39
51c8b189-63f3-46c8-a666-f766b22563d9	200227185731	db 	The database related activities category	2020-02-27 16:47:57
70724562-d83c-446e-94cf-58ced84f3a0e	200227185858	unknown	The "unknown" category	2020-02-27 16:49:17
5b73486a-141f-491f-a2ee-919259151052	200227190115	security	The "security" category	2020-02-27 16:51:32
0d9722b9-3fc9-4d55-b6ff-1d9c73ebbbd9	200227190212	testing	Related heavily to testing	2020-02-27 16:52:39
aff0a804-f121-404d-b61c-3626eeeb57cc	200227190326	refactoring	All the tasks and activities are mainly refactoring related ...	2020-02-27 16:54:01
d049ae30-a13e-4a58-b530-47fe4bf10ea9	200227190501	functionality	A technical functionality	2020-02-27 16:55:22
641a8836-dceb-42f8-8eb3-c3e97539a650	200227190531	release	Release	2020-02-27 16:55:52
9e6a661c-c70c-4071-a14f-1a2e79b97f00	200227190652	docs	Related to documentation creation or update	2020-02-27 16:57:17
3b2b3a79-f778-4978-a2b0-03d02561be84	200227190843	feature	The feature category	2020-02-27 16:58:59
\.


--
-- TOC entry 3167 (class 2606 OID 53424)
-- Name: category category_id_key; Type: CONSTRAINT; Schema: public; Owner: usrtstqtoadmin
--

--The trigger:
CREATE TRIGGER trg_set_update_time_on_category BEFORE UPDATE ON category FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'category'::regclass;
