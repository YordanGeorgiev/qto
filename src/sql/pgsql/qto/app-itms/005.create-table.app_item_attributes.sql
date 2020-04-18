-- DROP TABLE IF EXISTS app_item_attributes CASCADE ; 

SELECT 'create the "app_item_attributes" table'
; 
   CREATE TABLE app_item_attributes (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , table_name     varchar (100) NOT NULL DEFAULT 'table name ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , skip_in_list   boolean null default false
    , width          integer NULL DEFAULT null
    , readonly       boolean null default false 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    ) WITH (
      OIDS=FALSE
    );

ALTER TABLE app_item_attributes 
  -- DROP CONSTRAINT IF EXISTS uc_table_columns
;
ALTER TABLE app_item_attributes 
  -- DROP CONSTRAINT IF EXISTS pk_app_item_attributes_guid
;
    
ALTER TABLE app_item_attributes 
    ADD CONSTRAINT pk_app_item_attributes_guid PRIMARY KEY (guid)
;
ALTER TABLE app_item_attributes 
    ADD CONSTRAINT uc_table_columns unique (table_name, name)
;

create unique index idx_uniq_app_item_attributes_id on app_item_attributes (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_item_attributes'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_app_item_attributes BEFORE UPDATE ON app_item_attributes FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'app_item_attributes'::regclass;

; 

--
-- TOC entry 3322 (class 0 OID 47354)
-- Dependencies: 229
-- Data for Name: meta_columns; Type: TABLE DATA; Schema: public; Owner: usrtstqtoadmin
--

COPY public.app_item_attributes(guid, id, prio, table_name, name, description, skip_in_list, width, readonly, update_time) FROM stdin;
6a89f5fc-1115-4a89-8472-5591a0d50e80	190523215546	4	userstories	update_time	 	t	\N	f	2019-11-22 12:22:06
f36fc822-46a4-49e3-a53a-374036e95bb5	190614191158	4	meta_columns	description	 	f	50	f	2019-12-06 13:00:32
52189bff-d2f9-46b9-b8ba-e2ccd96a6bc7	181206221152	4	userstories	lft_rnk	\N	t	\N	f	2019-11-22 12:13:53
e3f1d0b1-ec58-4bcb-babd-408ae09e8036	181206221206	4	userstories	rgt_rnk	\N	t	\N	f	2019-11-22 12:13:53
aaaeea54-5b28-4f15-ab2b-7dad52f459bd	181125050540	4	monthly_issues	name	\N	f	\N	f	2019-11-22 12:13:53
a982d70f-b9b2-4461-b7d6-549c091c3d61	181125151422	4	meta_columns	update_time	\N	t	\N	f	2019-11-22 12:13:53
c8b49506-8306-48e9-93a2-4789c80411e1	181125104502	4	monthly_issues	start_time	_	t	\N	f	2019-11-22 12:13:53
3f45c255-7168-4369-b786-11ca1c9f5dcd	181125163726	4	monthly_issues	stop_time	\N	t	\N	f	2019-11-22 12:13:53
ace21c06-d7b3-45ae-a4f7-da96291d8050	181125163903	4	monthly_issues	planned_hours	\N	t	\N	f	2019-11-22 12:13:53
106265e2-073d-43a4-81c7-2eb3d0cb8905	181125104525	4	meta_columns	guid	_	t	\N	f	2019-11-22 12:13:53
d95f237e-00e5-4b46-acba-d89ba7099296	181125163942	4	monthly_issues	seq	\N	t	\N	f	2019-11-22 12:13:53
42681e08-31d8-425c-9f17-369561c0ed39	181125165700	4	monthly_issues	level	\N	t	\N	f	2019-11-22 12:13:53
2af06c04-c8b7-4847-8bef-77b77546b520	181125165752	4	monthly_issues	actual_hours	\N	t	\N	f	2019-11-22 12:13:53
153c36a0-b1c4-4bbc-aff0-dfe62688ce6a	181125165803	4	monthly_issues	update_time	\N	t	\N	f	2019-11-22 12:13:53
a4a6ecc0-c43a-4ded-a5cf-d736ec7e9186	181125171301	4	monthly_issues	tags	\N	t	\N	f	2019-11-22 12:13:53
2ffeea85-f182-4290-8862-64f71e26c552	181126131754	4	confs	update_time	\N	t	\N	f	2019-11-22 12:13:53
1aaeea54-5b28-4f15-ab2b-7dad52f459bd	181125150540	4	yearly_issues	name	\N	f	\N	f	2019-11-22 12:13:53
253c36a0-b1c4-4bbc-aff0-dfe62688ce6a	181125065803	4	yearly_issues	update_time	\N	t	\N	f	2019-11-22 12:13:53
a8b49506-8306-48e9-93a2-4789c80411e1	181125004502	4	yearly_issues	start_time	_	t	\N	f	2019-11-22 12:13:53
2f45c255-7168-4369-b786-11ca1c9f5dcd	181125063726	4	yearly_issues	stop_time	\N	t	\N	f	2019-11-22 12:13:53
1ce21c06-d7b3-45ae-a4f7-da96291d8050	181125063903	4	yearly_issues	planned_hours	\N	t	\N	f	2019-11-22 12:13:53
195f237e-00e5-4b46-acba-d89ba7099296	181125063942	4	yearly_issues	seq	\N	t	\N	f	2019-11-22 12:13:53
32681e08-31d8-425c-9f17-369561c0ed39	181125065700	4	yearly_issues	level	\N	t	\N	f	2019-11-22 12:13:53
1af06c04-c8b7-4847-8bef-77b77546b520	181125065752	4	yearly_issues	actual_hours	\N	t	\N	f	2019-11-22 12:13:53
4be7e57e-f306-4afd-98b9-7ba558d67bd2	181125171311	4	yearly_issues	tags	\N	t	\N	f	2019-11-22 12:13:53
c5d174a8-24a7-48ab-b883-8706305f235a	190202220548	4	monthly_issues	weight	\N	t	\N	f	2019-11-22 12:13:53
150ce162-e8a2-4895-835d-9aedc2c8bdf4	190309101902	4	export_files	update_time	 	t	\N	f	2019-11-22 12:13:53
2d519e36-a075-4872-98ed-43b33b6156b7	190501192032	4	problems	seq	 	t	\N	f	2019-11-22 12:13:53
38feebe7-190c-4bf0-b846-384447e7eb81	190708213054	4	release_issues	weight	 	t	0	f	2019-11-22 12:13:53
f4a0db03-fa8a-4e7b-8075-9a0256df4b2b	191122105848	4	release_issues	status	 	f	30	f	2019-11-22 12:13:53
ee7eda74-5a16-42b7-ba7b-ffd363d02bf7	191114190104	4	release_issues	type	The type of an release issue could be: \n - bug , feature , functionality , task , cnf change	f	\N	f	2019-11-22 12:13:53
a6aac2f1-895d-45ee-8b0f-f75ffbc2cca8	191122141244	4	problems	description	 	f	200	f	2019-11-22 12:13:53
70e9d8a4-9060-4bfb-8703-b1924aad7de9	190523213203	4	release_issues	update_time	 	t	\N	f	2019-11-22 12:22:13
3823d020-2fcb-4d5b-ad66-591ed7e3d481	191122142213	1	meta_columns	table_name	 	f	35	f	2019-12-06 11:30:29
cb762fd4-dc5e-4180-b91c-beab27652d37	191122141438	2	problems	update_time	 	t	\N	f	2019-11-22 12:15:22
7bfe04a8-3c45-4a4c-9fb5-eacca9b8a930	191122141418	2	problems	solution_proposal	 	f	200	f	2019-12-06 11:30:30
7784df12-652c-476e-96a1-dc08ac0172e3	191122141515	1	problems	owner	\N	f	10	f	2019-11-22 12:15:32
8421afcc-be0a-4eb1-9a76-77b7dd80f41d	200227200120	1	yearly_issues_2020	update_time	 	t	10	f	2020-02-27 18:01:31
a69e1cc6-2e69-4704-bd62-8b013e8afbc5	200227133517	1	monthly_issues_202004	issues_status_guid	 	f	30	f	2020-04-11 13:36:17
d050bc02-1bcf-4391-ad7b-97146fae662a	191206142026	1	items_doc	url	 	f	40	f	2020-04-11 13:36:22
57c54026-eeaf-468a-8326-9175b174b173	200227191454	1	monthly_issues_202004	category_id	 	f	30	f	2020-04-11 13:37:41
94124d2f-3895-4b6f-966c-1f9bfe42fbec	200227184143	1	items_roles_permissions	roles_guid	 	f	60	f	2020-04-11 13:37:51
\.

