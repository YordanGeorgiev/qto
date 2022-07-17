-- DROP TABLE IF EXISTS issues_status ;

SELECT 'create the "issues_status" table'
;
   CREATE TABLE issues_status (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint)
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (4000)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_issues_status_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_issues_status_id on issues_status (id);

-- the rank search index
CREATE INDEX idx_rank_issues_status ON issues_status
USING gin(to_tsvector('English', name || ' ' || description || 'owner'));


SELECT 'Display the columns of the just created table'
;

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.issues_status'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ;


-- Data for Name: issues_status; Type: TABLE DATA; Schema: public; Owner: usrdevqtoadmin
--

COPY public.issues_status (guid, id, name, description, update_time) FROM stdin;
ab989a14-d0b8-46e4-b2cc-5e2a974b5d29	200226071624	01-eval	The issue is being evaluated	2020-02-26 07:16:45
14ae9eac-e6df-4193-9d36-a527d5897292	200226092430	02-todo	The issues has to be done	2020-02-26 07:17:02
a0b9476b-7eb0-4045-b172-91c8635859d0	200226092448	03-wip	The issue is in Work in Progress	2020-02-26 07:17:16
152ccaad-89a4-4e5e-bb1b-6859ab3472f4	200226092506	04-diss	The must be discarded	2020-02-26 07:17:36
b9224b60-506a-457c-8303-27345b5a5a09	200226092521	05-tst	The issue is being tested	2020-02-26 07:17:48
9594f01f-92ef-48da-9319-57792ac8142f	200226092532	06-onhold	The issue has been put on hold	2020-02-26 07:17:59
345ee85b-570c-4661-b8f4-cd39f5d5ff76	200226092543	07-qas	The issues  is being tested for quality	2020-02-26 07:18:16
01ecf204-43d5-4ac5-aa5f-f1a0eee1ad53	200226092559	08-post	The issue is being postponed for completion in later point of time 	2020-02-26 07:18:56
f486d2d7-0789-4af2-8466-9b8c03743d85	200226092640	09-done	The issue has been done	2020-02-26 07:19:08
a36ac35d-d010-41ce-84f0-31ba5d808aa8	200226093618	03-act	The issues is being actively worked on 	2020-02-26 07:30:54
\.

--The trigger:
CREATE TRIGGER trg_set_update_time_on_issues_status BEFORE UPDATE ON issues_status FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'issues_status'::regclass;
