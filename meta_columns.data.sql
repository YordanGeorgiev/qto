--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.8

-- Started on 2018-11-25 17:09:35 EET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3320 (class 0 OID 296998)
-- Dependencies: 205
-- Data for Name: meta_columns; Type: TABLE DATA; Schema: public; Owner: ysg
--

COPY public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, update_time) FROM stdin;
1aaeea54-5b28-4f15-ab2b-7dad52f459bd	181125150540	1	yearly_issues	name	\N	f	2018-11-25 17:05:40
1982d70f-b9b2-4461-b7d6-549c091c3d61	181125051422	1	meta_columns	update_time	\N	t	2018-11-25 16:14:33
253c36a0-b1c4-4bbc-aff0-dfe62688ce6a	181125065803	1	yearly_issues	update_time	\N	t	2018-11-25 16:58:17
a8b49506-8306-48e9-93a2-4789c80411e1	181125004502	1	yearly_issues	start_time	_	t	2018-11-25 16:37:34
2f45c255-7168-4369-b786-11ca1c9f5dcd	181125063726	1	yearly_issues	stop_time	\N	t	2018-11-25 16:39:15
1ce21c06-d7b3-45ae-a4f7-da96291d8050	181125063903	1	yearly_issues	planned_hours	\N	t	2018-11-25 16:39:42
206265e2-073d-43a4-81c7-2eb3d0cb8905	181125004525	1	meta_columns	guid	_	t	2018-11-25 16:07:11
195f237e-00e5-4b46-acba-d89ba7099296	181125063942	1	yearly_issues	seq	\N	t	2018-11-25 16:57:10
32681e08-31d8-425c-9f17-369561c0ed39	181125065700	1	yearly_issues	level	\N	t	2018-11-25 16:57:52
1af06c04-c8b7-4847-8bef-77b77546b520	181125065752	1	yearly_issues	actual_hours	\N	t	2018-11-25 16:58:01
\.


-- Completed on 2018-11-25 17:09:41 EET

--
-- PostgreSQL database dump complete
--

