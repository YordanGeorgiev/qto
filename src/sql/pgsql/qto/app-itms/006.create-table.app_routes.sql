-- \echo 'If necessary, perform DROP TABLE IF EXISTS app_routes;'

-- \echo '6. Creating the app_routes table'

CREATE TABLE app_routes (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           smallint NOT NULL DEFAULT 1
    , is_open        bool NOT NULL default true
    , is_open_in     bool NOT NULL default false
    , has_subject    bool NOT NULL default true
    , is_backend     bool NOT NULL default true
    , name           varchar (200) NOT NULL DEFAULT 'Route name'
    , description    varchar (4000) DEFAULT ''
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_routes_guid PRIMARY KEY (guid)
    );

CREATE UNIQUE INDEX idx_uniq_app_routes_id
	ON app_routes (id);

-- \echo 'List columns of the created table app_routes'
SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_routes'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_routes
	BEFORE UPDATE ON app_routes
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_routes'::regclass;


--
-- TOC entry 3313 (class 0 OID 60445)
-- Dependencies: 270
-- Data for Name: app_routes; Type: TABLE DATA; Schema: public; Owner: usrdevqtoadmin
--

COPY public.app_routes (guid, id, prio, is_open, is_open_in, has_subject, is_backend, name, description, update_time) FROM stdin;
9b2bfd99-bedc-4c8d-8a89-1051a57386e7	200228153152	1	f	f	t	t	insert	The insert route tells the application layer to insert a row via post 	2020-05-13 17:28:08
e86764c7-c25b-4391-a24b-d155f3b7032a	200228080831	1	f	f	t	t	truncate	The TRUNCATE route tells the qto Application Layer to truncate a whole item table 	2020-05-13 17:28:08
4de2af7f-d23e-4f3c-a3e1-b84101cbf506	200228153439	1	f	f	t	t	hidelete	The deletion of hierarchical row in the db	2020-05-13 17:28:08
3f651cb4-0702-4dc6-8368-a1c7d1e45ba0	200228080425	1	f	f	t	t	delete	the DELETE route tells the qto Application Layer to delete a row in an item table from DELETE request provided json data	2020-05-13 17:28:08
03432642-6bcd-4bbc-bc39-674062e4403f	200228080115	1	f	f	t	t	select	The SELECT route tells the qto Application Layer  to select the data of an item in json data format ( aka qto api compliant table )	2020-05-13 17:28:08
8799afd6-5852-4e6d-a5e9-e8f8b07e23d4	200228153347	1	f	f	t	t	hicreate	The creation of a hierarchical row in the db	2020-05-13 17:28:08
b2a70ed6-e7d0-42ce-8e61-9138031a0e23	200228080331	1	f	f	t	t	update	The UPDATE route tells the qto Application Layer to update a single value in a row of an item table from POST request provided json data	2020-05-13 17:28:08
e0f2627a-e395-4f4a-a01a-793a2dde8bc8	200228153603	1	f	f	t	f	view	The viewing of a hierarchichal item in the view doc UI 	2020-05-13 17:28:08
ff5202c2-aebf-4007-af6d-e287addb8f93	200228153538	1	f	f	t	t	export	The export of data for an item , for example export as xls	2020-05-13 17:28:08
891ef0ee-bbf5-41c9-82d4-cfbb5982a59a	200228080240	1	f	f	t	t	create	The CREATE route tells the qto Application Layer  to create a row in an item table from POST request with json data	2020-05-13 17:28:08
05a29477-e337-4f63-8003-38a0f0ba4c01	200403234321	1	f	f	t	t	call-func	the back-end call of the report route°	2020-05-13 17:28:08
e8b82d1b-fbd9-4a55-9119-2e757ec48bb9	200228153215	1	f	f	t	t	hiselect	The hiselect selects a hierarchical data from a hierarchichal table	2020-05-13 17:28:08
8b4aed40-bd21-431e-bc5c-a491177e05fb	200228153323	1	t	t	f	f	login	The login route provides the login functionality	2020-05-13 19:18:01
77096ddd-4eb4-4dfb-ac13-2ad20a041e19	200404002417	1	t	t	f	t	select tables	lists all the tables in the project database	2020-05-13 19:15:55
e98492e3-73f4-4d82-86c6-1abc8174a0ac	200228080729	1	f	t	f	t	query	The QUERY route tells the qto Application Layer  to display the search results in json data format, produced by querying all the item tables in the db	2020-05-13 19:16:23
6dc3375f-781b-4d4f-8196-f18e1a75cc5c	200228153308	1	t	t	f	f	logon	The Logon routes logs on a user	2020-05-13 19:18:15
1ec738f2-865c-433d-b5a0-6f5e67882659	200228080606	1	f	t	f	f	search	The SEARCH route tells the qto Application Layer  to display the search results in the qto UI, produced by querying all the item tables in the db	2020-05-13 19:15:58
0f34e0b1-743c-4ad5-a391-f8f7a119a9b6	200403233318	1	t	t	t	t	serve	The routes serving errors and warnings from redirects such as 403 forbidden	2020-05-13 19:15:26
e7506dcd-3c2d-4b44-a126-45cd47deb8a0	200502002643	1	f	f	t	t	select-my	select only the records belonging to the logged in user	2020-05-13 19:15:34
cc2ae685-01f8-4375-ae15-cf48b9b54e49	200228153513	1	f	t	t	t	select-item-meta-for	The retrieval of the meta-data for an item	2020-05-13 19:15:38
81167627-8853-4ca1-ae9e-171890e80098	200309203853	1	f	f	t	f	report	The route used for calling reports ( which are postgres result set returning functions)	2020-05-13 19:16:02
9b6dbcd5-da0d-4d36-be4c-e1944dd03d94	200403234539	1	t	t	f	t	select-databases	list the databases in the configured postgres server to the AL	2020-05-13 19:15:45
07c0cbb7-07e4-477e-8ec3-d80e76a2ab3c	200502002514	1	f	f	t	f	list-my	list only the records belonging to the logged in user	2020-05-13 19:16:39
15b6523e-8e2c-45bf-bcc4-13bc8da1bf86	200228055434	1	f	f	t	f	list	The LIST route tells the qto Application Layer  to list in the qto UI the content of an item ( aka qto api compliant table )	2020-05-13 19:17:13
1854a713-d29e-4abd-9c29-0b27d08ebea2	200513223249	1	f	f	t	t	select-col	selects ONLY a single column from a table ...	2020-05-13 19:33:40
\.
