 ---- DROP TABLE IF EXISTS meta_routes ; 

SELECT 'create the "meta_routes" table'
; 
   CREATE TABLE meta_routes (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , has_predicate  bool NOT NULL default true
    , name           varchar (200) NOT NULL DEFAULT 'route-name...'
    , description    varchar (4000) DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_meta_routes_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_meta_routes_id on meta_routes (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.meta_routes'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_meta_routes BEFORE UPDATE ON meta_routes FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'meta_routes'::regclass;


--
-- TOC entry 3313 (class 0 OID 60445)
-- Dependencies: 270
-- Data for Name: meta_routes; Type: TABLE DATA; Schema: public; Owner: usrdevqtoadmin
--

COPY public.meta_routes (guid, id, prio, has_predicate, name, description, update_time) FROM stdin;
e86764c7-c25b-4391-a24b-d155f3b7032a	200228080831	1	t	truncate	The TRUNCATE route tells the qto Application Layer to truncate a whole item table 	2020-02-28 06:03:25
9b2bfd99-bedc-4c8d-8a89-1051a57386e7	200228153152	1	t	insert	The insert route tells the application layer to insert a row via post 	2020-02-28 13:27:38
e8b82d1b-fbd9-4a55-9119-2e757ec48bb9	200228153215	1	t	hiselect	The hiselect selects a hierarchical data from a hierarchichal table	2020-02-28 13:28:24
6dc3375f-781b-4d4f-8196-f18e1a75cc5c	200228153308	1	t	logon	The Logon routes logs on a user	2020-02-28 13:28:49
8b4aed40-bd21-431e-bc5c-a491177e05fb	200228153323	1	t	login	The login route provides the login functionality	2020-02-28 13:29:08
b2a70ed6-e7d0-42ce-8e61-9138031a0e23	200228080331	1	t	update	The UPDATE route tells the qto Application Layer to update a single value in a row of an item table from POST request provided json data	2020-02-28 05:59:08
8799afd6-5852-4e6d-a5e9-e8f8b07e23d4	200228153347	1	t	hicreate	The creation of a hierarchical row in the db	2020-02-28 13:30:04
891ef0ee-bbf5-41c9-82d4-cfbb5982a59a	200228080240	1	t	create	The CREATE route tells the qto Application Layer  to create a row in an item table from POST request with json data	2020-02-28 05:59:15
3f651cb4-0702-4dc6-8368-a1c7d1e45ba0	200228080425	1	t	delete	the DELETE route tells the qto Application Layer to delete a row in an item table from DELETE request provided json data	2020-02-28 05:59:51
4de2af7f-d23e-4f3c-a3e1-b84101cbf506	200228153439	1	t	hidelete	The deletion of hierarchical row in the db	2020-02-28 13:30:29
03432642-6bcd-4bbc-bc39-674062e4403f	200228080115	1	t	select	The SELECT route tells the qto Application Layer  to select the data of an item in json data format ( aka qto api compliant table )	2020-02-28 06:00:44
cc2ae685-01f8-4375-ae15-cf48b9b54e49	200228153513	1	t	select-meta	The retrieval of the meta-data for an item	2020-02-28 13:30:58
15b6523e-8e2c-45bf-bcc4-13bc8da1bf86	200228055434	1	t	list	The LIST route tells the qto Application Layer  to list in the qto UI the content of an item ( aka qto api compliant table )	2020-02-28 06:00:57
ff5202c2-aebf-4007-af6d-e287addb8f93	200228153538	1	t	export	The export of data for an item , for example export as xls	2020-02-28 13:31:22
1ec738f2-865c-433d-b5a0-6f5e67882659	200228080606	1	t	search	The SEARCH route tells the qto Application Layer  to display the search results in the qto UI, produced by querying all the item tables in the db	2020-02-28 06:02:06
e98492e3-73f4-4d82-86c6-1abc8174a0ac	200228080729	1	t	query	The QUERY route tells the qto Application Layer  to display the search results in json data format, produced by querying all the item tables in the db	2020-02-28 06:02:24
e0f2627a-e395-4f4a-a01a-793a2dde8bc8	200228153603	1	t	view	The viewing of a hierarchichal item in the view doc UI 	2020-02-28 13:31:49
\.
