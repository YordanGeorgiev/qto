-- v0.8.5

-- \echo 'If necessary, perform -- DROP TABLE IF EXISTS app_items_doc;'

-- \echo '5. Creating the app_items_doc table'

CREATE TABLE app_items_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , type           varchar (10) NOT NULL DEFAULT 'doc'
    , url            varchar (2048) NOT NULL DEFAULT '#' -- 2048 is the absolute max
    , title          varchar (50) NOT NULL DEFAULT 'link-title...'
    , name           varchar (100) NOT NULL DEFAULT 'doc-title...'
    , status         varchar (10) NOT NULL DEFAULT '02-todo'
    , description    varchar (4000)
    , item_id        integer NULL -- the future hook for the table name in the url
    , src            varchar (4000)
    , formats        text NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_items_doc_guid PRIMARY KEY (guid)
    );

CREATE unique index idx_uniq_app_items_doc_id
	ON app_items_doc (id);

-- insert into app_items_doc ( id , level , seq , lft , rgt , name) values ( 0 , 0, 1, 1, 8, 'ITEMS DOC' );
-- insert into app_items_doc ( id , level , seq , lft , rgt , name) values ( 1 , 1, 2, 2, 3, 'lists' );
-- insert into app_items_doc ( id , level , seq , lft , rgt , name) values ( 2 , 1, 3, 4, 5, 'docs' );
-- insert into app_items_doc ( id , level , seq , lft , rgt , name) values ( 3 , 1, 4, 6, 7, 'labels' );


-- \echo 'List columns of the created table app_items'
SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_items_doc'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_items_doc
	BEFORE UPDATE ON app_items_doc
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_items_doc'::regclass;

--
-- TOC entry 3321 (class 0 OID 46939)
-- Dependencies: 207
-- Data for Name: items_doc; Type: TABLE DATA; Schema: public; Owner: usrtstqtoadmin
--


