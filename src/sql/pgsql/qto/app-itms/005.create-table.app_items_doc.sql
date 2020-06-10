-- v0.8.4

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

COPY public.app_items_doc (guid, id, level, seq, type, url, title, name, status, description, item_id, src, formats, lft, rgt, update_time) FROM stdin;
c95e8b4f-48a1-4426-8ff3-9c512ee5d21f	1	1	2	folder	#	general	start	wip	\N	\N	\N	\N	2	13	2020-05-30 10:15:07
8d969e0b-03b4-400c-a8e7-78b723161bd2	191113062550	2	3	doc	search	search	home & search	wip	\N	\N	\N	\N	3	4	2020-05-30 10:15:07
5b9c9736-6d97-44f7-8453-8a63bad5f150	191109112208	2	5	doc	view/readme_doc	readme	readme	wip	\N	\N	\N	\N	5	6	2020-05-30 10:15:07
db69a517-647d-4f68-99bd-7fee79a8de78	200301102933	2	6	doc	view/concepts_doc	concepts	concepts	wip	\N	\N	\N	\N	7	8	2020-05-30 10:15:07
fb9c288d-e363-4219-8224-2e6a71e71777	191110045939	2	7	doc	view/enduser_guide_doc	end-user guide	end-user guide	wip	\N	\N	\N	\N	9	10	2020-05-30 10:15:07
3c232672-e6d1-484e-9da2-072a89929ea3	200504071444	2	8	doc	view/wow_doc	way of working	way of working	wip	\N	\N	\N	\N	11	12	2020-05-30 10:15:07
567e0f7d-4f88-4a19-a968-f2f50718d8ad	200530062325	2	10	doc	list-my/bugs?oa=prio	my bugs	my bugs	wip	\N	\N	\N	\N	15	16	2020-05-30 10:15:07
a9417bcd-e165-4661-a9ab-84eec05a39a0	200530062334	2	11	doc	list-my/monthly_issues_202006?oa=prio	my monthly issues	my issues	wip	\N	\N	\N	\N	17	18	2020-06-05 17:27:56
fa4bc87e-8a98-4012-9128-d40c0a15d40b	0	0	1	folder	#	not used	ITEMS DOC	wip	\N	\N	\N	\N	1	74	2020-05-31 19:44:15
90ff1312-fb72-41f3-a199-78d6edb142ed	200530062251	1	9	folder	my lists	my lists	my lists	wip	\N	\N	\N	\N	14	21	2020-05-31 19:44:15
f2d93c16-c20e-4b97-98c6-cd52d3c831b3	200514100345	2	15	doc	list/bugs?oa=prio	bugs	bugs	wip	\N	\N	\N	\N	25	24	2020-05-31 19:44:15
6d5b4f93-2694-4b34-8e7a-422da597518c	191113061322	2	15	doc	list/problems?oa=prio	problems	problems	wip	\N	\N	\N	\N	27	26	2020-05-31 19:44:15
b472356b-4ab2-450d-a444-11f95dbeb20c	191124075545	2	16	doc	list/questions?oa=prio	questions	questions	wip	\N	\N	\N	\N	29	28	2020-05-31 19:44:15
9205467f-759e-46c2-986a-86aa2e908395	200511105852	2	17	doc	list/incidents?oa=prio	incidents	incidents	wip	\N	\N	\N	\N	33	32	2020-05-31 19:44:15
05967bcf-c0ad-48cb-8ea0-0761b460717b	200516112554	2	18	doc	list/goals?oa=prio&pg-size=7	goals	goals	wip	\N	\N	\N	\N	35	34	2020-05-31 19:44:15
4763e1ee-abf5-4bd8-a903-9e5bcf64c5bc	191110044834	2	19	doc	list/yearly_issues_2020?&oa=prio&pg-size=7	yearly-issues	yearly_issues	wip	\N	\N	\N	\N	37	36	2020-05-31 19:44:15
dca70fdc-984a-422d-a237-333d883c9e4a	200530062656	2	21	doc	list/app_items?oa=name	list app items	list app items	wip	\N	\N	\N	\N	41	40	2020-05-31 19:44:15
dfc0af59-f7e5-46d1-ae5c-43454a755e2b	200301101958	2	22	doc	list/app_items_doc?oa=seq&pick=lft,rgt,seq,name,level,url,title,type&pg-size=100	list items doc	list items doc	wip	\N	\N	\N	\N	43	42	2020-05-31 19:44:15
2eeb2d86-39f0-44f6-a16e-999e4de7f6ee	200526063808	2	23	doc	list/app_items?pg-size=100&oa=name	list app items	list app items	wip	\N	\N	\N	\N	45	44	2020-05-31 19:44:15
648b31be-0964-4220-8412-50994394b488	200526064159	2	24	doc	list/routes?oa=name	list routes	list routes	wip	\N	\N	\N	\N	47	46	2020-05-31 19:44:15
f6af2e03-b6b6-41fc-8012-f7f033780b65	200301102020	2	25	doc	view/app_items_doc	view items doc	view items doc	wip	\N	\N	\N	\N	49	48	2020-05-31 19:44:15
1edc12ab-f824-44fa-b67d-a08d7eb7d269	200301102057	2	26	doc	list/app_item_attributes?oa=name&pick=prio,table_name,name,skip_in_list,width,readonly	meta attributes	list app items attributes	wip	\N	\N	\N	\N	51	50	2020-05-31 19:44:15
7b0e04c7-ccee-4c74-b32c-428916dc8b40	191110102142	2	28	doc	view/concepts_doc	application concepts	concepts	wip	\N	\N	\N	\N	55	54	2020-05-31 19:44:15
3d71a66a-f9e8-45c5-af6b-268cfc671a19	191110050537	2	29	doc	view/userstories_doc	user-stories	userstories doc	wip	\N	\N	\N	\N	57	56	2020-05-31 19:44:15
e80a74ac-69a4-4aa4-8500-0d8e6029fdfc	191113062934	2	30	doc	view/requirements_doc	requirements	requirements	wip	\N	\N	\N	\N	59	58	2020-05-31 19:44:15
d9aa6513-724c-420f-b694-a583d54564f5	191110102154	2	31	doc	view/features_doc	features & functionalities	features & functionalities	wip	\N	\N	\N	\N	61	60	2020-05-31 19:44:15
3a0b8f50-d88f-4e54-911e-f9bf84bc7ad1	191110051042	2	33	doc	view/system_guide_doc	system gude	system guide	wip	\N	\N	\N	\N	65	64	2020-05-31 19:44:15
5ea1e9e3-246a-4986-8f5b-53f9e8fedb9c	191110044638	2	34	doc	view/installations_doc	installation guide	installation guide	wip	\N	\N	\N	\N	67	66	2020-05-31 19:44:15
79599235-ae29-4eb3-8bc9-a4a91989503e	191110044649	2	35	doc	view/maintenance_guide_doc	maintenance & operations guide	maintenance & operations guide	wip	\N	\N	\N	\N	69	68	2020-05-31 19:44:15
d6652433-7bee-42c3-a564-0d2580330674	191110044713	2	36	doc	view/devops_guide_doc	devops guide	devops guide	wip	\N	\N	\N	\N	71	70	2020-05-31 19:44:15
e66250fb-324d-47c8-81f4-25c1ac3dd539	191109110438	1	13	folder	#	lists	lists	wip	\N	\N	\N	\N	22	39	2020-05-31 19:44:15
116296a9-23de-47e4-bafd-d0e6366ab892	200301101943	1	20	folder	#	admin corner	admin corner	wip	\N	\N	\N	\N	40	53	2020-05-31 19:44:15
ccabc9fd-39f2-492b-8079-29f58587a72e	191109112117	1	27	folder	#	documents	documents	wip	\N	\N	\N	\N	54	63	2020-05-31 19:44:15
3a6c7f4d-bf60-4180-9bbe-6f1f8fa2052c	191110043707	1	32	folder	#	devops docs	devops doc store	wip	\N	\N	\N	\N	64	73	2020-05-31 19:44:15
465b0a5c-13bb-4888-b2d7-6a08d3b86f69	191112032733	2	14	doc	list/ideas?oa=prio	ideas	ideas	wip	\N	\N	\N	\N	23	22	2020-05-31 19:44:54
d702d7d0-3cb6-4092-82cc-7336946d9fa8	200531074415	2	12	doc	list-my/ideas?oa=prio	my ideas	my ideas	02-todo	\N	\N	\N	\N	19	20	2020-05-31 19:45:05
16232847-865e-45b3-90be-21ca1f5636b4	191110044820	2	16	doc	list/monthly_issues_202006?oa=prio	monthly-issues	monthly-issues	wip	\N	\N	\N	\N	31	30	2020-06-05 17:27:59
\.
