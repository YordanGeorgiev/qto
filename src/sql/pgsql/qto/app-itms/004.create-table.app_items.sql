-- v0.8.4

-- \echo 'If necessary, perform -- DROP TABLE IF EXISTS app_items;'

-- \echo '5. Creating the app_items table'

   CREATE TABLE app_items (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigserial UNIQUE 
    , prio           smallint NOT NULL DEFAULT 1
    , name           varchar (200) NOT NULL DEFAULT 'Item name'
    , ver            varchar (10) NOT NULL DEFAULT '0.8.4'
    , description    varchar (4000) DEFAULT ''
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_items_guid PRIMARY KEY (guid)
    );

CREATE UNIQUE INDEX idx_uniq_app_items_id
	ON app_items (id);

-- \echo 'List columns of the created table app_items'
SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_items'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_items
	BEFORE UPDATE ON app_items
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_items'::regclass;

--
-- TOC entry 3310 (class 0 OID 58960)
-- Dependencies: 207
-- Data for Name: app_items; Type: TABLE DATA; Schema: public; Owner: usrtstqtoadmin
--

COPY public.app_items (guid, id, prio, name, ver, description, update_time) FROM stdin;
1948aa5f-3007-4b0a-8c59-b1a5b5fbcff1	1	1	benchmarks	0.8.3	benchmarks	2020-04-12 18:14:53
71fc6f55-32f5-4ec9-ae7b-d552d6196ec8	2	1	category	0.8.3	category	2020-04-12 18:14:53
149a194d-b20e-44d5-b1a5-4fbd32e058ce	3	1	check_lists	0.8.3	check_lists	2020-04-12 18:14:53
bd992a20-1f72-48d6-a89c-5f321d812b76	4	1	concepts_doc	0.8.3	concepts_doc	2020-04-12 18:14:53
fc8c1ece-5804-4ea7-9d50-c4778f18cbe8	5	1	confs	0.8.3	confs	2020-04-12 18:14:53
b59fdeca-3eac-4cbb-93f7-13e488ec993e	6	1	daily_issues	0.8.3	daily_issues	2020-04-12 18:14:53
6bcf5612-c611-42f7-91d7-499e4abe3e04	7	1	decadally_issues	0.8.3	decadally_issues	2020-04-12 18:14:53
5347e5b6-c366-4779-9592-b85caadb4be7	9	1	devops_guide_doc	0.8.3	devops_guide_doc	2020-04-12 18:14:53
eca33c21-138c-4a2f-b907-3b1d117bea64	8	1	definitions_dictionary	0.8.3	definitions_dictionary	2020-04-12 18:14:53
a0149328-0a2f-42b1-8725-714233c40062	10	1	enduser_guide_doc	0.8.3	enduser_guide_doc	2020-04-12 18:14:53
12660a04-8e58-4094-acf2-477a58f524e8	11	1	export_files	0.8.3	export_files	2020-04-12 18:14:53
532a3298-e92d-4171-83fe-87402220f03a	12	1	features_doc	0.8.3	features_doc	2020-04-12 18:14:53
7a99c707-da32-43ac-88fb-475255ff6a56	13	1	goals	0.8.3	goals	2020-04-12 18:14:53
c26dd0e6-c934-4511-80ee-4e58406f47d0	14	1	his_quinquennially_issues	0.8.3	his_quinquennially_issues	2020-04-12 18:14:53
c8cb693b-1b96-49ff-8f24-6e4ea9dca2cb	15	1	ideas	0.8.3	ideas	2020-04-12 18:14:53
8683aa99-d848-4f36-99a9-0a6632a946d8	16	1	ideas_status	0.8.3	ideas_status	2020-04-12 18:14:53
aba02ad6-4d51-4ce7-8635-cad777b0e520	17	1	imgs	0.8.3	imgs	2020-04-12 18:14:53
33a1dc14-323f-4612-a899-6bc2c3518739	18	1	installations_doc	0.8.3	installations_doc	2020-04-12 18:14:53
8d2249c4-ec14-43e8-ac26-49699cd0cdff	19	1	issues_status	0.8.3	issues_status	2020-04-12 18:14:53
6c1c3bae-e51f-4fba-9f01-d41991d08be8	20	1	items_doc	0.8.3	items_doc	2020-04-12 18:14:53
4cd69b6b-a6ed-49f8-8a19-90fdf16201d7	21	1	app_items_roles_permissions	0.8.3	app_items_roles_permissions	2020-04-12 18:14:53
a2b659fc-5b8b-432e-a912-e3948eeee48a	22	1	links	0.8.3	links	2020-04-12 18:14:53
4e2523dc-8c74-4130-9c77-ed7a81ca456a	23	1	logs	0.8.3	logs	2020-04-12 18:14:53
60d46031-2164-42d6-b51c-16c0e801f5f1	24	1	maintenance_guide_doc	0.8.3	maintenance_guide_doc	2020-04-12 18:14:53
704c4d59-8cac-492f-a2d1-510e6dea888f	25	1	meta_cols	0.8.3	meta_cols	2020-04-12 18:14:53
3f839b5d-ad22-47d1-92df-e1cca19545fa	26	1	app_item_attributes	0.8.3	app_item_attributes	2020-04-12 18:14:53
1c1f8263-5451-42e1-aab6-7ba77a96d772	27	1	app_routes	0.8.3	app_routes	2020-04-12 18:14:53
c1773113-a314-4813-a1a3-15a10ad8bcc5	28	1	app_items	0.8.3	app_items	2020-04-12 18:14:53
384fbb48-3c4d-465f-b018-47797d2c674d	32	1	naming_conventions	0.8.3	naming_conventions	2020-04-12 18:14:53
44c0e077-1fc5-4719-afef-5d346458772e	33	1	nix_book_doc	0.8.3	nix_book_doc	2020-04-12 18:14:53
5b7a0d36-2c47-4bcf-91cf-9bb8a20627d6	34	1	onboarding_guide_doc	0.8.3	onboarding_guide_doc	2020-04-12 18:14:53
0b264bef-93c3-494a-a984-ef94ed673608	35	1	principles	0.8.3	principles	2020-04-12 18:14:53
7a51bf56-9a79-41af-b2be-bce883a5638c	36	1	problems	0.8.3	problems	2020-04-12 18:14:53
56278003-869f-431e-a607-7642bca24a61	37	1	questions	0.8.3	questions	2020-04-12 18:14:53
102898fb-2819-4608-85f4-1b1ff7417de3	38	1	questions_status	0.8.3	questions_status	2020-04-12 18:14:53
7612f252-e3f4-4327-be6a-3e57545a1cc4	39	1	quinquennially_issues	0.8.3	quinquennially_issues	2020-04-12 18:14:53
2ef44587-2708-45e5-9a7d-12dc49fc2c0a	40	1	quinquennially_issues_2020	0.8.3	quinquennially_issues_2020	2020-04-12 18:14:53
f6ab29ac-0dd6-4bc4-aa1e-9136bf6c0ecc	41	1	readme_doc	0.8.3	readme_doc	2020-04-12 18:14:53
35a80929-94ca-415a-83fe-abf2dee23c6f	42	1	release_issues	0.8.3	release_issues	2020-04-12 18:14:53
a94f0d86-3a73-470a-8fda-cb9f8239d62d	43	1	requirements_doc	0.8.3	requirements_doc	2020-04-12 18:14:53
6a418106-60b2-4ec9-a2e6-4fb9cec05499	44	1	app_roles	0.8.3	app_roles	2020-04-12 18:14:53
84ec1bac-94fc-43bd-9460-b20a8a89f360	45	1	security_checklist_doc	0.8.3	security_checklist_doc	2020-04-12 18:14:53
b73199d6-9942-433b-97ef-96bddebfae90	46	1	skills	0.8.3	skills	2020-04-12 18:14:53
3f69e913-d970-4b0a-8331-de1c6da38876	47	1	system_guide_doc	0.8.3	system_guide_doc	2020-04-12 18:14:53
efe9717d-ee1e-43d4-a5ee-abca2b8ad7fb	48	1	test_create_table	0.8.3	test_create_table	2020-04-12 18:14:53
140fbe29-60a2-44bd-8565-fc9bdb2e1e93	49	1	test_delete_table	0.8.3	test_delete_table	2020-04-12 18:14:53
dda6fa24-03d4-4ec5-ba5f-45266887db69	50	1	test_empty_table	0.8.3	test_empty_table	2020-04-12 18:14:53
7286578c-e718-4dde-adf5-0bf3c0679ab4	51	1	test_hi_create_table_doc	0.8.3	test_hi_create_table_doc	2020-04-12 18:14:53
6e9f4d86-977d-484b-ab11-0b37f6c3378e	52	1	test_hi_delete_table_doc	0.8.3	test_hi_delete_table_doc	2020-04-12 18:14:53
13eaf174-ed53-4fac-95a4-83c299a7c99e	53	1	test_hierarchy_doc	0.8.3	test_hierarchy_doc	2020-04-12 18:14:53
49f48fb0-b986-4b60-9ec1-b9b89751d083	54	1	test_item	0.8.3	test_item	2020-04-12 18:14:53
21f6a51f-185b-4a25-b8c3-6f02e302a7b5	55	1	test_truncate_table	0.8.3	test_truncate_table	2020-04-12 18:14:53
1ff08076-9d37-4317-a784-e0fb815f3609	56	1	test_update_table	0.8.3	test_update_table	2020-04-12 18:14:53
28dd337a-e57a-4db9-ab3c-8767501867bb	57	1	test_xls_to_db_table	0.8.3	test_xls_to_db_table	2020-04-12 18:14:53
a0be3c42-d2c0-4cd4-b17b-3bc499489f10	58	1	tst_paging	0.8.3	tst_paging	2020-04-12 18:14:53
48cfc41e-ec47-4c42-be7f-e22f40096051	59	1	app_user_roles	0.8.3	app_user_roles	2020-04-12 18:14:53
9fd98df3-711f-4f04-b187-88fe583efabe	61	1	userstories_doc	0.8.3	userstories_doc	2020-04-12 18:14:53
9d837a36-6aa5-42c7-8c4b-ac087c01d371	62	1	yearly_issues	0.8.3	yearly_issues	2020-04-12 18:14:53
d3886a74-83c0-4c1e-803e-5864c8c4d72b	63	1	yearly_issues_2018	0.8.3	yearly_issues_2018	2020-04-12 18:14:53
dc319bf8-8a77-4e4b-8b3a-0cea4fa3eaa4	64	1	yearly_issues_2019	0.8.3	yearly_issues_2019	2020-04-12 18:14:53
356056aa-cd4f-4e62-a61a-d06979a60591	200412203004	1	monthly_issues_202003	0.8.3	monthly_issues_202003	2020-04-12 18:14:53
7ff899c5-d9e2-44cb-99c6-eeb58498a668	30	1	monthly_issues_202001	0.8.3	monthly_issues_202001	2020-04-12 18:14:53
4ef7e5ff-145e-48c2-96fd-c085daa79b2d	200412203024	1	monthly_issues_202004	0.8.3	monthly_issues_202004	2020-04-12 18:14:53
38b4dde8-34d2-4261-92b8-d891b1bfd210	31	1	monthly_issues_202002	0.8.3	monthly_issues_202002	2020-04-12 18:14:53
ca053b66-acc3-4b25-8c53-d3b7ac825fc6	29	1	monthly_issues	0.8.3	monthly_issues	2020-04-12 18:14:53
bbe094a4-2255-45ef-af76-8880ead881c7	65	1	yearly_issues_2020	0.8.3	yearly_issues_2020	2020-04-12 18:14:56
bea09ac2-f835-43d3-9746-d5da2228d4b3	200419113429	1	problems_status	0.8.3	problems_status	2020-04-19 09:07:17
f9fecf76-c485-4cd8-8454-b25f0322d521	60	1	app_users	0.8.3	app_users	2020-04-19 21:08:56
39b3eba3-e262-4e06-872c-d3c5f6085075	200515003827	1	bugs	0.8.5	will hold the bugs in the system	2020-05-14 21:38:46
c6fe1378-0be4-41f5-9662-66983021816a	200511135541	1	app_items_doc	0.8.5	contins the howl menu ...	2020-05-11 10:55:56
c84a7013-19c8-470c-8f2d-c17b7d660fe6	200504204736	2	wow_doc	0.8.4	the way of working doc	2020-05-04 17:48:06
f5b4fd92-039b-46ec-a923-7d1638314373	200509025750	1	incidents	0.8.4	contains the incidents in the qto.fi system	2020-05-08 23:58:20
\.