COPY public.app_items_doc (guid, id, level, seq, type, url, title, name, status, description, item_id, prio, src, formats, lft, rgt, update_time) FROM stdin;
5b9c9736-6d97-44f7-8453-8a63bad5f150	191109112208	2	4	doc	view/readme_doc	readme	readme	09-done	\N	\N	1	\N	\N	5	6	2020-01-31 18:39:56
7b0e04c7-ccee-4c74-b32c-428916dc8b40	191110102142	2	18	doc	view/concepts_doc	application concepts	concepts	09-done	\N	\N	1	\N	\N	31	26	2020-03-01 10:29:33
d9aa6513-724c-420f-b694-a583d54564f5	191110102154	2	21	doc	view/features_doc	features & functionalities	features & functionalities	09-done	\N	\N	1	\N	\N	37	30	2020-03-01 10:29:33
3a0b8f50-d88f-4e54-911e-f9bf84bc7ad1	191110051042	2	23	doc	view/system_guide_doc	system gude	system guide	09-done	\N	\N	1	\N	\N	41	34	2020-03-01 10:29:33
465b0a5c-13bb-4888-b2d7-6a08d3b86f69	191112032733	2	8	doc	list/ideas?oa=prio	ideas	ideas	09-done	\N	\N	1	\N	\N	13	12	2020-03-01 10:29:33
6d5b4f93-2694-4b34-8e7a-422da597518c	191113061322	2	8	doc	list/problems?oa=prio	problems	problems	02-todo	\N	\N	1	\N	\N	15	14	2020-03-01 10:29:33
db69a517-647d-4f68-99bd-7fee79a8de78	200301102933	2	5	doc	view/concepts_doc	concepts	concepts	02-todo	\N	\N	1	\N	\N	7	8	2020-03-01 10:30:15
e80a74ac-69a4-4aa4-8500-0d8e6029fdfc	191113062934	2	20	doc	view/requirements_doc	requirements	requirements	09-done	\N	\N	1	\N	\N	35	28	2020-03-01 10:29:33
d6652433-7bee-42c3-a564-0d2580330674	191110044713	2	26	doc	view/devops_guide_doc	devops guide	devops guide	09-done	\N	\N	1	\N	\N	47	40	2020-03-01 10:29:33
b472356b-4ab2-450d-a444-11f95dbeb20c	191124075545	2	11	doc	list/questions?oa=prio	questions	questions	09-done	\N	\N	1	\N	\N	19	18	2020-03-01 10:29:33
4763e1ee-abf5-4bd8-a903-9e5bcf64c5bc	191110044834	2	12	doc	list/yearly_issues_2020?&oa=prio&pg-size=7	yearly-issues	yearly_issues	09-done	\N	\N	1	\N	\N	21	20	2020-03-01 10:29:33
116296a9-23de-47e4-bafd-d0e6366ab892	200301101943	1	13	folder	#	admin corner	admin corner	02-todo	\N	\N	1	\N	\N	24	31	2020-03-01 10:29:33
dfc0af59-f7e5-46d1-ae5c-43454a755e2b	200301101958	2	14	doc	list/app_items_doc?oa=seq&pick=name,url,title,type	list items doc	list items doc	02-todo	\N	\N	1	\N	\N	25	24	2020-03-01 10:29:33
f6af2e03-b6b6-41fc-8012-f7f033780b65	200301102020	2	15	doc	view/app_items_doc	view items doc	view items doc	02-todo	\N	\N	1	\N	\N	27	26	2020-03-01 10:29:33
1edc12ab-f824-44fa-b67d-a08d7eb7d269	200301102057	2	16	doc	list/meta_columns?oa=name	list meta cols	list meta-columns	02-todo	\N	\N	1	\N	\N	29	28	2020-03-01 10:29:33
5ea1e9e3-246a-4986-8f5b-53f9e8fedb9c	191110044638	2	24	doc	view/installations_doc	installation guide	installation guide	09-done	\N	\N	1	\N	\N	43	36	2020-03-01 10:29:33
ccabc9fd-39f2-492b-8079-29f58587a72e	191109112117	1	17	folder	#	documents	documents	09-done	\N	\N	1	\N	\N	30	39	2020-03-01 10:29:33
3a6c7f4d-bf60-4180-9bbe-6f1f8fa2052c	191110043707	1	22	folder	#	devops docs	devops doc store	09-done	\N	\N	1	\N	\N	40	49	2020-03-01 10:29:33
8d65a710-d998-4fba-bc47-f163a896c378	200319133453	\N	\N	doc	#	link-title...	doc-title...	02-todo	\N	\N	1	\N	\N	\N	\N	2020-03-19 11:34:51
5960db0b-4508-4c25-9163-5492d6c3245d	200319133458	\N	\N	doc	#	link-title...	doc-title...	02-todo	\N	\N	1	\N	\N	\N	\N	2020-03-19 11:34:57
18fac44f-48ab-4ce9-98e2-5c953e19a1b0	200319133500	\N	\N	doc	#	link-title...	doc-title...	02-todo	\N	\N	1	\N	\N	\N	\N	2020-03-19 11:35:46
79599235-ae29-4eb3-8bc9-a4a91989503e	191110044649	2	25	doc	view/maintenance_guide_doc	maintenance & operations guide	maintenance & operations guide	09-done	\N	\N	1	\N	\N	45	38	2020-03-19 11:36:08
fa4bc87e-8a98-4012-9128-d40c0a15d40b	0	0	1	folder	#	not used	ITEMS DOC	09-done	\N	\N	1	\N	\N	1	52	2020-03-19 11:36:36
e66250fb-324d-47c8-81f4-25c1ac3dd539	191109110438	1	7	folder	#	lists	lists	09-done	\N	\N	1	\N	\N	12	23	2020-03-19 11:36:37
fb9c288d-e363-4219-8224-2e6a71e71777	191110045939	2	6	doc	view/enduser_guide_doc	end-user guide	end-user guide	09-done	\N	\N	1	\N	\N	9	8	2020-03-20 07:37:45
16232847-865e-45b3-90be-21ca1f5636b4	191110044820	2	10	doc	list/monthly_issues_202005?oa=prio	monthly-issues	monthly-issues	09-done	\N	\N	1	\N	\N	17	16	2020-04-01 02:35:07
3d71a66a-f9e8-45c5-af6b-268cfc671a19	191110050537	2	19	doc	view/userstories_doc	user-stories	userstories doc	09-done	\N	\N	1	\N	\N	33	28	2020-04-06 14:14:23
c95e8b4f-48a1-4426-8ff3-9c512ee5d21f	1	1	2	folder	#	general	start	09-done	\N	\N	1	\N	\N	2	11	2020-04-10 17:40:51
8d969e0b-03b4-400c-a8e7-78b723161bd2	191113062550	2	3	doc	search	search	home & search	09-done	\N	\N	1	\N	\N	3	4	2020-04-10 19:22:32
\.
