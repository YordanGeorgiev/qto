--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.8

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
-- Data for Name: benchmarks; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('9146c784-0a2c-4fdc-9796-36d7a60cef62', 181101161022, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 16:10:22', '2018-11-01 16:11:16', 0.009098, '000 00:00:54', 0.00, 54.00, 0.00, 'desc...', '2018-11-01 16:11:31');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('38ffbace-f44a-44b1-a981-da420a71a6fa', 181101180408, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 18:04:08', '2018-11-01 18:05:01', 0.008249, '000 00:00:53', 0.00, 53.00, 0.00, 'desc...', '2018-11-01 18:05:16');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('a84d16c3-0d17-494e-a5d3-94eef7fac87c', 181102120803, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 12:08:03', '2018-11-02 12:09:03', 0.015079, '000 00:01:00', 1.00, 60.00, 0.02, 'desc...', '2018-11-02 12:09:18');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('fb103c1f-abc9-43a8-9f1f-3877499be94a', 181101225544, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 22:55:44', '2018-11-01 22:56:38', 0.008665, '000 00:00:54', 0.00, 54.00, 0.00, 'desc...', '2018-11-01 22:56:53');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('818e8a82-d89f-493d-b5ea-fe295793f035', 181101205858, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 20:58:58', '2018-11-01 20:59:55', 0.012127, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-01 21:00:10');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('9db03b22-2188-42a0-8104-106b4186bd08', 181102142527, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:25:27', '2018-11-02 14:26:23', 0.011382, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-11-02 14:26:38');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('06cd3816-081c-4b53-addd-b424cca5ebb4', 181101225718, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 22:57:18', '2018-11-01 22:58:13', 0.010793, '000 00:00:55', 0.00, 55.00, 0.00, 'desc...', '2018-11-01 22:58:29');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('cf57bfbd-ce1b-4d7a-aef2-e798e40550e6', 181101210522, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 21:05:22', '2018-11-01 21:06:17', 0.010228, '000 00:00:55', 0.00, 55.00, 0.00, 'desc...', '2018-11-01 21:06:32');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('9bcf882d-8117-41b2-9486-843bd0c68a4f', 181102133223, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 13:32:23', '2018-11-02 13:33:20', 0.011616, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-02 13:33:35');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('6c91c6da-79d7-4790-a407-4103d0cabb76', 181101210706, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 21:07:06', '2018-11-01 21:08:06', 0.014549, '000 00:01:00', 1.00, 60.00, 0.02, 'desc...', '2018-11-01 21:08:21');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('4435fac0-5288-4358-a4a4-ccdf448f6bdd', 181102134307, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 13:43:07', '2018-11-02 13:44:04', 0.011495, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-02 13:44:19');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('57ce6c04-d232-4e54-8d8c-12840c43dffc', 181101225846, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 22:58:46', '2018-11-01 22:59:40', 0.008905, '000 00:00:54', 0.00, 54.00, 0.00, 'desc...', '2018-11-01 22:59:55');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('a5cb4a2e-3a7b-4f12-ab49-47739a9e0417', 181101225408, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 22:54:08', '2018-11-01 22:55:04', 0.010755, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-11-01 22:55:19');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('7d023615-d884-47ee-93fb-d6989d6ba84e', 181102133401, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 13:34:01', '2018-11-02 13:35:00', 0.013711, '000 00:00:59', 0.00, 59.00, 0.00, 'desc...', '2018-11-02 13:35:15');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('da021dbc-5039-4ed6-b54d-b732b6f22889', 181102115121, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 11:51:21', '2018-11-02 11:52:18', 0.011889, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-02 11:52:33');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('c9fb1f26-9f6c-453e-9a3a-a25f3c082f19', 181102142659, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:26:59', '2018-11-02 14:27:58', 0.014628, '000 00:00:59', 0.00, 59.00, 0.00, 'desc...', '2018-11-02 14:28:14');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('52457973-6fa1-4050-b2ed-128962161650', 181102142351, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:23:51', '2018-11-02 14:24:54', 0.017643, '000 00:01:03', 1.00, 63.00, 0.02, 'desc...', '2018-11-02 14:25:09');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('01494235-3c0c-4f0c-bff2-c9acf9931fff', 181102134123, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 13:41:23', '2018-11-02 13:42:19', 0.011471, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-11-02 13:42:34');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('7dc3d194-cfba-4cd0-9ad0-ce0b03f26798', 181102143717, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:37:17', '2018-11-02 14:38:17', 0.014817, '000 00:01:00', 1.00, 60.00, 0.02, 'desc...', '2018-11-02 14:38:24');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('9b93b62b-3725-4b54-a5b3-124b53b57dd7', 181102150556, 'eea37511', 'after the git_hash_addition', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:05:56', '2018-11-02 15:06:52', 0.011034, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-11-02 15:07:22');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('41ad7580-1300-45eb-965a-0b3bb0dbad3e', 181102144454, NULL, '        try with local materal fonts', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:44:54', '2018-11-02 14:45:53', 0.013781, '000 00:00:59', 0.00, 59.00, 0.00, 'desc...', '2018-11-02 15:21:44');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('d952fd56-9f1b-4648-a739-12cdaac3c1c4', 181102152729, '5fb4d86a', 'after the git_hash_addition', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:27:29', '2018-11-02 15:28:28', 0.013653, '000 00:00:59', 0.00, 59.00, 0.00, 'desc...', '2018-11-02 15:28:58');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('bedb33b9-3800-4cfe-8e83-a098dcfd5ec7', 181102145613, NULL, '        try with local materal fonts', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:56:13', '2018-11-02 14:57:11', 0.012579, '000 00:00:58', 0.00, 58.00, 0.00, 'desc...', '2018-11-02 15:21:36');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('6cf60419-ccf6-47d3-81d4-aedcb65b0901', 181102145253, NULL, '        try with local materal fonts', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:52:53', '2018-11-02 14:53:51', 0.012957, '000 00:00:58', 0.00, 58.00, 0.00, 'desc...', '2018-11-02 15:21:41');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('21d12ee6-3f3f-4ca1-8d63-06d543f3c4c2', 181102144714, NULL, '        try with local materal fonts', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 14:47:14', '2018-11-02 14:48:11', 0.011361, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-02 15:21:49');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('f1aea172-d00c-4288-aab8-9373c19c8a4b', 181102152155, '5fb4d86a', 'with sbt test NOT running ... in intra behind proxy', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:21:55', '2018-11-02 15:22:53', 0.012381, '000 00:00:58', 0.00, 58.00, 0.00, 'desc...', '2018-11-02 15:27:12');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('b9dc48fd-bbb2-42dc-b902-5af70e89124a', 181102151133, '5fb4d86a', 'sbt test running at the same time in intra behind proxy', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:11:33', '2018-11-02 15:12:38', 0.020650, '000 00:01:05', 1.00, 65.00, 0.02, 'desc...', '2018-11-02 15:34:17');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('d0ada3f5-bcc6-41b3-867d-2a4213120fd2', 181102182419, '1eacd923', 'without vuetify dependencies - adjusted new and del buttons', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 18:24:19', '2018-11-02 18:25:20', 0.016537, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-02 19:40:35');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('1791142d-5f8e-4c6f-b4b4-351eedbcd153', 181102153319, '5fb4d86a', 'after css link in body', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:33:19', '2018-11-02 15:34:20', 0.016014, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-02 15:34:50');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('019dbc52-667c-4543-a134-ad25a7ad163d', 181102153841, '5fb4d86a', 'with normal css link', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:38:41', '2018-11-02 15:39:40', 0.014082, '000 00:00:59', 0.00, 59.00, 0.00, 'desc...', '2018-11-02 16:18:10');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('d8914e21-21fa-4f49-ba01-d9c803d30e2b', 181102153509, '5fb4d86a', 'after css link in body __', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:35:09', '2018-11-02 15:36:09', 0.014810, '000 00:01:00', 1.00, 60.00, 0.02, 'desc...', '2018-11-02 16:18:12');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('32eb87c0-ebdc-4380-a5fd-1daae1a809c1', 181102162149, '5fb4d86a', 'without vuetify dependencies', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 16:21:49', '2018-11-02 16:22:50', 0.015825, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-02 19:40:37');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('1f7b0d94-cae2-479d-899f-d502671b7913', 181102182159, '1eacd923', 'without vuetify dependencies - adjusted new and del buttons', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 18:21:59', '2018-11-02 18:23:00', 0.014921, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-02 19:40:36');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('c9e801ac-d01a-4b0a-997f-98cf55729055', 181102154136, '5fb4d86a', 'with normal css link', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 15:41:36', '2018-11-02 15:42:34', 0.012888, '000 00:00:58', 0.00, 58.00, 0.00, 'desc...', '2018-11-02 19:40:39');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('22ce172d-5b32-4d4d-9ae5-4de038451ff4', 181102162605, '5fb4d86a', 'without vuetify dependencies', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 16:26:05', '2018-11-02 16:27:02', 0.012347, '000 00:00:57', 0.00, 57.00, 0.00, 'desc...', '2018-11-02 19:40:37');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('b685ef1b-80be-492b-a71d-92eb1e059727', 181128221649, '57757e43', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-28 22:16:49', '2018-11-28 22:17:50', 0.015888, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-28 22:24:16');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('1b52649b-2831-4da0-95f6-865ff947bacb', 181128194850, '57757e43', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid', '2018-11-28 19:48:50', '2018-11-28 19:50:06', 0.030534, '000 00:01:16', 1.00, 76.00, 0.02, 'desc...', '2018-11-28 19:50:36');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('77f92bcc-c5bb-41df-987c-0eed51f54059', 181128194905, '57757e43', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-28 19:49:05', '2018-11-28 19:50:15', 0.025004, '000 00:01:10', 1.00, 70.00, 0.02, 'desc...', '2018-11-28 22:24:24');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('25e15f13-4a12-46f2-932e-5a2a6567d636', 181102182656, '1eacd923', 'without vuetify dependencies - adjusted new and del buttons', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 18:26:56', '2018-11-02 18:27:52', 0.010626, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-11-28 19:49:17');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('50f7c6ec-c211-4f15-8a97-7dc042817114', 181102184006, '541bb182', 'without vuetify dependencies - adjusted new and del buttons', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-02 18:40:06', '2018-11-02 18:41:14', 0.022197, '000 00:01:08', 1.00, 68.00, 0.02, 'desc...', '2018-11-28 19:48:36');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('5af72340-ef9a-430a-8a79-66330a6e76b5', 181225140835, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/view/devops_guide', '2018-12-25 14:08:35', '2018-12-25 14:09:29', 0.009111, '000 00:00:54', 0.00, 54.00, 0.00, 'desc...', '2018-12-25 14:09:59');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('e5d71753-5307-48d0-8d8f-bbb3419055b4', 181128221049, '57757e43', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-28 22:10:49', '2018-11-28 22:11:50', 0.016708, '000 00:01:01', 1.00, 61.00, 0.02, 'desc...', '2018-11-28 22:24:19');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('e5fe3fea-eb41-4b20-87f7-76647a0ec51a', 181225140631, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/view/devops_guide', '2018-12-25 14:06:31', '2018-12-25 14:07:25', 0.008385, '000 00:00:54', 0.00, 54.00, 0.00, 'desc...', '2018-12-25 14:07:55');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('30098e5d-16ff-4f80-a9a8-d53f034cf734', 181128222455, '57757e43', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-28 22:24:55', '2018-11-28 22:25:58', 0.018327, '000 00:01:03', 1.00, 63.00, 0.02, 'desc...', '2018-11-28 22:26:28');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('1b518787-80d5-4358-b9e7-ee9a54753234', 181225135852, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues', '2018-12-25 13:58:52', '2018-12-25 13:59:54', 0.014538, '000 00:01:02', 1.00, 62.00, 0.02, 'desc...', '2018-12-25 14:00:24');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('7ec79c8c-43c0-478a-b0fc-c7e7d6fc93df', 181225141025, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/view/userstories', '2018-12-25 14:10:25', '2018-12-25 14:11:20', 0.010435, '000 00:00:55', 0.00, 55.00, 0.00, 'desc...', '2018-12-25 14:11:50');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('05375654-d355-4e81-8f06-acca8e6c1acd', 181225141456, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues', '2018-12-25 14:14:56', '2018-12-25 14:15:51', 0.010030, '000 00:00:55', 0.00, 55.00, 0.00, 'desc...', '2018-12-25 14:16:21');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('f4197606-ba4f-4e6f-9018-ddc0aa287557', 181101160725, '        ', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,category,status,prio,weight,name,description&page-size=7&page-num=1', '2018-11-01 16:07:25', '2018-11-01 16:08:20', 0.010047, '000 00:00:55', 0.00, 55.00, 0.00, 'desc...', '2018-12-25 14:13:39');
INSERT INTO public.benchmarks (guid, id, git_hash, name, url, start_time, stop_time, avg_ua_load_time, diff_time, diff_min, diff_sec, diff_hours, description, update_time) VALUES ('9ff41a09-6fb6-41c5-aa88-817d39757325', 181225141647, 'b73df371', 'url average page load', 'http://192.168.56.120:3001/dev_issue_tracker/list/yearly_issues', '2018-12-25 14:16:47', '2018-12-25 14:17:43', 0.010404, '000 00:00:56', 0.00, 56.00, 0.00, 'desc...', '2018-12-25 16:52:53');


--
-- Data for Name: check_lists; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('7aed5ade-c47e-4454-9854-1908d38c5634', 181017212250, NULL, 1, '02-todo', 'cat', 'name', 'desc', '2018-10-17 21:22:50');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('ee4b8303-435f-467e-8b28-fab1175805df', 180801162744, 1, 5, '02-todo', 'before-merge-into-develop', 'The feature or functionality current description is added in the Features doc', 'The feature or functionality current description is added in the Features and Functionalities document. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('472418b5-5d46-4d4b-b29e-f650220d5027', 180801162753, 7, 5, '02-todo', 'before-merge-into-develop', 'Deployment to the test environment', 'Deploy to the test environment as follows:', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('555a37f9-911d-49a4-a9e1-9d8986de958c', 180801162755, 9, 5, '02-todo', 'before-merge-into-develop', 'Apply run-state changes. ', 'Restart the application layer. Well just chain the both commands. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('ce96b091-48f4-4b22-aa64-3c0b14371753', 180801162745, 2, 5, '02-todo', 'before-merge-into-develop', 'The related requirement is added in the requirements document', 'The related requirement is added in the requirements document - there might be one or more requirements added. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('fb19662c-2106-41dd-a3b1-b7659e5b4673', 180801162746, 2, 5, '02-todo', 'before-merge-into-develop', 'The implementation code matches the naming and coding conventions described in the DevOps Guide', 'Check the instructions from the DevOps Guide ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('31030104-b6c3-42a2-b8e3-e57653962895', 180801162747, 2, 5, '02-todo', 'before-merge-into-develop', 'All the commits start with their respective issue-id''s', 'Each commit must be the simpliest logical unit of code, data or documentation added to the project which could be described by the commit msg', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('de389411-d9ad-4a45-bda5-49aac7ad5577', 180801162748, 2, 5, '02-todo', 'before-merge-into-develop', 'Back-End tests exist with maximum test coverage', 'The different control flow paths are described in the Features and Functionalities document', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('7fa0471c-e0ac-471d-9462-7b7083a189b3', 180801162749, 2, 5, '02-todo', 'before-merge-into-develop', 'Front-End tests exist with maximum test coverage', 'The different control flow paths are described in the Features and Functionalities document', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('4c74155a-e19c-4d4f-b1d2-8bc3874f5f1c', 180801162750, 3, 5, '02-todo', 'before-merge-into-develop', 'At least 2 times passed integration tests run in each environment instance', 'At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment by issuing the  -a run-integration-tests shell action.
Should the run behave differently start all over from dev. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('573dd438-189c-4ee4-adf8-4af7c3770df6', 180801162751, 5, 5, '02-todo', 'before-merge-into-develop', 'Aim for simplicity - is there anything to be refactored left ?!', 'Things should be as simple as possible, but not simpler - if Einstein said it it makes sense - having lost so much time in endless loops of IT complexity - the older we get the more it gets more rational. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('60b9b05f-7dbf-4d2b-8a37-da951babd2e0', 180801162752, 6, 5, '02-todo', 'before-merge-into-develop', 'Do not allow broken windows', 'A broken windows is any peace of code or documentation which is hanging around not included in the integration tests suite and not matching the most up-to-date standars for work deliverables. Either bring it up to the standard level or get rid of it. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('f53b4655-f443-4486-aad7-4479e64de759', 180801162756, 9, 1, '02-todo', 'before-merge-into-develop', 'do you really feel confortable before merging this branch into develop ?!', 'That is you feel sure that the feature or functionality does what it is supposed to be doing', '2018-09-26 22:22:19');


--
-- Data for Name: concepts; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('b0ab98aa-183d-4476-b7ae-84d2d658bcdb', 0, 0, 1, 1, 38, 0, '03-active', 'ISSUE-TRACKER CONCEPTS', NULL, '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('53b36b2d-3790-4598-8025-943015b5fdac', 9, 2, 10, 17, 18, 5, '09-done', 'Projects management', 'You can manage multiple projects with the issue-tracker tool. Each project has its own data directories, database storage and configurations. You could also have different envornments named dev,tst,prd for each project separately. 
As the tool is backwards compatible you could have differrrent instances of the issue-tracker projects with different versions ( and set of features ) operatiing against differrent project ( each one in its own version).
You must pre-set the configuration variables of an issue-tracker project each time you start working on a project from the shell', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('9ea140f4-ba21-4b7b-af71-8eb822243dd2', 10, 2, 11, 19, 20, 5, '09-done', 'Increase the date for all projects', 'to increase the date for all the projects at once use the following oneliner.', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('32fd6d87-7e31-42a9-8147-d280c32111e1', 11, 2, 12, 21, 28, 5, '09-done', 'Issues / Issue items / items', 'Issue item is the shortest possible description of task , activity , note or anything requiring distinguishable and prerferable measurable action or producing verfifiable outcome.
Issues could be of different types - tasks, activities, notes etc. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('2e236b6b-1f43-4027-8c0f-e658c886c722', 12, 3, 13, 22, 23, 5, '09-done', 'Categories', 'Each issue item could be categorized under one and only one category. One category might have 1 or more issues. 
The categories could contain letters ,numbers, dashes', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('a672d3ea-d0ee-44f9-8f84-c8eab5d95d24', 13, 3, 14, 24, 25, 5, '09-done', 'Issues status', 'You could define whatever statuses you like. As issue-tracker has been built to develop itself ( how sarcastic could that be ;o), that is for tracing the progress of a software project the following "default" statuses have been used: 
01-eval - for evaluate the issue
02-todo - for decided to do the issue
03-wip - for the issue is being in work in progress mode
04-diss - for discard the issue
05-tst - for the issue is being in testing like mode
06-onhold - for the issue is being kept onhold for the time period
07-qas - for the issue is being quality assured 
09-done - for the issue is being done / completed. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('a4750f30-8147-4869-882d-da1db2c83b07', 14, 3, 15, 26, 27, 5, '09-done', 'Issues management via time intervals', 'The issues are basically organised into the following periods:
 - daily
 - weekly
 - monthly
 - yearly
 - quinquennially
 - decadally

So that in the end of each previous time period you could go trough the issues of that period and transfer up and down in the time scale. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('f868349c-10c7-43af-96ce-88d44abf4d35', 15, 2, 16, 29, 30, 5, '09-done', 'Problems', 'Sometimes during the workings of your project you encounter problems, which are complex enough not to allows the definition of an issue. In those cases it would be more rational to just register the problem, discuss it or review it later on, and define the issue as soon as the problem domain is understood and even possible issue solution could be proposed', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('f868349c-10c7-43af-96ce-88d44abf4d31', 16, 2, 17, 31, 32, 5, '09-done', 'Questions', 'Sometimes during the workings of your project you might be simply asking questions, which are complex enough not to allows the definition of an issue. In those cases it would be more rational to just register the question, discuss it or review it later on, and define the issue(s) addressing this question later on. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('7f66d7f0-9e94-4273-8713-46b829360fab', 181230184021, 1, 18, 34, 37, 1, 'status ...', 'DEFINITIONS', 'This section contains definitions of terms within the context of the Issue-Tracker application.', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('ae777985-0235-4235-a64d-91c3482aba2f', 181230183647, 2, 19, 35, 36, 1, '03-act', 'release', 'An issue-tracker release is the artifact you can download from the following GitHub page:
https://github.com/YordanGeorgiev/issue-tracker/releases
The word is also used for the actual release of the latest source code into a working instance available in the web ... ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('3b0cf10b-6fa8-43c8-839f-cee6b340ea72', 1, 1, 2, 2, 9, 0, '03-active', 'INTRO', NULL, '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('8bfa3fef-fb64-4b5a-b74a-b64456423ae9', 2, 2, 3, 3, 4, 0, '03-active', 'Purpose', 'The purpose of this document is to present the concepts and the business logic of the Issue-Tracker application for this current version.', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('d262374e-452d-47a3-8814-bbd7dda1f6dd', 3, 2, 4, 5, 6, 0, '03-active', 'Audience', 'This document could be of interest for any potential and actual users of the application. Keyusers must read, understand and even be able to present and explain the contents of this document. 
Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('d2f1862b-b80c-473e-800b-e046db94993f', 4, 2, 5, 7, 8, 0, '03-active', 'Related documentation', 'This document is part of the Issue-Tracker application documentation-set, which contains the following documents:
 - UserStories - the collection of userstories used to describe "what is desired"
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - Features and Functionalities - description of the current features and functionalities

All the documents should be updated and redistributed in combination of the current version of the application and should be found under the following directories:
doc/md
doc/pdf
doc/xls
according to the file format used for the documentation storage.', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('cbfc90dd-31c9-44e1-af9d-0422c343c765', 5, 1, 6, 10, 15, 0, '03-active', 'CORE CONCEPTS', NULL, '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('86d0be9e-a341-4544-b91e-cd8cb99eca0f', 6, 2, 7, 11, 12, 0, '03-active', 'Time intervals based time-management', 'The time rules our lifes. Issue-tracker is aimed to help you and your organisation to manage your time and resources in the best possible way YOU CAN. You must make sure that you clearly define and state your issues and update their information based on the events from the real world.', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('6475d465-3440-411b-9a1b-19a0a64042fe', 7, 2, 8, 13, 14, 0, '03-active', 'Personal responsibility', 'You should assign 0 or 1 persons responsible for an issue at a time. Of course if you keep tool long an issue to be assigned to nobody it simply means that you are not fully committed to its completion. ', '2018-12-30 18:47:44');
INSERT INTO public.concepts (guid, id, level, seq, lft, rgt, prio, status, name, description, update_time) VALUES ('e47d1958-ffbb-4d27-bf40-4a94a65079d6', 8, 1, 9, 16, 33, 5, '09-done', 'BUSINESS LOGIC', NULL, '2018-12-30 18:47:44');


--
-- Data for Name: confs; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('b95795e1-9931-4299-8c6d-524b65928470', 181207003138, NULL, NULL, 'ui', 'prd env hypno url', 'http://192.168.56.120:8080/dev_issue_tracker/list/confs?as=grid&page-num=1&page-size=7', 'Note the port is 8080', '2018-12-07 00:32:24');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('f416784d-6f96-47e2-a56f-5a24619154ec', 181207003036, NULL, NULL, 'ui', 'tst environment ui', 'http://192.168.56.120:3002/tst_issue_tracker/list/confs?as=grid&page-num=1&page-size=7', 'Note the port is 3002', '2018-12-07 00:33:06');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('6092a34a-6dfc-4823-801e-2a1fc0e71c9c', 181207003341, NULL, NULL, 'ui', 'web tst env url', 'http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:3002/tst_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', 'Note the 3002 port and the tst_ prefix for the db name ', '2018-12-07 00:35:26');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('d67f734d-63ba-4c93-926c-8c6926b850b8', 181207003111, NULL, NULL, 'ui', 'prd env ui morbo url', 'http://192.168.56.120:3003/prd_issue_tracker/list/confs?as=grid&page-num=1&page-size=7', 'Note the port is 3003', '2018-12-07 00:33:11');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('3767b0e4-4fc3-42d7-b3f2-7499c2276b12', 181207003654, NULL, NULL, 'ssh', 'the loal path to the key-pair file in amzn', '/home/ysg/key-pair-issue-tracker.pem', NULL, '2018-12-07 00:37:24');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('f830eb66-abbd-4039-9184-54a89a9560c3', 181207003442, NULL, NULL, 'ui', 'web prd env url', 'http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', 'Note the 8080 port and the prd_ db', '2018-12-07 00:35:39');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('471f3615-a9f0-4ff0-b792-8378c104337b', 181207003014, NULL, NULL, 'ui', 'dev env web url', 'http://192.168.56.120:3001/dev_issue_tracker/list/confs?as=grid&page-num=1&page-size=7', 'Note the port is 3001', '2018-12-07 00:31:04');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('7ef8ca5d-5491-4ec9-83fa-efac2ad75cb6', 181207003224, NULL, NULL, 'ui', 'web dev env web url', 'http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:3001/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', 'Note the port is 3001 and the db name starts with dev_', '2018-12-07 00:33:59');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, update_time) VALUES ('307d90d2-f890-4183-af2b-c481006b0ac2', 181207003538, NULL, NULL, 'ssh', 'the ssh server ', 'ec2-34-243-97-157.eu-west-1.compute.amazonaws.com', 'the ssh server to access to deploy the back-end of the issue-tracker application ', '2018-12-07 00:36:52');


--
-- Data for Name: daily_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.daily_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ffbd7ff-734d-4173-ac6a-a06ae325bd48', 181222121718, NULL, NULL, 'task', 9, 'category ...', '02-todo', 2, 'hae Vesalasta sen matkahuollon paketin', 'https://www.google.com/maps/place/Rekipellontie+2,+00970+Helsinki/@60.2379826,25.0923548,15z/data=!4m5!3m4!1s0x469208b2fdc43389:0xdb66317290dbd8f7!8m2!3d60.2383287!4d25.1002834', 'unknown', '2018-12-22 13:30:00', '2018-12-22 13:30:00', NULL, NULL, NULL, '2018-12-22 12:21:04');
INSERT INTO public.daily_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbb3822d-3afa-462c-ab42-0e17f6db89bf', 181222122033, NULL, NULL, 'task', 9, 'category ...', '03-wip', 5, 'coding', NULL, 'unknown', '2018-12-22 10:30:00', '2018-12-22 11:30:00', NULL, NULL, NULL, '2018-12-22 12:22:05');
INSERT INTO public.daily_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4b90980-162e-443b-8054-272509d11ff3', 181222122041, NULL, NULL, 'task', 9, 'category ...', '02-todo', 5, 'tarkista saisiko kuusen jalka', NULL, 'unknown', '2018-12-22 12:20:41', '2018-12-22 12:20:41', NULL, NULL, NULL, '2018-12-22 12:22:11');
INSERT INTO public.daily_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4c3c9d0-6681-474a-88d7-1c6dfd699312', 181222122004, NULL, NULL, 'task', 9, 'category ...', '02-todo', 1, 'kuusen haku ', 'Tammisto:sta kuusen haku', 'unknown', '2018-12-22 12:20:04', '2018-12-22 12:20:04', NULL, NULL, NULL, '2018-12-22 12:26:31');


--
-- Data for Name: decadally_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.decadally_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c941aed6-f74e-42e5-bc81-874ecc311175', 181017212604, NULL, NULL, 1, 9, '02-todo', 'cat', 'name', 'desc', 'task', 'ysg', '2018-10-17 21:26:04', '2018-10-17 21:26:04', NULL, NULL, NULL, '2018-10-17 21:26:37');
INSERT INTO public.decadally_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a276d737-5a69-4897-912e-4a8877b67ca7', 180817105624, NULL, NULL, 1, 9, '03-act', 'cat', 'up-and-running aws instance', 'up-and-running aws instance', 'task', 'unknown', '2018-07-15 00:00:00', '2020-01-01 00:00:00', NULL, NULL, NULL, '2018-10-04 19:08:07');
INSERT INTO public.decadally_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8c482ac4-2097-4ccf-89ea-141e54c2bcef', 181004190758, NULL, NULL, 1, 9, '02-todo', 'cat', 'everything is bright and shine', NULL, 'task', 'unknown', '2018-10-04 19:07:58', '2018-10-04 19:07:58', NULL, NULL, NULL, '2018-10-04 19:10:42');


--
-- Data for Name: devops_guide; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('07846f37-53eb-46ba-8eff-982f4265c9c8', 0, 0, 1, 1, 158, 0, '03-active', 'content', 'ISSUE-TRACKER DEVOPS GUIDE', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('9298b6f7-7f90-4d5b-b768-364e6f78f4a6', 71, 2, 72, 141, 142, 5, '09-done', 'content', 'Deployment to the test environment', 'Deploy to the test environment as follows:', '# deploy to the tst environment
bash src/bash/issue-tracker/issue-tracker.sh -a to-tst

# go to the product instance dir of the tst env for this version
cd ../issue-tracker.<<version>>.tst.<<owner>>
', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('2cf91f0b-49eb-48fe-a608-f4e094279614', 7, 2, 8, 13, 14, 5, '03-active', 'principle', 'Aim for simplicity', 'Things should be as simple as possible, but not simpler - if Einstein said it it makes sense - having lost so much time in endless loops of IT complexity - the older we get the more it gets more rational. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('921ca14f-5454-43fd-a924-048973d1aa0b', 77, 3, 78, 152, 153, 5, '03-wip', 'content', 'Probable root cause', 'This one occurs quite often , especially when the application layer is restarted, but the server not ', '# the error msg is 
 [INFO ] 2018.09.14-10:23:14 EEST [issue-tracker][@host-name] [4426] running action :: mojo-morbo-start:doMojoMorboStart
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp        0      0 0.0.0.0:3001            0.0.0.0:*               LISTEN      6034/issue_tracker
tcp        0      0 0.0.0.0:3002            0.0.0.0:*               LISTEN      7626/issue_tracker
Can''t create listen socket: Address already in use at /usr/local/share/perl/5.26.0/Mojo/IOLoop.pm line 130.
 [INFO ] 2018.09.14-10:23:16 EEST [issue-tracker][@host-name] [4426] STOP FOR issue-tracker RUN with:
 [INFO ] 2018.09.14-10:23:16 EEST [issue-tracker][@host-name] [4426] STOP FOR issue-tracker RUN: 0 0 # = STOP MAIN = issue-tracker
issue-tracker-dev ysg@host-name [Fri Sep 14 10:23:16] [/vagrant/opt/csitea/issue-tracker/issue-tracker.0.4.9.dev.ysg] $', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('c4205d19-2d72-43fd-aacc-f0bc5f46d996', 20, 1, 21, 40, 45, 5, '09-done', 'content', 'BACKUP AND RESTORE', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('5fb075cd-2bce-4dae-92ad-b58a53bbf239', 23, 1, 24, 46, 65, 5, '09-done', 'content', 'USAGE SCENARIOS', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('ce1004a1-c057-4277-88f0-a1fb9a63e0e1', 68, 3, 68, 135, 136, 5, '03-wip', 'content', 'The related requirement is added in the requirements document', 'The related requirement is added in the requirements document - there might be one or more requirements added. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('3359556f-1188-417a-8c83-871d8ebdf9fd', 17, 3, 18, 32, 33, 5, '09-done', 'content', 'start the application layer', 'To start the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern ', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start

bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('faf7426e-2d41-4567-bcc9-baeac111e711', 18, 3, 19, 34, 35, 5, '09-done', 'content', 'stop the application layer', 'To stop the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern ', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop

bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('47ed5b2d-9778-4776-9973-df46bc5a0280', 25, 2, 26, 49, 50, 5, '05-teest', 'content', 'Run increase-date action', 'You track the issues of your projects by storing them into xls files in "daily" proj_txt dirs. 
Each time the day changes by running the increase-date action you will be able to clone the data of the previous date and start working on the current date. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a increase-date', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('c6d2d3e8-1146-4678-9019-5e0168d0613d', 28, 2, 29, 55, 56, 5, '09-done', 'content', 'Load xls issues to db and from db to txt files', 'to load xls issues to db and from db to txt files', 'bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt 

# or run for all the periods
for period in `echo daily weekly monthly yearly`; do export period=$period ; 
bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt ; done ;', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('28a2add9-16a6-4985-9cd8-88fe5aa69bf4', 9, 1, 10, 18, 39, 5, '09-done', 'content', 'MAINTENANCE AND OPERATIONS', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('ddb21bd7-771a-434b-bca1-3c25eb45118b', 10, 2, 11, 19, 30, 5, '09-done', 'content', 'RDBMS Run-state management', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('4e3ac575-f6b3-42a6-be85-6e3b774322ef', 11, 3, 12, 20, 21, 5, '09-done', 'content', 'To check the status of the postgreSql', 'To check the status of the postgreSql issue:', 'sudo /etc/init.d/postgresql status', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('577261ad-e131-4518-8eac-806a5b1073b1', 12, 3, 13, 22, 23, 5, '09-done', 'content', 'To stop the postgreSql', 'To stop the postgreSql issues:', 'sudo /etc/init.d/postgresql stop', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('4b8db6d6-105d-4ca7-b27f-ed7866e57e4f', 13, 3, 14, 24, 25, 5, '09-done', 'content', 'To start the postgreSql', 'To start the postgreSql issues:', 'sudo /etc/init.d/postgresql start', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('705f93dd-17b2-46d3-bf59-35f8505d9206', 73, 3, 74, 145, 146, 5, '09-done', 'content', 'restart the application layer', 'Well just chain the both commands. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('3e70debf-5a9a-42c4-a7df-3ab98dd141cd', 36, 1, 37, 72, 89, 5, '03-active', 'content', 'SOURCE CODE MANAGEMENT', 'The issue-tracker is a derivative of the wrapp tool - this means that development and deployment process must be integrated into a single pipeline. ', NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('b150530a-20f3-4f9a-9d68-a2198923cd9f', 39, 2, 40, 77, 78, 5, '03-active', 'content', 'Feature development in a feature branch', 'You start the development in your own feature branch named : dev--<<issue-id>>-<<short-and-descriptive-name>>.', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('e8941343-1891-4f5a-b6a4-f98ae47f7fed', 32, 2, 33, 63, 64, 5, '09-done', 'content', 'Run the http://<<web-host>>:<<web-port>>/<<proj-db>>/get/<<table>>/<<guid>> route', 'Load a table with guid''s.
Check a single item with your browser, for example:
http://doc-pub-host:3000/dev_stockit_issues/get/companies/727cf807-c9f1-446b-a7fc-65f9dc53ed2d', '# load the items
while read -r f; do 
export xls_file=$f; 
bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db  ; 
done < <(find $proj_txt_dir -type f)

# verify the data
psql -d $db_name -c "SELECT * FROM company_eps "', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('1c393dde-6b13-406b-88be-52ceeb7f6950', 26, 2, 27, 51, 52, 5, '02-todo', 'content', 'Run xls-to-db action', 'You insert the date of the daily , weekly , monthly or yearly issues from the daily input excel file(s) by running the xls-to-db action. 
If you have the guid column with uuid''s than this will be upsert and not bare insert.
You should be able to update only non-nullable column by reducing the number of columns in your xls sheet.', '
export do_truncate_tables=1 ;
bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('29f7929d-b723-4aa9-bda6-ff87721427af', 27, 2, 28, 53, 54, 5, '09-done', 'content', 'Run db-to-txt action', 'The db-to-txt action converts your db tables into txt files by using "smart" formatting rules. This feature is deprecated and should work only for tables having the same attributes set as the "issues" tables. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('a4a1d7ea-9a03-4e17-b45f-1598015b3a07', 61, 2, 62, 121, 122, 5, '06-onhold', 'content ', 'Unit and / or integration test creation', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('bfd1e7c9-deb6-4641-bbc5-65334a8da9cf', 66, 2, 67, 131, 132, 5, '03-wip', 'content', 'DoD check-list walkthrough', 'Perform the DoD checklist as follows', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('57f1eb5d-fe54-4dfe-ab64-6f8380f8ca5c', 72, 3, 73, 143, 144, 5, '09-done', 'content', 'Check that all the files in the deployment package are the same as those in the latest commit of the dev git branch. ', 'Deploy to the test environment as follows:', '# deploy to the tst environment
bash src/bash/issue-tracker/issue-tracker.sh -a to-tst

# go to the product instance dir of the tst env for this version
cd ../issue-tracker.<<version>>.tst.<<owner>>
', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('11c0316d-ff10-4700-93ee-5a5f5da5eef4', 8, 2, 9, 15, 16, 5, '03-active', 'principle', 'Do not allow broken windows', 'A broken windows is any peace of code or documentation which is hanging around not included in the integration tests suite and not matching the most up-to-date standars for work deliverables. Either bring it up to the standard level or get rid of it. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('6f0c6f91-3736-4cb8-aa74-cd7d74014e1a', 69, 3, 71, 137, 138, 5, '03-wip', 'content', 'At least 2 times passed unit tests run in each environment instance', 'At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment. Should the run behave differently start all over from dev. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('06040e35-400a-41dc-9c75-e46ef5786334', 30, 2, 31, 59, 60, 5, '09-done', 'content', 'Verify the inserted data from the db', 'Verify the inserted data from the db as follows:', '# check that the rows where inserted
echo ''SELECT * FROM issue ; '' | psql -d dev_issue_tracker', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('e7adb0c1-cf34-4639-b317-8262e4febb5f', 1, 1, 2, 2, 17, 1, '03-active', 'principle', 'GUIDING PRINCIPLE''S', 'This section might seem too philosophical for a start, yet all the development in the issue-tracker has ATTEMPTED to follow the principles described bellow. If you skip this section now you might later on wander many times why something works and it is implemented as it is ... and not "the right way". 
Of course you are free to not follow these principles, the less you follow them the smaller the possibility to pull features from your instance(s) - you could even use the existing functionality to create a totally different fork with different name and start developing your own toll with name X - the authors give you the means to do that with this tool ... , but if you want to use and contribute to THIS tool than you better help defined those leading principles and follow them. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('39618340-cb12-4fc5-89b6-0f0aea7ad251', 48, 2, 49, 95, 96, 5, '07-qas', 'content', 'Definition of Done', 'Each issue must have a tangible artifact. An issue without tangible artifact is a thought thrown in the air.
The DoD must be iterated and updated during each Sprint Review. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('eab492a2-4430-4b2e-b023-e913be0f02a5', 4, 2, 5, 7, 8, 1, '03-active', 'principle', 'It should just work', 'Any instance of the issue-tracker should simply work as promised. No less no more. 
Any instance is the combination of code, configurations, binaries in the System and data - that is the instance you are using should just work for the set of functionalities promised. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('5c0a3d44-8941-4c1b-8981-232fd2411f2b', 37, 2, 38, 73, 74, 5, '03-active', 'content', 'Aim for traceability between user-stories, requirements, features and functionalities', 'Once the issues are defined and you start working on your own branch which is named by the issue-id aim to map one on one each test in your code with each listed requirement in confluence and / or JIRA. ', NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('ac172c1c-c11f-434c-8184-257cf860905e', 78, 3, 79, 154, 155, 5, '03-wip', 'content', 'Known solution and workaround', 'List the running perl processes which run the morbo and kill the instances', 'ps -ef | grep -i perl

# be carefull what to kill 
kill -9 <<proc-I-know-is-the-one-to-kill>>', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('1afa67ed-6364-4722-90b4-c55e30deb285', 3, 2, 4, 5, 6, 3, '03-active', 'principle', 'Attempt for 100% test coverage to achieve reliability', 'The more you increase your test coverage the greater the confidence that the code will work as expected. 
Do not write a single function without first implementing the testing call for that function - this has been proven really, really difficult, yet the more features are added the less the time wasted in troubleshooting of bugs and un-expected behavior when proper testing is implemented. 
Testing ensures the consistency and future expandability of the functionalities. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('4e3f3807-bc4c-40ed-8863-099be90a30c2', 40, 2, 41, 79, 80, 5, '05-test', 'content', 'ALWAYS Start with a test unit creation', 'Do not ever never write code without starting first the unit test on how-to test the code. Period. 
This is he only way to avoid braking old functionalities when the application code base grows larger. 
Each time a new bug is found fix it by adding new Unit Test!', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('98cd420e-e223-4c68-9618-8a45dfec565e', 41, 2, 42, 81, 82, 5, '03-wip', 'content', 'Branch for development - dev', 'No code should be merged into the development branch without broad testing coverage and approval from the owner of the instance - as the owner of the instance is at the end responsible personally for the whole instance. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('0cf759bf-bc83-4308-9f0b-94b4b929537c', 42, 2, 43, 83, 84, 5, '03-wip', 'content', 'Testing and integrations in the tst branch', 'The tst branch is dedicated for testing of all the tests, the deployment, performance testing and configuration changes. Should you need to perform bigger than a small hotfix changes you must branch the tst branch into a separate dev--feature branch and re-run the integration testing and approval all over. 
At the end all the integration tests should be behind this shell call. ', 'export issue_tracker_project=""; bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('8c33ed61-1689-4983-ad42-81585380337e', 43, 2, 44, 85, 86, 5, '03-wip', 'content', 'Quality assurance in the qas branch', 'At this phase all the tests with all the expected functionalities should work at once. No small hotfixes are allowed - if a need arises new branch is created to the tst branch The quality assurance', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('e111742c-8745-43ee-bb42-10ef8d926db4', 44, 2, 45, 87, 88, 5, '03-wip', 'content', 'Production in the prd branch', 'The prd branch is the one deployed to the production environment. This code is NOT straight merged into the master branch , but after certain time depending on the dynamic of the tool with bugless operation merged. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('9009fccd-3f07-4fe4-a75d-8956f39f4ced', 47, 1, 48, 94, 103, 5, '09-done', 'installation', 'WAY OF WORKING', 'This section describes the way of working within a team working on the issue-tracker project. 
The work on the issue-tracker project is conducted by using the Scrum methodology, thus the Scrum', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('d12c3a82-d8d7-4b28-9a96-179c7101f716', 75, 2, 76, 149, 156, 5, '03-wip', 'content', 'Known issues and workarounds', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('95bac57d-c595-4212-a370-e7b406373488', 50, 2, 51, 99, 100, 5, '09-done', 'content', 'Chat / IRC', 'Should you want a quicker respond than 2 hours use thre chat tool', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('e5f1d8eb-b15a-4573-b79c-982c9cb87739', 33, 1, 34, 66, 71, 5, '09-done', 'installation', 'NAMING CONVENTIONS', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('98d3c397-ab7a-4383-904c-ac95471d5c99', 46, 2, 47, 91, 92, 5, '09-done', 'content', 'A small team project hours tracking scenario', 'This scenario describes the steps and processes, which could be implemented to achieve a small team ( 3-10 ) members issue-tracking with hours reporting by using the issue-handler combined with Google Cloud authentication and storage.', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('2f7bc874-6aaa-40b8-8efc-dfa543dca875', 51, 2, 52, 101, 102, 5, '02-todo', 'content', 'Documentation', 'Undocumented feature is not a feature. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('3da4e6e9-c0f3-4b83-bbcf-c02457ef6e8a', 19, 3, 20, 36, 37, 5, '09-done', 'content', 'Restart OS network service', 'Sometimes you might just need to restart the whole network service on Ubuntu:', 'sudo /etc/init.d/networking restart', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('c00dbc85-3fb8-4dd6-bc6b-8d5bd898b17a', 21, 2, 22, 41, 42, 5, '09-done', 'content', 'Backup a database', 'You backup a database with the following one-liner. Noe ', '# obs you have to have the shell vars pre-loaded !!!
# clear; doParseCnfEnvVars <<path-to-cnf-file>>
bash src/bash/issue-tracker/issue-tracker.sh -a backup-postgres-db', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('6e227f56-3e85-4d21-b593-2d316911f2a8', 22, 2, 23, 43, 44, 5, '09-done', 'content', 'Restore a database', 'You restore a database by first running the pgsql scripts of the project database and than restoring the insert data ', '# obs you have to have the shell vars pre-loaded !!!
# clear; doParseCnfEnvVars <<path-to-cnf-file>>

bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
psql 

psql -d $postgres_db_name < dat/mix/sql/pgsql/dbdumps/dev_issue_tracker/dev_issue_tracker.20180813_202202.insrt.dmp.sql', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('9a51a5dd-99a3-4926-854a-6e6d783643c7', 24, 2, 25, 47, 48, 5, '09-done', 'content', 'Shell based actions usage', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('371d56f2-8c60-47f1-8dd1-7e5179f89c36', 49, 2, 50, 97, 98, 5, '09-done', 'content', 'E-mail communication', 'Do not use e-mail communication for code style, testing, developing etc. Issues which could be achieved with the code review interface of the source code management system. 
Before writing an e-mail think first could you find a way to avoid writing it at all. 
Do not expect answer of your e-mail within 2 hours. 
Use e-mail when you have to get an written evidence on agreed matters, which might cause later on discussions. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('109b051e-dd9b-42a0-abdf-b53ccda4a27f', 52, 1, 53, 104, 147, 5, '09-done', 'installation', 'FEATURE IMPLEMENTATION WORKFLOW', 'This section describes the common workflow for implementing a feature. 
As in other places the main principle to follow is "use common sense" , thus try to follow this workflow for feature implementation, but challenge it as soon as it defies the common sense. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('c4a4047c-04e6-47b6-af44-6e5f1d883158', 15, 3, 16, 28, 29, 5, '09-done', 'content', 'Check the postgres status', 'Check the postgres status.
Check the port to which the postres is running with this command:', 'sudo /etc/init.d/postgresql status

# restart if needed
sudo /etc/init.d/postgresql restart

# check on which ports it is runnning
sudo netstat -plunt |grep postgres', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('7505fe5c-42f8-4fd1-a5dd-d04fc7570bfe', 31, 2, 32, 61, 62, 5, '09-done', 'content', 'web based routes usage', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('adad52eb-f61c-4d0d-b06d-52c53f7e6e4f', 34, 2, 35, 67, 68, 5, '09-done', 'content', 'Dirs naming conventions', 'The dir structure should be logical and a person navigating to a dir should almost understand what is to be find in thre by its name .. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('ee30ebc8-67f7-44fb-aace-7dd88a6ed109', 35, 2, 36, 69, 70, 5, '09-done', 'content', 'Root Dirs naming conventions', 'The root dirs and named as follows:
bin - contains the produced binaries for the project
cnf - for the configuration
dat - for the data of the app
lib - for any external libraries used
src - for the source code of the actual projects and subprojects', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('87af7824-1ae1-4e7a-a256-657c36f3e8dc', 53, 2, 54, 105, 106, 5, '06-onhold', 'content', 'Issue creation', 'Even if you do not have a defined documentation artifact - create a new issue, which could be the start for a an action affecting the run-state, configuration , data , features and functionalities or other aspects of the issue-tracker application. 
An issue could be a bug, a request for a feature or even simply an undefined combination of problems and solution which could quickly be formalized by defining a new requirement, another issue, feature-request', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('43ded518-600b-45c2-894a-1605a8cf65f0', 54, 2, 55, 107, 108, 5, '06-onhold', 'content', 'User-Story creation', 'Use the following template while creating the user story:
As an <<role>>
In order to <<achieve something>> 
I wanto to be able <<action-description>> ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('5f7389f9-4cb2-4265-9ae0-58e66935af67', 55, 2, 56, 109, 110, 5, '06-onhold', 'content', 'Requirements creation', 'Define a formal requirement as soon as possible. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('7491a9f7-c9a5-4cb1-a216-9fa02de78827', 56, 2, 57, 111, 112, 5, '06-onhold', 'content', 'Problem registration', 'Problems are usually entities which last for longer time period. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('c47ecbb7-4b66-4fea-96db-31bc99ccfbbc', 67, 3, 69, 133, 134, 5, '03-wip', 'content', 'The feature or functionality current description is added in the docs', 'The feature or functionality current description is added in the Features and Functionalities document. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('0cd7dfac-4709-429b-8d3f-be5a9db2132f', 57, 2, 58, 113, 114, 5, '06-onhold', 'content', 'Feature branch creation', 'Create the feature branch by using the following naming convention:
 - dev--<<short-feature-title>>', ' git branch -a
* dev
dev--it-18050801-add-order-by-in-select-ctrlr
master
prd
tst
remotes/origin/dev
remotes/origin/master
', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('beaba2c9-0296-4faa-9f5e-8a752def8f80', 58, 2, 59, 115, 116, 5, '06-onhold', 'content', 'Create a test-entry point', 'Even the smallest proof of concept needs a small test-entry point. Start always with the testing and the testing scalability in mind. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('75ff2252-9f54-4e93-a1d3-8231e1fd6eb5', 5, 2, 6, 9, 10, 4, '03-active', 'principle', 'Naming conventions', 'All the names used in the code and the configurations MUST BE human readable and expandable - that is name the objects from the greater realm to the smaller - for example <<env>>_<<db_name>> , because the concept of operational IT environments ( dev , test , qas , prd ) is broader than the concept of a application databases ... ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('fa664811-6d50-4bd0-b80b-715f892186ec', 59, 2, 60, 117, 118, 5, '06-onhold', 'content', 'Implementation of Proof of Concept', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('2111a512-e2bf-44a2-bf78-b6613d078cc9', 60, 2, 61, 119, 120, 5, '06-onhold', 'content', 'Prototype implementation', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('2bd2f995-aa21-460a-9e5b-929a91142919', 14, 3, 15, 26, 27, 5, '09-done', 'content', 'to check the port on which it is listening ', 'To check the port on which it is listening issue:', 'sudo netstat -tulntp | grep -i postgres
# tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      8095/postgres', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('b2b57549-b6f9-4664-9ab2-bd711ec1b023', 16, 2, 17, 31, 38, 5, '09-done', 'content', 'Application Layer run-state management', NULL, NULL, 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('5bc0db72-49cd-4a69-acd1-2cec6535ce34', 62, 2, 63, 123, 124, 5, '09-done', 'content', 'Implementation ', 'Implement by quick unit test runs. Constantly improve both the code , configuration changes and the test code. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('bbf869a7-f127-4d2d-a1af-2cd51bfbb8bb', 63, 2, 64, 125, 126, 5, '03-wip', 'content', 'Deployment and test to the test environment', 'Deploy to the test environment. ', '# deploy to the tst environment
bash src/bash/issue-tracker/issue-tracker.sh -a to-tst

# go to the product instance dir of the tst env for this version
cd ../issue-tracker.<<version>>.tst.<<owner>>
# run the integration tests
bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-integration-tests
', NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('d07e6106-7504-4a6d-89df-7caffd4dee1a', 64, 2, 65, 127, 128, 5, '03-wip', 'content', 'Deployment and test to the production environment', 'Repeat the same to the production environment. As the current version is usually work in progress your stable version will be one level bellow and thanks to the architecture of the tool you could test in the production environment ( as soon as you have proper configuration ) ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('99a25ddf-d21c-4462-99d5-9faea1c100be', 74, 1, 75, 148, 157, 5, '09-done', 'content', 'SYSTEM ADMINISTRATION AND MAINTENANCE OPERATIONS', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('527c05cd-fbcf-4a91-ac56-b075128b7ef7', 65, 2, 66, 129, 130, 5, '03-wip', 'content', 'Quality assurance iteration', 'This phase might be longer depending on the feature. Some of the features stay in quality assurance mode EVEN if they have been deployed to production ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('8d72ac6e-2fe5-4c9c-9725-988a35c3e8ba', 6, 2, 7, 11, 12, 5, '03-active', 'principle', 'Be user-friendly to all', 'Especially to technical personnel, as you cannot achieve user-friendliness for the end-users unless your developers and technical personnel are happy while interacting with your artifacts. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('3a311aaa-7ad7-4b21-9dac-47f6a0bc9ee8', 70, 2, 70, 139, 140, 5, '03-wip', 'content', 'At least 2 times passed integration tests run in each environment instance', 'At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment. Should the run behave differently start all over from dev. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('40d27e5f-956a-44ba-b97e-29f69ce32938', 45, 1, 46, 90, 93, 5, '09-done', 'installation', 'SCENARIOS', NULL, NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('1c645778-0859-4132-aafb-91b79e9fddcc', 38, 2, 39, 75, 76, 5, '03-active', 'content', 'Zero tolerance for bugs', 'As soon as bugs are identified and reproduceable, register them as issues and resolve them with prior 1.
After resolution, think about the root cause of the bug, the mear fact that the bug occurred tells that something in the way of working has to be improved , what ?!
Bugs are like broken windows the more you have them the faster the value of your building will be down to zero. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('cb0d5120-7414-4903-9174-6b2579fdeba0', 2, 2, 3, 3, 4, 1, '03-active', 'principle', 'Personal responsibility', 'Any given instance of the issue-tracker should have ONE and only ONE person which is responsible at the end for the functioning of THIS instance - so think carefully before attempting to take ownership for an instance. The author(s) of the code are not responsible for the operation, bugs or whatever happens to a new instance. As a responsible owner of an instance you could create, share and assign issues to the authors of the source code, yet there is no service level agreement, nor even promise to help. ', NULL, NULL, '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('3b7ef7be-2a3c-4da9-8d1c-8e1920d03989', 29, 2, 30, 57, 58, 5, '09-done', 'content', 'Run the issue-tracker file to db load', 'Run the issue-tracker file to db load ', '# ensure the following actions will be tested
cat src/bash/issue-tracker/tests/run-issue-tracker-tests.lst | grep -v ''#''
# output should be if not correct
check-perl-syntax
run-issue-tracker

# test those uncommented actions
bash src/bash/issue-tracker/test-issue-tracker.sh', 'bash', '2018-12-27 18:29:15');
INSERT INTO public.devops_guide (guid, id, level, seq, lft, rgt, prio, status, type, name, description, src, runtime, update_time) VALUES ('8c2e8a2f-8740-4cb2-8741-0c2ec8fef460', 76, 3, 77, 150, 151, 5, '03-wip', 'content', 'Morbo is stuck', 'This one occurs quite often , especially when the application layer is restarted, but the server not ', '# the error msg is 
 [INFO ] 2018.09.14-10:23:14 EEST [issue-tracker][@host-name] [4426] running action :: mojo-morbo-start:doMojoMorboStart
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp        0      0 0.0.0.0:3001            0.0.0.0:*               LISTEN      6034/issue_tracker
tcp        0      0 0.0.0.0:3002            0.0.0.0:*               LISTEN      7626/issue_tracker
Can''t create listen socket: Address already in use at /usr/local/share/perl/5.26.0/Mojo/IOLoop.pm line 130.
 [INFO ] 2018.09.14-10:23:16 EEST [issue-tracker][@host-name] [4426] STOP FOR issue-tracker RUN with:
 [INFO ] 2018.09.14-10:23:16 EEST [issue-tracker][@host-name] [4426] STOP FOR issue-tracker RUN: 0 0 # = STOP MAIN = issue-tracker
issue-tracker-dev ysg@host-name [Fri Sep 14 10:23:16] [/vagrant/opt/csitea/issue-tracker/issue-tracker.0.4.9.dev.ysg] $', NULL, '2018-12-27 18:29:15');


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9bd460fc-ae6c-4833-a0bc-7b52030eaec0', 0, 0, 1, 1, 282, 5, 5, '09-done', 'ISSUE TRACKER FEATURES, FUNCTIONALITIES AND CAPABILITIES', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('5ad6702a-f3e9-4954-8e64-9f6359e6d828', 9, 2, 10, 17, 24, 5, 5, '03-act', 'Support for different projects', 'You could access multiple projects by accessing their project databases as the first URI path component provided that the web server has tcp access to those databases. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('a0493281-6425-4060-9f9b-b3cadf2ee659', 99, 3, 100, 196, 197, 9, 1, '09-done', 'Error handling on non-existing db', 'If the db provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d4986bf7-a88e-4406-9ed6-fb584bd4e29a', 100, 3, 101, 198, 199, 9, 1, '09-done', 'Error handling on non-existing table', 'If the table provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('04614ba8-fee1-47cd-9489-3b285671e3f4', 101, 3, 102, 200, 201, 9, 1, '09-done', 'Error handling on non-existing attribute ', 'If the attribute(column) provided in the post data does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('8a1328a2-6d2d-485c-9a2a-f89c6c08e643', 102, 3, 103, 202, 203, 9, 1, '09-done', 'Error handling on wrong data-type', 'Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.
', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('afbea977-d528-4e2a-8441-9f0af367b03a', 103, 3, 104, 204, 205, 9, 1, '09-done', 'Automatic upate_time attribute update', 'Any item having the update_time attribute will get its value automatically based on the update time of the transaction. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('80aab444-04be-4d03-ab58-46afe5f8bbd9', 104, 2, 105, 207, 214, 9, 1, '09-done', 'delete web action', 'An http client could create  a new row into ANY table by passing a bigint as the id.', '<<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7b24fb2e-7c93-4995-9896-64a423cca0fe', 105, 3, 106, 208, 209, 9, 1, '09-done', 'Successful execution', 'Once the post call is executed the item is deleted from the db.', '<<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
// example data
{attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4dc1239a-8f53-4d0e-b54e-da1885fa62d0', 106, 3, 107, 210, 211, 9, 1, '09-done', 'Error handling on non-existing db', 'If the db provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f9b38e5e-4da2-4c37-b58b-30b10916f390', 107, 3, 108, 212, 213, 9, 1, '09-done', 'Error handling on non-existing table', 'If the table provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('12ea6f73-ca5e-4499-8d5a-fe5b73e9c457', 108, 2, 109, 215, 260, 5, 5, '09-done', 'select web action', 'An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to ( ie not only the one configured in the application layer but also other databases in the same postgres instance)  by using the following syntax:', '<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9352edeb-8623-4c3f-a642-55f4e91543f9', 10, 3, 11, 18, 19, 5, 5, '03-act', 'Change projects via url', 'The following 2 different databases are actually the tst and dev databases of the issue-tracker, but of course the database names could be any valid other database names:

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/tst_issue_tracker/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

Note the upper left corner of the page contains the name of your current project database. ', '# access the issue-tracker''s project development database
http://host-name:3000/dev_issue_tracker/list/monthly_issues

# access the issue-tracker''s project testing database
http://host-name:3000/tst_issue_tracker/list/monthly_issues

# access the aspark-starter project production database
http://host-name:3000/prd_aspark_starter/list/monthly_issues', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('ac8a79af-9114-42e6-86eb-9bc29f7c0190', 109, 3, 110, 216, 217, 5, 5, '09-done', 'successful execution', 'An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2d4a665c-79c4-41d2-a492-ae7ca8fbc03a', 110, 3, 111, 218, 219, 5, 5, '09-done', 'apply multiple operators on the select properly', 'All the operators bellow could be combined and the result set is the one "translated" with the AND operator in the back-end side. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4be211ea-a200-4849-982a-3013f70ffd79', 111, 3, 112, 220, 221, 5, 5, '09-done', 'error handling for failed connect to db in the select web action', 'If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 
', '// 20180503234141
// http://192.168.56.120:3000/non_existent/select/daily_issues

{
  "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
  "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('8d750499-4911-416c-ae81-b3415d13b5ef', 112, 3, 113, 222, 223, 5, 5, '09-done', 'error handling for non-existent table in the select-tables web action', 'if a table does not exist a proper error msg containing response is generated.
', '// 20180505205015
// http://192.168.56.120:3000/dev_issue_tracker/select/non_existent

{
  "msg": " the table non_existent does not exist in the dev_issue_tracker database ",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/non_existent",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('1f89454a-1801-423d-9784-9477973d05fc', 113, 3, 114, 224, 231, 5, 5, '09-done', 'filter functionality in select table web action', 'The response cold be filtered by ANY attribute with any valid value. 
', '// using the following syntax:
<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?fltr-by=<<filter-attribute-to-filter-by>>&fltr-val=<<filter-value-to-filter-by>>', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7803bf1f-8557-455b-9d4a-d422a41272b5', 114, 4, 115, 225, 226, 5, 5, '09-done', 'successful execution', 'The response of the select web action could be filtered by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 

', '// 20180505204531
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio&fltr-val=1

{
  "dat": {
    "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
      "actual_hours": null,
      "category": "issue-tracker-features",
      "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
      "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
      "id": 180402,
      "level": 2,
      "name": "add the web select controller",
      "owner": "ysg",
      "planned_hours": "3.00",
      "prio": 1,
      "seq": 1,
      "start_time": "2018-04-02 18:00",
      "status": "07-qas",
      "stop_time": null,
      "tags": "feature",
      "type": "feature",
      "update_time": "2018-05-04 23:18:45.104771"
    }
  },
  "msg": "SELECT OK for table: monthly_issues",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio&fltr-val=1",
  "ret": 200
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c71d93de-f178-485a-844f-fe8d226628a4', 115, 4, 116, 227, 228, 5, 5, '09-done', 'error handling for wrong filtering syntax by missed fltr-by or fltr-va url params', 'If the request does not have either one of the url params the following response is produced. 
', '// 20180505204734
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio

{
  "msg": "mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d6561095-c965-4658-a5dc-0350093e75ab', 116, 4, 117, 229, 230, 5, 5, '09-done', 'error handling for non-existent filter name', 'If the syntax is correct but an non-existent filtering attribute is provided ( that is the table columns and the attribute name do not match ) the following error msg is returned: 
', '// 20180506220030
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj

{
  "msg": "the foo column does not exist",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9', 117, 3, 118, 232, 237, 5, 5, '09-done', 'Use pick url param functionality in select table web action', 'Works for both a single colum and a comma separated select of columns. Obeys the following syntax:
', '// using the following syntax:
<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?pick=col1,col2,col3', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('5523996a-d53e-49f0-a3f6-02564dee7e1f', 118, 4, 119, 233, 234, 5, 5, '09-done', 'successful execution', 'if the request contains the "pick" url parameter only the picked column values are selected. 
', '// 20180506230955
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=name,prio

{
  "dat": {
    "0daa3447-42f5-4792-aca2-bd1cb06e2a78": {
      "guid": "0daa3447-42f5-4792-aca2-bd1cb06e2a78",
      "name": "define REST API response structure",
      "prio": 3
    },
    "3c3aff5d-8246-4893-acc4-4853904f1d40": {
      "guid": "3c3aff5d-8246-4893-acc4-4853904f1d40",
      "name": "add the pick in url to select in db reader control flow for Select.pm controller",
      "prio": 3', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('b72e0a92-a7ca-4882-9c83-b611ca16a13d', 11, 3, 12, 20, 21, 5, 5, '03-act', 'Switch projects by the :to operator in the search-box', 'If you type the ":to <<database-name>>" you will get a drop down which will list the projects databases , to which your instance has access to, by chosing the database from the list and hitting enter you will be redirected to the same url by on the different database.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('fd3e2d4e-99a1-4cd8-8ebe-bb47f9de9caf', 119, 4, 120, 235, 236, 5, 5, '09-done', 'error handling if a picked column does not exist', 'if a picked column does not exist the following error is displayed. 
', '// 20180506230926
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=non_existent_column

{
  "msg": "the non_existent_column column does not exist",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=non_existent_column",
  "ret": 400
}
  },
  "msg": "SELECT OK for table: monthly_issues",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=name%2Cprio",
  "ret": 200
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('3c43addf-bc2a-4eed-b4a5-040e9bd9dc75', 120, 3, 121, 238, 247, 5, 5, '09-done', 'Use filtering with the like operator in select table web action', 'The response cold be liked by ANY attribute with any valid value. 
', '// using the following syntax:
<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?like-by=<<like-attribute-to-like-by>>&like-val=<<like-value-to-like-by>>', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('036ca698-69d2-4b72-8fcf-13beb04e98bf', 121, 4, 122, 239, 240, 5, 5, '09-done', 'successful execution for number types', 'The like operator could be used with numbers as well.', '// 20180508191656
// http://192.168.56.120:3000/dev_issue_tracker/select/yearly_issues?like-by=prio&like-val=1&pick=name,prio

{
  "dat": {
    "46533749-1c00-4688-9cdd-1cc276ca40ac": {
      "guid": "46533749-1c00-4688-9cdd-1cc276ca40ac",
      "name": "implement upsert in DbWriterPostgres",
      "prio": 21
    },  "msg": "SELECT OK for table: monthly_issues",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1",
  "ret": 200
}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d4592c2e-60a4-4078-b499-743423d66d94', 122, 4, 123, 241, 242, 5, 5, '09-done', 'successful execution for text types', 'The response of the select web action could be likeed by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 

', '// 20180505204531
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1

{
  "dat": {
    "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
      "actual_hours": null,
      "category": "issue-tracker-features",
      "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
      "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
      "id": 180402,
      "level": 2,
      "name": "add the web select controller",
      "owner": "ysg",
      "planned_hours": "3.00",
      "prio": 1,
      "seq": 1,
      "start_time": "2018-04-02 18:00",
      "status": "07-qas",
      "stop_time": null,
      "tags": "feature",
      "type": "feature",
      "update_time": "2018-05-04 23:18:45.104771"
    }
  },
  "msg": "SELECT OK for table: monthly_issues",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1",
  "ret": 200
}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dfd70012-bc52-4c8a-860f-a760d77f50ad', 123, 4, 124, 243, 244, 5, 5, '09-done', 'error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params', 'If the request does not have either one of the url params the following response is produced. 
', '// 20180505204734
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio

{
  "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio",
  "ret": 400
}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dbaeebbe-b827-4c0b-90b5-c63627c620b8', 124, 4, 125, 245, 246, 5, 5, '09-done', 'error handling for non-existent like table''s attribute', 'If the syntax is correct but an non-existent like operator''s attribute is provided ( that is the table columns and the attriute name do not match ) the following error msg is returned: 
', '// 20180506220030
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=foo&like-val=sdklfj

{
  "msg": "the foo column does not exist",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=foo&like-val=sdklfj",
  "ret": 400
}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('244fd24f-9e03-4701-8594-9b4f8050203c', 125, 3, 126, 248, 253, 8, 2, '07-qas', 'Filtering by using the "with" url param', 'You can filter the result of the query by using the "with=col-operator-value"', '// 20180605150216
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=cloud&with=prio-lt-6&o=prio&pick=name,prio&with=status-eq-02-todo

{
   "dat": [
      {
         "guid": "55a06b10-7bbf-4298-a1ee-804bbfd12570",
         "name": "poc for data-load testing",
         "prio": 5
      }
   ],
   "msg": "",
   "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=cloud",
   "ret": 200
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('67897224-1c12-4f0b-958d-b437762a9765', 126, 4, 127, 249, 250, 8, 2, '07-qas', 'Successful execution', 'The application selects only the rows matching the generated where <<column>> <<operator>> <<value>> , where the operator could be also the like operator ( set also if the value contains the % char ) ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c24eb24b-201d-489e-8a86-b9a23427aa9c', 127, 4, 128, 251, 252, 8, 2, '07-qas', 'Error handling for non-existent column', 'If the column used does not exist an error is provided as follows:
', '// 20180605150010
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=cloud&with=prio-lt-7&o=prio&pick=name,prio&with=foo-eq-02-todo

{
   "msg": "the foo column does not exist",
   "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=cloud",
   "ret": 400
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2be978a7-1228-4502-9c5e-1c0bee8d2548', 128, 3, 129, 254, 259, 5, 5, '09-done', 'the hide operator in the select web action', 'Whenever a hide=<<col-name>> operator is applied the values and the column names of the column to hide are not displayed in the result. Use command to as the separator for listing multiple columns to hide. 
', '// using the following syntax:
<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?hide=guid,prio', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dc6ebe6d-a12a-455d-b7a4-f8fe14efb685', 12, 3, 13, 22, 23, 5, 5, '03-act', 'Switch items by using the :for operator in the search-box', 'If you type the ":in <<item-name>>" you will get a drop down which will list the items , to which your instance has access to, by chosing the item from the list and hitting enter you will be redirected to the same url by on the different database.
You can combine both the ":in <<db>>" and ":for <<item>>" operators at once. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('83fa6b81-544a-4d1c-b62b-c2628fbcc172', 129, 4, 130, 255, 256, 5, 5, '09-done', 'successful execution for text types', 'The response of the url query presents all but the hidden attribute values.
', '// 20180511144541
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=category&like-val=features&pick=name,prio,start_time,stop_time,category,status&o=stop_time&hide=guid

{
  "dat": [
    {
      "category": "issue-tracker-features",
      "name": "improve integration testing",
      "prio": 5,
      "start_time": null,
      "status": "09-done",
      "stop_time": null
    }
  ],
  "msg": "",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=category&like-val=features&pick=name%2Cprio%2Cstart_time%2Cstop_time%2Ccategory%2Cstatus&o=stop_time&hide=guid",
  "ret": 200
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('be1b150f-c5c7-45a4-9160-a50242ebbc51', 130, 4, 131, 257, 258, 5, 5, '06-onhold', 'error handling for inexistent column to hide', 'If the column which values are requested to be hidden does not exist the proper error message is retrieved. 
', '// 20180505204734
// http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio

{
  "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio",
  "ret": 400
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('ecd424d7-e5bd-45f1-90c8-10fae1316bf9', 131, 2, 132, 261, 266, 5, 5, '09-done', 'select-tables web action', 'An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to ( that is not only the one configured in the application layer )
', '<<web-host>>:<<web-port>>/<<database>>/select-tables', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('1d270227-0959-488f-83d3-0397221385a0', 132, 3, 133, 262, 263, 5, 5, '09-done', 'successful execution', 'An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to
', '// 20180505205212
// http://192.168.56.120:3000/dev_issue_tracker/select-tables

{
  "dat": {
    "1": {
      "row_id": "1",
      "table_catalog": "dev_issue_tracker",
      "table_name": "confs",
      "table_schema": "public"
    },
    "2": {
      "row_id": "2",
      "table_catalog": "dev_issue_tracker",
      "table_name": "daily_issues",
      "table_schema": "public"
    },
    "3": {
      "row_id": "3",
      "table_catalog": "dev_issue_tracker",
      "table_name": "decadally_issues",
      "table_schema": "public"
    }
  },
  "msg": "SELECT tables-select OK ",
  "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select-tables",
  "ret": 200
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dfc1216d-5a16-40eb-849a-2785264aa5bd', 133, 3, 134, 264, 265, 5, 5, '09-done', 'error handling for failed connect to db in the select-tables web action', 'If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 
', '// 20180503234141
// http://192.168.56.120:3000/non_existent/select/daily_issues

{
  "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
  "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('fd50704f-1d32-48ac-8b91-927721d71af6', 134, 2, 135, 267, 274, 5, 5, '09-done', 'Query web action', 'An http-client could query the name and description attributes for all the tables having those attributes by a keyword , which is translated to the sql like clause.', '<<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('46f022b6-c7a8-43cd-bda7-ba9940709d92', 135, 3, 136, 268, 269, 5, 5, '09-done', 'successful execution', 'An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
<<web-host>>:<<web-port>>/<<database>>/query?for=<<phrase-to-srch-for>>
For example: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=meta-data', '// 20181105161448
// http://192.168.56.120:3001/dev_issue_tracker/query?for=meta-data

{
   "dat": [
      {
         "description": "The meta-data could be added to the met , as the data is set in the dat of the json ...\nBecause this will also enable the display of the warning msgs capability",
         "guid": "4deaead1-721e-4bee-93ce-22d7e01dd511",
         "id": 180806103105,
         "item": "monthly_issues",
         "name": "add fetching of the meta-data in the select web-action"
      },
      {
         "description": "Basically a good calendar control should be pretty easy to be integrated ... , but it would require \"infra\" for fetching the meta-data as well ...",
         "guid": "bf2206c2-0b12-415f-90a0-d008b0d6913a",
         "id": 180806102543,
         "item": "yearly_issues",
         "name": "add vue calendar on the dates "
      }
   ],
   "met": 0,
   "msg": "",
   "req": "GET http://192.168.56.120:3001/dev_issue_tracker/query",
   "ret": 0
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('b5c48fe1-7dbc-4ebd-86a0-dc1726bdc0a0', 136, 3, 137, 270, 271, 5, 5, '09-done', 'error handling on non-provided for operator', 'If the for operator is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query', '// 20181105161651
// http://192.168.56.120:3001/dev_issue_tracker/query

{
   "met": "",
   "msg": "nothing to search for, the for url parameter is undefined the query route",
   "req": "GET http://192.168.56.120:3001/dev_issue_tracker/query",
   "ret": 400
}', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631365', 53, 3, 54, 104, 105, 5, 5, '09-done', 'Export data to md', 'To export a document via the export url you could apply any of the listing parameters and replace the view web action with the export one and the as=<<control> to the as=md and the application will present you with a save file dialog with a generated md document with the desired data', '<<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f88fd7a9-c8cd-46af-a8e7-83e910643903', 137, 3, 138, 272, 273, 5, 5, '09-done', 'error handling for empty for url parameter', 'If the for url parameter is empty  is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=', '// 20180503234141
// http://192.168.56.120:3000/non_existent/select/daily_issues

{
  "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
  "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
  "ret": 400
}', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('21a9b606-9110-42a3-98f9-8501e2a9f34b', 138, 1, 139, 276, 281, 5, 5, '03-act', 'SECURITY FEATURES AND FUNCTIONALITIES', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('e8529e58-db4d-40a7-be83-a059711d8cd8', 13, 2, 14, 25, 46, 5, 5, '03-act', 'The list page', 'The list page presents part or the whole content of a database by the means of UI controls - dynamic html table, forms etc. 
In the context of the issue-tracker''s parley the "listing" is the ui list of control/(s) you get by using the following URL format:', 'http://<<web-host>>:<<web-port>>/<<proj-db-name>>/list/<<item>>?as&<<ui-type>>&<<listing-params>>
', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7e48d90d-a64b-411e-a286-bfd2b1d820cf', 139, 2, 140, 277, 278, 5, 5, '09-done', 'Fully open mode', 'Currently the default mode of any running issue-tracker application is "fully open", that is any user having access to the url of the application might perform any change from the ui. ', NULL, 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('3780fca4-fd6d-4532-8898-db8ce83ea78b', 140, 2, 141, 279, 280, 5, 5, '09-done', 'Basic authentication mode', 'A fully deployed and configured issue-tracker instance provides basic authentication mode for any project database it has access to allowing thus persons having the credentials of the system account used for the particular project database to have full read,write and delete access to the data of that instance, in a way preventing users not having access to those credentials to the application. 
It is worth noting that this basic authentication does not mean strict security requirements for business and personal data on the web.
For more info consult the BasicAuthPlus module docs  :
https://metacpan.org/pod/Mojolicious::Plugin::BasicAuthPlus#DESCRIPTION
 ', NULL, 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('aecd02ab-c3ba-4b8d-b6f5-f662be315ba1', 14, 3, 15, 26, 27, 5, 5, '03-act', 'Listing url syntax', 'The common listing syntax components are as follows:
- web-host is the web-host the issue-tracker''s web instances is accessible from
- web-port - the web port the instance is accessible from 
- proj-db-name is the name of the database of your project ( as the issue-tracker supports multiple projects , with multiple databases ... ) 
- list - is the name of the action to perform 
- item is the name of the item which ui controls you want to list ( could be issues,problems,questions, etc.
- ?<<params>> the additional url parameters used to control the look and behavior of the listing action, should the url params be omitted the full content of the item table with default ui look and behavior are displayed. ', 'http://host-name:3000/dev_ysg_issues/list/monthly_issues?as=table&pick=id,status,prio,name,description&page-size=15&page-num=1&o=prio&with=status-ne-09-done
', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d056d9c1-a40d-4a8c-8788-3eb59bca3f78', 15, 3, 16, 28, 29, 5, 5, '09-done', 'Successful execution', 'You can use the pick=col1,col2,col3 url parameter to select for only desired attributes.
You could filter the result the same way the filters for the select page work ( see bellow ). ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('09be5455-eedc-4edb-9b3a-82b37d7dba0e', 16, 3, 17, 30, 31, 5, 5, '09-done', 'Error handling for non-existent db', 'If the db provided in the url pattern does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example url:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/non_existent/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('834764ec-b156-4941-a428-d0eaa2e7549a', 17, 3, 18, 32, 33, 5, 5, '09-done', 'Error handling for non-existent table', 'If the table requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/non_existent_table?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('b527aa86-35ef-4e9a-b4e2-e55d1896c38d', 18, 3, 19, 34, 35, 5, 5, '09-done', 'Error handling for non-existent column', 'If the column requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out.
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=NON_EXISTENT,status,name,description&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2fce735f-a802-49d8-aa4d-123d45c86d64', 1, 1, 2, 2, 15, 5, 5, '03-wip', 'INTRODUCTION', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('47513cc6-3b1f-4bd7-af05-cfc9c260ec3d', 19, 3, 20, 36, 37, 5, 5, '03-wip', 'The "pick" url param', 'You can use the pick=col1,col2,col3 url parameter to select for only desired attributes to be show in the ui control used for listing.
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('0b42b17a-a527-447f-8aef-b7508cca5184', 20, 3, 21, 38, 39, 5, 5, '03-wip', 'The "hide" url param', 'If you do not specify any attribute to pick, you could hide specific attributes by using the "hide=col1,col2,col3" syntax.
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=established=guid,description', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('20d5b463-83e8-47b8-b5c6-578de46fd288', 21, 3, 22, 40, 41, 5, 5, '07-qas', 'The "with=col-operator-value" filter', 'You can filter the result of the query by using the "with=col-operator-value". The following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done', 'with=status-eq-09-done
list all the items having the attribute "status" equal to the "09-done" string

with=prio-lt-7
list all the items having the attribute prio smaller than the number 7

this is the list of all the operators supported
       ''eq'' => ''=''
     , ''ne'' => ''<>''
     , ''gt'' => ''>''
     , ''lt'' => ''<''
     , ''ge'' => ''>=''
     , ''le'' => ''<=''
     , ''like'' => ''like''

', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('1b4e85e7-8299-4fd2-8f0c-acce5f773400', 22, 3, 23, 42, 43, 5, 5, '07-qas', 'The "where=col-operator-value" filter', 'You can filter the result of the query by using the "where=col-operator-value", which works exactly as the with operator, thus the following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. ', 'with=status-eq-09-done
list all the items having the attribute "status" equal to the "09-done" string

with=prio-lt-7
list all the items having the attribute prio smaller than the number 7

this is the list of all the operators supported
       ''eq'' => ''=''
     , ''ne'' => ''<>''
     , ''gt'' => ''>''
     , ''lt'' => ''<''
     , ''ge'' => ''>=''
     , ''le'' => ''<=''
     , ''like'' => ''like''

', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('14812adc-f236-49b4-9708-07881bbb002c', 23, 3, 24, 44, 45, 9, 1, '03-wip', 'Filtering with "like"', 'The filtering with the like operator translates to the SQL "like" operator- the "like-by=<<attr>>&like-val=<<val>> filtering, where <<attr>> stands for the name of the attribute to use the like operator. 
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03', '# this example url will list all the monthly_issues items having the "bug" string in their "name" attribute:
http://host-name:3000/dev_issue_tracker/list/monthly_issues?as=table&like-by=name&like-val=bug', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('97c03361-b7d5-4ce8-b5f3-d554d7958672', 24, 2, 25, 47, 56, 5, 5, '09-done', 'List as table page', 'The list table page lists all the rows from any table in the app db in form of simple ui table , which is sortable by clicking with  .. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c88cfe09-d822-4150-befa-d07ce415a7f5', 25, 3, 26, 48, 49, 5, 5, '09-done', 'table sorting', 'The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('ec633591-5fb7-402b-a7f9-1a61dc87ceab', 26, 3, 27, 50, 51, 5, 5, '09-done', 'table quick filtering', 'You can filter the already presented part of the result set in the page by using the search textbox. This is only an ui type of filtering for the already loaded data. This type of filtering is different compared to the url parameters filtering by using the with url param syntax and it filters the already fetched from the db data-set, whereas the with=<<attribute>><<operator>><<value>> filtering does filter on the database side.
You could focus the quick search textbox by pressing the forward slash on your keyboard. 
The quick search box works instantaneously, thus hitting enter is not needed. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('8dc3bcb2-c33a-4029-b54e-5ffb03bb2a27', 27, 3, 28, 52, 53, 5, 5, '09-done', 'set table paging size', 'You can set the page size of the result set to be fetched from the database by using the "&page-size=<<page-size>>" url parameter or by clicking on the page sizes links right of the table search box. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('1f5b14ac-966d-4b89-bffd-053c599becad', 28, 3, 29, 54, 55, 5, 5, '09-done', 'paging - setting the table''s page number', 'If the result-set requested is larger than the page size you can go to the next page number by using the "&page-num=<<page-num>>" url parameter. 
You could go to the next page number by clicking on the links just bellow the quick search textbox. The table control has UI for setting the table page number. 
The pager shows 10 pages at a "pager page" so getting to the end of hundreds of pages ( depending of course on your page size ) is comparably easy. 
You could quickly use the / char shortcut to focus to the quick search box and from there use the tab to quickly navigate to the desired page number. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('a6200a14-1774-43a8-89c1-7f67deb27c09', 2, 2, 3, 3, 4, 5, 5, '07-qas', 'Purpose', 'The purpose of this document is to describe all the features, functionalities and capabilities provided by a properly installed, configured and operated instance of the issue-tracker application. 
This document is the CONTRACT between you as the potential, former or active user of an issue-tracker instance and the product owner of that instance. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('ead7cf8a-557e-48f6-9acc-ac1a1b128042', 29, 2, 30, 57, 58, 5, 5, '09-done', 'List labels page', 'The list labels page lists all the rows from any table in the app db in form of "labels" - rectangular forms containing all the selected attributes ( by default all ) and their values. 
Note that only the as=lbls url change triggers the different view of the same data:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=lbls&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('5fae575e-d9b3-4544-b989-bb4ae0adc17d', 30, 2, 31, 59, 96, 5, 5, '03-wip', 'List as etable page', 'The list a table page has all the functionalities as the list as "table" page with the following additional features', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('04c30a06-b52d-44cc-9fa5-99c90ad4aa70', 31, 3, 32, 60, 61, 5, 5, '09-done', 'table sorting', 'The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=etable&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('746bd6ef-6feb-4f59-8622-08bf0862f896', 32, 3, 33, 62, 69, 5, 5, '09-done', 'Keyboard usability', 'You can quickly traverse the cells of the table via the tab key, which does go over the non-editable items too ( the id''s ) , so that you could quickly scroll the table as scrolling when the editable is in focus does not work. 
The whole table is easily scrollable whenever the cursor is on non-editable part of the table ( the id''s column ) and whenever the last rows must be edited the page is scrolled so that the rows are situated in the middle and not the bottom of the screen. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2ba5b98a-0e5a-416a-b117-43a84f53a283', 33, 4, 34, 63, 64, 5, 5, '09-done', 'Navigability of the list page with the keyboard', 'The order of the list-as-grid page has been arranged so that the ui user cuold cycly trough the whole table with the tab easily. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f80b4212-fbcb-4d17-90de-c0e18c630fe9', 34, 4, 35, 65, 66, 5, 5, '09-done', 'Focus the quick search box', 'You could focus the quick search by typing / IF you are not editing a cell. Thus the paging on the next cell is quite handy - as you could easily jump onto the quick search and with couple of tabs navigate to the next page. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c7099f25-a3b3-4a76-beef-f5c645ac3a6f', 35, 4, 36, 67, 68, 5, 5, '09-done', 'Undo the edit on a cell', 'If you were on a cell and types some text without leaving it, but you change your mind you could simply press the Esc key, which will restore the original content of the cell and you could proceed by tab to the next cell. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f48f7598-9bd2-45e6-a23c-9dc471612d51', 36, 3, 37, 70, 75, 5, 5, '09-done', 'New item creation ( CREATE )', 'A new item could be added to the table in the ui and thus in the db table by clicking the plus button above the table ( which uses the google material design ui ). 
The new button has a fixed positon, thus available during scrolling as well from the same position. 
The new button changes it''s appears when focused via the keyboard, and can be pressed when in focus by hitting enter with the keyboard. 
To practice new items'' creations and deletions to get confortable on the app''s behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('8801663d-3931-4517-8e5a-a3e1a65c18c2', 54, 1, 55, 108, 143, 5, 5, '09-done', 'DEVOPS FEATURES AND FUNCTIONALITIES', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c3166bb8-0ddf-4845-92e6-972da2a05946', 37, 4, 38, 71, 72, 9, 1, '09-done', 'Successful execution', 'After clicking the plus button the System adds the new row into the database table and presents it into the table ui AS THE FIRST ROW to emphasize the created row - that is the existing sort of the table is changed to the id column.
This behavior is not obvious if you have at the time of pressing the add-new button a valid search in the quick search box as the result set will most probably not show your new item as the filter is ongoing, this is rather bug, which for now is handled with the dimming of the add new button during an active search in the quick search box. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7554a699-b40e-40e2-afa3-9eb2fe092d3a', 38, 4, 39, 73, 74, 9, 1, '09-done', 'Error handling on db create error', 'If any error occurs while the creation an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not created to the database and nothing is stored. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9952df0b-f912-4926-af9b-d13e20bc2366', 3, 2, 4, 5, 6, 5, 5, '07-qas', 'Document status', 'This document is updated constantly in every release of the issue-tracker. Each version however is considered to be a complete version regarding the issue-tracker version it situated in.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d058ecb5-bbf2-4d23-84af-3977bbf2e7c8', 39, 3, 40, 76, 87, 5, 5, '09-done', 'Single cell Inline-edit ( UPDATE )', 'The table can be edited inline so that the data is updated to the database. White space in the cells is preserved. 
To practice new items'' creations updates and deletions to get confortable on the app''s behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d5763def-43e5-4b02-9e8a-b3ce5dcac04d', 40, 4, 41, 77, 78, 5, 5, '09-done', 'Table columns resizing', 'You can resize the columns of the tables to a max size of 500 pixels by dragging only one text area. Note however that the textarea will NOT be resized bigger than the maximum width of the current column … 
For the estetics of the table a certain default values for certain columns'' cotents widths are assumed.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('bebd0607-fae3-4f67-82d8-fd22362a164e', 41, 4, 42, 79, 80, 5, 5, '09-done', 'Contents for the table''s cells', 'The table''s cells should accept any UTF-8 characters including html entities. The textarea''s width should adjust automatically till the width of the widest cell in the table column. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7bb5aad6-95f1-43be-8345-7cff71187b59', 42, 4, 43, 81, 82, 9, 1, '09-done', 'Successful execution', 'If the single cell inline-edit is successful no msg is presented and the data is updated to the database storage.
If the updated cell was part of the currently sorted column the ui is automatically adjusted to the new sort order ( for example if a numeric sort was applied and the cell had value of 9 with 1..9 range and the smallest to greatest was currently active if the new update is 1 the item will appear in the top of the listing.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('e9a6ad21-ab7a-44a0-9255-3eb56803f559', 43, 4, 44, 83, 84, 9, 1, '09-done', 'Error handling on db update error', 'If any error occurs while updating an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('edcedfe0-2a4a-48c9-a75d-9ff4875b10e6', 44, 4, 45, 85, 86, 5, 5, '09-done', 'Nulls handling', 'Nulls handling is somewhat problematic in ui. For now the behavior by convention is to leave a nullable record in the database as null, whether the cell of the ui table is left empty ( white space chars are also considered empty)', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('95667143-66d1-4caa-91b9-6751af463837', 45, 3, 46, 88, 93, 5, 5, '09-done', 'Item deletion ( DELETE )', 'You could delete items by clicking the delete button in the beginning of every item. 
To practice new items'' creations and deletions to get confortable on the app''s behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f0084fa8-5060-4df1-8166-29ff96862903', 46, 4, 47, 89, 90, 9, 1, '09-done', 'Successful execution', 'If the deletion is successful the item is removed both from the ui and from the database. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('554e6723-89ff-461c-a6c0-d8638041a717', 47, 4, 48, 91, 92, 9, 1, '09-done', 'Error handling on delete error', 'If any error occurs while deleting the item an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631367', 48, 3, 49, 94, 95, 5, 5, '09-done', 'List as print-table page', 'The list as print-table page is aimed at producing quickly refined result-set from the database for a further copy paste or even print to paper. 
It has all the functionalities as the list as "table" page, without the filtering from the quick search box and without the ui for the pager and page-sizer -the url params for paging and page-sizing work, however. All the url params work as in the etable listing page. 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=print-table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9b4d7afd-8e4c-4630-8095-f83072fa20e0', 4, 2, 5, 7, 8, 5, 5, '07-qas', 'Audience', 'This document is aimed for everyone, who shall, will or even would like to interact with an issue-tracker application instance. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631361', 49, 2, 50, 97, 100, 5, 5, '03-act', 'The view page', 'The view page presents the data of a database table, having nested-set hierarchichal model partially or fully by the means of different controls', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631362', 50, 3, 51, 98, 99, 5, 5, '03-act', 'The view-doc page', 'The view page presents the data of a database table partially or fully by using a document like structure. The ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631363', 51, 2, 52, 101, 106, 5, 5, '09-done', 'The export url', 'The export url follows the same syntax naming conventions as the list page , but instead of presenting a list with the data it exports it in the specified with "as" url parameter format. ', '<<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('48760763-47f3-4ede-902a-6b178d631364', 52, 3, 53, 102, 103, 5, 5, '09-done', 'Export data to xls', 'To export data via the export url you could apply any of the listing parameters and replace the list web action with the export one and the as=<<control> to the as=xls and the application will present you with a save file dialog with the desired data. ', '<<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('6c4f2c4a-60d4-4e25-ad90-ca028230512c', 55, 2, 56, 109, 118, 5, 5, '09-done', 'Testability', 'The issue-tracker app has a good and improving all the time test coverage. You can all the tests in the application as follows:', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('3f40881b-9a95-4f86-9615-9cb37b837e24', 56, 3, 57, 110, 111, 5, 5, '09-done', 'Perl syntax check call', 'You can check the perl syntax for each perl code file in the whole project by issuing the following shell call:', 'bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('94304dcd-6b6a-407f-9cfd-53082a81a87a', 57, 3, 58, 112, 113, 5, 5, '09-done', 'Unit tests call', 'You can run the unit tests of the application by issuing the following single shell call:', 'bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-unit-tests', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('5c0f4461-2b4f-42e4-918f-eb77fbac96b8', 58, 3, 59, 114, 115, 5, 5, '09-done', 'Integration tests call', 'You can run the integration tests of the application by issuing the following single shell call ( note that the integration tests will not start if you do not have pre-loaded the needed shell env vars for your project you want to operate on ). ', 'bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('3caf79ee-5bc9-4a5a-ac80-b4fdec592d80', 5, 2, 6, 9, 10, 5, 5, '07-qas', 'Master storage and storage format', 'The master storage of this document is the master branch of the issue-tracker release you are interested in. The main storage format is Markdown. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('444d2d5b-4581-45b7-8297-562f269d991f', 59, 3, 60, 116, 117, 5, 5, '09-done', 'Bash tests call', 'You can run all the bash functions in the tool by issuing the following command in the shell. ', '# if you set the previous 2 actions as those to be tested
bash src/bash/issue-tracker/test-issue-tracker.sh

2018-05-12 18:01:08      START test-issue-tracker test run report

result  start-time  stop-time   action-name
   ok    18:01:09 18:01:19 run-perl-unit-tests
   ok    18:01:20 18:01:30 run-perl-integration-tests



2018-05-12 18:01:30      STOP  test-issue-tracker test run report', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f0d1711a-658e-4e9b-b2af-425f00defc74', 60, 2, 61, 119, 126, 5, 5, '09-done', 'Documentation', 'We consider up-to-date and complete documentation as being integral part of the application, thus each release must have the documentation updated to it''s current set of features, functionalities and capabilities. 
You might argue that the amount of documentation is too big, yet the more you dive into the application the more you will justify it''s existence by yourself. ', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('57ca4979-7998-4ed4-afa6-50aa3353f91d', 61, 3, 62, 120, 121, 5, 5, '09-done', 'Single shell call documentation generation - the generate-docs shell action', 'You can generate all the md and pdf docs by if you have a running instance of the isg-pub application accessible via single shell call by issuing the following command: 
The command will fail if there is a doc configured in the isg-pub database which has less than 100 lines. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('819e2c51-ca58-43bf-8455-3d3e15670e23', 62, 3, 63, 122, 123, 5, 5, '03-act', 'Full documentation set', 'Every instance of the isssue-tracker application comes with up-to-date documentation set addressing the latest commit of the released version, namely the following documents:
 - Requirements
 - UserStories
 - Features and Functionalities
 - DevOps Guide
 - Installation and Configuration Guide', 'find doc/md', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('212da561-100d-4b31-b415-9986892d988a', 63, 3, 64, 124, 125, 5, 5, '03-act', 'Documentation''s file formats', 'The documentation set of the application is available at least in the following file formats:
 - md - ( the master documentation format )
 - pdf - for distribution

The following formats MIGHT be also optionally available :
 - xls ( extracts from the isg-pub database ) 
 - sql ( dumps from the isg-pub database ) 
 - json ( extracts from the isg-pub database )  ', 'find doc -type f | sort', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4059143a-6824-4375-98cb-330b7aba5dd7', 64, 2, 65, 127, 132, 5, 5, '09-done', 'Logging', 'Logging is implemented as follows:', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f48825e3-7247-42b6-8798-18dfdec0331f', 65, 3, 66, 128, 129, 5, 5, '09-done', 'Bash logging', 'The issue-tracker.sh bash entry point loggs both to STDOUT and file. You cold easily defined your own log levels. ', 'doLog "INFO an info msg"
[INFO ] 2018.05.08-21:05:25 EEST [issue-tracker][@host-name] [29667] an info msg:', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('45f6ba6b-f3a1-4e9a-9127-eb0caf995d80', 66, 3, 67, 130, 131, 5, 5, '09-done', 'Perl logging', 'The perl logger could be configured to log to file and std outputs. ', 'doLog "INFO an info msg"
[INFO ] 2018.05.08-21:05:25 EEST [issue-tracker][@host-name] [29667] an info msg:', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('f3bf05ae-62d7-4aaa-b199-bbfa9c52909d', 67, 2, 68, 133, 142, 5, 5, '09-done', 'Development efficiency increasing actions', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('cb4946a8-781a-4a91-acb9-478643b89fde', 68, 3, 69, 134, 135, 5, 5, '09-done', 'Support for different projects', 'The issue-tracker could be used against many different projects as soon as they have the needed file and dir structure , configuration file and dedicated db in the PostgreSQL. 
You could quickly fork a new project out of the issue-tracker instance by copying the ', '# pre-load the vars of an issue-tracker project
doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('e6e6e38f-6f9e-4992-8cd1-0e8cd24b3578', 6, 2, 7, 11, 12, 5, 5, '07-qas', 'Version control', 'The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the issue-tracker version, in which this document residues.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2d923672-0d94-4d3b-9e65-2ca77b7a405b', 69, 3, 70, 136, 137, 5, 5, '09-done', 'The "morph-dir" action', 'You can recursively search and replace strings in both file and dir paths and their contents ( as soon as they non-binary , txt files ) by issuing the following commands:', 'export to_srch=WriterTxtDaily
export to_repl=WriterTxtTerm
export dir_to_morph=`pwd`
bash src/bash/issue-tracker/issue-tracker.sh -a morph-dir
fg
history | cut -c 8-
', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('3103e6f4-bfdd-4cc1-8be2-f84f95ed8a7a', 70, 3, 71, 138, 139, 5, 5, '09-done', 'Perl code syntax check', 'You can check the perl code syntax with the following command:', 'bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('bdf617e7-6969-4379-bf0c-e7d557b13530', 71, 3, 72, 140, 141, 5, 5, '09-done', 'Single call export of the md and pdf documentation files', 'Single call export of the md and pdf documentation files', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9439aa4c-80ca-4b15-9f60-ee9b94b4ffe2', 72, 1, 73, 144, 165, 5, 5, '09-done', 'SYSADMIN FEATURES AND FUNCTIONALITIES', 'The term feature usually denotes an UI usability, but as the sysadmins of the issue-tracker system must be technical people accustomed to the black screen in this context feature simply means a well memorizable shell call to perform a single action on the System they must operate. ', '# pre-load the project variables
doParseCnfEnvVars cnf/issue-tracker.dev.host-name.cnf

# run the run-integration-tests
bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('9fda1bfb-b81f-4e08-acbc-e940f370d009', 86, 3, 87, 170, 171, 5, 5, '09-done', 'The "xls-to-db" action without passing xls file', 'if you do not provide a xls file the newest xls file from the mix data dir will be used', 'clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r ''.| .dat| .[] | .table_name''|perl -ne ''s/\s+/,/g;print''`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('feae0d0b-9f8f-43b0-9c00-3c3919dfbcde', 73, 2, 74, 145, 146, 5, 5, '09-done', 'Enforced daily backups by "increase-date" action', 'The concept of daily backups in in-build in the functionalities of the issue-tracker application for all the projects data - that is you cannot operate the application without having daily backups, as every day a new working daily dir having the current day daily backup will be created!
The "increase-date" action copies the content of the latest daily data dir ( build by concentrating the mix_data_dir and the latest date string) with the current date in the file path. 
This IS the defacto way of making backup of the data ( including db dumps ) on daily basis, which could be quite easily made really robust for Unix admins with couple of cron scripts and symlinks ... 
The increase-date behaves for different projects in the same way, except of course using a different daily data dir root. ', '# load the env vars for a different proj: 
clear; doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf

# make backup of the latest daily dir
bash src/bash/issue-tracker/issue-tracker.sh -a increase-date', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4ed4fd56-8949-4bea-babc-fa2129c91d3b', 74, 2, 75, 147, 148, 5, 5, '09-done', 'Postgres db backup', 'You can backup any project database by using the following calls:', '# pre-load the project variables
doParseCnfEnvVars cnf/issue-tracker.dev.host-name.cnf
# replace the second strin to the full path of the project file if needed 

# backup the postgres db of the project 
bash src/bash/issue-tracker/issue-tracker.sh -a backup-postgres-db', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('b6285d88-0ec9-42fb-ad3a-d89c97d035ea', 75, 2, 76, 149, 150, 5, 5, '09-done', 'The "run-pgsql-scripts" action', 'You can create a preconfigured <<env>>_<<db_name>> postgres via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit.', 'bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts', NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('cb1db63d-e04b-4eb9-9e63-5d4f88bc999a', 76, 2, 77, 151, 164, 5, 5, '09-done', 'The "run-mysql-scripts" action', 'You can create a preconfigured <<env>>_<<db_name>> in mariadb  via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('6491098e-7ab8-4ce2-8562-d3e89b3e73bb', 77, 3, 78, 152, 153, 5, 5, '09-done', 'The "txt-to-db" action period handling ( deprecated)', 'Issues txt files are stored in a daily folder with the following naming convention:
<<project>>.<<current_date>>.<<period>>.txt
The tool knows to correctly fetch the issues files for the configured period ( by export period=weekly ) and copy its data in to the <<period>>_issue table. ', 'ysg-issues.2017-06-03.daily.txt
ysg-issues.2017-06-03.monthly.txt
ysg-issues.2017-06-03.weekly.txt
ysg-issues.2017-06-03.yearly.txt', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('7a8fda9e-6fdc-49e0-9a00-40cbd976985c', 78, 3, 79, 154, 155, 5, 5, '09-done', 'The "txt-to-db" action ( deprecated)', 'You can load you issues from an "issues txt file" , having a specific syntax into a PosgtreSQL issue table, by issueing the shell.
This call with truncate the issue table from the db and convert all the issues data from the issues txt file into the issue table. ', '# pre-load the vars of an issue-tracker project
doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf

# ensure there is no data in the issue table
psql -d "$db_name" -c ''TRUNCATE TABLE issue ;''

# run the txt-to-db action
bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db

# check the data by :
psql -d "$db_name" -c ''SELECT issue_id , category , name FROM issue order by name''', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4b1601b4-fc21-410c-834c-f4d5b0b561da', 7, 2, 8, 13, 14, 5, 5, '07-qas', 'Process', 'The issue-tracker provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behavior of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('b23e701e-16b3-464f-a046-bbb4255f8ceb', 79, 3, 80, 156, 157, 5, 5, '09-done', 'The "db-to-txt" action ( deprecated ) ', 'You can load your already stored in the issue table issues and load them into the same issues txt file', '# check the data by :
psql -d "$db_name" -c ''
SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio''

# run the db-to-xls action
bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt

# check the updated data
psql -d "$db_name" -c ''
SELECT issue_id , start_time , stop_time , category , name FROM issue order by start_time''', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('69664123-7a9a-48e9-ad70-ed394aca2437', 80, 3, 81, 158, 159, 5, 5, '09-done', 'The "db-to-txt" action with pre-defined sorting attribute ( deprecated )', 'You can load your already stored in the issue table issues and load them into the same issues txt file by using a pre-defined sorting attribute. ', 'export issues_order_by_attribute=start_time

bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('d8269ae9-7017-4183-be64-6d377b944ea7', 81, 3, 82, 160, 161, 5, 5, '09-done', 'restart the morbo development server', 'You could restart the development morbo server by issuing the following syntax ( Note that each environment type starts within the pre-configured mojo_morbo_port if configured to do so):', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dc133b73-5ec6-4397-87e9-4d250b85a01a', 82, 3, 83, 162, 163, 5, 5, '09-done', 'restart the hypnotoad production server', 'You could restart the production hypnotoad server by issuing the following syntax:', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('cf889505-d7b2-44c3-b4f0-6a2e89d318e1', 83, 1, 84, 166, 179, 5, 5, '03-act', 'ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('2ce7ff8f-50ca-4016-8052-33ba370812a4', 84, 2, 85, 167, 168, 5, 5, '09-done', 'The "db-to-xls" action against postgres', 'You can unload your already stored ANY xls table with unique id''s and load them into a xls file. ', '# pre-load the vars of an issue-tracker project
doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf


# check the data by :
psql -d "$db_name" -c ''SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio''

# run the db-to-xls action
bash src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('beaac6e7-ec21-40ee-9471-c83194437b2d', 85, 2, 86, 169, 174, 5, 5, '09-done', 'The "xls-to-db" action', 'You can load the latest produced xls file ( note as long as your xls sheet headers match the columns in your db table ANY xls is compatible )
You can control whether or not the loadable table should be truncated by setting the do_truncate_tables environment variable to 1 or 0. ', 'clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r ''.| .dat| .[] | .table_name''|perl -ne ''s/\s+/,/g;print''`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('44c22721-b2c4-448f-a431-59ce89f9f48d', 87, 3, 88, 172, 173, 5, 5, '09-done', 'The "xls-to-db" action with nested-set mode against mysql', 'You could run the xls-to-db action against mysql or mariadb rdbms so that the issue-tracker will arrange your table to be compatible with the nested-set hierarchy model. ', 'export tables=Tests,ItemController,ItemModel,ItemView,ExportFile,UserStory,Requirement,DevOps,Feature,ReadMe,SystemGuide,Image,ExportFile; export do_truncate_tables=1 ; export rdbms_type=mysql ; export load_model=nested-set ; perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('5d75dd21-840c-41e7-919a-edbf769c3749', 88, 2, 89, 175, 176, 5, 5, '09-done', 'The db-to-json shell action', 'You could make a backup of all your postgres tables data by running the db-to-json shell action as follows:', 'clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r ''.| .dat| .[] | .table_name''|perl -ne ''s/\s+/,/g;print''`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-json --tables $tables', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('dbd991f1-aca9-404e-8326-2d48cc41076a', 8, 1, 9, 16, 107, 5, 5, '03-act', 'UI FEATURES', 'This section describes the User Interface ( UI ) features of the issue-tracker application, which all ( for now ) are accessible from an internet browser accessing a running instance of the issue-tracker application. The following examples illustrate the concept:', NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('58ff0490-9e89-4779-b217-a3c4d5e68e25', 89, 2, 90, 177, 178, 5, 5, '09-done', 'The json-to-db shell action', 'You could restore a previously created json files backup ( the json files are stored in the <<ProductInstanceDir>>/dat/json by default by issueing the following oneliner ( you need to have the web server up and running in order to fetch the list of tables too ) ', 'clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r ''.| .dat| .[] | .table_name''|perl -ne ''s/\s+/,/g;print''`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do json-to-db --tables $tables', 'bash', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('75002e4a-a73b-4ffa-b97f-f00ae11ecd65', 90, 1, 91, 180, 275, 5, 5, '03-act', 'BACK-END API FUNCTIONALITIES', NULL, NULL, NULL, '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('22ddc7c4-51b5-49e2-8822-2701fae7687c', 91, 2, 92, 181, 192, 9, 1, '09-done', 'create web-action', 'An http client could create  a new row into ANY table by passing a bigint as the id.', '<<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('4de1dc78-c15f-45be-9913-514f8230e23c', 92, 3, 93, 182, 183, 9, 1, '09-done', 'Successful execution', 'After 200 http returned code a new item is created in the database. Note that all non-null columns in the database MUST have default values, otherwise this call will always fail. This limitation is by design for now.', '<<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>
// example data
{ id: "3"}', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('921bfadf-885b-4b02-93d4-f86f1738b8e9', 93, 3, 94, 184, 185, 9, 1, '09-done', 'Error handling on non-existing db', 'If the db provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('69476c20-30fb-49d0-9397-df568d690f78', 94, 3, 95, 186, 187, 9, 1, '09-done', 'Error handling on non-existing table', 'If the table provided in the url pattern does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('c34c4b60-b30d-4ea6-8f59-0a3b6e91abc2', 95, 3, 96, 188, 189, 9, 1, '09-done', 'Error handling on non-existing attribute ', 'If the attribute(column) provided in the post data does not exist an error is shown. ', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('057cb903-2ba1-4af0-a013-12accaf606f6', 96, 3, 97, 190, 191, 9, 1, '09-done', 'Error handling on wrong data-type', 'Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.
', NULL, 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('29b9c61a-78a4-4881-9117-a0162b362122', 97, 2, 98, 193, 206, 9, 1, '09-done', 'update web-action', 'An http client could update ANY table with a single column name by provinng the column name and the column value', '<<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>', 'js', '2018-12-30 16:28:39');
INSERT INTO public.features (guid, id, level, seq, lft, rgt, prio, weight, status, name, description, src, runtime, update_time) VALUES ('8977d160-7c97-4fbe-b53a-4f7eb872b1e9', 98, 3, 99, 194, 195, 9, 1, '09-done', 'Successful execution', 'An http client could update ANY table with a single column name by provinng the column name and the column value', '<<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
// example data
{attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}', 'js', '2018-12-30 16:28:39');


--
-- Data for Name: goals; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('f3b27b92-bd4c-4f56-96d7-8b6a541330e0', 181206125525, 1, '03-act', 'capability', 'full text capabilities', 'achieve full text search capabilities for all the relational data in any of the issue-tracker databases ', NULL, 9, 'ysg', '2018-12-30 18:34:23');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('750604aa-d58a-4d4b-8551-b78b05962d2e', 181230152953, 1, '03-act', 'installation', 'achieve the capability to ALWAYS migrate ', 'achieve the capability to ALWAYS migrate the data in the database when upgrading the application ... 

 - must set alias for url and conf vs. db name - v056_dev_issue_tracker
', NULL, 9, 'ysg', '2018-12-30 18:36:14');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('66a18dab-c35d-4db8-8702-c5509c53e438', 181206125624, 1, '03-act', 'ui-administration', 'modify ui via meta-data', 'achieve the capability to modify the major ui properties via update of the application meta data ... ', NULL, 9, 'ysg', '2018-12-30 15:29:40');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('8e03b040-cc10-4fd6-b476-47e081d54669', 181206123625, 5, '09-done', 'capability', 'full CRUD capabilities', 'achieve full CRUD capabilities for any relational table following the issue-tracker data model', 1, 9, 'ysg', '2018-12-06 12:57:32');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('8689388a-e48a-4b3b-b857-e9efa0c81fa0', 181206125814, 1, 'status ...', 'administration', 'achieve a single one-liner update of any application', 'achieve a single one-liner update of any application', NULL, 9, 'ysg', '2018-12-30 18:36:19');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('4501d8ec-2967-4295-970f-61a951901c91', 181206123659, 2, '09-done', 'feature', 'hierarchical data table presentation', 'achieve capability to present only hierarchical data as in the isg-pub application ... Fully decouple the existing issue-tracker from the isg-pub application code ... ', NULL, 9, 'ysg', '2018-12-30 15:28:39');
INSERT INTO public.goals (guid, id, prio, status, category, name, description, seq, weight, owner, update_time) VALUES ('ec215b2e-cabf-4bf2-868e-3087179b66c3', 181230183423, 1, '03-act', 'docs', 'achieve 100% match between code and documentation ', 'Until release v1.0.0 the 100% match and consistency should be achieved between the application documentation and the release source code. 
The only way to achieve this is to constantly update the docs during the work for every release. ', NULL, 9, 'ysg', '2018-12-30 18:36:10');


--
-- Data for Name: ideas; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('bd1664b2-619c-4916-bdb2-51f65c5222c8', 180724175934, 10, 5, '01-eval', 'define the roles in the application', 'Define the roles of the application, first on the UserStories level, than in the ArchitectureGuide', 'ysg', '2018-08-06 18:23:47', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('622e776e-df75-4a54-822a-9d8e372a426e', 180724180734, 10, 1, '02-todo', 'try the page life cycle', 'The page life cycle must be figured out so that:- a single method for the AJAX call 
- the insert should insert with the default values', 'ysg', '2018-09-26 22:06:27', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('a667692e-81ec-40cf-9304-de2dd3ad3327', 180519211901, 10, 5, '02-todo', 'why the README.md does not get updated ...', 'add configuration table for the master-app db so that by editing it once could later on spown new app dbs from this one ...', 'ysg', '2018-09-26 22:07:21', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('ce31ab8c-d443-4461-b049-1c56a0c78bbc', 181025082255, NULL, 2, '02-todo', 'enable monitoring capabilities', 'Each instance should record every 15 minutes it''s avilability via the benchmarking tests ... ', 'unknown', '2018-10-25 08:23:46', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('7d37c37a-b896-4b73-8614-a7fe055ba062', 181114091733, NULL, 1, '01-eval', 'implement tag search', 'Could be achieved by :
 - re-use of the search interface  
 - marking the tables with tags 
 - union of all the tables ', 'unknown', '2018-11-14 09:04:05', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('6c791232-f950-45d2-8f19-e5c7826a6dce', 181114090909, NULL, 3, '01-eval', 'single cell update control flow for view doc similarly as the in the list-as-grid page', 'Use the same model as in the grid in the view doc pages for updating a single cell into the database by event in the front end and axious post, because : 
 - it''s easier to implement and more straight forward to complex save form
 - it''s faster in ui performance 
 - it has better ui usability
 - the whole meta-data is available now !!!', 'unknown', '2018-11-14 08:56:55', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('40399077-3668-432f-84f2-4f1403a2c469', 181114091704, NULL, 1, '01-eval', 'implement universal text search', 'Could be achieved by generating the union in the Search by specifying select table_name as table, col_name as attribute_name , col , foreach col which is char or varchar ... 
After the same meta data is passed to the client the client will know how-to generate accordingly the links ... ', 'unknown', '2018-11-14 09:05:46', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('81f1cfed-651a-417c-ba1f-f5bcb65adb6b', 180724180934, 10, 9, '09-done', 'add default values for all the tables', 'Otherwise the inserts will fail ... The idea is to be able to :', 'ysg', '2018-11-14 08:57:13', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('178dacc9-e922-4603-8346-88d36962b5e2', 180724175434, 10, 5, '01-eval', 'create the Promoters Guide', 'The Promoters Guide should be a document, which guides the way of promoting the issue-tracker application', 'ysg', '2018-11-14 08:57:39', NULL);
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time, tags) VALUES ('7291217e-56be-4275-9ea7-6c57b8a559e9', 181114091440, NULL, 4, '01-eval', 'Create End-Users Guide', 'The end-users guide should provide instructions on how-to use the ui of the issue-tracker application by assuming really office level it skills for the target audience. ', 'unknown', '2018-11-14 09:02:23', NULL);


--
-- Data for Name: installations; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('4947dde7-6c6c-40e9-924c-27056263018f', 0, 0, 1, 1, 102, 0, '03-active', 'ISSUE-TRACKER INSTALLATIONS AND CONFIGURATION GUIDE', NULL, NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('49517e85-a6eb-4b75-af77-d26541f0123c', 9, 2, 10, 17, 30, 5, '09-done', 'OS level access via aws', 'This section will provide you with the instructions to instantiate an Ubuntu 16 micro instance in AWS. Should create an AWS account if you have not yet one … ', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('f564c782-87bd-485e-a06d-2ee337ffd918', 10, 3, 11, 18, 23, 5, '09-done', 'Launch a new instance', 'Go to your management console''s by clicking Services-EC2 ( note I am using the region=eu-west-1, you might be using a different one ) :
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#Instances:sort=monitoring
Click on the blue "launch instance" button. ', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('befedfe0-c692-4b0c-a2f7-7126a964409c', 11, 4, 12, 19, 20, 5, '09-done', 'Choose an Ubuntu AMI', 'Scroll down the list. Choose the "Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-05-22" AMI. Click on select', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d4e66954-272b-44c7-9b1b-046be54e6c12', 12, 4, 13, 21, 22, 5, '09-done', 'Select the type of instance', 'Choose the type of instance - I am using t2.micro, which is supposed to be free "freetire eligible". Click on the review and Launch ( you could continue configuring till the end of the wizard but you should be ok with the defaults by now', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('9aa9e24e-ef7b-45ba-ac33-2a74f88e9dac', 13, 3, 14, 24, 25, 5, '09-done', 'Open ports ', 'In the AWS menu click Services - EC2. Click on the left on the security groups. If you configured an explicit security group, select it by clicking on the check box next to it, if you did not that click on the check box to the default security group created something like "launch-wizard-1 created 2018-07-03T14:39:25.644+03:00", where the latest string is the time when you launched the instance. 
Click on Actions - edit inbound rules - open the 3000 and 8080 tcp ports ( the default ones used by the mojo and hypnotoad malicious web servers) ', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d9142d67-a986-4c75-ac58-1b865ea26b0a', 14, 3, 15, 26, 27, 5, '09-done', 'Create a key-pair to access the instance via ssh', 'Click on the key-pairs in the left. Create a new one. Download the file in a path you could navigate later on to. I am using for example the following path:', '/opt/csitea/issue-tracker/dat/sec/key-pair-issue-tracker.pem', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d6a92614-3de8-4d6d-808e-f1e73308157c', 15, 3, 16, 28, 29, 5, '09-done', 'Access the running instance via ssh.', 'Run the following commands, by replacing the ssh_server with the value taken from the "Private DNS" of the running instance. ', 'export ssh_user=ubuntu
export ssh_server=ec2-31-223-97-157.eu-west-1.compute.amazonaws.com
export key_pair_file=/opt/csitea/issue-tracker/dat/sec/key-pair-issue-tracker.pem

ssh -i $key_pair_file $ssh_user@$ssh_server', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('ad273187-c367-4ca9-b0c9-477ef746a706', 16, 1, 17, 32, 57, 5, '09-done', 'LIBS AND BINARIES INSTALLATIONS ON OS LEVEL', NULL, NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('65364a67-ee0c-4eeb-b273-309d82b2b3c8', 17, 2, 18, 33, 34, 5, '09-done', 'Check you can sudo with the ubuntu user', 'You should be able to sudo with your ubuntu user. ', '# set a nice informative prompt
export PS1="\h [\d \t] [\w] $ \n\n  "

sudo su - ', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('7ad6d48a-278b-4ae6-96cf-222309ad1a79', 18, 2, 19, 35, 36, 5, '09-done', 'Add the issue-tracker application OS user''s group', 'The current "as simpliest as possible" setup is to use a separate OS group for the user of the issue-tracker application. 
The name of the group could be anything, as well it''s gid , use those values if you do not want to make additional own configurations. ', 'export group=grp_it
export gid=10001
sudo groupadd -g "$gid" "$group"
sudo cat /etc/group | grep --color "$group"', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('1ff643c1-2c83-4677-a7ea-2a94e44dd7fd', 1, 1, 2, 2, 15, 5, '09-done', 'INTRODUCTION', NULL, NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('519f205c-c7f0-4058-9298-d976d5b96659', 19, 2, 20, 37, 38, 5, '09-done', 'Add the issue-tracker application OS user', 'Add the user as shown bellow. The name of the user could be also anyting, as log as it belongs to the above configured group. ', 'export user=usr_it
export uid=10001
export home_dir=/home/$user
export desc="the hadoop group"
#how-to add an user
sudo useradd --uid "$uid" --home-dir "$home_dir" --gid "$group" \
--create-home --shell /bin/bash "$user" \
--comment "$desc"
sudo cat /etc/passwd | grep --color "$user"
groups "$user"', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('5ab9f035-fbd0-4a03-9939-8ae436fb17a5', 20, 2, 21, 39, 40, 5, '09-done', 'Add the issue-tracker app user to the sudoers group', 'Edit the /etc/group', 'sudo:x:27:ubuntu,usr_it', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('96ce927d-7143-471a-8b45-113e87f0bb22', 21, 2, 22, 41, 42, 5, '09-done', 'Allow sudo without having to type password ', 'Add the following text to the /etc/sudoers file:', '# See sudoers(5) for more information on "#include" directives:
usr_it  ALL=(ALL) NOPASSWD: ALL', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('9d587141-5e8a-4627-90a9-572eca938c29', 22, 2, 23, 43, 44, 5, '09-done', 'Install the git binary', 'You will need the git binary to fetch the issue-tracker source - you could alternatively download its zip fille. ', 'sudo apt-get install build-essential git', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('21b7d654-342e-448d-9e44-d33e970a6cf9', 23, 2, 24, 45, 46, 5, '09-done', 'Fetch the source', 'Fetch the source from git hub as follows:', '# got to a dir you have write permissions , for example:
mkdir -p ~/opt/; cd ~/opt/

# fetch the source
git clone https://github.com/YordanGeorgiev/issue-tracker.git

# checkit
ls -la 
', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('79073b9b-a98f-4e90-89eb-93a5024fa129', 24, 2, 25, 47, 48, 5, '09-done', 'run the boot-strap script', 'The bootstrap script will interpolate change the git deployment dir to a "product_instance_dir" ( your instance of the issue-tracker, having the same version as this one, but running on a different host with different owner - your )', '# defiine the latest and greates product_version
export product_version=$(cd issue-tracker;git tag|sort -nr| head -n 1;cd ..)

# check it 
echo $product_version

# run the bootstrap script : 
bash issue-tracker/src/bash/issue-tracker/bootstrap-issue-tracker.sh', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('b5e0eadd-8ca1-4e57-b56e-5619a02060ac', 25, 2, 26, 49, 50, 5, '09-done', 'Install the OS libs listed in the prereq sh script', 'The "prereq"script contains the listing of the binaries to be installed. Run the script. ', '# go to your product instance dir - 
cd ~/opt/csitea/issue-tracker/issue-tracker.$product_version.dev.$USER
sudo bash src/bash/issue-tracker/install-prerequisites-on-ubuntu.sh', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('a98dca1d-6eda-4282-a818-08180c330f7b', 26, 2, 27, 51, 52, 5, '09-done', 'Install the Perl modules listed in the preq pl scriipt', 'The Perl modules installation looks ALWAYS, yet it usually goes trough without any googling of sessions etc. ', '# go to your product instance dir - 
cd /opt/csitea/issue-tracker/issue-tracker.$product_version.dev.$USER
sudo perl src/perl/issue_tracker/script/issue_tracker_preq_checker.pl', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d6628794-afd5-40f9-9295-2b1f3d01da26', 27, 2, 28, 53, 54, 5, '09-done', 'Disable the warnings in the OAuth2.pm', 'As many of the actions in the issue-tracker this is simply a one-liner. ', 'vim /usr/local/share/perl/5.22.1/Net/Google/DataAPI/Auth/OAuth2.pm
# edit the use Any::Moose; line as follows:

no warnings ''deprecated'';
use Any::Moose;
use warnings ''deprecated'' ;', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('a5357b8d-9bf6-4cc8-8a6e-de82642dc3fe', 28, 2, 29, 55, 56, 5, '09-done', 'Check that the project source code ', 'As many of the actions in the issue-tracker this is simply a one-liner. You should not get any errors after the execution of this one , if there are probably some prerequisite module has not been included in the prerequisite script ( although we have tested those several times ... ). So you would either have to install it by yourself or troubleshoot why it does not install. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('851ff48a-e68a-4fce-b27b-4cc0b02211c4', 2, 2, 3, 3, 4, 5, '09-done', 'Purpose', 'The purpose of this document is to describe the tasks and activities to be performed in order to achieve a fully operational issue-tracker application instance. ', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('bfb78d8a-d9fd-49f6-8a11-ffa3f6cceaa3', 29, 1, 30, 58, 79, 5, '09-done', 'POSTGRES RELATED INSTALLATIONS AND CONFIGURATIONS', NULL, NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('c1ddc5c6-7647-490d-b1ee-4dc91c775fba', 30, 2, 31, 59, 60, 5, '09-done', 'Configure the Ubuntu repositories', 'Configure the Ubuntu repositories', 'sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"

sudo apt-get update
sudo apt-get install postgresql-9.6', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('cf9cf137-30cf-42af-a8af-61391c1ef607', 31, 2, 32, 61, 62, 5, '09-done', 'Add the media keys', 'Add the media keys as follows:', 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('aeba1961-2f60-476c-a53a-827c6c0507a8', 32, 2, 33, 63, 64, 5, '09-done', 'Install the postgres package with apt', 'Install the postgres package with apt', '# update your repos
sudo apt-get update

# install the postgresql binary
sudo apt-get install postgresql postgresql-contrib

# enable postgre
sudo update-rc.d postgresql enable', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('1bbb5219-6ef7-451a-a829-3bef6950be67', 33, 2, 34, 65, 76, 5, '09-done', 'Change the postgres user password', 'Configure the Ubuntu repositories', 'sudo passwd postgres
# Type a pw - add to your password manager !!!

# and verify 
su - postgres', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('1378c267-c243-4739-8abd-67d60ee32fd5', 34, 3, 35, 66, 67, 5, '09-done', 'start the PostgreSQL', 'Start the PostgreSQL by issuing the following command', 'sudo /etc/init.d/postgresql start', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('c22eeadb-0f58-4c04-83f9-d845ebc995cf', 35, 3, 36, 68, 69, 5, '09-done', 'Start the pgsql client as the postgres shell user', 'Start the pgsql client as the postgres shell user
source:
http://dba.stackexchange.com/a/54253/1245', 'sudo su - postgres
# start the psql client
psql

# the psql prompt should appear as
# postgres=# 

# list the databases
\l
#and quit
\q', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('c6349fc6-5471-491d-a89c-bbf75906f619', 36, 3, 37, 70, 71, 5, '09-done', 'Create the pgsql user ', 'Create the pgsql user and grant him the privileges to create dbs and to connect to the postgres db. 
You could alternatively configure different way of authentication according to the options provided in this stackoverflow answer:
http://stackoverflow.com/a/9736231/65706', '# create the pgsql user to be the same as the shell 
# user you are going to execute the scripts with 
sudo su - postgres  -c "psql -c ''CREATE USER ''$USER'' ;''"

# grant him the priviledges
sudo su - postgres  -c "psql -c ''grant all privileges on database postgres to ''$USER'' ;''"

# grant him the privilege to create db''s 
sudo su - postgres  -c "psql -c ''ALTER USER ''$USER'' CREATEDB;''"

sudo su - postgres  -c ''psql -c "select * from information_schema.role_table_grants
 where grantee=''"''"$USER"''"'';"''', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d2014065-e135-4e28-b57f-540993ac27a7', 37, 3, 38, 72, 73, 5, '09-done', 'add the uuid generation capability enabling extension', 'add the uuid generation capability enabling extension', 'sudo su - postgres  -c "psql template1 -c ''CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";''"

sudo su - postgres  -c "psql template1 -c ''CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";''"', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('2813c75e-110c-4c68-8b58-3aa47a9f109b', 38, 3, 39, 74, 75, 5, '09-done', 'Install the dblink extension as follows', 'Install the dblink extension as follows', 'sudo su - postgres  -c "psql template1 -c ''CREATE EXTENSION IF NOT EXISTS \"dblink\";'' "', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('23fe49c4-06b8-4748-a096-52b343bff8c6', 3, 2, 4, 5, 6, 5, '09-done', 'Document status', 'This document is updated constantly in every release of the issue-tracker. Each version however is considered to be a complete version regarding the issue-tracker version it situated in.', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('f40720e3-db91-4caf-b1a9-0c9489a4fa5a', 39, 2, 40, 77, 78, 5, '09-done', 'Install the perl modules', 'Install the perl module by first installing the server development package', '
# check which server development packages are available
sudo apt-cache search postgres | grep -i server-dev | sort

# install it
sudo apt-get install -y postgresql-server-dev-9.6

# install the DBD::Pg module
sudo perl -MCPAN -e ''install DBD::Pg''

sudo perl -MCPAN -e ''Tie::Hash::DBD''', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('220f47b7-a946-41cd-812f-f9103de9ccff', 40, 1, 41, 80, 91, 5, '09-done', 'LOAD THE ISSUE-TRACKER PROJECT DATA', NULL, NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('fa7b76c3-500d-4f11-9609-7ee64a63894f', 41, 2, 42, 81, 82, 5, '09-done', 'Edit and pre-load the project env vars configuration file', 'As the issue-tracker supports loading data for multiple instances of itself - dev,tst,prd AND multiple pre-configured projects, YOU MUST have a shell with the pre-configured set of environmental variables in order to achieve ANY of the actions.', '# load the bash func to parse the conf files
source lib/bash/funcs/parse-cnf-env-vars.sh

doParseCnfEnvVars cnf/issue-tracker.dev.$(hostname -s).cnf', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('a269d579-a52e-48ea-9a35-ae1de3aafda1', 42, 2, 43, 83, 84, 5, '09-done', 'Create the database and run the DDL scrripts', NULL, 'bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('9eb4352f-9824-41df-8d95-bdff9cf888ac', 43, 2, 44, 85, 86, 5, '09-done', 'Start the mojo and hypno servers', 'The morbo dev server is listening on the 3000 port by default and the hypnotoad on the 8080 by default. You will need to use either one when loading the tables in the next step. ', 'bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('cf63dc98-71fd-46e1-a11e-1300bc494fd3', 44, 2, 45, 87, 88, 5, '09-done', 'Load the data from the xls file', 'Load the data to the db from the xls file', 'clear ; export tables=`curl -s -k http://$web_host:8080/$postgres_db_name/select-tables|jq -r ''.| .dat| .[] | .table_name''|perl -ne ''s/\s+/,/g;print''`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db', '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('76e73c2e-b8b7-4cae-937c-0150ebd25cdf', 45, 2, 46, 89, 90, 5, '09-done', 'Verify that the app layer and the db work together', 'In the aws menu click Services - EC2. Click on the instances on the left. Check the public DNS name of your instance and use it for the URL as follows:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/yearly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=20&page-num=1', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('4ee34f6c-737a-4028-bc7d-64744243f39a', 4, 2, 5, 7, 8, 5, '09-done', 'Audience', 'This document is aimed for everyone, who shall, will or even would like to interact with an issue-tracker application instance. Although this guide is aimed to be fully implementable via copy paste by following top to bottom, you need to have basic understanding of networking, protocols and Linux in order to complete the full installation, as your mealige will vary...', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('eddd9e10-28a1-428b-98fa-39eb99200e98', 5, 2, 6, 9, 10, 5, '09-done', 'Master storage and storage format', 'The master storage of this document is the master branch of the issue-tracker release you are interested in. The main storage format is Markdown. ', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('28dfc07d-9c17-40ac-9856-12a6ad7d7980', 6, 2, 7, 11, 12, 5, '09-done', 'Version control', 'The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the issue-tracker version, in which this document residues.', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('7aa280f1-fe31-46f7-a8b1-42dd24049fa3', 7, 2, 8, 13, 14, 5, '09-done', 'Process', 'The issue-tracker provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behavior of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.', NULL, '2018-12-30 17:05:42', 'bash');
INSERT INTO public.installations (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('7bd90fb5-95e1-4af8-a787-91f6b65194dc', 8, 1, 9, 16, 31, 5, '09-done', 'OS LEVEL ACCESS', 'The issue-tracker has been deployed on Ubuntu OS running virtual machines , physical hosts and aws instances. ', NULL, '2018-12-30 17:05:42', 'bash');


--
-- Data for Name: meta_columns; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('52189bff-d2f9-46b9-b8ba-e2ccd96a6bc7', 181206221152, 1, 'userstories', 'lft_rnk', NULL, true, NULL, '2018-12-06 22:12:06');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('e3f1d0b1-ec58-4bcb-babd-408ae09e8036', 181206221206, 1, 'userstories', 'rgt_rnk', NULL, true, NULL, '2018-12-06 22:12:34');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('aaaeea54-5b28-4f15-ab2b-7dad52f459bd', 181125050540, 1, 'monthly_issues', 'name', NULL, false, NULL, '2018-11-25 17:05:40');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('a982d70f-b9b2-4461-b7d6-549c091c3d61', 181125151422, 1, 'meta_columns', 'update_time', NULL, true, NULL, '2018-11-25 16:14:33');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('c8b49506-8306-48e9-93a2-4789c80411e1', 181125104502, 1, 'monthly_issues', 'start_time', '_', true, NULL, '2018-11-25 16:37:34');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('3f45c255-7168-4369-b786-11ca1c9f5dcd', 181125163726, 1, 'monthly_issues', 'stop_time', NULL, true, NULL, '2018-11-25 16:39:15');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('ace21c06-d7b3-45ae-a4f7-da96291d8050', 181125163903, 1, 'monthly_issues', 'planned_hours', NULL, true, NULL, '2018-11-25 16:39:42');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('106265e2-073d-43a4-81c7-2eb3d0cb8905', 181125104525, 1, 'meta_columns', 'guid', '_', true, NULL, '2018-11-25 16:07:11');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('d95f237e-00e5-4b46-acba-d89ba7099296', 181125163942, 1, 'monthly_issues', 'seq', NULL, true, NULL, '2018-11-25 16:57:10');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('42681e08-31d8-425c-9f17-369561c0ed39', 181125165700, 1, 'monthly_issues', 'level', NULL, true, NULL, '2018-11-25 16:57:52');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('2af06c04-c8b7-4847-8bef-77b77546b520', 181125165752, 1, 'monthly_issues', 'actual_hours', NULL, true, NULL, '2018-11-25 16:58:01');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('1aaeea54-5b28-4f15-ab2b-7dad52f459bd', 181125150540, 1, 'yearly_issues', 'name', NULL, false, NULL, '2018-11-25 17:05:40');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('253c36a0-b1c4-4bbc-aff0-dfe62688ce6a', 181125065803, 1, 'yearly_issues', 'update_time', NULL, true, NULL, '2018-11-25 16:58:17');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('a8b49506-8306-48e9-93a2-4789c80411e1', 181125004502, 1, 'yearly_issues', 'start_time', '_', true, NULL, '2018-11-25 16:37:34');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('2f45c255-7168-4369-b786-11ca1c9f5dcd', 181125063726, 1, 'yearly_issues', 'stop_time', NULL, true, NULL, '2018-11-25 16:39:15');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('1ce21c06-d7b3-45ae-a4f7-da96291d8050', 181125063903, 1, 'yearly_issues', 'planned_hours', NULL, true, NULL, '2018-11-25 16:39:42');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('195f237e-00e5-4b46-acba-d89ba7099296', 181125063942, 1, 'yearly_issues', 'seq', NULL, true, NULL, '2018-11-25 16:57:10');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('32681e08-31d8-425c-9f17-369561c0ed39', 181125065700, 1, 'yearly_issues', 'level', NULL, true, NULL, '2018-11-25 16:57:52');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('1af06c04-c8b7-4847-8bef-77b77546b520', 181125065752, 1, 'yearly_issues', 'actual_hours', NULL, true, NULL, '2018-11-25 16:58:01');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('153c36a0-b1c4-4bbc-aff0-dfe62688ce6a', 181125165803, 1, 'monthly_issues', 'update_time', NULL, true, NULL, '2018-11-25 17:13:04');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('4be7e57e-f306-4afd-98b9-7ba558d67bd2', 181125171311, 1, 'yearly_issues', 'tags', NULL, true, NULL, '2018-11-25 17:13:20');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('a4a6ecc0-c43a-4ded-a5cf-d736ec7e9186', 181125171301, 1, 'monthly_issues', 'tags', NULL, true, NULL, '2018-11-26 11:18:03');
INSERT INTO public.meta_columns (guid, id, prio, table_name, name, description, skip_in_list, width, update_time) VALUES ('2ffeea85-f182-4290-8862-64f71e26c552', 181126131754, 1, 'confs', 'update_time', NULL, true, NULL, '2018-11-26 13:02:07');


--
-- Data for Name: meta_tables; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.meta_tables (guid, id, prio, name, description, update_time) VALUES ('fb8ca4df-1bc9-4b52-8584-0efea90e2d97', 181023132814, 1, 'type the name ...', NULL, '2018-10-23 13:16:10');


--
-- Data for Name: monthly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.monthly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de4275e9-5822-4753-bfca-5712ade84fbf', 190106032514, NULL, NULL, 'task', 9, 'feature', '09-done', 1, 'add dynamic right menu in the view-doc page', 'As follows: 
 - easy open and close the right menu 
 - the scrolling for the left body content and the toc in the right works separately', 'unknown', '2019-01-06 03:25:14', '2019-01-06 03:25:14', NULL, NULL, NULL, '2019-01-06 04:07:56');


--
-- Data for Name: naming_conventions; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('ac1db772-5b61-4281-ad65-90f0417d4865', 181230153232, NULL, NULL, 'release-process', 'application layer versioning', 'The technical version of an instance is as follows: 
 - v<<MajorRelease>>.<<MinorRelease>>.<<MicroRelease>>

There are no HotFix releases !!!! All hot fixes and bugs are part of a single stream-lined release process

The end-goal is to produce an application, for which EVERY micro release comprises a full instance of the data, binaries , configuration software renewal ( which yes might include database migration as well ) ', '2018-12-30 15:38:58', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('a3076e1a-9b98-437b-8a29-3d323ebf7450', 181128171647, 5, 9, 'db', 'database names - <<env>>_<<project_name_alias>>', 'The database names contain the prefix to the environment to which this database as follows: 
 - <<env>> - the environment could be : dev,tst,prd,qas,stg,prd,src
 -- dev - a development database
 -- tst - db for testing
 -- prd - the production database 
 -- qas - a db for quality assurance 
 -- stg - a staging database ( usually used instead of both qas and tst)
 -- src - a database used for source code storage ', '2018-11-28 17:07:36', 'databases');
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('a43a830e-7b70-475d-8575-8afe9ac99934', 181214142155, NULL, NULL, 'db', 'url parameters', 'The following url params are in use:
 - with=<<attrigute>>-<<op>>-<<value>>
 - like-by=<<attribute>>&like-bal=<<value>>
 - fltry-by=<<attr>>&fltr-val=<<value>>
 - order ascending - oa=<<attribute>>
 - order descending - od=<<attribute>>
 - page-num=<<page-number>>
 - page-size=<<page-size>>
 - pick=<<attr1>>,<<attr2>>,<<attr3>>
 - for=<<string-to-search-for>>', '2018-12-14 14:27:57', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('6bdb89fe-e800-471a-92b2-3f0084ea8e41', 181128171016, 1, 5, 'db', 'table triggers - trg_<<table>>_<<action>>_<<column>>', 'Where : 
 - <<table>> stands for the table of the table trigger
 - <<action>> could be insrt,upsrt,updte,del
 - <<column>> the column to which the action is applied to', '2018-11-28 16:59:58', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('05ff41c2-9989-4caf-9b43-328992c8dd57', 181219112330, NULL, NULL, 'architecture', 'Writer classes', 'All Writer classes according to the IOMC architecture are responsible for writing data from the application perspective into some target media  and their naming convention is : 
Wtr<<TargetMediaType>> for example: WtrFile
WtrDir
WtrPostgresDb
WtrMariaDb', '2018-12-19 11:25:45', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('b6e82463-95a2-4f8b-a8ff-1a27aae2a1b7', 181219120154, NULL, NULL, 'dev', 'object names ', 'all the objects are named with the obj pre-fix and the name of the class ... which reduces the amount of associations the developer has to do for each object and also improves the time to open the class file of the object ... 
Examples:
objRdrFile
objRdrDir
objWtrDir
objWtrPostgresDB', '2018-12-19 12:12:40', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('12b4d6ad-ac3c-424b-a5aa-ec9889e19754', 181219112528, NULL, NULL, 'architecture', 'Converter classes', 'All Converter classes according to the IOMC architecture are responsible for converting data from one data structure ( in the volatile memory !!!) to another ( in the volatile memory !!! )  : 
Cnr<<SourceDataStructure>>To<<TargetDataStructure>> for example: 
CnrArrRefToHashRef
', '2018-12-19 11:27:37', NULL);
INSERT INTO public.naming_conventions (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('5bb7b156-36ff-40aa-8d60-e1d475d7ad8f', 181219112110, NULL, NULL, 'architecture', 'Reader classes ', 'All Reader classes according to the IOMC architecture are responsible for reading data from the application perspective and their naming convention is : 
Rdr<<DataSourceType>> for example: 
RdrFile
RdrDir
RdrPostgresDb
RdrMariaDb', '2018-12-19 11:23:40', NULL);


--
-- Data for Name: principles; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('b74cfbfb-5930-4555-8ef3-f6e2f1ba0032', 1807030320, 5, 9, 'business', 'The documentation is integral part of the application', 'Any application with missing,non-up-to-date or incorrect documentation is undermining the user-experience of its users on purpose.', '2018-08-06 18:23:47', 'biz');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('162c4337-4196-408d-bf75-da20b7a5a678', 1805110001, 5, 6, 'life', 'life complexity', 'Everything is interconnected in life.
Everything you do now is dependant and will be interdependent to everything happening to you. Thus do your best and leave the rest.', '2018-08-06 18:23:47', 'philosophy');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('c3202748-744b-4f7b-b480-97bb3a46980f', 180919090814, 5, 5, 'coding', 'wise naming of objects within their usage and context', 'The names of the variables , classes , methods , functions should such that they make the most sense within the context they are used in - not too explicit and verbose, nor too short. 
"Clever" naming to trick the reader of your code will inevitably trick first yourself ... So do yourself a favour and do not do it ...', '2018-09-19 09:08:14.010394', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('baa31544-48ae-48db-8b44-3c65389566c6', 1805311658, 5, 9, 'bugs', 'zero tolerance for bugs', 'A good software does not have bugs. It just works - it might be simple or even dummy looking, but it just works without bugs.
A bug is like broken window - have several of them and the value of your building will go down straight to zero.
The maximum amount known unresolved bugs at a current period of time should not be greater than 7.', '2018-08-06 18:23:47', 'bugs');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('ec193996-79ea-4f63-b3c6-e8f29c6e69fc', 1805150001, 5, 9, 'business', 'the busines is a matter of life and death', 'The business is a matter of life and death, thus it should be conducted according to its seriousness', '2018-08-06 18:23:47', 'life');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('1be42f71-848f-4975-aadf-1bae25bc7a48', 1805120001, 5, 7, 'realtions', 'aim for underpromise and overdeliver', 'Generally speaking in businesss and politics you wanto to underpromise and overdeliver and not vice versa', '2018-08-06 18:23:47', 'relations,marketing');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('6e09447b-80b0-400f-9e22-dc2c44ac341a', 1805100001, 5, 5, 'relax', 'invest in planning', 'Every well invested time in planning results in 2x to 10x improvement in efficiency.', '2018-08-06 18:23:47', 'efficiency, relax');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('e39af25b-5ee3-4596-b43b-d75036efebf0', 1805070001, 5, 5, 'relax', 'code for automation without tests is like attempting to build without scaffolding', 'Code for automation without tests is like building without scaffolding.', '2018-08-06 18:23:47', 'efficiency');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('1421f6be-74f8-4000-ade8-72c376db2fd0', 1806291841, 5, 8, 'code', 'unused features are WASTE', 'if the usage of feature is rare , better to remove instead of maintaining the code for it …', '2018-08-06 18:23:47', 'code,best-practices');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('74e52886-d43d-42ae-9e9a-7629505a074f', 1805130001, 5, 9, 'performance', 'aim for 10x improvement', 'Any activity which does not aim for more than a 10x impovement in the long run will be outcompeted.
Google.', '2018-08-06 18:23:47', 'performance');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('095ee668-907e-4221-8053-cf7eaae9512e', 180919091638, 5, 9, 'life', 'work output quality and quantity', 'Your work output quality and quantity reflect the work- and personal life balance at the moment of working', '2018-09-19 09:16:38.810094', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('add532b4-af68-4aaa-8e9c-c9aadb3a1764', 1805090001, 5, 1, 'communication', 'Complaining is easy, commitment towards working solutions proposals hard', 'Complaining is easy, proposing working solutions hard and committing for them hard In communication emphasize on WHAT needs to be done and provide reasoning only when asked / it is not obvious for the audience.', '2018-08-06 18:23:47', 'comms');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('50db07d4-049e-4399-aedb-fa39f0bf9fc3', 1805140001, 5, 9, 'performance', '10x efficiency gain with time invested in planning', '1 unit of time invested in planning usually saves 10 times more in execution', '2018-08-06 18:23:47', 'performance');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('ca16d803-05ed-469e-9ffd-e2a229c40d22', 180919091215, 2, 9, 'life', 'staying mentally and physically fit saves time', 'Working while not being at top of own physical and mental fitness leads to stupid mistakes and a lot of time wastage. 
You can increase that top line, BUT we are are humans, at least for now ...', '2018-09-26 22:29:55', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('3fcf6409-fc59-40b1-9157-abaf81d95553', 180919091423, 1, 6, 'code', 'use smallest possible logical units in the control flow', 'Any methood or function as a logical unit in the control flow execution should be as short as possible - thus, if it could be split into 2 or more units - do it asap !', '2018-09-26 22:25:48', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('bb10369a-3974-4f58-be44-b7a916def75a', 181005114203, 5, 5, 'biz', 'Issue-Tracker Instance Ownership', 'Each instance has an owner, which is responsible for EVERYTHING which happens to that instance before the organisation(s) using that instance. Thus, if you are an owner of an running issue-tracker instance you MUST ensure according to the requirements of your organisation the following:
 - the instance is up-and-running aka available
 - binaries, configuration, data and own software harmony
 - you and your org has the capability for disaster recovery
 - you have the capability to record who does what , when and why
If this principle is not met the issue-tracker instance cannot', '2018-10-05 11:52:27', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('195ab7a5-22a1-4ffb-85ea-da5797ba6b09', 180927105742, 5, 1, 'ui', 'The rule of 7 in UI', 'Humans usually do not grasp more than 7 items on a page', '2018-10-05 13:45:43', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('ff41a7b7-14f6-434f-97e0-a8a929c383f7', 181128162938, 1, 9, 'code', 'do not over-engineer in the beginning', 'Do it as simple as possible, but not simpler. Do not create probably un-used future abstractions. Add abstractions and factories only after they are really used by more than 1 code units. ', '2018-11-29 13:17:24', 'code,over-engineering');
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('60bf4785-389c-489e-be64-fd5afd810c88', 181127221553, 1, 7, 'code', 'code should be easy to browse', 'The code should be easy going even when you need to quickly browse it and not read it carefully - code units, identation, naming conventions ', '2018-11-27 22:16:11', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('69abf534-db1c-4622-9311-befe91774b93', 181203174749, 3, 9, 'code', 'do not add more complexity if you do not have sufficient control', 'If your current code base has symptoms  for being on the edge of being broken do not add more complexity in it, but first resolve ALL the issues which could be resolved:
 ', '2018-12-03 18:28:03', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('66a3ba1d-b6d8-4bc6-9b3b-e20b878853e4', 181127221401, 4, 6, 'setup', 'shorten the release cycle', 'The shorter the release cycle is the greater the real need for automation, the greater the possibilities to spot real-condition bugs and improvements', '2018-11-27 22:15:01', NULL);
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('b85365a0-814e-4f68-91ec-c50bb5354dfb', 181129132839, 2, 9, 'org', 'personal ego and rational decision making are incompatible', 'Sooner or later the personal ego will get in the way of rational decision making in organisation or undertaking - thus the lesser of the first the better ... ', '2018-11-29 13:17:37', 'ego,organisational');


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('9e51fbb3-e1ba-4ca1-8ef7-54522095fcd4', 1807031157, 1, 2, 5, 5, '03-act', 'architecture', 'documentation overbloat', 'The amount of the documentation becomes huge :
 - time consuming to keep up-to-date
 - who is going to read that ?!', 'Activate on those:
- split into smaller documents
- remove content which is developer oriented - they should know how-to check from the src code', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('b6925e6d-90c1-497e-9e12-e1dbc824c4af', 1706010100, 1, 1, 5, 5, '02-todo', 'testing', 'unit controls testing', 'how-to unit test ui controls', 'Install Joe Bergers chrome', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('c54b25e1-b80e-457c-ba31-98fae149fa64', 1804010100, 1, 2, 5, 5, '06-onhold', 'architecture', 'full stack architecture definition', 'Probably obsoleteGaps in the skills to define the full-stack architecture ...', 'Activate on those:
 - end-to-end testability', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('abc77ce6-2b59-46e7-b404-8d28003bee72', 1805070100, 1, 2, 9, 5, '06-onhold', 'architecture', 'the xls is crashing all the time', 'Ain''t crashing so often when ran straight from the mac … 
use it as less as possible. Recreate it from scratch by copying only the data. 
And data is lost when the vm is put into sleep mode … ', 'Activate on those:- run on mac- install the phppgadmi
 - create web json update and insert ui
 - enable db-to-json - json-do-db
 - php-admin ?!', 'ysg', '2018-11-10 23:46:22');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('e6f23d12-1430-4165-89bb-fbda9ad8a2f0', 1805010100, 1, 2, 9, 9, '09-done', 'testing', 'how-to describe the unit tests texts', 'The test names and descriptions should be part of the application content, linked to the requirements and userstories. ', 'Do not describe tests at all - tests are code and they should remain code , but do describe features and functionalities with guids. ', 'ysg', '2018-11-10 23:46:24');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('00458856-b96f-4d4b-a325-ec31844c64aa', 1806102335, 1, 2, 5, 5, '02-todo', 'setup', 'npm modules', 'the installed with npm installed modules are not transfered in the
Solution proposal: 
broserify ...
a long list of tools ... ', 'One of those ?! : 
 - npm install commands in the product instance install shell call ...', 'ysg', '2018-11-12 22:16:02');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('23b855ea-b061-454a-b98e-7eef11380cd8', 1805172131, 1, 1, 3, 7, '03-act', 'testing', 'the long term goals are quite ambitions compared to the allocated time', 'The scope of the application in terms of features is enourmous compared to the available allocated time ...', 'Try:
- work smarter, not harder
- attract more developers, by opennes and userfriendliness', 'ysg', '2018-11-10 23:54:53');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('72219045-040c-42c9-8cbe-689ada2f58e2', 1805171359, 1, 1, 4, 5, '03-act', 'performance', 'how-to implement minification ?!', 'A lot of data is lost when the code is not minified - this is also a potential financial cost ...', 'Some kind of Mojo::Plugin ?! Or external plugin ...', 'ysg', '2018-11-10 23:55:00');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('6989ae1e-304a-4ef6-8b28-a10695387200', 181110234630, NULL, NULL, 9, 9, '09-done', 'performance', 'slowness in the ui ', 'Remove the vuetify dept ?!
Yes !!!', NULL, 'none', '2018-11-10 23:47:19');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('391fced8-25ec-4c27-93ca-ac432e212d10', 181112204549, NULL, NULL, 3, 9, '02-todo', 'setup', 'how-to force update the css files on update', 'After every update the cached css files on the clients should be updated ... , but how ?! This should not be a big problem during the development time , but if bigger structural changes must be done after going life this will be big problem ... ', NULL, 'none', '2018-11-12 22:16:07');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('c34f52d9-a2c2-4278-b811-57fd254239de', 181123143848, NULL, NULL, 4, 9, '02-todo', 'design', 'the packaging takes too long time ...', 'the packaging should be ideally less than 20 seconds ... but it takes more than a minute ', 'Use xargs ... ?!
use tar ?
', 'none', '2018-11-23 14:29:05');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('5a094e1d-4254-4d77-974d-6d446434edba', 181110235500, NULL, NULL, 1, 9, '02-todo', 'refactoring', 'code repetition', 'A certain pattern for code repetitions appear: 
 - in the javascript code for the url ( params ) handling
 - in the backend for the perl modules hierarchy ... ', NULL, 'none', '2018-12-14 14:38:55');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('92ab00e9-f521-434b-a885-3dcf06439fe6', 1805312200, 1, 2, 2, 8, '02-todo', 'architecture', 'too much msgs floating around', 'the amount of messages becomes overwhelming , one cannot be able to manage them from a central location', '- keep the ( ret , msg , whatever , else ) in list context call order ... it just works ... - keep using the msg var for a msg , but what if there are other msgs ...  some kind of hash with message return code ? CallStatus type of object ?!', 'ysg', '2018-12-14 14:38:59');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('65c22915-6d1f-4513-9c0d-9a977c2226a5', 1805181956, 1, 1, 3, 7, '03-act', 'testing', 'complexity is building up ...', 'The more complexity is added to the system the more regression bugs occur .... 
Solution proposal: 
Simplify all the aspects of the ui.
Reduce the amount of use cases in the ui to the minimum ... 
Initial ', 'As follows:
 - separate the testing
 - route testing
 - data load testing
 - integration testing
 - client side JS testing', 'ysg', '2018-12-14 14:39:04');


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('e65e582b-a0ac-4b0d-9558-8cb1401137f5', 1806011127, 1, 1, 3, 8, '06-onhold', 'data-etl-fullstack', 'how-to copy efficiently items rows froom one project to another', 'the copy of items data from one project to another includes the copying via ui ( google sheet , xls )', 'ysg', '2018-08-12 14:37:34');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('a4b2fe97-db4d-4a71-8128-3e0111d959ef', 180901190013, NULL, NULL, 3, 9, '01-eval', 'ui', 'client-side changes to browser url', 'how-to learn to update the url params as soon as someone does stuff client-side on the browser without page refresh
 - use event handlers + axious for back-end fetch', NULL, '2018-11-13 11:06:19');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('8afc5b28-21b7-4228-a83a-44dfefbe90c8', 180807084003, NULL, NULL, 2, 9, '02-todo', 'ui-concept', 'how-to populate a hidden modal dialog with data from the back-end on-click', 'According to the following scenario :

 - list items 
 - click on edit item on the left 
 - the system fetches the data by the id of the row AFTER the click
 - the system shows the modal dialog with the form filled with the fetched data', NULL, '2018-11-13 11:04:21');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('009c4b63-191d-4da2-9eee-b1e49754a057', 180807091915, NULL, NULL, 5, 9, '02-todo', 'ui', 'how-to implement minification', 'A lot of data is lost over the wite as white space as minification has not yet been implemented', NULL, '2018-11-10 23:45:08');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('8b88f96a-1010-47a7-af83-e078af48202d', 181112103700, NULL, NULL, 2, 9, '02-todo', 'ui', 'how-to include js components in the mojolicious templating system', 'The whole stuff with WebPack etc. JS frameworks seems just overkill for both performance and learning curve ... 
', NULL, '2018-11-13 11:06:17');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('29f6a55a-2872-4760-89b5-38ebb9890fff', 1806130914, 1, 1, 9, 9, '09-done', 'ui-vue', 'how-to get a dynamic string into attribute with vue to generate the paging urls', 'The paging utilizes as much as possible simplified html pager, which should get the dynamic urls from the vue app methods.', 'ysg', '2018-11-13 11:03:57');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('4eb51ad8-bd3f-4faf-96e5-d2938c735422', 180828103835, NULL, NULL, 8, 4, '01-eval', 'design', 'level attribute design for non-hierarchy items - non-hitems', 'should non hierarchy items have or not have defined level attribute', NULL, '2018-11-13 11:09:16');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('a093dcb8-7166-423f-9288-b6f2086f91cb', 181110234301, NULL, NULL, 5, 9, '01-eval', 'ui', 'how-to indicate via the ui that a new search is to be done ', 'a home page ?! Some kind of reset button ?!
Solution Proposal: 
 - use the search page ... with empty search, but show the message from where we came from ... error ... warning ... etc. ', NULL, '2018-11-13 11:06:18');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('333ee90d-0dbe-43c1-8b34-f6d5d2c11367', 1805020101, 1, 1, 5, 9, '02-todo', 'issuee-tracker', 'how-to copy autogenerated data', 'we know how-to copy the non-autogenerated data from src db to another , yet has to copy it with the autogenerated uuid''s', 'ysg', '2018-11-13 11:04:07');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('1af39311-d9c4-4acd-b20c-7473b3175cb9', 180812143532, NULL, NULL, 4, 9, '02-todo', 'fullstack', 'why back-end fetch is needed in delete Item', 'why on the delete item one must fetch the data from the back-end and only client-side it does not work ?!', NULL, '2018-11-13 12:53:18');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('706d91b0-fba6-4d19-836c-9b6778b87538', 181113111752, NULL, NULL, 1, 9, '01-eval', 'security', 'how-to hash the passwords so that the password saving would be professional', 'Solution proposal: 
 - use the app hash + personal pwd to salt the passwords so that they would be salted in the database ... ', NULL, '2018-11-13 12:53:28');


--
-- Data for Name: quinquennially_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('02cab5c6-72a0-473b-940b-307e4cb6759e', 1806110013, 1, NULL, 5, 5, '03-act', 'ui', 'add dynamic switch of pre-defined ui themes', 'would require a totally new approach to ui design + possibly changes to the css dir structure', 'milestone', 'ysg', '2019-01-01 00:00:00', '2020-01-01 00:00:00', 100.00, 0.10, NULL, '2018-08-06 18:23:46');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5cee88d2-1ee7-44dd-8398-56ec74e29ac0', 1707200100, 1, NULL, 9, 1, '02-todo', 'feature', 'implement the copy by id via the back-end api from one table to another', 'implement the copy by id via the back-end api from one table to another', 'task', 'ysg', '2019-01-01 00:00:00', '2018-05-07 10:26:09', 20.00, 0.20, NULL, '2018-08-06 18:23:46');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3ac67766-7613-488d-b55e-86907133f55b', 180824090642, NULL, NULL, 6, 9, '02-todo', 'feature-ui', 'e-table with websockets', 'add instant update of the e-table via web-sockets

If one users updates the data, after it has been stored in the db it should be reflected in the contents of another user e-table', 'task', 'unknown', '2018-08-24 08:51:23', '2020-01-01 00:00:00', NULL, NULL, NULL, '2018-08-30 14:17:27');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3201908-eebd-4370-a81b-a59d35889046', 1806011302, 1, NULL, 1, 5, '03-act', 'issue-tracker', 'minimalistic MVP with basic auth in the web', 'Deploy to an amzn instance :
 - minimalistic mvp with gruds and basic ui
 - basic auth
 - multiple projects', 'goal', 'ysg', '2018-06-01 00:00:00', '2019-01-01 00:00:00', 450.00, 0.10, NULL, '2018-09-26 22:23:24');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('636d6a11-0c75-43ea-8856-b66bce3df1e7', 1807031404, 1, NULL, 2, 5, '02-todo', 'ui', 'add hierarchichal table listing page', 'Add listing for the hierarchical data:
 - should have visual differentiation between first level and sub-levels … ', 'milestone', 'ysg', '2019-06-01 00:00:00', '2019-12-31 00:00:00', 30.00, 1.00, 'ui', '2018-09-26 22:23:31');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f6e7301b-96d3-4c07-9240-ed3a35bbf6af', 1806011301, 1, NULL, 5, 5, '03-act', 'issue-tracker', 'complete secured instance in the web', 'complete secured instance in the web:
- OAuth2 , authorization and authentication 
- full CRUD ui for issues,projects,problems,questions,principles
- history data management
- time tracking biz features', 'goal', 'ysg', '2019-01-01 00:00:00', '2019-06-30 00:00:00', 450.00, 0.10, NULL, '2018-09-26 22:24:03');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aebb44b0-2d4b-4b6d-855e-204a39986c4c', 181005081114, NULL, NULL, 5, 9, '04-move-to-2019', 'capability', 'achieve capability for 5 min deployment', 'achieve capability for 5 min deployment to the cloud', 'task', 'unknown', '2018-10-05 08:08:14', '2018-12-30 22:00:00', NULL, NULL, NULL, '2018-10-19 18:49:10');


--
-- Data for Name: requirements; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('26237778-e3b4-4db0-aabd-b964db5648dc', 0, 0, 1, 1, 102, 5, 5, '03-active', 'REQUIREMENTS', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('b2b1db39-ca99-40ee-9785-e6801815dd20', 25, 3, 10, 16, 17, 5, 2, '09-done', 'Oneliner for Perl modules check', 'All the required Perl modules, must be verifiable via a single runnable perl script. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('c93cba08-c68a-443d-9f50-ce46f1c587e6', 26, 3, 11, 18, 19, 5, 2, '07-qas', 'Installation documentation', 'The installation of the required mysql and postgres db must be documented in the DevOps guide, which should have both markdown and pdf versions in the doc directory of the deployment package. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('b5bdaaf9-ffa9-4621-8762-d7274e4e3889', 28, 2, 12, 21, 26, 5, 2, '09-done', 'A full application clone should be ready for less than 5 minutes', 'A DevOps operator should be able to perform an application clone of the issue-tracker application in less than 5 minutes. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('ec815734-93d9-4a09-8b23-7a862b9ae351', 27, 3, 13, 22, 23, 5, 2, '09-done', 'Shell script for postgres db creation', 'The creation of the postgres database should be doable via a single shell call. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('b542198b-45c4-400f-9c3a-044bb25fef47', 42, 3, 14, 24, 25, 5, 5, '05-test', 'One liner for single restore', 'The full data example of a cloned from the issue-tracker db should be loadable with a single shell call. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('8da73d08-f987-4798-b801-a06aceac2a94', 3, 1, 15, 28, 39, 5, 1, '03-active', 'USER-FRIENDLINESS', 'The interaction with each endpoint and interface of an application instance should be as user-friendly as possble. 
As abstract as it may sound the tool must be multi-dimensionally and vertically integrated regarding the questions what,how and why towards a new person interacting with the tool by the usage of code comments,links from the documentations and uuids to be used for simple grepping from the docs till the source code. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('1978fa66-72f2-49c7-a729-410104a8adc1', 4, 2, 16, 29, 38, 5, 2, '03-active', 'Oneliner shell calls', 'The interaction of the application on the shell should be designed and implemented so that most of the features and bigger entry points should be accessible via one-liners on the shell - for example the testers should be able to lunch all the unit-tests via a single one line call. The integration tests should be triggerable via single oneline call. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('4ddb9862-28d5-4269-abc9-7d7b9df83ef4', 5, 3, 17, 30, 31, 5, 6, '09-done', 'Database recreation and DDL scripts run one-liners', 'The developers should be able to create the database via a single oneline call ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('f53fb350-a591-42d3-96f7-9740c3594f17', 6, 3, 18, 32, 33, 5, 6, '09-done', 'Table(s) load via aa single one-liner', 'The developers should be able to load a table to the database via a single oneline call ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a08ab6e2-f6cc-4c3f-879f-f25d2b359673', 7, 3, 19, 34, 35, 5, 6, '09-done', 'Testing one-liner call', 'The testers and the developers should be able to trigger all the unit or integration tests via a single one-line call. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('f68ad962-e826-4c28-ba05-7cd4c534b84a', 1, 1, 2, 2, 9, 5, 5, 'content', 'INTRO', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('3e3368ea-cdc6-4aa3-a817-68ec33839700', 29, 3, 20, 36, 37, 5, 6, '09-done', 'Test messages user', 'Each test should obey the following convention:
 - short message as descriptive within the context as possible - what is being tested
- a short technical example of the generated entry being tested ( for example a dynamic url )
- a uuid to search for from the Feature document what exactly is being tested within the context of the features description. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('afef76a3-62c4-4a4e-81eb-37116d6cb26d', 8, 1, 21, 40, 51, 5, 2, '03-active', 'RELIABILITY AND STABILITY', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('f21d0251-735f-4d47-b41b-be0fa48d1ee8', 30, 2, 22, 41, 42, 5, 5, '03-active', 'Zero tollerance towards crashing', 'Crashing in normally configured and operating environment must not be tollerated, as soon as any crash has occured a bug must be registered and the bug set with prio towards the features pipeline. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('144297be-9189-4fea-9af8-2ba704248c99', 44, 2, 23, 43, 44, 5, 5, '03-active', 'Zero tollerance towards bugs', 'All bugs and inconsistencies must be delt with top priority bypassing new features implementation. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('15bcdf51-0928-42e5-9e23-0a6dbfaf62ec', 32, 2, 24, 45, 46, 5, 5, '07-qas', 'Daily backups', 'Daily backups should be show-stopper for the normal operation of the application - that is if an instance is to be considered as normally operating , the daily backups should be performed automatically as indispensable part of the functioning of the application. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('133a4305-8385-4ee3-b6c9-68502d0d03a4', 9, 2, 25, 47, 48, 5, 5, '03-active', 'Logging', 'The application shoud support configuratble logging to STDOUT and STDERR for the following levels - debug,info,warn', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('c8cee173-5bce-4a9a-8339-b7f6fbe9a539', 52, 2, 26, 49, 50, 5, 5, '03-active', 'Full backup to the cloud in less than 5 minutes', 'A gull backup of sotware,configuration and data for the issue-tracker and/or another project database should be doable in less than 5 minutes. The backup should be easily searchable from the cloud as well. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('711f591f-5500-45fd-905c-f3f6f2793084', 11, 1, 27, 52, 59, 5, 5, '03-active', 'SCALABILITY', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('1e7e1c36-8743-45a2-a4bb-ae4a7469bcb7', 12, 2, 28, 53, 54, 5, 1, '03-active', 'Feature scalability', 'The addition of new features should be as scalable as possible. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('7b9548b7-bd01-4e8b-8168-ab0c08e00ed9', 13, 2, 29, 55, 56, 5, 5, '03-active', 'Setup scalability', 'The creation of new instances of the application should be as easy as possible. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('2f149508-f5d3-4363-a1b5-899c97d564f0', 49, 2, 3, 3, 4, 5, 5, 'content', 'Purpose', 'The purpose of this document is to present the requirements set to the Issue-Tracker application for this current version.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('680222a8-c94d-4f38-ab46-e631b04c8003', 45, 2, 30, 57, 58, 5, 5, '03-active', 'Projects databases scalability', 'Each instance of the issue-tracker application must be able to connect to one or many project databases which DDL schemas matching the current api of the application.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a57f2d6f-bc46-4052-a68f-dc614b54dc46', 14, 1, 31, 60, 65, 5, 3, '03-active', 'PERFORMANCE', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('f793464d-c63b-4b3b-9e28-e5b44bd86eb7', 15, 2, 32, 61, 62, 5, 1, '03-active', 'Page load maximum time', 'Each page of the application containing less than 2000 items MUST load for less than 0.3 seconds.
Any new feature which does not meet this requirement should be disregarded or implemented into a clone of the application with different name ( see the cloning / forking section bellow ). ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('bdabbd9b-bef5-42c9-830c-3889fd18fb33', 43, 2, 33, 63, 64, 5, 5, '03-active', 'Login, logout', 'Every login and logout operation MUST complete in less than 0.3 seconds in modern network environments', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('7ae7f96e-5721-4b9f-bba2-880142e05ba1', 16, 1, 34, 66, 71, 5, 2, '03-active', 'MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a96ef9bb-8217-4792-86a5-6725243f30a2', 31, 2, 35, 67, 68, 5, 5, '03-active', 'Environment type self-awareness', 'Each deployed and running instance of the issue-tracker must "know" its own environment type - dev,tst, qas or prd to comply with the multi-instance architecture on a single host. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('57106664-e09c-4502-af18-d478000a82c4', 17, 2, 36, 69, 70, 5, 5, '03-active', 'Cross running between instances of different types', 'The application layers should support as much as possible cross running between different application layer instances and database instances - for example a dev appalication layer should be able to fetch data from a prd database. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('ef94cc0f-4600-43bd-a9cb-b6e51d7e9bd7', 35, 1, 37, 72, 81, 5, 2, '03-active', 'UI REQUIREMENTS', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a195be90-91d8-481b-b39a-ab4829636ace', 34, 2, 38, 73, 78, 5, 5, '03-active', 'CRUDs', 'The System must provide the needed UI interfaces to Create , Update , Delete and Search items in the system for the users having the privileges for those actions
Any modelled item in the database must be capable for:
 - create 
 - update
 - delete
 - search', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('d2be0aba-c1a1-4c34-9233-fd31f7e5671d', 46, 3, 39, 74, 75, 5, 5, '03-active', 'Execution time', 'The full execution time of any crud operation ( create,update,delete,search) from the end-user of the UI point of view should be less than 0.3 seconds', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('bf5c742c-79c0-4fff-bb59-a254bd43e6e7', 50, 2, 4, 5, 6, 5, 5, 'content', 'Audience', 'This document could be of interest for any potential and actual users of the application. Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('8cd921b4-a8bd-43d7-ac03-fdbd6b28834a', 47, 3, 40, 76, 77, 5, 5, '03-active', 'Visual indication', 'The System should not show ok messages , but only error messages, yet the UI should be as responsive that the end-user would easily undertand when an item has been created,updated or deleted.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('2983e6ef-c936-4d78-8332-8e9532ccbee1', 36, 2, 41, 79, 80, 5, 5, '03-active', 'Clarity on errors', 'The UI must present every error in a clear and concise way, so that the end-user would understand that an error has occured, however no msgs should be displayed when the data is saved properly. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('757f0367-a3a3-467c-ad95-049c73306d52', 53, 1, 42, 82, 95, 5, 5, '03-active', 'SECURITY', 'An well operated instance of the issue-tracker application should have security corresponding to the data sensitivity it is operating on. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('043055d7-c07c-469a-a6f8-316a310d312d', 54, 2, 43, 83, 92, 5, 5, '03-active', 'Authentication', 'Users should by authenticated via a standard implementation of web tokens. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('fbdecda3-8a8a-4839-89fb-6d4832b58007', 58, 3, 44, 84, 85, 5, 5, '09-done', 'Non-athentication mode', 'Any issue-tracker instance should support a non-authentication mode - that is all users having http access could perform all the actions on the UI without restrictions', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('32e81575-7d4f-42cb-b101-bfb8512c7997', 59, 3, 45, 86, 87, 5, 5, '09-done', 'Basic authentication mode', 'An issue-tracker instance running under basic authentication mode should support single system user per project database authentication, which must have full acess for the all the available actions via the web ui. 
It is worth noting that each issue-tracker instance having access to data resources should meet the requirements on organisation''s level for data access - i.e. if instance dev has full access to the dev,tst,prd project databases there is no rationel of having basic authentication on the prd instance having access to the same dev,tst,prd databases. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('4907a947-d2d9-43de-ae26-671a0c81e2d7', 55, 3, 46, 88, 89, 5, 5, '03-active', 'Native authentication', 'The issue-tracker should support native web tokens based authentication, by using as login a valid user e-mail and password, stored in the issue-tracker database. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a976a272-05f1-44f3-880a-d47405c11666', 56, 3, 47, 90, 91, 5, 5, '03-active', 'Web SSO authentication', 'The issue-tracker should support authorization', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('a976a272-05f1-44f3-880a-d47405c11661', 57, 2, 48, 93, 94, 5, 5, '03-active', 'Authrorisation', 'The SysAdmin of any instance should be able to add users to the issue-tracker instance. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('722b366f-1ff9-4357-8f55-8a88484a60ab', 38, 1, 49, 96, 101, 5, 2, '03-active', 'DOCUMENTATION', NULL, '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('2d951d9a-2fd6-4e20-af2d-7575c52f8c64', 51, 2, 5, 7, 8, 5, 5, 'content', 'Related documentation', 'This document is part of the Issue-Tracker application documentation-set, which contains the following documents:
 - UserStories - the collection of userstories used to describe "what is desired"
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - Features and Functionalities - description of the current features and functionalities

All the documents should be updated and redistributed in combination of the current version of the appilication and should be found under the following directories:
doc/md
doc/pdf
doc/xls
according to the file format used for the documentation storage.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('0b53d1f1-39b9-4ff9-ad2a-522e6fc5a727', 39, 2, 50, 97, 98, 5, 5, '03-active', 'Documentation completeness', 'Each running instance MUST have the following documentation set :
 - Features and Functionalities doc
 - DevOps Guide
 - Requirements
 - SystemGuide
 - UserStories document
 - Installation and Configuration Guide
in at least the md and pdf file formats.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('e21a5090-f313-4553-9b55-80124137fa5d', 40, 2, 51, 99, 100, 5, 5, '03-active', 'Documentation and code base synchronization', 'Each running instance MUST have its required documentation set up-to-date. No undocumented or hidden features are allowed. Should any be missing or misreported a new issue must be created to correct those with top priority. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('ac2a5a9a-6caf-4f0a-adc8-8ba75352fa89', 22, 1, 6, 10, 27, 5, 1, '05-test', 'DEPLOYABILITY', 'The issue-tracker must be easily deployable on any Unix like OS. Windows family based OS''es are explicitly out of the scope of the issue-tracker tool. Any issue-tracker instance should be configurable as easily as possible for the version it has.  ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('5383b4c2-ad83-43e5-94c0-1d84c4954254', 41, 2, 7, 11, 20, 5, 5, '05-test', 'Full deployment in less than an hour', 'The full System should be ready for use in a "blank" OS host in less than an hour.', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('b3f4aee8-427e-46fd-8d97-7cfbabb5c455', 23, 3, 8, 12, 13, 5, 2, '05-test', 'Deploy by simple unzip', 'The issue-tracker tool could be deployed by a simply unzip of the full package, which must have all of the documentation and scripts to provide assistance for the setup and the configuration of the tool. ', '2018-12-30 15:02:49');
INSERT INTO public.requirements (guid, id, level, seq, lft, rgt, weight, prio, status, name, description, update_time) VALUES ('1adf89b9-6d6c-4d18-9c8c-2a5dc6763b35', 24, 3, 9, 14, 15, 5, 2, '09-done', 'Oneliner for prerequisite binaries check', 'All the binaries which are required for the running of the tool must be checked by a user-friendly binaries prerequisites check script', '2018-12-30 15:02:49');


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.skills (guid, id, seq, prio, name, description, update_time) VALUES ('1ee8e1ea-9f5a-44b8-a278-97627fe3d004', 180926181013, NULL, 1, 'a skill', 'a desc', '2018-09-26 22:24:42');


--
-- Data for Name: system_guide; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('7b045722-d135-4e11-a8d8-22df7ff21bcb', 0, 0, 1, 1, 36, 0, '03-active', 'ISSUE-TRACKER SYSTEM GUIDE', NULL, NULL, '2018-12-30 16:53:20', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('9f06e2ff-62c1-41bd-b474-fa5547f96fee', 1, 1, 2, 2, 7, 1, '03-active', 'INTRO', NULL, NULL, '2018-12-30 16:53:20', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('d5dcb129-34e3-4233-9812-b856e25eb309', 2, 2, 3, 3, 4, 1, '03-active', 'Purpose', 'The purpose of this guide is to provide description of the existing issue-tracker System and it''s architecture', NULL, '2018-12-30 16:53:20', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('aa4df001-b2c2-4557-a061-1a3a64f8e84d', 3, 2, 4, 5, 6, 1, '03-active', 'Audience', 'Any givien instance of the issue-tracker should have ONE and only ONE person which is responsible at the end for the funtioning of THIS instance - so think carefully before attempting to take ownership for an instance. The author(s) of the code are not responsible for the operation, bugs or whatever happens to a new instannce. As a responsible owner of an instance you could create, share and assign issues to the authors of the source code, yet there is no service level agreement, nor even promise to help. ', NULL, '2018-12-30 16:53:20', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('42227f4e-9e68-459c-8225-7174002264c4', 181230212520, 1, 5, NULL, NULL, 5, '03-wip', 'CONCEPTS AND DEFINITIONS', NULL, NULL, '2018-12-30 21:26:42', 'runtime...');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('e8d3e4ab-8ac6-41f2-b848-541acac6e778', 9, 3, 12, 16, 17, 5, '09-done', 'The Output Components', 'The Output Components are generally named as "Writers" Their responsibility is to write the already processed data from the Models into the output media . ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('de1bd860-ca17-4a4c-949f-65f399f8134b', 10, 3, 13, 18, 19, 5, '09-done', 'The Converter Components', 'The Converters apply usually the business logic for converting the input data from the Models into the app specific data back to the Models. ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('dfcb51fd-eba5-4a5c-ba62-9ab27e2e96dd', 11, 2, 14, 21, 24, 5, '09-done', 'Multi-instance setup', 'The multi-instance setup refers to the capability of any installed and setup instance of the issue-tracker application to "know" its version , environment type  - developement , testing and production ) and owner.', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('b6e17f2d-d1e1-4084-9b4c-e7c4d2b307cc', 12, 3, 15, 22, 23, 5, '09-done', 'Multi-environment naming convention', 'Each database used by the issue-tracker application has an <<environment abbreviation>> suffix refering to its environment type. Running application layers against different db versions should be supported as much as possible.  ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('bcf6ee88-101e-4e1c-9aac-abce3ebad013', 13, 2, 16, 25, 30, 5, '03-wip', 'Sofware architecture', NULL, NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('deacc214-0640-4893-a142-60de338f6855', 14, 3, 17, 26, 27, 5, '03-wip', 'Front-End', 'The Mojolicious Web Framework runs on top of a perl instance, which serves the back-end requests and passes back and forth json, as well as the ui Mojo templates dynamically, which combined with the vue template create the generic ui. ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('76194b5e-29c5-4fd0-9216-27ddc04c2786', 15, 3, 18, 28, 29, 5, '03-wip', 'Back-End', 'The id''s of the tables which ARE VISIBLE to the end users ui are big integers, which are formed by the concatenation of the year,month,day,hour,minutes and second in which the row in the table is created. ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('346efc0e-c4f2-406d-9944-1d807876133a', 4, 1, 7, 8, 31, 5, '02-todo', 'ARCHITECTURE', NULL, NULL, '2018-12-30 21:27:39', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('06eb4662-638b-4081-ad0c-4d839fc416ce', 16, 1, 19, 32, 35, 5, '03-wip', 'APPLICATION CONTROL FLOW ', 'This section provides a generic control flow description for the shell based and ui based control flows. ', NULL, '2018-12-30 21:27:28', NULL);
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('42d1b420-4ceb-496a-b2ae-028a7f711098', 17, 2, 20, 33, 34, 5, '03-wip', 'Shell control flow', 'The shell control flow is based on the control model input output architecture. ', NULL, '2018-12-30 21:27:28', NULL);
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('0cd12301-e97b-408a-a712-ec881478d19d', 5, 2, 8, 9, 20, 5, '09-done', 'IOCM architecture definition', 'The Input-Output Control Model architecture is and application architecture providing the highest possible abstraction for allmost any software artifact, by dividing its components based on their abstract responsibilities, such as Input, Output , Control and Model. ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('028606dd-75e1-4bc3-a054-2529b8279ca6', 6, 3, 9, 10, 11, 5, '09-done', 'The Control components', 'The Control components control the control flow in the application. The instantiate the Models and pass them to the Readers , Converters and Writers for output. ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('98dee852-5bd1-4154-97ad-bf037a7d85dc', 7, 3, 10, 12, 13, 5, '09-done', 'The Model components', 'The model components model the DATA of the application - that is no configuration, nor control flow nor anything else should be contained wihing the model. 
Should you encounter data, which is not modelled yet , you should expand the Model and NOT provide differrent data storage and passing techniques elsewhere in the code base ... ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('9d159edb-31f6-45e9-b83e-dc5d2bb551d7', 8, 3, 11, 14, 15, 5, '09-done', 'The Input Components', 'The Input Components are generally named as "Readers". Their responsibility is to read the application data into Model(s). ', NULL, '2018-12-30 21:27:28', 'bash');
INSERT INTO public.system_guide (guid, id, level, seq, lft, rgt, prio, status, name, description, src, update_time, runtime) VALUES ('065bab42-77d6-4a1a-b141-e3bf2f4c3871', 181230212739, 2, 6, NULL, NULL, 1, '03-wip', 'The issue-tracker IT System perspective', 'The success in the achievement for the goals of any IT System is derived from the success of the management in the following 7 entities:
 - humans
 - infra
 - hardware
 - binaries
 - configuration
 - data
 - source code
Thus should any of those components be failing or not in the level of sufficiency required by the others, the outcome would be according to the eakest link ...', NULL, '2018-12-30 21:32:06', 'runtime...');


--
-- Data for Name: test_create_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('5e586c62-8c06-4f62-bc69-b4efd54cf659', 20180106170815, 'type the name ...', 'type the description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('deba6e27-caf6-4395-9258-a86a4021b47c', 20180904191018, 'type the name ...', 'type the description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('0bd472d7-b70f-4201-8d7b-eb6ae21e00af', 20182214151135, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('ac1fbf2d-8b08-44d0-9d92-7d167cb2f2ee', 20181914171124, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('8ff2b415-14f7-423c-b029-e615b5ee438d', 20180014181146, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('760c7529-ecfc-4e63-be33-3bb761e1fb0d', 20181614181119, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('3ed90cf0-239b-40d4-83a8-c93ad7e463b9', 20182414191151, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('e61e0463-39ac-4929-85b9-415ac28384cb', 20182614191139, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('8c23d4c6-9a72-4956-9f1c-e9208d319cc2', 20181914211124, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('ed733994-3102-4139-a8dc-de81b6705c18', 20182614211152, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('d1577448-ebea-4501-8d69-3eb1c5262723', 20182321131124, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('5bb6f4b0-5345-4f82-b59f-403c43efc710', 20184521151105, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('9e3002c8-c1ef-4886-9115-c0fe3ed3a3a0', 20182710221206, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('97407ccc-7912-4f81-819a-10357af12d15', 20180610231219, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('2a11e821-b58f-4b0b-9387-34d0f294f702', 20180211181200, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('0947541a-9ebe-469f-8b70-1fee76107539', 20183911221209, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('90b4a5ec-7795-4402-8383-2fed1df260b3', 20185112151252, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('4052e605-a012-4dc6-97c3-12f5060938de', 20180312221209, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('a8a426a2-4b18-4bf7-a6da-de2654949157', 20185812221245, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('23a46a4d-127f-4d0b-8d31-cf7fd6c833ab', 20182913221207, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('d54af5e8-6c7e-4c67-8038-918289e29edb', 20185313221244, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('5b865777-a6e3-419f-926b-b0ce2fee96a9', 20183714141219, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('8d7d39c9-db7d-4112-b0dd-117f30414380', 20180015211232, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('df8ba28a-bfa2-4281-b36b-1115d1f0f3a5', 20182915211222, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('664e1d79-3832-47ee-8274-a0fcfa5e43bf', 20182724221200, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('cd201c30-af80-4e54-9dbf-2c7e566699eb', 20181525191233, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('66d693f9-75a8-44b7-8cdc-81580cdb6793', 20185529151222, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('e6d76938-5ae7-41d9-a1f0-1b9f86258832', 20184529161225, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('68fce9ee-6767-4356-acda-1142d843399e', 20184329211215, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('527367a7-66d0-4511-ab86-03f5dc0b900f', 20182929221240, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('bdcb6647-3674-45dd-b8e8-0913c0810841', 20184829221224, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('33357038-20a5-4bf2-ad5f-bc694b47930e', 20181330141245, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('198a0608-1f4d-406b-b6cf-ab6dbbf64811', 20185930151217, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('be625b9d-2540-431b-aa05-cc79376c6c83', 20185530161201, 'name ...', 'description ...');
INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('dd66c64a-fd85-417f-8bac-053889ab79c1', 20184430171243, 'name ...', 'description ...');


--
-- Data for Name: test_delete_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('f002d0f2-3fcc-4088-8cf3-612ce7722fa2', 2, 'name-2', 'the name attr should NOT be deleted');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('eefb536b-64dd-4448-8fc5-1ee27204b2f7', 20180014181104, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('a11228be-ccb9-4c85-9fce-a08d1fa487ab', 20180014181149, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('a34165da-c722-47ee-a8cd-94c89118f22e', 20181614181122, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('4c894379-bd5b-4a65-81f0-6316d4c0d608', 20182414191153, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('30c5b8fa-6888-4cee-8af6-fc250a5a875a', 20182614191141, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('86f95d7c-b0c1-4ff7-b17e-0f71329a5f4e', 20181914211126, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('66a89dac-6bd0-4486-bd7d-a8aab6e110ee', 20182614211154, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('8dc31396-7fe3-42e7-916f-8a8d51dcab29', 20182321131129, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('13aa6eb6-9b03-4f79-bf23-a7e8f4638556', 20184521151112, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('c8660994-0f1a-4224-9adc-b74fecdfac71', 20182710221207, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('aaca534b-3519-4575-9ead-b61428b48d3f', 20180610231224, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('0a64ff3b-68e3-4fdd-ac3d-1e6c89f06501', 20180211181203, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('b1379cbe-e716-40ad-8d55-6e8fa806e3d9', 20183911221211, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('1379031a-ca3c-47fe-a0bb-d3d5566baeff', 20185112151255, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('27f381c3-2d2f-4855-96f9-a40b4e16a694', 20180312221212, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('ee63a72e-85b6-43c4-8101-c24be455db4d', 20185812221248, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('448235a6-c103-4e39-b53c-3622c050f6ec', 20182913221211, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('2fcd67a1-57b2-41a6-a5d0-d3da094e42ee', 20185313221248, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('1b8569b0-095f-4c36-931b-e5c357291a25', 20183714141222, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('fa3c9ed5-86e6-4759-a1b0-fafe7cc3d7f2', 20180015211235, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('50b9d647-0082-416b-be2c-04aa776902c6', 20182915211226, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('bf9d3c8d-4250-468c-bc2c-ddaaced0579a', 20182724221203, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('f33b4522-cfd6-4e34-a9d8-50cf24975900', 20181525191236, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('7bde790b-6a0e-46ef-bd2b-b96a7a8c262e', 20185529151224, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('3c5fb7b7-0dd0-4ac3-92c5-3c18e2902412', 20184529161228, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('0afa8bbf-e94a-422e-8013-19add4eb6503', 20184329211219, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('3d64541b-4602-4cb4-a4e4-14010160865d', 20182929221243, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('cdc66ce3-3310-4b59-a547-bca0e89e7e23', 20184829221227, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('8c245b8b-012a-49f4-9550-a208a1d063c6', 20181330141248, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('fec06b0a-bd19-4932-b778-c9a6f1300422', 20185930151220, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('1b0e33e0-2a08-440d-8b3e-2c9f964e93b6', 20185530161205, 'name ...', 'desc ...');
INSERT INTO public.test_delete_table (guid, id, name, description) VALUES ('f77ee996-1ad1-4d50-a1c2-c966de91f698', 20184430171248, 'name ...', 'desc ...');


--
-- Data for Name: test_hierarchy_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('0f63d129-adce-4bb4-be74-86b5f4c1518a', 1, 0, 1, 1, 24, 'name-01 0.0.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('ef46f946-abc4-4371-9535-d0101990cc2e', 8, 1, 8, 14, 23, 'name-08 3.0.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('3bf3ea28-d82c-43a0-9b00-aeba4bb49849', 10, 2, 10, 17, 22, 'name-10 3.2.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('9a826eaf-498c-497e-baac-867883e2587b', 11, 3, 11, 18, 21, 'name-11 3.2.1', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('7d3c8fca-a04a-41c7-ba1b-102db7538412', 12, 4, 12, 19, 20, 'name-12 3.2.1.1', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('db8c2fee-f0b2-4c04-8d24-3960afbf06b0', 4, 3, 4, 4, 5, 'name-04 1.1.1', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('f23aa804-ec00-41aa-9c5f-08944298407d', 2, 1, 2, 2, 9, 'name-02 1.0.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('72c2c6e7-eaa3-4d32-a23c-d596f6c5913d', 3, 2, 3, 3, 8, 'name-03 1.1.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('1cb4b0b2-d226-4c53-8c6d-c4e5251a52ef', 5, 3, 5, 6, 7, 'name-05 1.1.2', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('64483ed5-2039-4305-a4aa-83aa10c0863d', 6, 1, 6, 10, 13, 'name-06 2.0.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('0d9abddc-201c-47c9-8605-9fde696bba2b', 7, 2, 7, 11, 12, 'name-07 2.1.0', NULL);
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('d3bc2682-e4a1-49fe-8b31-328eebec1749', 9, 2, 9, 15, 16, 'name-09 3.1.0', NULL);


--
-- Data for Name: test_hierarchy_table_expected; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('a7b9817d-d33b-4216-bdfd-0ba65720a196', 1, 0, 1, 1, 24, 'name-01 0.0.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('d50507e8-7b19-4150-9104-1ff4db45d372', 8, 1, 8, 14, 23, 'name-08 3.0.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('9d69e6ec-c1c2-41fd-a857-68ca23b27370', 10, 2, 10, 17, 22, 'name-10 3.2.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('4d9c2405-e23d-4aa4-a199-519e124a1966', 11, 3, 11, 18, 21, 'name-11 3.2.1', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('e2afe6a9-1a12-441d-aa02-6475c855043a', 12, 4, 12, 19, 20, 'name-12 3.2.1.1', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('466bafa4-2d40-4e2a-aeae-ce99650a484f', 4, 3, 4, 4, 5, 'name-04 1.1.1', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('4f919275-2ba0-4648-8fee-f1f1e4268f6d', 2, 1, 2, 2, 9, 'name-02 1.0.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('03db7236-8698-4656-91f1-2289bef6814e', 3, 2, 3, 3, 8, 'name-03 1.1.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('be7bf6bc-4516-4f20-a430-199c888d8721', 5, 3, 5, 6, 7, 'name-05 1.1.2', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('c43c01de-c8a7-4bb2-95e2-58896b8c6e5a', 6, 1, 6, 10, 13, 'name-06 2.0.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('a88d4eb3-8cc0-4655-8441-022aba484ac9', 7, 2, 7, 11, 12, 'name-07 2.1.0', NULL);
INSERT INTO public.test_hierarchy_table_expected (guid, id, level, seq, lft, rgt, name, description) VALUES ('ca2e1830-7bac-4e55-aac1-76229e3a51e7', 9, 2, 9, 15, 16, 'name-09 3.1.0', NULL);


--
-- Data for Name: test_item; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_item (guid, id, name, description, update_time) VALUES ('b1469f2a-243b-4d03-a93f-af28ea3c7342', 181009213610, 'name-01', 'desc-01', '2018-10-09 21:36:16');


--
-- Data for Name: test_item_hierarchy; Type: TABLE DATA; Schema: public; Owner: ysg
--



--
-- Data for Name: test_update_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('4132b638-5a34-4655-b820-440fa0a812e2', 1, 1, 'name-1-updated', 'the name should be updated to updated-name-1');
INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('e58e6dd2-1214-4efa-af26-8103a6d45f1b', 3, 3, 'name-3-updated', 'the name attr should be updated to updated-name-3');
INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('3e529e72-56ca-41f3-a229-783a0cc77973', 2, 2, 'name-2', 'the name attr should NOT be updated');


--
-- Data for Name: tst_paging; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('3df4096e-a8af-433d-841c-1057c0c44cf6', 1806100001, 1, 'name-01');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('356c38d7-dc01-4a28-a81a-9879b506b4da', 1806100010, 2, 'name-10');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('ed844679-2b98-4a73-988c-880ae3bcbcf1', 1806100011, 3, 'name-11');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('f16281f7-9f3d-4d41-9cf7-633827dc5e79', 1806100012, 3, 'name-12');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('782f2a9c-cf55-480d-bdd3-c55bc750bd84', 1806100013, 3, 'name-13');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('86e06791-6fed-4ee7-9014-503b53123cf3', 1806100014, 3, 'name-14');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('c34c103e-093a-49a9-8ac4-e7523743f4ea', 1806100015, 3, 'name-15');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('ba1ed9a1-e6a7-4888-8c4a-99d0703f3aa7', 1806100016, 4, 'name-16');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('166b46d7-2604-44a1-9800-0187c6f5e6a4', 1806100017, 4, 'name-17');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('620ad2b1-8c88-4ab1-ad29-8dbe9b6c1678', 1806100018, 4, 'name-18');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('ab8e2679-7e2f-4537-a919-66a2af59509d', 1806100019, 4, 'name-19');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('60b955bb-4668-45c9-8599-026469e0bfa5', 1806100002, 1, 'name-02');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('64f5a8d1-0ceb-4a63-adf4-94983a0ecff9', 1806100020, 4, 'name-20');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('11c69e57-824f-4e87-8906-13e53bae1cec', 1806100021, 5, 'name-21');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('787adf53-8cbe-4ef5-939b-becfa19fed48', 1806100022, 5, 'name-22');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('2589f8e5-79cc-492d-8865-989a7d05094c', 1806100023, 5, 'name-23');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('1e857de1-84ae-4436-80cb-971fca11d837', 1806100024, 5, 'name-24');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('93120abc-32e5-4bba-a124-ec00b84dd543', 1806100025, 5, 'name-25');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('6e1f69b3-e5fe-4c98-a90a-630a61433a9e', 1806100026, 6, 'name-26');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('32c27bd7-ee9f-475e-9652-265f7583752c', 1806100027, 6, 'name-27');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('2e210cc7-0790-4496-ab4c-e80ccc2056bb', 1806100028, 6, 'name-28');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('edfc7c08-a034-44a9-949d-5f0e6c946509', 1806100029, 6, 'name-29');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('2844e07e-f78b-4b8c-97f5-bb6e18d69c18', 1806100003, 1, 'name-03');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('94396065-5e48-4707-b905-1c7d4f4bbfec', 1806100030, 6, 'name-30');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('3d71d071-62b3-46ad-94e7-da36d091e5a4', 1806100031, 7, 'name-31');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('6d0ad84b-a901-411d-8d24-88e8f56c1b1f', 1806100032, 7, 'name-32');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('09d6eceb-44e6-4e24-a67c-3b11d92fb551', 1806100004, 1, 'tst_paging');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('55e7103a-0845-4194-bf32-a18be0dcef0c', 1806100005, 1, 'name-05');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('4252c188-4f66-4e26-89ac-69b56e618e33', 1806100006, 2, 'name-06');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('3d34ada8-8a67-4718-b5aa-94c830cb03c1', 1806100007, 2, 'name-07');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('d1bf06c6-c29e-4ff9-8c87-9af9d2330714', 1806100008, 2, 'name-08');
INSERT INTO public.tst_paging (guid, id, prio, name) VALUES ('c0e7ffd4-0db6-4563-8ba2-9cccb8fa4dd8', 1806100009, 2, 'name-09');


--
-- Data for Name: userstories; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('154ec773-acf7-4386-8233-bb0a4654d102', 0, 0, 1, 1, 322, '03-active', 5, 'ISSUE-TRACKER USERSTORIES AND SCENARIOS', NULL, '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4a9015ce-a127-4a5e-8e0d-c4143e4bffde', 9, 4, 10, 15, 16, '09-done', 5, 'Current project visibility', 'As a team leader
In order to avoid confusion between different projects 
I wanto to be able to see the current project name from any interface I am working in quickly and easily', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ed1cd62d-2859-4d88-8b40-0ae39a2ecd40', 99, 3, 100, 196, 201, '07-qas', 5, 'Load issues by xls-to-db action', 'As a cli user of the issue-tracker application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('778fb9bd-c395-4da1-bc52-8d811438a41a', 100, 4, 101, 197, 198, '07-qas', 5, 'Load issues by xls-to-db action for insert or upset', 'As a cli user of the issue-tracker application 
in order to insert or upsert my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load and specifying upsert by adding the guid column to the xls sheet ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ca3b890f-093b-4347-a81f-11298af6514a', 101, 4, 102, 199, 200, '07-qas', 5, 'Load issues by xls-to-db action by truncating or not the loadable table', 'As a cli user of the issue-tracker application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('21dc6669-664d-46c8-a5eb-64e856cb1b1a', 102, 3, 103, 202, 209, '07-qas', 5, 'Load issues by db-to-txt', 'As a cli user of the issue-tracker application 
in order to store my isssues in more structurized data format for further procesing
I want to :
- be able to load the issues for a period from the db to a file
- by choosing the names of the tables to load', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('af385dee-acb6-4583-8a92-b0b4d25dcafd', 103, 4, 104, 203, 204, '07-qas', 5, 'xls-to-db action load sort by issues prio attribute', 'As a cli user of the issue-tracker application 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the prio attribute 
by choosing the names of the tables to load', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('6dcddc62-512f-4152-8a47-fd7d477b8d76', 104, 4, 105, 205, 206, '07-qas', 5, 'db-to-txt action load sort by issues start_time attribute', 'As a cli user of the issue-tracker application 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the start_time attribute ( start_time could be in the following format YYYY-mm-dd HH:MM in start_time or HH:MM  )
by choosing the names of the tables to load', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9a466d96-dd35-4b6f-ba83-ac4f1f4d4365', 105, 4, 106, 207, 208, '07-qas', 5, 'db-to-txt action load sort by issues start_time attribute', 'As a cli user of the issue-tracker application 
during the db-to-txt action load
in order to view the issues by categories
I want to :
- be able to specify the order in the issues txt files lines to be based on the category attribute', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('bd2fd5f3-bfd3-46a2-a747-c01f20ce611c', 106, 3, 107, 210, 211, '02-todo', 5, 'Load issues file from db to file system', 'As a cli user of the issue-tracker application 
in order to store my isssues in more structurized data format for further procesing
I want to :
- be able to load the issues for a period from the db to a file
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('87e6c337-7628-4413-8c1c-fed477a101f6', 107, 2, 108, 213, 214, '02-todo', 5, 'issues file filtering', 'As a CLI user 
In order to filter quickly my issues 
I wanto to be able to show the issues with their categories of only certain status', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7e8dbbca-b6d8-4715-8d7b-0b74255b22b3', 108, 2, 109, 215, 216, '09-done', 5, 'Single shell call for projects switching', 'As an issues-manager 
In order to be able to switch between different projects quickly
I wanto to be able to issue a single shell call for loading a project''s configuration
and run the issue-handler against this pre-loaded configurtion', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('543c1eac-92a1-4b1e-8572-eb139c198cb5', 10, 2, 11, 19, 30, '02-todo', 5, 'Time management', 'As an team leader
In order to be able the maximize the performance of the team for issue-tracker used periods 
I wanto to be able to manage time efficiently 
by accessing a simple page containing its value and the period it is related to.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e4789a48-505d-4caf-8c4c-ef1322fcc307', 109, 2, 110, 217, 224, '03-active', 5, 'Issues publishing from shell calls', 'As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I wanto to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f79a40b3-ad9a-467c-a25b-ec644d6952fa', 110, 3, 111, 218, 219, '09-done', 6, 'Issues publishing in e-mail format', 'As a DevOps 
In order to be able to quickly share the current issues data in email format
I wanto to be able to issue a single shell call for copying the current items data to email by specifying the tables to be published', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('585025d8-2af9-4da1-be6e-ddfadfa3b126', 111, 3, 112, 220, 221, '02-todo', 3, 'Issues handling in google sheet format', 'As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I wanto to be able to issue a single shell call for copying the current items data to google sheet by specifying the tables to be published', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('36e8a825-d66e-46c6-8249-45de807ad683', 112, 3, 113, 222, 223, '02-todo', 2, 'Issues publishing in google calendar format', 'As a DevOps 
In order to be able to quickly share the current issues data in google calendar format
I wanto to be able to issue a single shell call for copying the current items data to google calenda by specifying the tables to be published for the items having set start_time and stop_time attributes. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2e348043-7bc1-40bc-8353-5b4649a66cb0', 113, 2, 114, 225, 226, '03-act', 4, 'Metadata handling', 'As a DevOps operator
In order to be able to programatically manage all aspects of my data
I wan to to have a single entry point to manage the meta data per tables , columns and UI elements
so that even a table, column or whatever object is not populated in the meta still there will be default values for it usable by the application', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('34914e07-65e5-414e-bbc6-5bbe5fa3aa2b', 114, 1, 115, 228, 315, '03-active', 2, 'COMMON UI PERSPECTIVE', 'As an UI user of the issue-tracker application 
In order to manage my issues via the UI successfully  
I want to have a nice user experience while using the issue-tracker application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('38faba84-1836-4698-9963-8f77a7bfee40', 115, 2, 116, 229, 234, '03-active', 5, 'UI Performance', 'As an UI user of the issue-tracker application 
In order to enjoy the usage of the tool and interact efficiently   
I wanto to  have responsive and quick UI.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c7556b60-64eb-49a1-b541-5cb84e6b689e', 116, 3, 117, 230, 231, '03-active', 5, 'UI Page load times', 'As an UI user of the issue-tracker application 
In order to enjoy the usage of the tool and interact efficiently   
I wanto to  have a maximum page load time on efficient network less than 0.5 seconds and preferably even less than 0.3 seconds', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c7556b60-64eb-49a1-b541-5cb84e6b689f', 117, 3, 118, 232, 233, '03-active', 5, 'UI Page parts load times', 'As an UI user of the issue-tracker application 
In order to enjoy the usage of the tool and interact efficiently   
I wanto to  have a maximum page part load time on efficient network less than 0.5 seconds and preferably even less than 0.3 seconds', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('65de1611-a21a-4479-aae4-4c0c38896eac', 118, 2, 119, 235, 236, '02-todo', 5, 'SEARCH', 'As an issue-tracker ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) 
I want to have a pop-up search SearchBox with dimmed background providing with interactive autocomplete, which would assist me in specifying the search criteria for any item I want to list. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9f6c32a8-0d31-4f6f-b9d9-9335e78b524d', 11, 3, 12, 20, 21, '02-todo', 5, 'Total planned time tracking', 'As a team leader 
In order to see the planned time left for achieving the goals of a period
I want to be able to have a +-3% approximation of the planned time left for a period
by accessing a simple page containing its value and the period it is related to', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2b302754-c83f-4dbc-a460-58cacf45f134', 119, 2, 120, 237, 242, '02-todo', 5, 'global search modal dialog ui', 'As an UI user 
In order to have the best possible search experience
I want to be able to search from a modal dialog UI which will pop-up on a dimmed background after the search-box is focused .. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7fccd29b-41f8-4cc7-9bb3-1d476f0f432e', 120, 3, 121, 238, 239, '09-done', 5, 'SearchBox autocomplete for changing the project ( databases ) ', 'As an issue-tracker ui user 
In order to be able to quickly switch between projects of the issue-tracker application instance I have access to
I wanto to be able to start typing with the ":to" operator and the System to autocomplete a dropdown of databases my instance has access to. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('af462019-c6ea-4d6c-9eb9-7ea0b2be4cb1', 121, 3, 122, 240, 241, '09-done', 5, 'SearchBox autocomplete for item-name', 'As an issue-tracker ui user 
In order to be able to quickly specify the name of the item I am searching for ( issue,problem,idea etc. )
I want to be able to use a special natural-language like syntax in the autocomplete when the SearchBox appears,
by having the System displayed the ":in" string and starting providing me autocomplete for the items names in a dropbox list I could choose from. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f7016b20-da9e-4b27-b2bf-61466b3cb665', 122, 2, 123, 243, 246, '02-todo', 5, 'search-autocomplete on modal search dialog', 'As an UI user 
In order to get quickly to exactly the searched item I am searching for
I want the System to present me with autocomplete of the mostly occuring string I am searching for with the name of the item on the left and when clicking on it I want it to open the list as grid page with all the items having this item in the search ... ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2a2e2c8d-d793-4355-a6bd-8cfb4099e5ec', 123, 3, 124, 244, 245, '01-eval', 5, 'SearchBox autocomplete for with <<attribute>> name <<operator>> <<attribute-value>>', 'As an issue-tracker ui user 
In order to be able to quickly specify the search criteria to re-strict the already chosen item to search for 
I want to be able to use a special natural-language like syntax in the autocomplete when the SearchBox appears,
by having the System displayed the "with:type-here-the-attribute op:type-here-operator val:type-here-the-value" string and starting providing me autocomplete for the filtering criteria. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('51e0602a-707a-4ee1-8846-a422387e0dc1', 124, 2, 125, 247, 260, '03-act', 5, 'Items listing', 'As an issue-tracker ui user 
In order to be able to quickly see as much items ( issues, problems, ideas etc. ) 
I want to list the items in a web page according to the filtering criteria I might have specified earlier on … ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('6ecaf03b-5665-43c5-8c8c-0835cd643d9b', 125, 3, 126, 248, 259, '09-done', 5, 'items listing in table format', 'As an UI user of the issue-tracker application 
In order to quickly display as much items ( issues,problems, questions, etc. ) as possible
I want to be able to list the items per period. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9b047e4c-e9a8-4a1a-9352-666750d14bc9', 126, 4, 127, 249, 250, '09-done', 7, 'Automatic issue items sequencing', 'As an UI user of the issue-tracker application 
In order to save time while arranging all the different issue items
I want the System to automatically sequence each item in list view by a defaut incremental sequence unless I have specified my own sequence. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2e48bc54-9d90-4c6a-bb0b-4946fb25bfe2', 127, 4, 128, 251, 252, '02-todo', 5, 'items re-ordering by desired or defaut attribute in list view', 'As a UI user 
In order to prioritize and re-arrange to a logical sequence my items 
I wanto to be able to drag and drop items up and down , 
which would correspondingly increase or decrease their attribute to which they are currently sorted or ordered by. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c3482f37-0a06-4365-abb1-3876b514f998', 128, 4, 129, 253, 254, '09-done', 5, 'items list default row height', 'As a UI user 
In order to quickly comprehend the data in the lists  
I wanto each row of the ui to have a certain minimum height and whenever the data cannot fit into this height to be greater than it', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('19a91273-a2b5-4f9b-ba79-64f72eab72a5', 12, 3, 13, 22, 23, '02-todo', 5, 'Total remaining allocated time tracking', 'As a team leader 
In order to see the remaining time left for achieving the goals of a period
I want to be able to have a +-3% approximation of the allocated time left for a period', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('09c78990-40cd-44ad-af1d-5504723e36a9', 129, 4, 130, 255, 256, '02-todo', 5, 'Drag and drop columns in table to reorder columns order', 'As the UI user of an issue-tracker instance 
In order to list the attributes of an item in a order significant for the moment
I want to be able to drag and drop columns in the table so that the System would re-render the table with the new order. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('efb900f6-bd8c-4bf0-949b-fe3672adf1b2', 130, 4, 131, 257, 258, '02-todo', 5, 'Columns resizing in table listing', 'As the UI user of an issue-tracker instance 
In order to see better the contents in the table columns 
I want to be able to resize the columns width ( excel like or by other means ) ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('1cc34f32-2429-439d-8f19-d93272924fd3', 131, 2, 132, 261, 270, '09-done', 2, 'Items editing', 'As an UI user of the issue-tracker application 
In order to update the application data via the UI 
I wan to to be able to edit the data for ANY of the items in the application I have access to. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('cb48a07b-e616-4efc-bae4-4fcf0e44b1fc', 132, 3, 133, 262, 269, '02-todo', 5, 'Single Cell Items editing in list as table view', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item I
I want to be able to quickly navigate to the item to edit and update the data of exactly this item ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b95c3f83-7daa-4555-a2cc-c3ad5add4d6c', 133, 4, 134, 263, 264, '09-done', 5, 'Single Cell Items editing in list as table view in-line', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item I
I want to be able to quickly navigate to the cell of the table of the data I want to edit
and update the data by clicking with the mouse or navigating with the tab and typing the new data, so that when navigating out of the cell the data will be updated unless the Esc case has been clicked. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('354a73d1-e09b-48d0-a36d-8ce5a8ffe346', 134, 4, 135, 265, 266, '02-todo', 5, 'Items editing in list as table view via form', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item 
I want to be able to click on the edit button , fill in the poping-up dialog with the form of the full data of the item and clicking the Save button. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('00806e61-8a44-44d9-9b3d-c8a92d4e24b2', 135, 4, 136, 267, 268, '02-todo', 5, 'Refresh list on item edit', 'As an UI user of the issue-tracker application 
In order to see the updated list after editing it
I want the System to refresh the list according to the new updated value - that is for example if the order was set to be prio and the prio was updated, the page should be refreshed with the new prio order applied', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('189a90cd-8f32-4734-9b48-9ad0d55793a5', 136, 2, 137, 271, 276, '05-tst', 5, 'Items creation', 'As an UI user of the application 
I order to create new items in the application 
I wanto to be able to create them via the UI 
by clicking "create new button" and filling as few as possible data entries and clicking a Save button for ANY of the items in the application. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('6c87867f-4421-45fd-ba05-56c45c6fcf26', 137, 3, 138, 272, 273, '09-done', 9, 'Items creation inline', 'As an UI user of the application 
I order to create new items in the application 
I wanto to be able to create them via the edit-table listing UI page 
by clicking jsut "create new button" , 
when the System will add a new row which will appear automatically in top of the listing sorted by id ( which will be automatically generated based on the timestamp of the creation moment ) ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('987aa4eb-553b-497d-9c42-634c55f1334d', 138, 3, 139, 274, 275, '02-todo', 5, 'Items creation by form', 'As an UI user of the application 
I order to create new items in the application 
I wanto to be able to create them via the edit-table listing UI page 
by clicking jsut "create new button" , 
when the System will add a new row which will appear automatically in top of the listing and the edit form with the pre-filled "type the <<attribute-name >> will occur ...', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e20a3275-d31b-41ac-872e-3cabd662a77d', 13, 3, 14, 24, 25, '02-todo', 5, 'Total spent time tracking', 'As a team leader 
In order to see the spent time left for achieving the goals of a period
I want to be able to have a +-3% approximation of the spent time left for a period
by accessing a simple page containing its value and the period it is related to', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e3cc7651-a307-4c7d-99e1-6c4c5555dba7', 139, 2, 140, 277, 282, '02-todo', 5, 'Items deletion', 'As an UI user of the application 
I order to delete existing items in the project
I wanto to be able to delete them via the UI 
by clicking a "delete " button and confirming the deletion for the item', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('56473090-77f8-45ed-b7bf-91c9e5179786', 140, 3, 141, 278, 279, '09-done', 8, 'Items deletion inline', 'As an UI user of the application 
I order to delete existing items in the project
I wanto to be able to delete them via the UI 
by clicking a "delete " button and confirming the deletion for the item by clicking on the ok dialog presented by the System.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('efe452f0-6e07-4b5e-9ddb-68720494c407', 141, 3, 142, 280, 281, '02-todo', 6, 'Items deletion from the edit form', 'As an UI user of the application 
I order to delete existing items in the project
I wanto to be able to delete them via the UI of the edit form
by clicking a "delete " button in the form
and confirming the deletion for the item by clicking on the ok dialog presented by the System.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c9caeb86-b907-402d-bc29-e7baf1971808', 142, 2, 143, 283, 288, '03-act', 5, 'Items export', 'As an UI user of the application 
I order to export the data  of the items in the application 
I wan to to be able to perform every possible export in the UI from a single button click or a single url access. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7afa1a0e-4220-4447-87d2-ffe4450c2e1b', 143, 3, 144, 284, 285, '05-tst', 5, 'Items xls export', 'As an UI user of the application 
I order to export the data  of the items in the application into xls format
I wanto to be able to perform the exprot by clicking on an xls icon like button and point to the file path to save to the listed in the UI data', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7c01e2ab-c87d-4774-ab85-84dc8751ab10', 144, 3, 145, 286, 287, '02-todo', 5, 'Issues export to Google calendar', 'As the UI user of an issue-tracker instance 
In order to be able to visualize and manage my start- and stop_time having issues better 
I wanto to be able to export my issues to Google calendar 
', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('aacf3922-60bb-4ca4-bdd1-7e4c93618146', 145, 2, 146, 289, 292, '02-todo', 7, 'Items import', 'As an UI user of the application 
I order to import data  of the items in the application 
I wanto to be able to perform every possible import in the UI from a single button click and pointing to the file path of a file', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2cfe1fc9-ef87-42c1-a5ae-bd1a5aefdaae', 146, 3, 147, 290, 291, '02-todo', 8, 'Items xls import', 'As an UI user of the application 
I order to import the data  of the items in the application into xls format
I wanto to be able to perform the exprot by clicking on an xls icon like button and point to the file path to save to the listed in the UI data', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('18f1635d-de6e-493a-b6c0-a5f3f6216062', 147, 2, 148, 293, 294, '03-wip', 1, 'hierarchical items management', 'As an the ui user
In order to manage the hierarchical items in the application
I want to be able to manage by actions (list,create,update,delete,search) ANY hierarchichal items of the application in from a hierarchical doc format

 - by their id
 - by their sequence', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('5e2d688c-abd4-449f-97a9-6f9d4f8002b4', 148, 2, 149, 295, 296, '02-todo', 5, 'Items move', 'As an UI user of the application 
I order to move the items into different tables
I wanto to be able to move them from a button in the listing page by specifying the target table', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4e19494b-b6d6-4296-83d8-0f5fe1612d43', 14, 3, 15, 26, 27, '02-todo', 5, 'Tracking of issues per period', 'As a team leader 
In order to see the relation of the issues to the daily,weekly,monthly,yearly,quinquennially and decadelly periods 
I wanto to be able to manage the issues within those periods per period and mother period', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('05644e92-778e-4fa7-9f01-195952f3e041', 149, 2, 150, 297, 298, '03-active', 5, 'Mobile UI', 'As an UI user of the issue-tracker application 
In order to enjoy to be able to access it quickly on the go
I wanto to be able to use the same UI on an advanced mobile phones. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('6515254f-77c7-4fc3-8025-996bd2772097', 150, 2, 151, 299, 300, '09-done', 5, 'UI for accessing different projects', 'As an issue-tracker ui user 
In order to be able to quickly switch between projects of the issue-tracker application instance I have access to
I wanto to be able to access a web page providing autocomplete to preloaded configuration entries for the different projects', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('838e5590-b03c-4ae4-86e5-b68af8ecf3da', 151, 2, 152, 301, 302, '01-eval', 5, 'UI for Time management in Google Calendar', 'As an issue-tracker ui user 
In order to be prepare for issues such as ( events , tasks ) which have start and stop time
I wanto to be able to view the issues with the same title, start_time and stop_time in google calendar', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('efb900f6-bd8c-4bf0-949b-fe3672adf1b1', 152, 2, 153, 303, 306, '02-todo', 5, 'items data transfer between different projects', 'As the UI user of an issue-tracker instance 
In order to save be able to track my personal time usage between different projects and the different interdependancies 
I want to be able to move items data from one project to another via the UI', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e10c879a-32d9-439f-bfd8-b56e8f480a06', 153, 3, 154, 304, 305, '02-todo', 5, 'Copy an issue-tracker instance issue to  a google calendar event', 'As an issue-tracker ui user 
In order to be able to see my issues time-schedule via phone and browser in a calendar view
I wanto to be able to copy via the ui an issue as a new google calendar event', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('fdd19fea-3014-44c4-bdcb-f15556a93573', 154, 2, 155, 307, 308, '01-eval', 9, 'Issues import from Google calendar', 'As the UI user of an issue-tracker instance 
In order to be able to visualize and manage my  start- and stop_time having issues better 
I wanto to be able to import my Google calendar issues into my issue-tracker profile on an issue-tracker instance', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('11499460-7537-4e4f-af43-af7c8310e61b', 155, 2, 156, 309, 310, '01-eval', 9, 'Access issues txt format from email', 'As a user of the issue tracker tool 
In order to be able to access and read my issues from a mobile device
I wanto to be able to send each period txt file from the daily folder via gmail. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ecb51d9f-6bd4-4adb-9670-4952e002e5e9', 156, 2, 157, 311, 314, '01-eval', 9, 'Access issues data from Google sheet', 'As the biz user  of the issue tracker tool 
In order to be able to share and edit the data with multiple users authenticated within the Google eco system
I wanto to be able to access , edit and update the issues data from google sheeet', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('55225509-996e-4f49-9601-697d5862f908', 157, 3, 158, 312, 313, '01-eval', 5, 'Apply publish filter while posting to Google Sheet', 'As the biz user  of the issue tracker tool 
In order to show only relevant data to the future viewers of the published to Google sheets issues data
I wanto to be able to apply publishing filter for columns to be left unpublished per item table per project', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9657c30b-5436-41dc-8739-17a5465e6e63', 158, 1, 159, 316, 321, '03-act', 3, 'UI DEVELOPER PERSPECTIVE', 'As the UI Developer
In order to be able to deliver working solutions for the UI 
I wanto to have user friendly development experience. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('56569301-858c-4ce9-bb07-23885242a7db', 15, 3, 16, 28, 29, '02-todo', 1, 'tracking of issues per target product version', 'As Biz Manager 
I want to be able to track the issues development per target product version', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('a3bc8ce4-0784-4946-b0dc-db2baed0ee4f', 159, 2, 160, 317, 318, '03-act', 5, 'Easy setup for testability', 'As the UI Developer
In order to deliver working ui units 
I wanto to be able to quickly setup the existing project with minimalistic default set of data', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('a3bc8ce4-0784-4946-b0dc-db2baed0ee4a', 160, 2, 161, 319, 320, '03-act', 5, 'Code traceability by uuid', 'As the UI Developer 
In order to be able to grasp the inner working of the application
I want to be able to search by user-story uuid from the source code of the application', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('99b29243-7e32-4d5d-969b-8ce35de0e458', 16, 2, 17, 31, 48, '02-todo', 6, 'Security Management', 'As an team leader
In order to keep my business data secure 
I wanto to be able decide which users to which projects will have access to the data my issue-tracker application has access to. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b8692a45-e20d-433a-a60e-f69393c6a6ef', 17, 3, 18, 32, 41, '02-todo', 6, 'Users management', 'As an team leader
In order to keep my business data secure 
I wanto to be able decide which users to which projects will ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2ea5e85b-6033-4284-b856-1706236ba10b', 18, 4, 19, 33, 34, '02-todo', 6, 'Add new users to a project', 'As an team leader
In order to be able to add new users into a project
I wanto to be able to add them via the UI only by their e-mail address. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('632b264c-aef7-4dd1-b81b-9960b51b23ff', 1, 1, 2, 2, 49, '03-active', 4, 'TEAM LEADER BIZ PERSPECTIVE', 'As a team leader
In order to operate successfully one or many projects of my team(s)  
I want to have a nice user experience while using the issue-tracker tool.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('85dcfae4-8118-406c-aa85-f71887c5bcad', 19, 4, 20, 35, 36, '02-todo', 6, 'Update existing users in a project', 'As an team leader
In order to be able to update the existing users from a project
I wanto to be able to update their details via the UI only by their e-mail address. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('26dd0436-93f8-4572-8ed1-a2a046b9f081', 20, 4, 21, 37, 38, '02-todo', 6, 'Delete existing users from a project', 'As an team leader
In order to be able to delete the existing users from a project
I wanto to be able to delete their details via the UI only by their e-mail address. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('a9523b8e-4dae-44cc-81ec-1b8a738f0da5', 21, 4, 22, 39, 40, '02-todo', 6, 'Search for users in a project', 'As an team leader
In order to be able to search the existing users from a project
I wanto to be able to search their details via the UI only by their e-mail address. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('d4bf3369-4d62-4d96-86f6-bab8ed312a34', 22, 3, 23, 42, 47, '02-todo', 9, 'Users access management', 'As a team leader 
In order provide the persons and programs access to my project
I want to provide read, write access to the data and execute access ( run DDL''s) per table', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('60e9cafd-4bff-4358-9b93-1a793a794d26', 23, 4, 24, 43, 44, '02-todo', 9, 'Grant access per project', 'As a team leader 
In order to enroll authenticated users into the project I am responsible to 
I want to be able to grant them with access by only writing their e-mail into a text field and clicking invite button. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('901462ae-7409-4e58-8e78-fdec30fdff85', 24, 4, 25, 45, 46, '02-todo', 2, 'Personal data handling minimization', 'As a team leader 
In order to avoid legal obligations and complex procedures while handling personal data
I want to be able to handle the interpersonal exchange of data by collecting ONLY the e-mail of the persons or programs participating in the project', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f6ba9040-f47f-49ab-86ee-11aa9d4322a7', 25, 1, 26, 50, 109, '02-todo', 5, 'TEAM MEMBER BIZ PERSPECTIVE', 'As a team member
In order to operate successfully in the project  
I want to have a nice user experience while using the issue-tracker application
by being able to manage all the items in the application ( issues,questions,problems , etc. ) ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('581e8a70-0c4a-42a6-837b-a49e2c172df2', 26, 2, 27, 51, 64, '03-active', 5, 'Issues management', 'As a team member of the issue-tracker
In order to achieve the best possible efficiency during the work on one or many projects
I wanto to be able to manage the issues in those projects. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7ebe39a0-7d30-45eb-82da-5138ab0c318c', 27, 3, 28, 52, 53, '02-todo', 5, 'Create new issues', 'As an team member
In order to be able to manage multiple issues 
I wanto to be able to create , update and remove issues.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4e141874-aa87-420a-aff6-57aa0e0da575', 28, 3, 29, 54, 55, '02-todo', 5, 'Update existing issues', 'As an team member
In order to be able to manage new issues 
I wanto to be able to create issues via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9855733c-200c-40b0-8ed6-f6e641b1dbc8', 2, 2, 3, 3, 18, '03-act', 5, 'Projects management', 'As an team leader
In order to be able to manage multiple projects 
I want to  be able to create , update and remove projects.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b2a51d6b-1957-4894-94f6-e50cb90081f2', 29, 3, 30, 56, 57, '02-todo', 5, 'Remove existing issues', 'As an team member
In order to be able to stop the work on existing issues
I wanto to be able to remove issues via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('5a222927-2322-43e5-9d56-58423155c7f6', 30, 3, 31, 58, 59, '02-todo', 5, 'Search for existing issues', 'As an team member
In order to be able to change attributes of the issues I am responsible for
I wanto to be able to update the issues'' data. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('170c5a57-39e5-42c7-a4d3-e71cfcf21287', 31, 3, 32, 60, 61, '03-active', 5, 'Track issues progress', 'As an team member
In order to be able to quickly access existing issues
I wanto to be able to search the issues. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f5c960a3-273a-4bae-b20d-4f8e6f889e6b', 76, 2, 77, 151, 160, '09-done', 5, 'Logging', 'As a Full-Stack Developer
In order to quickly understand what is happening in the application
I wanto to have easy-to-use and highly customizable logging to both file and console.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('89de67f4-82b3-4d5a-b48c-5b041ddb0a94', 32, 3, 33, 62, 63, '01-eval', 5, 'Track issues history', 'As a team member
In order to keep track on what and when was planned on daily basis
I wanto to be able to keep track what was planned on a project term  - day,week,month,year,quinquennial or decade  
', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f5c32f3f-9625-4233-a427-59655b45383a', 33, 2, 34, 65, 78, '03-active', 5, 'Items management', 'As a team member of the issue-tracker
In order to achieve the best posible efficiency during the work on one or many projects
I wanto to be able to manage the Items in those projects, where items could be ( problems , questions etc. )', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('32c2e2e6-b48b-45ba-8c32-7bbc044cc9e2', 34, 3, 35, 66, 67, '02-todo', 5, 'Create new Items', 'As an team member
In order to be able to manage multiple Items 
I wanto to be able to create , update and remove Items.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e4e91885-443c-4e59-a0ad-c95b76190abe', 35, 3, 36, 68, 69, '02-todo', 5, 'Update existing Items', 'As an team member
In order to be able to manage new Items 
I wanto to be able to create Items via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('1d9af9fd-3d4e-43e6-b176-a17ce74e253f', 36, 3, 37, 70, 71, '02-todo', 5, 'Remove existing Items', 'As an team member
In order to be able to stop the work on existing Items
I wanto to be able to remove Items via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('a29fb135-e131-46a4-a037-7ae997de3c65', 37, 3, 38, 72, 73, '02-todo', 5, 'Search for existing Items', 'As an team member
In order to be able to change attributes of the Items I am responsible for
I wanto to be able to update the Items'' data. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('14dbd499-3dc6-4931-a59c-c0b477d3dd3c', 38, 3, 39, 74, 75, '03-active', 5, 'Track Items progress', 'As an team member
In order to be able to quickly access existing Items
I wanto to be able to search the Items. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9855733c-200c-40b0-8ed6-f6e641b1dbc7', 3, 3, 4, 4, 5, '03-act', 5, 'Create new projects', 'As an team leader
In order to be able to manage new projects 
I want to  be able to create projects via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4ea0e93a-20dd-47b8-b99d-04a861fc77ad', 39, 3, 40, 76, 77, '01-eval', 5, 'Track Items history', 'As a team member
In order to keep track on what and when was planned on daily basis
I wanto to be able to keep track what was planned on a project term  - day,week,month,year,quinquennial or decade  
', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('5188364b-d836-413f-9ee4-1168e08c448f', 40, 2, 41, 79, 94, '02-todo', 5, 'Track issues relations', 'As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I wanto to be able to access the related objects to an issue by means of a link', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('d7345d96-ab0e-46a6-ae8a-901bec8158f8', 41, 3, 42, 80, 81, '03-wip', 5, 'Generic search for items from a single entity ( table ) ', 'As a team member
In order to be able to find all the items from a single entity
I want to be search for those items from the UI of the application 
by using a single SearchBox UI interface. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c821d5b8-792f-4c98-97ec-91b6c5770129', 42, 3, 43, 82, 87, '05-tst', 5, 'Generic list for the searched items from a single entity ( table ) ', 'As a team member
In order to be able to list and review all the items from a single entity
I want to be able to review the searched items for those items from the UI of the application 
by using a single label forms like interface', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('d74528c1-0416-432e-ad7f-98221eeab546', 43, 4, 44, 83, 84, '05-tst', 5, 'Generic list labels for the searched items from a single entity ( table ) ', 'As a team member
In order to be able to list and review all the items from a single entity
I want to be able to review the searched items for those items from the UI of the application 
by using a single label forms like interface', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('dd31c756-d51e-4110-8d07-e3a1e96380f1', 44, 4, 45, 85, 86, '05-tst', 5, 'Generic cloud list for the searched items from a single entity ( table ) ', 'As a team member
In order to be able to list and review all the items from a single entity
I want to be able to review the searched items for those items from the UI of the application 
by using a single tag cloud like interface', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b315949d-753e-4155-a455-50cdc4e1acb9', 45, 3, 46, 88, 89, '03-active', 5, 'Generic create capability from UI for new items from a single entity ( table ) ', 'As a team member
In order to be able to create new items from a single entity
I want to be able to create new items from the UI of the application 
by using a simple form. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('99c823d9-4c79-42b7-b2a3-4afeeb31f5fb', 46, 3, 47, 90, 91, '03-active', 5, 'Generic edit capability from UI for existing items from a single entity ( table ) ', 'As a team member
In order to be able to edit existing items from a single entity
I want to be able to edit those  items from the UI of the application 
by using a simple form. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('f813b16e-d6da-464f-96e3-f2a411cc3222', 47, 3, 48, 92, 93, '03-active', 5, 'Generic delete capability from UI for existing items from a single entity ( table ) ', 'As a team member
In order to be able to delete existing items from a single entity
I want to be able to edit those  items from the UI of the application 
by using a simple form. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('25becd64-61a3-4635-a548-9ec7a3622762', 48, 2, 49, 95, 96, '02-todo', 5, 'Measure success', 'As a team member
In order to measure the success of the planned issues 
I wanto to be able to measure the deliverables of each issue by comparable metrics.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('967c9d60-9e39-41a1-bc86-20aefaae7937', 4, 3, 5, 6, 7, '02-todo', 5, 'Remove existing projects', 'As an team leader
In order to be able to stop the work on existing projects
I want to be able to remove projects via the issue-tracker', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('bf7fa6ad-f6c0-4d20-9363-bb4a80525be8', 49, 2, 50, 97, 98, '02-todo', 5, 'Monitor success', 'As a team member 
In order to monitor the success of the planned issues 
I wanto to be able to monitor the metrics of the issues. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('949ac3c9-9e90-473f-a3dd-e176e445500b', 50, 2, 51, 99, 104, '03-wip', 5, 'Time management', 'As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I wanto to be able to save their start time and stop time per issue in every possible interface', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7fa1fc81-0002-4816-b16a-9ec6153e6c28', 51, 3, 52, 100, 101, '03-wip', 5, 'time centric planning', 'As an issues-manager 
In order to be able to plan the issues data for a certain term - day,week,month,year,quinquennial or decade
I wanto to be able to perform all the features of the issue-tracker on that specific period regardless whether it is today , in the past or in the future', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4aaaa364-bc31-4708-9d45-1970edd65512', 52, 3, 53, 102, 103, '03-wip', 5, 'time centric reporting', 'As an issues-manager 
In order to be able to report the issues data for  a certain term - day,week,month,year,quinquennial or decade
I wanto to be able to perform all the features of the issue-tracker on that specific day regardless whether it is today , in the past or in the future', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b858a174-6588-4ccd-9e49-e93706c6fc3a', 53, 2, 54, 105, 106, '09-done', 9, 'Generic CRUDS for items', 'As a team member
In order to be able to manage all the items in the application I have access to
I want to be able to create,update,delete and search for those items from the UI of the application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('99c75da3-9d2a-4cb3-a6ae-c790d5d40272', 77, 3, 78, 152, 153, '09-done', 5, 'Control flow logging', 'As a CLI user 
In order to be able to understand what the issue tracker tool is executing
I wanto to have configurable logging with stderr, stdout and file output', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('33878694-66e3-4f71-951b-9aad14a661db', 54, 2, 55, 107, 108, '03-active', 5, 'Project''s persons issue combinations', 'As the project manager  of an issue-tracker project 
In order to be able to quickly and reliably combine the reported hours by the project''s people
I wanto to be able to read their issue-tracker formatted google sheets and combine them into a single project''s google issue-tracker sheet', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('2480539b-86a3-4933-9ed8-5f84744a40c9', 55, 1, 56, 110, 115, '03-act', 7, 'PROJECT OBSERVER BIZ PERSPECTIVE', 'As a project observer 
In order to observe the advancement of a project  
I want to have a nice user experience while using the issue-tracker application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('27f22b5f-11e8-4660-9992-301ac9fc61ad', 56, 2, 57, 111, 112, '03-active', 5, 'Projects observation', 'As a project observer 
In order to observe the advancement of a project  
I want to be able to observe the project''s data. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('fee59053-abb5-4df7-9006-ae2b3a7e0f60', 57, 2, 58, 113, 114, '03-active', 5, 'Issues observation', 'As a project observer 
In order to observe the advancement of the project''s issues  
I want to be able to observe the project''s issues. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('b9d30339-fbc7-46c5-ba72-3bfefcf572d2', 58, 1, 59, 116, 129, '03-active', 2, 'SYSADMIN PERSPECTIVE', 'As a sysadmin of the issue-tracker application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the issue-tracker application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('3d5cb5fc-b598-44ac-9cc4-ac3c3b19e36c', 5, 3, 6, 8, 9, '02-todo', 5, 'Update existing projects', 'As an team leader
In order to be able to change attributes of the projects I am responsible for
I want to be able to update the projects'' data. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('caf29975-b4f6-40a2-aef8-985360593ad3', 59, 2, 60, 117, 118, '03-active', 5, 'System deployability', 'As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I wanto to be able to deploy an instance of the issue-tracker application and spawn a new project out of it in less than a hour from a clean Linux host. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('85a87ef8-20f1-4b40-803a-b5a3e51b0840', 60, 2, 61, 119, 120, '03-active', 5, 'System performance', 'As the SysAdmin 
In order to ensure the performance of the issue-tracker application
I wanto the System containing the issue-tracker application to perform its functions within the defined performance criteria', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4220ccd6-bd73-41c2-a4fd-54eabdb7bd64', 61, 2, 62, 121, 122, '03-active', 5, 'System stability', 'As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I wanto the System containing the issue-tracker application to perform its defined functions on request without interruptions or unknown side effects', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('1dfeb384-5ede-4e55-9497-0a1faccec694', 62, 2, 63, 123, 124, '03-active', 5, 'System reliability', 'As the SysAdmin
In order to be able to rely on the operations of the tool
I wanto the System containing the issue-tracker application to perform its functions as specified consistently ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7ef5783c-90db-4dd8-8af1-1685416ca306', 63, 2, 64, 125, 126, '03-active', 5, 'Ease of use', 'As the SysAdmin
In order to be efficient and decrease the amount of errors
I wanto to generally perform any command the system within the sysadmin scope via clean and memorable oneliners ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('004fb83c-888b-488e-a1d4-301df5ddd30a', 64, 2, 65, 127, 128, '03-active', 5, 'Security', 'As the SysAdmin
In order to be able to provide the best possible security level of operation for the Issue-tracker instance I am responsible for
I want to have pre-defined and clear set of tasks and activities to perform related to the security. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('754e15a3-9c0f-4013-906c-2d762efec24a', 65, 1, 66, 130, 143, '03-active', 3, 'ETL AND INTEGRATIONS PERSPECTIVE', 'As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the issue-tracker application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e515241f-d587-4b2e-887d-aa6fa51e98e1', 66, 2, 67, 131, 132, '09-done', 5, 'Database to json files data load', 'As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I wanto to be able to export the project db data into json files - one per table via a single shell call. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('c52fa013-93d9-449e-94d2-254014be0d92', 67, 2, 68, 133, 134, '09-done', 5, 'Json files to db data load', 'As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I wanto to be able to import the exported json files ( one per table ) into the database. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('d0adc30a-4fac-4193-aa4f-cd954ef4e109', 68, 2, 69, 135, 138, '09-done', 9, 'Xls-to-mysql-db hierarchical data load', 'As the Data Integrator
In order to be efficient while handling the System''s hierarchical data 
I want to be able to
use a single shell call to load all or chosen table(s) to the mysql db ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('0f996be4-d562-437a-b819-bdbf04e0dd8e', 6, 3, 7, 10, 11, '02-todo', 5, 'Search for existing projects', 'As an team leader
In order to be able to quickly access existing projects
I want to be able to search the projects. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('25b10dc7-a3a1-49a8-92e9-b79ee69ea5e0', 69, 3, 70, 136, 137, '09-done', 9, 'error reporting in xls-to-mysql-db hierarchical data load ', 'As the Data Integrator
In order to be efficient while troubleshooting data loading errors 
I want to be able to see : 
 - which table''s load failed
 - what was the error in failed to ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('db2fa02c-d515-4904-8444-9a28f636c88f', 70, 2, 71, 139, 142, '01-eval', 5, 'Xls-to-postgres-db hierarchical data load', 'As the Data Integrator
In order to be efficient while handling the System''s hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('bddab165-ca43-40fd-888a-dd73f17e9456', 71, 3, 72, 140, 141, '09-done', 7, 'error reporting in xls-to-postgres-db hierarchical data load ', 'As the Data Integrator
In order to be efficient while troubleshooting data loading errors 
I want to be able to see : 
 - which table''s load failed
 - what was the error in failed to ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('3a432edb-7442-412b-9df6-bd1289187c3b', 72, 1, 73, 144, 227, '03-active', 1, 'DEVOPS PERSPECTIVE', 'As a devops operator of issue-tracker application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the issue-tracker application.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ee9f2d55-8a6c-4f19-8d72-7a44203233bb', 73, 2, 74, 145, 150, '03-active', 5, 'System verifiability and testability', 'As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System 
by issuing a single shell call.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4e0003a1-21df-4520-944f-da7adf5798ad', 74, 3, 75, 146, 147, '03-wip', 5, 'Clarity and brevity of the end to end tests', 'As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to see the results of each test in 1 flow in the following format:.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('70324884-8fa3-455b-9450-05de7e488930', 75, 3, 76, 148, 149, '03-wip', 5, 'Abort end-to-end tests on single test fail', 'As an ITOPS 
In order to be able to run continuously end-to-end tests and skip for several runs failing tests
I want to be able to configure the single e2e entry point script to skip certain tests, but report me what was skipped. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4fb99cad-476f-4ff3-aef5-35497f2fc5b8', 78, 3, 79, 154, 155, '09-done', 5, 'Log entries format configuration', 'As a Full-Stack Developer
In order to be able to get the msg of any component of the application 
I want each log entry to content:
- the type of the entry - log , error, warn , fatal
- the timestamp of the log entry event 
- the name of the component issueing the msg and the line num of the src file 
- the msg as it was echoed by the application', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('4a8100da-6335-4cb0-833b-cf93900f6c33', 7, 3, 8, 12, 17, '09-done', 5, 'Switch between projects', 'As a team leader
In order to manage issues from different projects  
I want to be able to switch between different projects easily and quickly', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('75998f68-d723-4aef-8212-f04d95e8432f', 79, 3, 80, 156, 157, '03-wip', 5, 'Single entry point for end to end tests', 'As an DevOps
In order to be able to verify all the features and functionalities of the tool within the System
I want to run a single shell call running all the end-to-end test of the application ensuring the prespecified features and functionalities.  ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e3d3de2e-1991-4327-9572-1c5267101b27', 80, 3, 81, 158, 159, '09-done', 5, 'Tool run log to human readable description', 'As a CLI user 
In order to be able to get a human readable description of the log of the specific run of the tool
I wanto to be able to translate the recorded uuid''s in the execution run log to their respective records', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('98247df4-4c80-4336-b67a-23f7e34d17f5', 81, 2, 82, 161, 188, '03-active', 5, 'Application''s source code and documentation integrity', 'As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('8bc4f444-a6c0-43df-aefb-35f3f1ddba76', 82, 3, 83, 162, 163, '03-active', 5, 'Userstories to test case relations', 'As a Developer 
In order to ensure the stability and expandability of the application
I want to be able to run for each implemented user-story a single test', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ccba18e7-c84d-4493-9956-aad829d6d7b4', 83, 3, 84, 164, 165, '03-wip', 5, 'UUID trackability for test files and userstories', 'As a Developer 
In order to identify each user-story to be tested with its according test
I want to be able to track each user-story or test code entry point file by UUID.', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e880f14d-38f1-4bce-968e-2dc6b0d7e461', 84, 3, 85, 166, 167, '02-todo', 5, 'Components start run message print', 'As a CLI user 
In order to know when a component has been started
I wanto to be able to see the "START <<COMPONENT NAME>> on either the STDOUT or the log file of the component', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('19d94b2c-096c-4bf9-b6ba-780c3f90bf70', 85, 3, 86, 168, 169, '09-done', 5, 'Tool exit with exit code and exit message', 'As a CLI user or calling  automated component
In order to be able to understand whether or not the execution of the call to the tool was successful or not 
I wanto to get the exit code from the tool execution and see the exit message', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('1c1f6130-55f6-445f-bc88-47a3a6e6ec34', 86, 3, 87, 170, 171, '09-done', 5, 'Execution path tracing by UUID''s', 'As a DevOps operator
Foreach execution run of the tool
I want to be able to walk trough the execution path of the tool programmatically. ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('1848fb04-502a-4dbb-a987-f17ec3a8163b', 87, 3, 88, 172, 173, '09-done', 5, 'Issues directories naming conventions', 'As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
I wanto to be able to store large quantity of issues txt files by their date on daily, weekly, monthly, yearly and decadally basis', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('a13d7f96-df7a-441d-acab-6b8c189f7b9d', 88, 3, 89, 174, 175, '09-done', 5, 'Issues files naming conventions', 'As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
and open them quickly
I wanto to be able to just type the first letter in a text editor supporting select opened file by typing its first letter and jump to that file', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('359350e2-2932-489d-9d34-3af04c8a1462', 8, 4, 9, 13, 14, '09-done', 5, 'Web UI for switch between projects', 'As a team leader
In order to manage issues from different projects  
I wanto to be able to switch between different projects easily and quickly
by simply changing the first token of the url of the app', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('6fbe1c3c-04f3-4bfc-92ad-23366726a0cf', 89, 3, 90, 176, 177, '09-done', 5, 'Issues file open', 'As a CLI user 
In order to be able quickly to access my issues ( daily , weekly, monthly , yearly )
I wanto to be able to view my daily issues by simply opening a single txt file', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('9cb46c04-d5b1-4aad-a2b6-16e91632a20e', 90, 3, 91, 178, 179, '09-done', 5, 'Issues files history', 'As a CLI user 
In order to be able quickly to search trough old issues 
I wanto to be able to access old issues files by their date held in their file names from the file system', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('e6228e25-3222-4b15-90c2-b9aedbfe76f0', 91, 3, 92, 180, 187, '09-done', 5, 'Issues files naming conventions', 'As a DevOps 
In order to be able quickly to access and manage programmatically issues
I wanto to be able to quess the file paths of the issues file by their date ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('0655ed00-74d3-4bbd-8d65-9478cc62f295', 92, 4, 93, 181, 182, '09-done', 5, 'Issues files naming conventions for the  project', 'As a DevOps 
In order to be able quickly to switch between different projects
I wanto to have the project name of the issues file in its name as the first token as follows:
<<issue_tracker_project>>-issues.<<current-iso-date>>.<<daily|weekly|monthly|yearly>>.txt', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('ef7c6df0-0945-4a3e-9b23-d88ed0b37e93', 93, 4, 94, 183, 184, '09-done', 5, 'Issues files naming conventions for current date', 'As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
<<issue_tracker_project>>-issues.<<current-iso-date>>.<<daily|weekly|monthly|yearly>>.txt', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('7377d9ac-b158-46a3-be2a-6259e7b9ed7b', 94, 4, 95, 185, 186, '09-done', 5, 'Issues files naming conventions for the time frame', 'As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
<<issue_tracker_project>>-issues.<<current-iso-date>>.<< ( daily|weekly|monthly|yearly) >>.txt', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('33a9cb07-d213-45de-aab3-53337c97e22f', 95, 2, 96, 189, 212, '07-qas', 5, 'Issues transformations', 'As a cli user of the issue-tracker application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls filee
I wanto to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues taable in db
db-to-txt - to load a txt file from db table ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('8b5af50d-31d3-412e-9d47-1353816eb38b', 96, 3, 97, 190, 193, '07-qas', 5, '
Load by txt-to-db action', 'As a cli user of the issue-tracker application 
in order to store my issues in structured form to db for further processing
I want to be able to load any issue file with a single line shell call to a db ', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('3991dc9d-ed7e-499d-84e6-184d0ad823c5', 97, 4, 98, 191, 192, '07-qas', 5, 'Load issues file from file system to db', 'As a cli user of the issue-tracker application 
- in order to be able to handle issues from different projects
- and load them to db for further processing
I want to:  
- pre-set the variables of the project 
- and than load any issue file with a single line shell call to a db
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default', '2018-12-25 20:11:23');
INSERT INTO public.userstories (guid, id, level, seq, lft, rgt, status, prio, name, description, update_time) VALUES ('3d5b6282-8e17-4324-9184-834e5141433c', 98, 3, 99, 194, 195, '07-qas', 5, 'Load issues by db-to-xls action', 'As a cli user of the issue-tracker application 
in order to be able to sort and edit my issues in Excel
I want to be able to unload my issues from one or many tables in the db at once in a single shell call', '2018-12-25 20:11:23');


--
-- Data for Name: weekly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('84580926-7622-40cb-8a89-ddd07d812719', 181101173837, NULL, NULL, 1, 9, '02-todo', 'test', 'a test issue', 'At least one task with status 02-todo is needed ... ', 'task', 'unknown', '2018-11-01 17:38:36', '2018-11-01 17:38:36', NULL, NULL, NULL, '2018-11-01 17:39:25');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6e0125f-d9d5-4b4e-a4d3-d81cfdfad84e', 181106222828, NULL, NULL, 1, 9, '02-todo', 'test', 'deploy v0.5.3 version ', 'deploy v0.5.3 version : 
 - prepare the configuration file', 'task', 'unknown', '2018-11-06 22:28:28', '2018-11-06 22:28:28', NULL, NULL, NULL, '2018-11-06 22:30:54');


--
-- Data for Name: yearly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('376a6ffe-ad79-4450-9cf5-a8cd3fb2ec89', 181207010500, NULL, NULL, 'code-task', 9, 'feature', '02-todo', 4, 'add a docker script for a single devops image', 'Containing both the needed binaries and configurations to run the back-end and the front-end of the application ... ', 'ysg', '2018-12-07 01:05:01', '2018-12-07 01:05:01', NULL, NULL, NULL, '2018-12-25 21:03:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f2d416a0-c99f-4b09-9653-34d060fcdc48', 180807161137, NULL, NULL, 'task', 9, 'ui-usability', '02-todo-to-yearly', 6, 'add column delete button', 'add a small button in the top right corner of the column titles

Scenario:
 - the user clicks the button 
 - the System removes visually the column with ajax call - no full page redrow !!!
 - the url is changed accordingly', 'ysg', '2018-09-20 16:11:37', '2018-08-07 16:11:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('149dfea2-8a9e-4788-83bc-1c59cc61b6f5', 181207010650, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'add a file upload route in the front-end', 'A solution for the landing dir ?!', 'ysg', '2018-12-07 01:06:50', '2018-12-07 01:06:50', NULL, NULL, NULL, '2018-12-07 13:25:04');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('911a3bb4-fd79-4e73-82ab-4125c07f4e08', 181230175631, NULL, NULL, 'code-task', 9, 'feature', '02-move', 6, 'add link for jump-to-next title in view-doc right context menu', 'According to the following usage scenario: 
 - User right clicks on a title link
 - the System presents the context menu 
 - The user chooses the jump to the next title link
 - the system scrolls till the next title', 'ysg', '2018-12-30 17:56:32', '2018-12-30 17:56:32', NULL, NULL, NULL, '2018-12-30 17:58:21');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b59ddf99-8f16-422e-9500-1949caab4f90', 1806232302, 1, 10, 'task', 5, 'feature', '02-todo-2019', 4, 'evaluate a lib for the generic forms creation', 'The CRUD functionality will require a generic forms creation', 'ysg', '2018-06-30 00:00:00', '2018-07-15 00:00:00', 5.00, 0.30, 'poc', '2018-12-25 21:03:38');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd1949da-cbe6-474e-8810-0d29bda8811a', 181106222627, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'make the getUrlParams a global js app function', 'Because: 
 - it will be needed in all the pages of the front-end', 'ysg', '2018-11-06 22:26:27', '2018-11-06 22:26:27', NULL, NULL, NULL, '2018-12-30 21:22:48');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e643d88f-f61e-4e65-bbcb-5d0e58a20c54', 181229080528, NULL, NULL, 'task', 9, 'refactor', '02-move', 2, 'refactor the doInitRequestModel into the BaseController', 'As it seems to repeat in each and every Controller under small variations .. 

Because it starts causing serious bugs ... ', 'ysg', '2018-12-29 08:05:29', '2018-12-29 08:05:29', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ac02db6e-2a4c-420a-80e8-10b31f982528', 181225211130, NULL, NULL, 'task', 9, 'feature', '02-move', 1, 'add the right menu in the view-doc page', 'The right menu will contain the links to the ', 'ysg', '2018-12-25 21:02:07', '2018-12-25 21:02:07', NULL, NULL, NULL, '2018-12-29 07:31:52');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9bb1568f-e3fb-4830-9668-8759bc1e82eb', 180807153721, 3, NULL, 'task', 3, 'feature', '01-eval-2019', 7, 'add push update to the table on db update', 'Might be doable if web sockets are implemerted and the whole data flow architecture change ... 

Might be too late for the list as grid page , but might be possible to be implemted more easily for the view as doc page ... 

add push update to the table on db update

This one is hard !!!
It would require websockets ... as well as somekind of trigger which "knows" what is the last selected "area" of table check that area and push to the client the info to refresh !!!!', 'ysg', '2018-08-07 15:37:21', '2018-08-07 15:37:21', NULL, NULL, NULL, '2018-12-13 16:49:50');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('324755df-a7aa-4e2c-a3d9-5da4aa20ee2c', 180925230044, NULL, NULL, 'task', 8, 'docs', '08-post', 4, 'functional requirements update', 'Update the functional requirements: 
 - what is the maximum amount of rows per table which should be supported
 - how-many users at once should be supported
The System should support 1000 users at a time
The System should be able to retrieve 2000 rows max per request

Write down those in the Requirements.
', 'ysg', '2018-09-25 23:00:45', '2018-09-25 23:00:45', NULL, NULL, NULL, '2018-12-29 23:46:09');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('027fbbc0-e886-487b-8e14-9af74aec7404', 181128111024, NULL, NULL, 'code-task', 9, 'feature', '08-post', 4, 'numbers should be right-aligned in the table cells', 'The formatting of numbers should be as follows: 
 - right aligned', 'ysg', '2018-11-28 10:58:40', '2018-11-28 10:58:40', NULL, NULL, NULL, '2018-12-29 23:46:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23c3fd72-679c-4f45-a4b0-ba33485e4bf4', 1806110034, 1, 10, 'task', 7, 'feature', '02-todo-2019', 3, 'add a modal dialog edit form for the edit action', 'Could be either from the list as html page or from the list as lables page', 'ysg', '2018-07-30 00:00:00', '2018-08-31 00:00:00', 30.00, 0.20, NULL, '2018-12-25 21:04:39');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2ec249cf-a841-4bc6-a8ff-b0e742136d69', 181208152441, NULL, NULL, 'task', 4, 'feature', '02-move', 5, 'add the read_only boolean attribute in the meta_columns table', 'which will provide the functionality to set certain columns to be only read_only

set the default to false', 'ysg', '2018-12-08 15:23:21', '2018-12-08 15:23:21', NULL, NULL, NULL, '2018-12-29 23:44:27');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0f3014d2-89e1-4a08-84b6-00445519db38', 181225211013, NULL, NULL, 'task', 9, 'feature', '02-move', 1, 'add paging to the view-doc ', 'As follows: 
 - should follow the same naming convention as the list-grid page', 'ysg', '2018-12-25 21:00:49', '2018-12-25 21:00:49', NULL, NULL, NULL, '2018-12-25 21:02:06');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('22916132-eea4-40f8-800b-f9903bcf1f7f', 181210105229, NULL, NULL, 'code-task', 9, 'feature', '02-move', 3, 'add it-<<item>-<<id> interlinking from text content', 'For example the it-yearly_issuses-181210105229 should link straight to this issue. 
Could use the full db meta-data from the editable and JavaScript search and replace ... 
Should be carefull about the performance ... ', 'ysg', '2018-12-10 10:52:29', '2018-12-10 10:52:29', NULL, NULL, NULL, '2018-12-25 21:01:54');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES (NULL, 190106044308, NULL, NULL, 'code-task', 6, 'feature', '02-todo', 3, 'add calendar control in the grid', 'Add calendar control for the the timestamp columns based on the meta-data', 'ysg', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f6229ae-06d2-4118-9076-eb13c8fdc19b', 181105184704, NULL, NULL, 'task', 9, 'refactor', '02-move', 4, 'refactor the Query and Search ', 'both have repetitive code , which could to some QueryAble parent ... 
', 'ysg', '2018-11-05 18:35:14', '2018-11-05 18:35:14', NULL, NULL, NULL, '2018-12-29 23:43:35');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd144c6f-7571-4f1d-ba76-e49b61ce271f', 181208102040, NULL, NULL, 'task', 9, 'feature', '02-move', 5, 'implement add new nested-set node on insert as trigger on hierarchy table', 'Attempt to move the logic of the updates of the lft & rgt attributes for each row on CRUD operations into a postgres trigger ... 
This would provide the benefit utilising the same API''s from the back-end from the UI, while gaining the feature of CRUD for a hierarchy table ... ', 'ysg', '2018-12-08 10:20:40', '2018-12-08 10:20:40', NULL, NULL, NULL, '2018-12-30 16:40:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('31e6b6e9-7d3a-4ef2-89b0-b02f78bfd509', 181127043713, NULL, NULL, 'task', 9, 'feature', '02-move', 3, 'implement full text search with ranking', 'how-to setup full-text search in postgres src:
https://stackoverflow.com/questions/22732507/how-to-setup-a-full-text-search-query-in-postgresql
', 'ysg', '2018-11-27 04:37:13', '2018-11-27 04:37:13', NULL, NULL, NULL, '2018-12-30 14:17:42');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f795731-c493-4b00-a0c0-2991f95f5bf7', 181126105005, NULL, NULL, 'code-task', 9, 'feature', '08-post', 7, 'pre-populate search box with for url param value', 'when the list is comming from search the search box should be pre-populated with the search item from the for url param', 'ysg', '2018-11-26 10:34:04', '2018-11-26 10:34:04', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8d94e082-96f2-422a-9de1-ca816174ff10', 181123143612, NULL, NULL, 'task', 9, 'bug', '03-act', 2, 'the for url param is left in the list-as-grid page', 'It could possibly cause problems while naviating to the text search page ...', 'ysg', '2018-11-23 14:25:19', '2018-11-23 14:25:19', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('953b7bd6-d373-45e5-9223-094d1f82cea5', 181005085048, NULL, NULL, 'task', 9, 'major-release', '03-act', 3, 'release v0.6.0', 'Major release containing:
 - simplistic view-doc page
 - universal global txt search on items level for name & desc
 - simplistic JWT authentication
 - simplistic users with roles and authorisation model
 - patterns interpolation setting per column based on cols meta data
 - users, roles , item-level privilege granularity
 - 45 min deployment with 8 min downtime per instance
 - simplistic monitoring & benchmarking
 - list?as=grid page load with 7 items for 0.09 via benchmark
 - perfected GRUD grid with paging, filtering and page-sizing', 'ysg', '2018-10-30 22:00:00', '2019-01-01 22:00:00', NULL, NULL, NULL, '2018-12-25 21:05:05');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7532beb1-555d-4dff-b54b-46e2506cceda', 181213164328, NULL, NULL, 'task', 9, 'feature', '02-todo', 6, 'web sockets simple poc ..', 'With Mojolicious and JavaScript web sockets
create a single msg passing back and from front-end to back-end 

If the poc is successfull than probably a change of the implemntation of the view as doc page would be needed ... ', 'ysg', '2018-12-13 16:43:24', '2018-12-13 16:43:24', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('043b1d6a-2112-4c23-8c06-19e952a2822b', 181211182822, NULL, NULL, 'activity', 9, 'refactor', '03-move', 5, 'remove the "clever" usage of objModel as universal hash', 'IT was simply a "bad idea" ... better to stick with named variables and clean api''s in list context .. ', 'ysg', '2018-12-11 18:28:22', '2018-12-11 18:28:22', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8059ce5f-66fb-434e-8af0-d81b3c9c078c', 181128111217, NULL, NULL, 'code-task', 9, 'bug', '08-post', 5, 'if the numbers have more than 4 decimals they are wrapped', 'due to the default width of the column : 
solution options: 
 - add the width column in the meta_columns table
 - check the editable defaults', 'ysg', '2018-11-28 11:00:33', '2018-11-28 11:00:33', NULL, NULL, NULL, '2018-12-30 14:17:47');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ed426826-27f6-4442-bc36-7e85261d1f62', 1805282138, 1, 10, 'feature-implementation', 5, 'feature', '02-todo', 9, 'add export to txt from web ui', 'add export to txt from web ui', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 4.00, 0.10, NULL, '2018-12-30 15:57:10');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b34e616-6fb1-4dda-af0a-4ccae9aef2f5', 181204162534, NULL, NULL, 'task', 9, 'docs', '08-post', 4, 'add the docs for the "cannot connect to db" issue to DevOps guide', 'Because the easiest way to resolve would have been to check it from the DevOps Guide: ', 'ysg', '2018-12-04 16:25:34', '2018-12-04 16:25:34', NULL, NULL, NULL, '2018-12-29 23:45:47');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b997f867-2c14-430f-8e35-7b2c5996ac0a', 181025082427, NULL, NULL, 'task', 9, 'feature', '03-act', 4, 'enable instance monitoring ', 'Instance monitoring: 
 - each instance has configurable scheduled ( in cron ) monkey benchmarking scripts
 - the results of each call are visible from a benchmarking table as follows: 
 -- start_time , stop_time , url , amount of requests 
 -- average page load time 
 -- average success rate ', 'ysg', '2018-10-25 08:24:10', '2018-10-25 08:24:10', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9eb0e098-31f8-4c08-bbe7-306393ee1ebe', 181101180808, NULL, NULL, 'task', 9, 'feature', '02-todo', 2, 'ensure the meta data reload does not brake the requests of other users', 'The following scenario: 
 - 2 users simultanious reload , when the global appConfig->{db-name.meta } is not set
 - one of them loads it ... 
 - the second one too ... 
 Anyways both of the requests should perform flowlessly ... ', 'ysg', '2018-11-01 18:08:08', '2018-11-01 18:08:08', NULL, NULL, NULL, '2018-12-25 21:04:20');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('123c4912-f6cf-4356-97eb-b7733ee0455c', 181126153639, NULL, NULL, 'code-task', 7, 'bug', '02-move', 4, 'pager is overlapping search-box on horizontal scroll', 'This might require a full refactor of the list as grid page ... it migth be better to re-iterate after the 
Needs a broader table to reproduce ... 
the pager should be with absolute position
If the table is too long the pager is placed on top of the search box ... and it should probably just be fixed at the top of the screen
', 'ysg', '2018-11-26 15:20:47', '2018-11-26 15:20:47', NULL, NULL, NULL, '2018-12-29 23:44:18');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7a76c58b-291c-4411-ae82-9278fe837b95', 181213164633, NULL, NULL, 'task', 9, 'feature', '02-move', 5, 'add the ver attribute in the issues tables ', 'Because the target versions should be tracked and because the release notes for each version should be a single extract from the monthly issues table ', 'ysg', '2018-12-13 16:46:30', '2018-12-13 16:46:30', NULL, NULL, NULL, '2018-12-29 23:44:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65488841-9b53-4e26-bfc9-d5499f6e1afe', 181111121729, NULL, NULL, 'task', 9, 'feature', '06-onhold', 4, 'add the error template to be the blank search page', 'add the error template to be the blank search page as follows:
 - an empty search page is displayed with the current db
 - an error msg is displayed informing ', 'ysg', '2018-11-11 12:17:29', '2018-11-11 12:17:29', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0d92112c-5fc0-47c7-adb3-2d0ad9ab9a7f', 181216141131, NULL, NULL, 'task', 9, 'feature', '02-move', 5, 'add node level crud for nested-set hierarchy tables by trigger', 'According to the following url: 
http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
', 'ysg', '2018-12-16 14:11:31', '2018-12-16 14:11:31', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('928a1379-7623-4cdb-b021-9d48e26aa0e8', 181208142118, NULL, NULL, 'task', 9, 'refactor', '06-onhold', 4, 'change the site.html.ep to list.html.ep', 'The site should support also different dependencies for the view pages ... ', 'ysg', '2018-12-08 14:19:56', '2018-12-08 14:19:56', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b4682b6-f3a7-488b-847b-20f687875a25', 181106153644, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'refactor the setting of url params in the RdrUrl params', 'It should be more generic , there is huge amount of repetitions ... 
Should have more testing as well ... ', 'ysg', '2018-11-06 15:17:55', '2018-11-06 15:17:55', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0aee1245-f7fc-4c2f-af2f-33af91c893b7', 181019152804, NULL, NULL, 'task', 9, 'bug', '04-diss', 9, 'add tests for the basic auth ', 'Should run the tests ONLY if the http_passwd_file is present: 

 - how-to capture the login dialog box ?!
Might be a waste of time as the basic auth is to be replaced by v0.6.0 by the proper JWT auth ... ', 'ysg', '2018-10-19 15:15:35', '2018-10-19 15:15:35', NULL, NULL, NULL, '2018-12-25 21:05:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de2eec9b-2335-4552-9780-f29a3f7d00d5', 181002103808, NULL, NULL, 'task', 9, 'refactor', '04-diss', 9, 'move all external dependencies to be locally hosted', 'This "DECREASES" performance in the amnz ec2 prod substantially => no go !!!

Must be rolled back with a separate issue ...
A more clever mechanism must be figured out ... later on ... 

move all external dependencies to be locally hosted. This should improve sudden network
 latencies', 'ysg', '2018-10-02 10:20:24', '2018-10-02 10:20:24', NULL, NULL, NULL, '2018-12-25 21:05:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de0910ff-78fb-4167-be79-f5c63610ede4', 181225211611, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'move all movable issues to the yearly_issues_2018 table', 'Where a "movable" issue means: 
 - having status 09-done
 - having status 04-diss, but not strategical meaning for the curr year
', 'ysg', '2018-12-25 21:06:48', '2018-12-25 21:06:48', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ff5afb7-6a17-46fb-83b3-d838c3478e9e', 181114145604, NULL, NULL, 'task', 9, 'refactor', '02-move', 4, 'refactor the objModel naming conventions', 'too much different keys in different situations lead to big mishups in refactoring ...
caused by it-181114095907', 'ysg', '2018-11-14 14:41:13', '2018-11-14 14:41:13', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('237fcff2-a422-4843-905c-a5e3504d0df6', 181224175417, NULL, NULL, 'task', 9, 'feature', '02-move', 4, 'add the doc-editable control ', 'The doc-editable should provide inline editing for the description and the source code ... possibly also to the titles ... ', 'ysg', '2018-12-24 17:54:17', '2018-12-24 17:54:17', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32e05c85-933f-4884-892e-c268a71eb01f', 181212225114, NULL, NULL, 'task', 9, 'refactor', '03-move', 4, 'refactor all the postgres facades to use Mojo::Pg , rv ', 'Which will also change the security model as well as the connection string will the the username and the pw from the configuration file :
 - go route by route
 - run always unit tests
 - a method shoud fill into 1 screen
', 'ysg', '2018-12-12 22:51:14', '2018-12-12 22:51:14', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('022f0662-6fe0-4a1f-9072-1f7899c22671', 181126154113, NULL, NULL, 'code-task', 9, 'bug', '06-onhold', 6, 'if the table is too broad there is no horizontal scrolling', 'This might not be a bug , but kind of quirk ... 
Anyway''s to check whether or not this horizontal bar could be shown IF the table is wider than 100% ... 

The horizontal scrolling appears ONLY when one navigates with the tab, which is rarely the case as the majority of the users will use only the mouse ', 'ysg', '2018-11-26 15:25:21', '2018-11-26 15:25:21', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8146fd79-0625-4133-b518-e8fa9d04f1de', 181127110903, NULL, NULL, 'task', 9, 'docs', '06-onhold', 5, 'add the Perl Style Guide section in the DevOps document', 'add the Perl Style Guide section in the DevOps document
src: https://docs.scala-lang.org/style/', 'ysg', '2018-11-27 10:49:56', '2018-11-27 10:49:56', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ebedd47d-831e-4dda-a34d-aa15e9dc18b5', 180806102235, 1, NULL, 'task', 9, 'feature', '06-onhold', 5, 'add 3D effect on the table cells', 'add 3D effect on the table cells.', 'ysg', '2018-08-07 00:00:00', '2018-08-07 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('584b3bb1-325e-495c-9eee-99a438dc456d', 181230211652, NULL, NULL, 'task', 9, 'bug', '02-move', 2, 'if no data is found set the play previous link and rewind prv to page-num 1', 'if no data is found set the play previous link and rewind prv to page-num 1 as it now does not point anywhere ...', 'ysg', '2018-12-30 21:16:52', '2018-12-30 21:16:52', NULL, NULL, NULL, '2018-12-30 21:17:53');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f608f1e5-9dc8-425d-85b3-a9210414070f', 181230181018, NULL, NULL, 'task', 9, 'feature', '02-move', 3, 'add edit title,desc and src on f2 in view-doc', 'According to the following scenario: 
 - the user selects with the keyboard the control
 - the System provides a visual that this control is selected
 - the user presses F2 ... 
 - the User turns the selected control into editable ... ', 'ysg', '2018-12-30 18:10:18', '2018-12-30 18:10:18', NULL, NULL, NULL, '2018-12-30 18:11:57');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2a515908-c7b2-4fcc-894b-4c34ff1dfc27', 180921152541, NULL, NULL, 'task', 9, 'functionality', '04-diss', 9, 'add the back-end action for select table columns ', 'A duplicate issue:
Prerequisite for the :pick operator in the search-box:
180921085537
chk:
http://192.168.56.120:3001/dev_issue_tracker/select-meta/monthly_issues



http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,weight,name,description&page-size=5&page-num=1&oa=prio&with=id-eq-180921085537', 'ysg', '2018-09-21 15:25:39', '2018-09-21 15:25:39', NULL, NULL, NULL, '2018-12-25 21:06:14');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9ef86517-40b3-4ca2-a770-637796d85d7c', 181229072850, NULL, NULL, 'task', 9, 'feature', '02-move', 3, 'add app version into db name', 'Implement the data versioning by : 
 - setting the app name in the url vs. the app db name in the cnf
 - each time the app version is increased, db name is changed
 - this means that each app version upgrade is db migration !!!
 
Benefits: 
 - enforce data and ui validity
 - enforce end-to-end testing for each change of the environment
 - remove the striking and not user-friendly suffixes in the urls
 - the version,env-type combination in the ui via the http_port 
 

Cons: 
 - the fetch from one ver-type db to another ver-type ui is removed

', 'ysg', '2018-12-29 07:28:50', '2018-12-29 07:28:50', NULL, NULL, NULL, '2018-12-29 07:37:21');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be1561da-7c88-4e2b-83bf-b678477788b5', 181229232905, NULL, NULL, 'task', 9, 'feature', '02-move', 2, 'remove code repetion in error handling in Select.pm', 'A lot of code repetition ... check the HSelect implementation ...', 'ysg', '2018-12-29 23:29:05', '2018-12-29 23:29:05', NULL, NULL, NULL, '2018-12-29 23:50:20');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55696674-b8a8-4f1a-b1c1-c2cc4e556b32', 181207002244, NULL, NULL, 'task', 9, 'setup', '02-todo', 3, 'setup a new landing dir in the web host ', 'Because it has caused 2 times downtime in the web !!!
Anyways the lading dir MUST not be /tmp/
Probably something like /home7ubuntu/var/issue-tracker/dat/tmp/landing', 'ysg', '2018-12-07 00:22:44', '2018-12-07 00:22:44', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a563cdc3-f63c-4f59-8567-6e202c91b3df', 181229225428, NULL, NULL, 'task', 9, 'feature', '01-move', 1, 'add right click menu on the links ', 'Chk the following source: 
http://jsfiddle.net/megazd/n6h549f1/
https://www.cssscript.com/demo/css-togglable-fullscreen-side-navigation
https://www.w3schools.com/howto/howto_js_sidenav.asp', 'ysg', '2018-12-29 22:54:28', '2018-12-29 22:54:28', NULL, NULL, NULL, '2019-01-06 03:24:53');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('eea2a2c4-4476-478e-8580-34a46b451ee4', 180830103358, NULL, NULL, 'task', 9, 'feature-ui', '04-diss', 9, 'query title label', 'Build a human readable query title with the same font and style as the existing app_db label', 'ysg', '2018-08-30 10:16:32', '2018-08-30 10:16:32', NULL, NULL, NULL, '2018-12-25 21:06:29');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a44dda06-f709-4ed6-8ef1-c08def3fedbc', 1805111400, 1, 10, 'activity', 6, 'feature', '04-diss', 9, 'create the select-create form page', 'To test the create action and to start avoiding using the xls', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-25 21:11:32');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('98e6b6fb-e165-41b6-afc8-74d86d18eec6', 180517213101, 1, NULL, 'goal', 9, 'load-testing', '04-diss', 9, 'add load testing to the update back-end web action', 'By simply instantiating ASYNCRONOUSLY 2,4,16,32,64,128,256,512,1024 ajax calls at once non-blocking-wise .Chk the following info src: https://mojolicious.io/blog/2017/12/09/day-9-the-best-way-to-test/http://blogs.perl.org/users/chase_whitener/2016/01/mock-testing-web-services-with-mojo.html', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-12-25 21:11:20');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbe11026-4a14-4900-bc80-fa826f296e4d', 1806251101, 1, 10, 'task', 3, 'feature', '04-diss', 9, 'speed-up the xls-to-db action', 'By running in sequence read xls , file, write to db for each table', 'ysg', '2018-07-01 00:00:00', '2018-07-01 00:00:00', 2.00, 0.10, 'feature,xls', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aceefa3f-630c-4f63-85e3-8ee3cda6758c', 181229234842, NULL, NULL, 'task', 9, 'feature', '02-todo', 5, 'pdf docs download automation', 'create automation and setup for pdf docs download', 'ysg', '2018-12-29 23:48:42', '2018-12-29 23:48:42', NULL, NULL, NULL, '2018-12-29 23:50:17');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('502efdc0-c82c-48d8-bf9f-c842def5cd2c', 180815141257, NULL, NULL, 'task', 2, 'feature-ui', '01-eval', 8, 'add drag-and-drop for doc view', 'Evaluate the following component: 
https://github.com/SortableJS/Vue.Draggable

Would require update of the h_table hierarchy', 'ysg', '2018-08-15 14:12:47', '2018-08-15 14:12:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bdcef54c-dda3-4c6a-861b-e17b73d8e9e3', 1807101028, 2, 5, 'feature', 8, 'feature', '02-todo', 7, 'add the CREATE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3761dfcf-91a4-427e-ad1a-f62063ff2008', 1807170141, 1, 10, 'documentation', 1, 'documentation', '04-diss', 9, 'document the list as table control flow in the system guide', 'Update the application control flow descpription', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1d2744a6-2fcd-46a5-b121-78387616c316', 1805141000, 1, 10, 'docs-addition', 1, 'docs', '01-eval-2019', 9, 'create user manual', 'create the user manual document, which will contain ONLY business rules and logic as well as non-devops related content.', 'ysg', '2018-05-25 20:53:00', '2018-05-30 00:00:00', 0.50, 0.50, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5d04f84b-5484-40e6-81cb-fecca5e99fa9', 181229234920, NULL, NULL, 'task', 9, 'feature', '02-todo', 5, 'implement export to pdf', 'Implement the export to pdf action ... 
', 'ysg', '2018-12-29 23:49:20', '2018-12-29 23:49:20', NULL, NULL, NULL, '2018-12-29 23:50:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bf2206c2-0b12-415f-90a0-d008b0d6913a', 180806102543, NULL, NULL, 'task', 9, 'feature', '02-todo', 5, 'add vue calendar on the dates ', 'Basically a good calendar control should be pretty easy to be integrated ... , but it would require "infra" for fetching the meta-data as well ...', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7390294e-fbe3-4a01-9aea-67acaf25e98f', 180815103724, NULL, NULL, 'task', 9, 'feature-ui', '04-diss-to-yearly', 6, 'table position fix on paging', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'ysg', '2018-08-15 10:25:36', '2018-08-15 10:25:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d0c526a8-75e8-45ad-8824-875cb3405975', 181005085509, NULL, NULL, 'task', 9, 'major-release', '02-todo', 6, 'release v0.7.0', 'Major release containing:
 - secure native authentication via JWT
 - 95% scenario to tests coverage ( including ui )    
 - 35 min deployment with 7 min downtime per instance
 - SSO via JWT via OpenId ( at least Google )
 - generic forms
 - generic drop down control in list ui ', 'ysg', '2019-03-01 22:00:00', '2019-03-01 22:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6bde43f8-f794-4b4b-8e50-ffbb1f72057c', 180824074822, NULL, NULL, 'task', 9, 'setup', '04-diss', 9, 'create deploy-proj-db func', 'Could be done via a simple oneliner ... for now not needed ...
Add only db restore , increase date from deployed version', 'ysg', '2018-08-24 07:48:13', '2018-08-24 07:48:13', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32133ace-4648-4ad3-a3de-d4b5a5ce9d0d', 180829211042, NULL, NULL, 'task', 9, 'docs', '02-todo', 4, 'separate the Features and Functionalities doc', 'separate the Features and Functionalities doc so that the end-user and ui features should be in one doc and the more technical stuff into another doc
2018-09-20 13:24:20 ::: status change -> 01-eval', 'ysg', '2018-08-29 21:10:42', '2018-08-29 21:10:42', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fa4c2c9a-9504-4430-9285-36d6483cadf4', 181027090033, NULL, NULL, 'task', 9, 'bug', '01-eval', 3, 'morph-dir does not replace multiple occurencies of string to replace', 'morph-dir does not replace multipe occurences of string to replace', 'ysg', '2018-10-27 09:00:33', '2018-10-27 09:00:33', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b13a4e70-f5da-4280-bdc4-1f5f6e138faf', 1707200100, 1, 10, 'task', 6, 'feature', '02-todo', 5, 'implement the copy by id via the back-end api from one table to another', 'implement the copy by id via the back-end api from one table to another', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', 20.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fab8075d-d6c3-4ef7-af0f-81c246e834f2', 180816103139, NULL, NULL, 'task', 9, 'docs-design', '02-todo', 4, 'design the projects dashboard / projects hub concept', 'As a single user must have access to different projects + the authentication should be at the end both on :  - issue-tracker app-layer instance  - issue-tracker project-db instance

', 'ysg', '2018-08-16 10:31:39', '2018-08-16 10:31:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2576cfcb-ec09-4907-9344-344e9ea553bd', 1805160700, 2, 10, 'task', 5, 'feature', '01-eval', 7, 'add the feature for the validation of the spent time', 'design the validation of the available time and the spent time = registered time', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 15.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cf355eff-1d87-4477-a506-dd1a40309891', 181019175335, NULL, NULL, 'task', 9, 'feature', '01-eval', 9, 'remove vuetify to improve performance', 'As for now only the addNew and the butDelete actually do use it ... 
Try to remove the vuetify.css to improve performance

', 'ysg', '2018-10-19 17:41:11', '2018-10-19 17:41:11', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('87fbf6d7-2ec7-4767-bcdd-eeefc433eb05', 180815133836, 1, NULL, 'task', 9, 'feature', '01-eval', 6, 'improve load testing for the select web action ', 'add load testing for the select web action

Perform asyncrously requests to examine the amount of asyncrounous calls the application "breaks"', 'ysg', '2018-08-15 13:38:36', '2018-08-15 13:38:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ffb17f21-d053-41f2-86b7-cfe9e7d7165d', 180921091057, NULL, NULL, 'task', 4, 'feature', '01-eval', 5, 'when the pager is resized', 'When the browser window is resized the pager stays on the right , but it should get bellow the srch box', 'ysg', '2018-09-21 09:10:53', '2018-09-21 09:10:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8145bc77-49cf-43f9-b546-d1982c19c398', 1805172131, 1, 10, 'goal', 9, 'feature', '03-act', 6, 'implement data load testing', 'Should be single liner:
- very simple
- should have reliable start _time and stop_times
- should be able to verify the executions times per request , request phases to keep track on performance while increasing complexity
- and optionally all this by single user', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('49efe9c1-8757-4850-9d72-4e4e0bf623f5', 1807101029, 2, 5, 'feature', 8, 'feature', '02-todo-to-2019', 8, 'add the DELETE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe3ca692-b9e2-409a-bc77-a246b31ac7d2', 1807162248, 1, 5, 'feature', 4, 'feature', '02-move', 7, 'add the clone with new id html row for table for CREATE', 'chk the following answer:
- wip add the default values for all the non-null columns
- wip create the front-end call by (new Date()).toISOString().replace(/-/g,"").replace(/T/g,"").replace(/:/g,"").slice(2,14)', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a094afaf-b422-47b6-85d6-19b18606cf9a', 1805111100, 1, 10, 'activity', 8, 'feature', '01-eval', 7, 'add the edit web action from the list as labels page', 'Create the update.pm action and integrate within the existing integration tests', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e13014c-c786-4908-a556-84d7dcc05453', 180824090913, NULL, NULL, 'task', 9, 'functionality', '03-act', 9, 'implement authentication till v0.6.0', 'Only authenticated persons should be authorized to access resources in an instance

2018-09-20 13:24:20 - status update -> 01-eval', 'ysg', '2018-09-01 00:00:00', '2018-08-24 08:53:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('557c34d8-e2f0-4b8a-958d-ca972eaa24be', 180920103551, NULL, NULL, 'task', 1, 'feature', '02-todo', 4, 'add actions on selected items', 'add the capability to perform actions on selected items. The user performs a search , selects all the checkboxes in the left of the list ( gmail like ) , types <> for example: :do move selected to <> would move the selected items to the table <<test>>', 'ysg', '2018-09-20 10:20:53', '2018-09-20 10:20:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f3951bd2-0bb8-49bc-b680-b99ee8a670c2', 1805111200, 1, 10, 'activity', 6, 'feature', '02-todo', 4, 'add the select-update form page', 'To test the update action and to start avoiding using the xls', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd557f0d-bf6c-4cf1-8c59-f33fe273f25d', 180817194442, NULL, NULL, 'task', 9, 'feature-backend', '01-eval', 6, 'backend post call to move the issues with specific attribute name and like value to another table', 'create a backend post call to move the issues with specific attribute name and like value to another table something like: 

<<db>>/upsert/<<src_table>>/with=<<attr-name>><<operator>><<attribute-value>>&to=<<tgt-table>>', 'ysg', '2018-08-17 19:36:05', '2018-08-17 19:36:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d7ec6aeb-ca1f-4f87-b2c2-2970c55d1f5d', 180813222648, NULL, NULL, 'task', 9, 'feature-ui', '04-diss', 9, 'add a dropdown for the grid pager /', 'add the grid page component , which would be vuetify select at the botom

https://vuetifyjs.com/en/components/selects', 'ysg', '2018-08-13 22:09:59', '2018-08-13 22:09:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1821a48c-f4b0-482b-930d-92c2413faf2d', 181019181533, NULL, NULL, 'task', 9, 'feature', '02-todo', 8, 'dynamically resize the textaread on growing input content', 'Scenario:
- each time the user hits enter 
- the cols wil increase with 2 ... 
 - after leaving the default size will be restored ', 'ysg', '2018-10-19 18:03:09', '2018-10-19 18:03:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d703d532-267d-429f-9075-a6a8be824a9d', 180926113604, NULL, NULL, 'task', 9, 'docs', '01-eval', 7, 'add the ReleaseNotes document', 'The ReleaseNotes should contain all the releases with the following info per release:
 - release intro 
 - performance and stability (refactoring)
 - api changes - changes of behaviours
 - known issues', 'ysg', '2018-09-26 11:26:44', '2018-09-26 11:26:44', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b293825f-8152-49e8-9ef2-bbf084ee3bd4', 180920104140, NULL, NULL, 'task', 9, 'feature', '02-todo', 9, 'add the json backup to the increase-date action', 'The "increase-date" action should create a json backup as well ... 
Because it will provide a double daily backup of the data', 'ysg', '2018-09-20 10:26:43', '2018-09-20 10:26:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd9688b9-f859-4c67-b6ba-a98d003f932e', 180920102836, NULL, NULL, 'task', 7, 'feature', '04-diss', 9, 'show 1 page if page x did not contain data', 'Add the "page <<GreatPage>>" did not return any data showing page 1 feature by displaying the warning at the bottom of the page', 'ysg', '2018-09-20 10:13:39', '2018-09-20 10:13:39', NULL, NULL, NULL, '2018-12-25 21:06:19');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3fed31d4-63b5-4cee-8194-84d955e88870', 181022170059, NULL, NULL, 'task', 9, 'code', '04-diss', 9, 'convert the basic auth to be global for each request via app hook', 'Did not find any proper hook ... 
Not needed for now ( till v0.6.0 ?! ) as 
For the basic auth probably not needed', 'ysg', '2018-10-22 17:00:59', '2018-10-22 17:00:59', NULL, NULL, NULL, '2018-12-25 21:11:25');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a83bebb-7e57-4955-a744-df64f8fec4f0', 1805301624, 1, 4, 'bug', 4, 'issue-tracker', '04-diss', 9, 'issue_tracker.pl.log appearance in product instance dir', 'Occurs when one runs the "run-integration-tests" action', 'ysg', '2018-05-29 20:53:00', '2018-06-30 00:00:00', 0.00, 0.10, 'bugs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c021ba38-1796-4570-9b10-a8eb87e8aa78', 180822210340, NULL, NULL, 'task', 4, 'feature-ui', '02-todo', 6, 'add undelete function', 'As an UI user I would like to revoke a deleted item ... 
dependant on the addition of the history table ', 'ysg', '2018-11-01 00:00:00', '2018-08-22 21:03:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0f6686f3-1608-4e09-a546-710201280231', 1807101032, 3, 3, 'feature', 5, 'feature', '04-diss', 9, 'place the cursor at the end of the txt in content editable during update', 'chk:
https://stackoverflow.com/a/19588665/65706

replaced with select all on tab with the keboard ... 


as the click is usually "I wanto to click in a specific part of the text"', 'ysg', '2018-07-20 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b33291c0-9311-4c64-815c-31dde6ee6779', 180806213141, 1, NULL, 'task', 7, 'feature', '01-eval', 5, 'add Excel like moving with the keys also move and down with the cursor keys', 'add Excel like moving with the keys also move and down with the cursor keys', 'ysg', '2018-08-06 21:31:40', '2018-08-06 21:31:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12f6689a-fa8e-4024-a693-9d1e5cd5dffc', 180517213501, 1, NULL, 'goal', 2, 'bug', '06-onhold', 6, 'pager should re-drow based on the current sort', 'or should there be simply redirect ... 

The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('36a15918-7526-4c3f-9f8a-3682d8456d44', 180817232013, NULL, NULL, 'task', 9, 'bug', '01-eval', 7, 'The pager should re-draw based on the current sort', 'The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown

So the feature is to enable update of the url params when one clicks on the columns sorting - aka clicking on the update_time asc should change the od=update_time to oa=udpate_tim', 'ysg', '2018-08-17 23:20:14', '2018-08-17 23:20:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cfb65b19-88d6-439c-810e-a243bc1b94bc', 1806110059, 1, 5, 'feature', 5, 'feature', '02-todo-2019', 6, 'add the weight-by-<<attribute-name>> for the list cloud page', 'This would enable for example the visualization of the sizes based on actual hours , planned hours ...', 'ysg', '2018-07-04 04:06:05', '2018-07-04 04:06:05', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0be434f5-1066-43dd-be7e-053de08c5447', 1806060841, 1, 6, 'feature', 6, 'testing', '06-onhold', 9, 'poc for client side testing for all the client side functionalities', 'Evaluate:
- pure selenium 
- https://github.com/jhthorsen/test-mojo-role-selenium
poc for client side testing for all the client side functionalities

Might be too time-consuming', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 10.00, 7.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3f604b7-d422-49e7-ab4e-50dcafcf44d3', 180925215439, NULL, NULL, 'task', 9, 'docs', '02-todo', 6, 'create security component diagram', 'Create and add to docs the security compoent diagram:
 - list the main compoents and their responsibilities
 - list the security subjects', 'ysg', '2018-09-25 21:54:37', '2018-09-25 21:54:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('826161d5-9afc-47fb-b759-d777087cb3ad', 181102110528, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'minify JavaScript to improve performance', 'The performance could be improved by minifying the Javascript, as follows: 
 - should be configurable  - aka on , off
 - should be proved by benchmarking for ', 'ysg', '2018-11-02 10:53:39', '2018-11-02 10:53:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a72ad39e-4bf0-43fa-953e-50e99db86537', 181022141252, NULL, NULL, 'task', 1, 'feature', '04-diss', 9, 'add the :width operator', 'Add the :width operator with the column name suggestions only ... 

Disgarded as entirely new heuristics for determining the syntax should be added ...', 'ysg', '2018-10-22 14:12:52', '2018-10-22 14:12:52', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('83182443-1c85-4ed2-810d-90d333d4d673', 1806251545, 1, 10, 'task', 3, 'documentation', '02-todo', 9, 'add a component diagram', 'Add an official component diagram UML-wise:
http://agilemodeling.com/artifacts/componentDiagram.htm', 'ysg', '2018-10-01 00:00:00', '2018-12-31 00:00:00', 3.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ee61ab80-f648-4d9a-99fe-0f7c785c2c1c', 180815110339, NULL, NULL, 'task', 9, 'feature-ui', '01-eval', 5, 'add vue calendar page', 'For example from the following GitHub project: 
https://github.com/richardtallent/vue-simple-calendar', 'ysg', '2018-08-15 10:51:51', '2018-08-15 10:51:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('872773cb-d638-442a-ac25-8115bf632a7f', 180807161151, 1, NULL, 'task', 9, 'design-concepts-docs', '02-todo', 6, 'define copy and move operations of items', 'The thing is that those are much more complex than it seems and thus they first be designed and defined and AFTER that implement

For example: 
 - "same table item copy action"  ( newid and new guid must be created ) 
 - "different table item copy action" 
 - "different database , same table item copy action"
 - "different database , different table item copy action"', 'ysg', '2018-08-07 16:11:51', '2018-08-07 16:11:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbc92c1f-7b6b-4bce-bd0a-d0e4bd50db0f', 181019122441, NULL, NULL, 'task', 9, 'feature', '01-eval', 5, 'add smart column suggestions for the :pick operator', 'add a metatable called meta_autocompletes as follows: 
 - will contain the mostly used columns lists
 - only requested table columns from the list will be suggested
 - will contain the list of the page-sizes
 - will contain the list of the data-bases FOR THIS PROJ DB ( Security !!!)
', 'ysg', '2018-10-19 12:12:07', '2018-10-19 12:12:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('43929f18-b1d1-43ee-921d-13f49133a291', 180921091752, NULL, NULL, 'task', 9, 'feature-ui', '02-todo-to-2019', 9, 'add icon for the pager', 'The pager on the top is kind of strange - new users would know what is it all about ...

https://www.storyblocks.com/stock-image/page-pdf-glyph-icon-bdigvdpe7uzj6gmsu0c', 'ysg', '2018-09-21 09:17:48', '2018-09-21 09:17:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9df5b82c-2d86-4967-8bb7-26871427a568', 1806291841, 1, 1, 'task', 6, 'feature', '02-todo', 5, 'add columns stickiness in list as table ui', 'When the ui scrolls a table with page containing more items than the height of the screen the headers of the table must stick to the top of the page. 
Quite difficult with pure css … this one has been the best so far : 
https://jsfiddle.net/dPixie/byB9d/3/', 'ysg', '2018-07-10 00:00:00', '2018-08-30 00:00:00', 3.00, 1.50, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('78d22cd6-864c-4219-ab1e-d29fc8b63e6a', 1806011256, 1, 10, 'feature', 5, 'feature', '01-eval', 7, 'implement a time report web ui page_', 'The time report web ui page will :
- fetch the daily,weekly,monthly and yearly hours
- get the allocated hours per time period
- calculate the registered actual hours to the went-by hours of the start of the period
- calculate the diff between the actual and passed-by hours
- accessible from the list/table-name/?as=table url
- should be able t osort the data', 'ysg', '2018-12-01 00:00:00', '2018-12-31 07:00:00', 20.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b25dbe49-ff4a-489a-a78d-2fe4dddb7a59', 1805102300, 1, 10, 'feature-implementation', 5, 'feature', '02-todo', 5, 'add a default route for the "/" web address', 'add a default route for the "/" web address.
May be something like forward to the list view ?!

Should be time-wise actual, when the authentication and the login with landing is developed ...', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 2.00, 1.00, ' feature,', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('44fda35e-21b5-4af9-b148-1552a2fb7cf8', 1806011701, 1, 5, 'setup', 5, 'setup', '01-eval', 6, 'configure web-pack packaging', 'configure web-pack packaging
Is it even feasible to have the web-pack in the current setup ?!', 'ysg', '2018-06-01 00:00:00', '2018-06-10 00:00:00', 2.00, 2.00, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7c3da050-81e0-4ac0-b74d-940415360773', 1805140900, 1, 5, 'feature-implementation', 2, 'feature', '06-onhold', 6, 'implement data-load testing with 3 tables x 10 000 rows', 'This is partially implemented witht the benchmarking ... 

As follows:


- At least 3 tables
 - with at least 10 000 rows load
 - Because if you cannot get it right from the very beginning than you will get it never ever right
 implement a poc for data-load testing with single table load to postgres with start and stop times recordingAdd as a non-blocking post update for start_time and stop_time', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('881dd1a1-044d-42e3-9119-ce5d0d1cb568', 180824130856, NULL, NULL, 'task', 9, 'specs', '02-todo-monthly', 6, 'login , logout requirements specifications', 'Create the requirements for the login and logout operations

Add the user-stories for the login and logout operations', 'ysg', '2018-09-01 00:00:00', '2018-08-24 13:08:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d1831d21-c0f0-428e-aee3-c7346e82e3f2', 1805172135, 1, 10, 'goal', 9, 'feature', '06-onhold', 5, 'client-side UI automation testing for JS events', 'By using the Mojo::Chrome module:Should be able to capture JS events:Vue induced changes on the page. ', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2a52cd-c4b9-4248-8665-9dc0df6e9f63', 180803093321, 1, 10, 'task', 3, 'feature', '03-act', 5, 'release process automation', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process
add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'ysg', '2018-09-01 12:00:00', '2018-09-30 12:00:00', 10.00, 0.10, 'setup,feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ec67678-7532-4b72-b07d-38cfb13e834e', 1805221029, 1, 10, 'feature', 6, 'feature', '04-diss', 9, 'add form order in url params', 'The ability to order the form elements from the url ... By using the pick order and not a separate fo= ...', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd5f22aa-6349-42a5-8526-d29f06bc192d', 181022131409, NULL, NULL, 'task', 9, 'biz', '02-todo', 5, 'restrict the amount of databases one which could be fetched ', 'restrict the amount of databases one which could be fetched with the :for operator in the select-databases route

Create a custom table per database which contains a list for the db''s this project has access to ... 
', 'ysg', '2018-10-22 13:14:09', '2018-10-22 13:14:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('218c1b15-0a7c-4b0b-86ca-0b5a586b7ac4', 1806011111, 1, 10, 'task', 9, 'architure', '06-onhold', 8, 'change Front-End architecture to use Web Pack', 'As Web Pack seems to be the best in town package manager and a lot of JS code is distributed as npm packages.', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3b210ebd-7a52-42f7-989f-eb02aaf119b9', 1806232256, 1, 5, 'task', 5, 'feature', '02-todo-2019', 6, 'add modal dialog for item-edit in the list table ui', 'add modal dialog for item-edit in the list table ui. 
Status change -> 04-diss . No time till the end of this monthly …', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature ', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('495f36ea-ea34-403c-93df-b7a8c11e9ab8', 180927084435, NULL, NULL, 'task', 9, 'feature-bug', '04-diss', 9, 'replace redirects with partial page updates', 'The whole ui ideology of the navigation is based on the fact that it should be easy to move back and forther between the result sets ...
In the cases when the grid has to be updated a partial page refresh only on the grid root div is needed as the page blinks annoyingly', 'ysg', '2018-09-27 08:44:35', '2018-09-27 08:44:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d4740701-7593-442c-9b3c-7a642d575cef', 181009105544, NULL, NULL, 'task', 9, 'setup', '04-diss', 9, 'add the /opt/csitea symlnk in ec2 env', 'Not needed. The setup should be ~/opt and ~/var as default 
Update accordingly the user-guides etc. 

export link_path=/opt/csiteaexport 
tgt_path=/home/usr_it/opt/csiteamkdir -p `dirname $link_path`unlink $link_pathln -s "$tgt_path" "$link_path"ls -la $link_path; # add both for /opt and /v', 'ysg', '2018-10-09 10:55:38', '2018-10-09 10:55:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('331aaf30-45a2-45c0-a5fa-a19b9d513aa9', 1806241213, 1, 6, 'task', 9, 'feature', '02-todo-2019', 7, 'add poc for the vue-js-modal dialog page', 'Add the poc from the following source: 
https://github.com/euvl/vue-js-modal/blob/master/README.md

Probably all the node_modules must be installed globally, because there is dependency between the mojo morbo web server … which gets REAAALly SLOW …', 'ysg', '2018-06-24 00:00:00', '2018-06-30 00:00:00', 2.00, 0.30, 'poc', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ae71d31-263b-430f-998e-58bd5dee2814', 181027084820, NULL, NULL, 'task', 9, 'bug', '05-tst', 5, 'failed to choose non-first entry from dropdown in the srch box', 'The dropdown looses the state somehow its state
 - caused by arrow down ...', 'ysg', '2018-10-27 08:48:20', '2018-10-27 08:48:20', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('20f646a7-c322-40f1-b0bf-777fff8f3e5e', 1805110400, 2, 10, 'feature-implementation', 1, 'feature', '01-eval', 6, 'improve the select-tables web action', 'Add the following:
- list of views
- ability to specify order by table name and/or creation date 
creation date is important fo rthe population for the primary and foreign key tables 
  - ok - convert result-set to array and not hash', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 1.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e69cd654-9bfe-4565-ba09-390f391892a8', 181019123648, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add shortcuts for textarea resizing', 'Scenario: 
- user clicks on the textarea : 
 - the system listens for the Shfit + Arrows keys shortcut
 - one pressed the System resizes the textarea to the desired direction', 'ysg', '2018-10-19 12:24:14', '2018-10-19 12:24:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34072102-26e1-4995-8aab-496c0cbdc363', 180926103938, NULL, NULL, 'task', 9, 'docs', '04-diss', 9, 'update way of working section', 'Update the System Guide with the way of working section: 
 - requirements should have explicitly written deadline', 'ysg', '2018-09-26 10:39:38', '2018-09-26 10:39:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('004d8fd5-4124-426e-a661-831658f699e6', 181103164723, NULL, NULL, 'task', 9, 'feature', '02-todo', 6, 'make the search-box global for all the views', 'As it is for now only for the list-grid and search page. As follows: 
 - add for the as=cloud page view
 - add for the as=labels page view', 'ysg', '2018-11-03 16:36:27', '2018-11-03 16:36:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('428b55bd-8ef4-4f30-9c7f-5fe29057dad9', 180803161926, 1, NULL, 'task', 6, 'feature', '01-eval', 5, 'implement a new hierarchy model', 'implement a new hierarchy model by using the seq into a separate items_hierarchy table , which will have the following attributes:
id - the FK pointing to the items id 
seq - the sequence in the hierarchy 
item_nam e- the name of the item''s table to refer to 
( all those should comprise an unique PK ) 

Change in the hierarchy would mean changing the seq number - those not all issues will be hierarchical, but those which are could be seen in an hierarchy UI !!!', 'ysg', '2018-10-01 20:53:00', '2018-12-31 20:53:00', 30.00, 0.10, 'hierarchy', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('681b3805-c434-45e2-9616-6d2c58e2aa04', 1806110020, 1, 6, 'activity', 6, 'security', '02-todo', 5, 'add validation of ui params against SQL injections _', 'Each time a new data param is to be parametrized till the db ... A validation must be added to it.', 'ysg', '2018-06-10 23:00:00', '2018-12-31 07:00:00', 5.00, 3.00, ' security', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('006f6640-27ad-413a-bee9-b2576db67bde', 181009205519, NULL, NULL, 'task', 9, 'feature', '06-onhold', 8, 'initial hierarchical docs modelling', 'The item and item_hierarchy combined will server as the storage mechanism for the doc_itemA doc_item has logical and consistent hierarchy

- one
- two', 'ysg', '2018-10-09 20:55:15', '2018-10-09 20:55:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0b2ee6b1-2f94-43de-8933-ed5223c67fd9', 181003125316, NULL, NULL, 'task', 9, 'feature', '06-onhold', 9, 'achieve capability to write client side tests', 'Obtain the capability to write selenium web driver UI automation scripts on the mac:  - install node - ok  - install atom - ok - install the chrome-driver - done - run js script get response in perl - foo- todo', 'ysg', '2018-10-03 12:53:16', '2018-10-03 12:53:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a234ead-76ed-4dfc-9768-0dc5ddb12ae6', 180925220009, NULL, NULL, 'task', 9, 'docs', '04-diss', 9, 'add login sequence diagram', 'Create and store for future maintenance a login authentication sequence diagram', 'ysg', '2018-09-25 22:00:07', '2018-09-25 22:00:07', NULL, NULL, NULL, '2018-12-25 21:11:22');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a455442-1a47-4f2a-9565-52161b0bf7b4', 180824132128, NULL, NULL, 'task', 9, 'feature-ui', '02-todo-to-2019', 9, 'add a search button in the bottom', 'When using with mobile to select the global search is too much of a hassle, if the button is on the bottom of the page it would be much easier to just click on the bottom of the screen ( the size of the button might be the same as the add - new ) , and click on the search , which would than open the modal dialog with the global search window', 'ysg', '2018-10-15 00:00:00', '2018-08-24 13:21:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d9ffb12-960a-4648-b288-9cd435838abe', 1805110401, 1, 10, 'feature-implementation', 5, 'feature', '04-diss', 9, 'add db-to-json export for all the issues tables in the integration tests', 'To enable later the avoidance of the xls file ...', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 4.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b9f0becc-db54-4638-b8d2-daf3b5c4c281', 1806062253, 1, 10, 'bug', 1, 'setup', '04-diss', 9, 'poc for print-to-pdf via headless chrome', 'Could be achieved via UI , not so often used - no sence to spend time automating it … at least for now …', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 3.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8a127f15-a399-452a-a530-ff64ae8f9f26', 1807101030, 2, 4, 'feature', 5, 'feature', '02-todo', 4, 'add the UPDATE for the CRUD table via the vue-js-modal form', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item 
I want to be able to click on the edit button , fill in the poping-up dialog with the form of the full data of the item and clicking the Save button.', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-25 21:04:36');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a013b45a-0600-40e5-ad02-07536e075af9', 181106093939, NULL, NULL, 'task', 9, 'refactor', '02-move', 5, 'refactor the doSelectTablesColumnList function calls in the shell actions', 'Benefits : 
 - alignment to the common meta-model
 - less round trips back and forth to the database ... 
 - cleaner separation between readers and writers ( no readers code in writes etc. ) 

find . -type f -name ''*.pm'' -exec grep -nHi doSelectTablesColumnList {} \;
', 'ysg', '2018-11-06 09:20:39', '2018-11-06 09:20:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d10e1e5c-e87e-4be2-b9e8-9e4e52aba93f', 180815171338, NULL, NULL, 'task', 2, 'feature-ui', '02-todo-2019', 9, 'added draggability in the labels page', 'add drability and sorting by attribute ( prio , weight ) for the labels page', 'ysg', '2018-08-15 17:07:22', '2018-08-15 17:07:22', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('24889a37-4362-4012-aeee-ded06d590f4a', 180920104253, NULL, NULL, 'task', 9, 'feature', '01-eval', 6, 'add the Ctrl+N should click on the add new item', 'The keyboard combination of Ctrl + N should create a new combination - it will make the addition of items much more faster ...
chk https://stackoverflow.com/a/7296303/65706
add to global events', 'ysg', '2018-09-20 10:27:48', '2018-09-20 10:27:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9677f7c2-7028-4033-b174-a3dc98737738', 181102115933, NULL, NULL, 'task', 9, 'feature', '01-eval', 5, 'improve performance by changing setup with Nginx for static files', 'Could it be worth it to improve performance for adding Nginx into the setup ?!
Source: https://blog.localh0rst.de/mojolicious-hypnotoad-and-nginx/
pros: 
 - more RAM for hypnotoad
 - less optimizations for static files 

cons : 
 - more complexity in system administration
 - greater deviation between dev and prod setups', 'ysg', '2018-11-02 11:47:45', '2018-11-02 11:47:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('daf1a325-594e-4212-af0f-2ea42e022278', 181005090038, NULL, NULL, 'task', 9, 'major-release', '02-todo', 9, 'release v0.8.0', 'Major release containing:  
- 25 min deployment with 6 min downtime per instance 
- global per role-level visibility menu - personal links save
- view/item?as=doc with CRUD 
- list?as=grid page load with 7 items for 0.07 via benchmark
- export as pdf for all the pages generically via as=pdf 
- generic calendar control in list ui', 'ysg', '2019-06-01 22:00:00', '2019-06-01 22:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('665f009d-3b27-4e70-ac00-f77b716fb3d4', 180921091603, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add icon for the page-sizer', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'ysg', '2018-09-21 09:15:59', '2018-09-21 09:15:59', NULL, NULL, NULL, '2018-12-25 21:06:16');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a34bcb5e-bcb2-4414-a926-427172c83781', 180806102413, 1, NULL, 'task', 9, 'feature-ui-usability', '01-eval', 5, 'add fixing of the table header , page-sizer and the quick-search text-box on table scroll', 'Basically the upper part of the ui should stay fixed, while scrolling the table', 'ysg', '2018-09-01 00:00:00', '2018-09-30 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4d7094b5-4033-4f3d-b003-d311e60952ed', 181128132640, NULL, NULL, 'task', 9, 'refactor', '01-eval', 7, 'fetch the default values for the insert from the meta-data', 'fetch the default values for the insert from the meta-data and do not set them in the create-table ... ?!', 'ysg', '2018-11-28 13:15:01', '2018-11-28 13:15:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d6e029c-b823-474e-86c6-5a8e6b44e3ad', 181031173728, NULL, NULL, 'task', 9, 'major-release', '02-todo', 9, 'release v0.9.0', 'Major release containing containing: 
 - public api 
 - own data handling - downloads to the interested parties
 - deployment under 5 min , 0 downtime 
 - LDAP integration for security 
 - integrated cubernetes / docker infra in src code ?', 'ysg', '2018-10-31 17:37:28', '2018-10-31 17:37:28', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59da9507-e762-4975-a0b0-03f6affe94be', 180806110417, 1, NULL, 'task', 9, 'bug', '06-onhold', 5, 'add error on non-existent network', '2018-09-25 09:37:03 for next month
 ...basically if vue , vuetify etc. libs cannot be loaded via the cdn - aka if there is no connectivity a basic error message should be added to indicate that ...', 'ysg', '2018-08-06 10:51:54.714225', '2018-08-06 10:51:54.714225', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4eded046-53d4-4a53-ad63-550f777bbc72', 181102121443, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'try to speed-up the woff2 font usage', 'Was not faster ... stored the attempt into the following branch : 

Speed up the woff2 font usage by : 
https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/webfont-optimization

https://stackoverflow.com/a/37271195/65706
', 'ysg', '2018-11-02 12:02:56', '2018-11-02 12:02:56', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8e0a8c6e-e254-48a9-8617-cacc1807d878', 181023100621, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'implement global meta_columns model', 'Too fuzzy definition ...
Change the tables listing to arrive from the meta_tables table. For each table: 
 - there might 1..* columns with interpolation patterns
 - there will be 1..1 interpolation pattern per column', 'ysg', '2018-10-23 10:06:21', '2018-10-23 10:06:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65357b2e-7966-4097-9535-141ec5518c7d', 181113220139, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'omit non-existing columns with warning while picking non-existent column', 'This is against the best practices for back-end api''s ... 
Better to implement default set of columns to pick and always redirect to a table without the picks
When the url contains a column which does not exist while switching between pages :', 'ysg', '2018-11-13 22:01:39', '2018-11-13 22:01:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f9ed1a7-87df-4758-b1c3-24408375af2a', 181024092334, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add cols_pick_list attribute in the meta_columns table', 'The cols_pick_list which will be setable for each attribute IN THE ORDER of preference based on the  seq attribute in the meta_columns order should: 
 - contain the pick lists for the columns of this table in the order above
 - if left empty all the columns in the attribute order should be used', 'ysg', '2018-10-24 09:23:34', '2018-10-24 09:23:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f54c4e12-5d7a-4af4-baab-1306132127ff', 181123154943, NULL, NULL, 'task', 9, 'refactor', '04-diss', 9, 'implement one JS best practice', 'pick the most newbie implementation currently in code going against the JS best practice AND implement it:
https://www.w3.org/wiki/JavaScript_best_practices
Keep DOM access to a minimum
Accessing the DOM in browsers is an expensive thing to do. The DOM is a very complex API and rendering in browsers can take up a lot of time. You can see this when running complex web applications when your computer is already maxed out with other work — changes take longer or get shown half way through and so on.

To make sure that your code is fast and doesn’t slow down the browser to a halt try to keep DOM access to a bare minimum. Instead of constantly creating and applying elements, have a tool function that turns a string into DOM elements and call this function at the end of your generation process to disturb the browser rendering once rather than continually.', 'ysg', '2018-11-23 15:38:17', '2018-11-23 15:38:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5c9d52d-fad8-431a-8ca5-177202a63748', 181114081113, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'preserve url in add-new by ordering only in select by id', 'could the add new only fetch the data ordered by id, but preserve the url ?!
And achieve that without an redirect - that is remove the annoying flashing of the table ... ', 'ysg', '2018-11-14 08:07:45', '2018-11-14 08:07:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f03e0d83-f1ba-4ca2-9c4b-3a4ee570dff5', 1806081610, 1, 10, 'poc-feature', 5, 'feature', '04-diss', 9, 'add omnibox poc page with web service for projects search', '2018-11-11 11:55:24 : change of intentions ... and expression  - the search page is actually this one... 
add omnibox poc page with web service for projects search. The end goal should be pop-up omnibox which will present the results on enter lepton like...', 'ysg', '2018-08-01 00:00:00', '2018-08-31 00:00:00', 3.00, 2.50, NULL, '2018-12-25 21:11:27');
INSERT INTO public.yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('162fd56d-ff0d-4171-ba3e-a0e8bce60b1c', 1806281640, 1, 10, 'task', 7, 'feature', '04-diss', 9, 'add pages minification on deployment', 'The pages should be always minified ... Chrome has the feature to format minified content
Pages must be minified as 1/3 of the data is white space …', 'ysg', '2018-10-01 00:00:00', '2018-12-30 00:00:00', 20.00, 1.00, 'setup', '2018-12-25 21:11:30');


--
-- Data for Name: yearly_issues_2018; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('911a3bb4-fd79-4e73-82ab-4125c07f4e08', 181230175631, NULL, NULL, 'code-task', 9, 'feature', '02-todo', 4, 'add link for jump-to-next title in view-doc right context menu', 'According to the following usage scenario: 
 - User right clicks on a title link
 - the System presents the context menu 
 - The user chooses the jump to the next title link
 - the system scrolls till the next title', 'unknown', '2018-12-30 17:56:32', '2018-12-30 17:56:32', NULL, NULL, NULL, '2018-12-30 17:58:21');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0f3014d2-89e1-4a08-84b6-00445519db38', 181225211013, NULL, NULL, 'task', 9, 'feature', '02-todo', 1, 'add paging to the view-doc ', 'As follows: 
 - should follow the same naming convention as the list-grid page', 'ysg', '2018-12-25 21:00:49', '2018-12-25 21:00:49', NULL, NULL, NULL, '2018-12-25 21:02:06');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('376a6ffe-ad79-4450-9cf5-a8cd3fb2ec89', 181207010500, NULL, NULL, 'code-task', 9, 'feature', '02-todo', 4, 'add a docker script for a single devops image', 'Containing both the needed binaries and configurations to run the back-end and the front-end of the application ... ', 'ysg', '2018-12-07 01:05:01', '2018-12-07 01:05:01', NULL, NULL, NULL, '2018-12-25 21:03:12');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f2d416a0-c99f-4b09-9653-34d060fcdc48', 180807161137, NULL, NULL, 'task', 9, 'ui-usability', '02-todo-to-yearly', 6, 'add column delete button', 'add a small button in the top right corner of the column titles

Scenario:
 - the user clicks the button 
 - the System removes visually the column with ajax call - no full page redrow !!!
 - the url is changed accordingly', 'ysg', '2018-09-20 16:11:37', '2018-08-07 16:11:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ac02db6e-2a4c-420a-80e8-10b31f982528', 181225211130, NULL, NULL, 'task', 9, 'feature', '02-todo', 1, 'add the right menu in the view-doc page', 'The right menu will contain the links to the ', 'ysg', '2018-12-25 21:02:07', '2018-12-25 21:02:07', NULL, NULL, NULL, '2018-12-29 07:31:52');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0efb386e-3ee5-46e5-bbe1-b102c8a1ea95', 181213165111, NULL, NULL, 'task', 9, 'bug', '04-diss', 5, 'on enter in global search does not go to the page number 1 always', 'global search preserves the page-num after enter and does not go to page number 1
which is kind of occurance of the larger bug with id:
', 'ysg', '2018-12-13 16:51:08', '2018-12-13 16:51:08', NULL, NULL, NULL, '2018-12-14 09:59:42');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('149dfea2-8a9e-4788-83bc-1c59cc61b6f5', 181207010650, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'add a file upload route in the front-end', 'A solution for the landing dir ?!', 'ysg', '2018-12-07 01:06:50', '2018-12-07 01:06:50', NULL, NULL, NULL, '2018-12-07 13:25:04');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2ec249cf-a841-4bc6-a8ff-b0e742136d69', 181208152441, NULL, NULL, 'task', 4, 'feature', '08-post', 5, 'add the read_only boolean attribute in the meta_columns table', 'which will provide the functionality to set certain columns to be only read_only

set the default to false', 'ysg', '2018-12-08 15:23:21', '2018-12-08 15:23:21', NULL, NULL, NULL, '2018-12-29 23:44:27');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b534f65a-b8f4-467d-8f9d-7bd113ac49c3', 181206222009, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'ddl changes to the userstories and goals ', 'Create the goals table. 
Change the userstories table to reflect the new dataformat for postgres porting ...', 'ysg', '2018-12-06 22:20:09', '2018-12-06 22:20:09', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd144c6f-7571-4f1d-ba76-e49b61ce271f', 181208102040, NULL, NULL, 'task', 9, 'feature', '08-post', 5, 'implement add new nested-set node on insert as trigger on hierarchy table', 'Attempt to move the logic of the updates of the lft & rgt attributes for each row on CRUD operations into a postgres trigger ... 
This would provide the benefit utilising the same API''s from the back-end from the UI, while gaining the feature of CRUD for a hierarchy table ... ', 'ysg', '2018-12-08 10:20:40', '2018-12-08 10:20:40', NULL, NULL, NULL, '2018-12-30 16:40:58');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f6229ae-06d2-4118-9076-eb13c8fdc19b', 181105184704, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'refactor the Query and Search ', 'both have repetitive code , which could to some QueryAble parent ... 
', 'ysg', '2018-11-05 18:35:14', '2018-11-05 18:35:14', NULL, NULL, NULL, '2018-12-29 23:43:35');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('22916132-eea4-40f8-800b-f9903bcf1f7f', 181210105229, NULL, NULL, 'code-task', 9, 'feature', '02-todo', 3, 'add it-<<item>-<<id> interlinking from text content', 'For example the it-yearly_issuses-181210105229 should link straight to this issue. 
Could use the full db meta-data from the editable and JavaScript search and replace ... 
Should be carefull about the performance ... ', 'ysg', '2018-12-10 10:52:29', '2018-12-10 10:52:29', NULL, NULL, NULL, '2018-12-25 21:01:54');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b59ddf99-8f16-422e-9500-1949caab4f90', 1806232302, 1, 10, 'task', 5, 'feature', '02-todo-2019', 2, 'evaluate a lib for the generic forms creation', 'The CRUD functionality will require a generic forms creation', 'ysg', '2018-06-30 00:00:00', '2018-07-15 00:00:00', 5.00, 0.30, 'poc', '2018-12-25 21:03:38');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3b94d22-7a86-4ef1-99ee-a4d6e3b9be97', 1808012100, 2, 10, 'task', 1, 'bug', '09-done', 9, 'the sorting does not work after the inline cell update', 'list as etable -> update cell content inline -> sort by this column does not work …', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 8.00, 0.50, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e643d88f-f61e-4e65-bbcb-5d0e58a20c54', 181229080528, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'refactor the doInitRequestModel into the BaseController', 'As it seems to repeat in each and every Controller under small variations .. 

Because it starts causing serious bugs ... ', 'ysg', '2018-12-29 08:05:29', '2018-12-29 08:05:29', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd1949da-cbe6-474e-8810-0d29bda8811a', 181106222627, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'make the getUrlParams a global js app function', 'Because: 
 - it will be needed in all the pages of the front-end', 'ysg', '2018-11-06 22:26:27', '2018-11-06 22:26:27', NULL, NULL, NULL, '2018-12-30 21:22:48');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('daa1a2f4-5fe8-45f7-8613-058cb0be22a7', 181213080222, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'add the view controller skeleton', ' - must have route test for every control flow branch
 - must support multiple "as" forms 
 - must be part of the site template
 - must be able to set css on per "as" form level
', 'ysg', '2018-12-13 08:02:22', '2018-12-13 08:02:22', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd56c37d-1999-4ab3-9cb6-2b0cf0f3bc80', 181223144043, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'style view-doc for read-only doc with title,desc & src', 'As follows: 
 - use view web action view.css
 - use view-doc.css
 - align the h3 properly 
 - align the description and src parts
 - add click on link sets the url in the address bar
', 'ysg', '2018-12-23 14:26:46', '2018-12-23 14:26:46', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9bb1568f-e3fb-4830-9668-8759bc1e82eb', 180807153721, 3, NULL, 'task', 3, 'feature', '01-eval-2019', 7, 'add push update to the table on db update', 'Might be doable if web sockets are implemerted and the whole data flow architecture change ... 

Might be too late for the list as grid page , but might be possible to be implemted more easily for the view as doc page ... 

add push update to the table on db update

This one is hard !!!
It would require websockets ... as well as somekind of trigger which "knows" what is the last selected "area" of table check that area and push to the client the info to refresh !!!!', 'ysg', '2018-08-07 15:37:21', '2018-08-07 15:37:21', NULL, NULL, NULL, '2018-12-13 16:49:50');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('324755df-a7aa-4e2c-a3d9-5da4aa20ee2c', 180925230044, NULL, NULL, 'task', 8, 'docs', '08-post', 4, 'functional requirements update', 'Update the functional requirements: 
 - what is the maximum amount of rows per table which should be supported
 - how-many users at once should be supported
The System should support 1000 users at a time
The System should be able to retrieve 2000 rows max per request

Write down those in the Requirements.
', 'ysg', '2018-09-25 23:00:45', '2018-09-25 23:00:45', NULL, NULL, NULL, '2018-12-29 23:46:09');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23c3fd72-679c-4f45-a4b0-ba33485e4bf4', 1806110034, 1, 10, 'task', 7, 'feature', '02-todo-2019', 2, 'add a modal dialog edit form for the edit action', 'Could be either from the list as html page or from the list as lables page', 'ysg', '2018-07-30 00:00:00', '2018-08-31 00:00:00', 30.00, 0.20, NULL, '2018-12-25 21:04:39');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('027fbbc0-e886-487b-8e14-9af74aec7404', 181128111024, NULL, NULL, 'code-task', 9, 'feature', '08-post', 4, 'numbers should be right-aligned in the table cells', 'The formatting of numbers should be as follows: 
 - right aligned', 'ysg', '2018-11-28 10:58:40', '2018-11-28 10:58:40', NULL, NULL, NULL, '2018-12-29 23:46:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7ceb5f7a-e803-43ad-a3a9-eb3b7de1f2e2', 1805082200, 1, 10, 'feature', 1, 'feature', '09-done', 9, 'improve integration testing', 'add the mysql db creation and population, add the documentation generation', 'ysg', '2018-05-12 20:00:00', '2018-05-12 21:00:00', 2.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('31e6b6e9-7d3a-4ef2-89b0-b02f78bfd509', 181127043713, NULL, NULL, 'task', 9, 'feature', '08-post', 5, 'implement full text search with ranking', 'how-to setup full-text search in postgres src:
https://stackoverflow.com/questions/22732507/how-to-setup-a-full-text-search-query-in-postgresql
', 'ysg', '2018-11-27 04:37:13', '2018-11-27 04:37:13', NULL, NULL, NULL, '2018-12-30 14:17:42');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d0874fda-e35a-4049-8345-e2a2f0d23091', 1806262001, 1, 5, 'refactor', 9, 'feature', '09-done', 9, 'refactor, update docs, features - regression tests walktrough', 'Prepare for stable monthly release - v0.4.5', 'ysg', '2018-06-26 10:00:00', '2018-06-29 11:00:00', 4.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0d92112c-5fc0-47c7-adb3-2d0ad9ab9a7f', 181216141131, NULL, NULL, 'task', 9, 'feature', '06-onhold', 5, 'add node level crud for nested-set hierarchy tables by trigger', 'According to the following url: 
http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
', 'ysg', '2018-12-16 14:11:31', '2018-12-16 14:11:31', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f795731-c493-4b00-a0c0-2991f95f5bf7', 181126105005, NULL, NULL, 'code-task', 9, 'feature', '08-post', 7, 'pre-populate search box with for url param value', 'when the list is comming from search the search box should be pre-populated with the search item from the for url param', 'ysg', '2018-11-26 10:34:04', '2018-11-26 10:34:04', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7532beb1-555d-4dff-b54b-46e2506cceda', 181213164328, NULL, NULL, 'task', 9, 'feature', '08-post', 9, 'web sockets simple poc ..', 'With Mojolicious and JavaScript web sockets
create a single msg passing back and from front-end to back-end 

If the poc is successfull than probably a change of the implemntation of the view as doc page would be needed ... ', 'ysg', '2018-12-13 16:43:24', '2018-12-13 16:43:24', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8d94e082-96f2-422a-9de1-ca816174ff10', 181123143612, NULL, NULL, 'task', 9, 'bug', '03-act', 2, 'the for url param is left in the list-as-grid page', 'It could possibly cause problems while naviating to the text search page ...', 'ysg', '2018-11-23 14:25:19', '2018-11-23 14:25:19', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('173cf109-180d-4cfd-a41a-a323e9e558cd', 181208235606, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'add the view-doc page skeleton', 'Should match the following requirements:
 - should follow the site-web-action-page-controls hierarchy
 - should have TestView.t from the very beginning
 - should be the example of how-to refactor the list web action
 - should be example of how-to refactor with the BaseController
 - should improve api for authorization with the BaseController
 - should improve the api for rendering with the BaseController

', 'ysg', '2018-12-08 23:56:06', '2018-12-08 23:56:06', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1f72929b-ed14-4627-8675-d07434e92ddf', 181229224919, NULL, NULL, 'task', 9, 'refactor', '09-done', 5, 'simplify the UrlParams converter api', 'The API had a lot of code repetitions ... ', 'ysg', '2018-12-29 22:49:19', '2018-12-29 22:49:19', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d93b33f-7ec2-432d-8787-e055e9b9ad1c', 181208150811, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'lbls are not shown in non-pick url in the list as labels page', 'Due to the default meta_columns pick of the colums: 
http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&page-num=1&page-size=7', 'ysg', '2018-12-08 15:06:50', '2018-12-08 15:06:50', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9eb0e098-31f8-4c08-bbe7-306393ee1ebe', 181101180808, NULL, NULL, 'task', 9, 'feature', '02-todo', 2, 'ensure the meta data reload does not brake the requests of other users', 'The following scenario: 
 - 2 users simultanious reload , when the global appConfig->{db-name.meta } is not set
 - one of them loads it ... 
 - the second one too ... 
 Anyways both of the requests should perform flowlessly ... ', 'ysg', '2018-11-01 18:08:08', '2018-11-01 18:08:08', NULL, NULL, NULL, '2018-12-25 21:04:20');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8059ce5f-66fb-434e-8af0-d81b3c9c078c', 181128111217, NULL, NULL, 'code-task', 9, 'bug', '08-post', 5, 'if the numbers have more than 4 decimals they are wrapped', 'due to the default width of the column : 
solution options: 
 - add the width column in the meta_columns table
 - check the editable defaults', 'ysg', '2018-11-28 11:00:33', '2018-11-28 11:00:33', NULL, NULL, NULL, '2018-12-30 14:17:47');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('123c4912-f6cf-4356-97eb-b7733ee0455c', 181126153639, NULL, NULL, 'code-task', 7, 'bug', '08-post', 4, 'pager is overlapping search-box on horizontal scroll', 'This might require a full refactor of the list as grid page ... it migth be better to re-iterate after the 
Needs a broader table to reproduce ... 
the pager should be with absolute position
If the table is too long the pager is placed on top of the search box ... and it should probably just be fixed at the top of the screen
', 'ysg', '2018-11-26 15:20:47', '2018-11-26 15:20:47', NULL, NULL, NULL, '2018-12-29 23:44:18');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ed426826-27f6-4442-bc36-7e85261d1f62', 1805282138, 1, 10, 'feature-implementation', 5, 'feature', '02-todo', 9, 'add export to txt from web ui', 'add export to txt from web ui', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 4.00, 0.10, NULL, '2018-12-30 15:57:10');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b34e616-6fb1-4dda-af0a-4ccae9aef2f5', 181204162534, NULL, NULL, 'task', 9, 'docs', '08-post', 4, 'add the docs for the "cannot connect to db" issue to DevOps guide', 'Because the easiest way to resolve would have been to check it from the DevOps Guide: ', 'ysg', '2018-12-04 16:25:34', '2018-12-04 16:25:34', NULL, NULL, NULL, '2018-12-29 23:45:47');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7a76c58b-291c-4411-ae82-9278fe837b95', 181213164633, NULL, NULL, 'task', 9, 'feature', '08-post', 5, 'add the ver attribute in the issues tables ', 'Because the target versions should be tracked and because the release notes for each version should be a single extract from the monthly issues table ', 'ysg', '2018-12-13 16:46:30', '2018-12-13 16:46:30', NULL, NULL, NULL, '2018-12-29 23:44:58');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65488841-9b53-4e26-bfc9-d5499f6e1afe', 181111121729, NULL, NULL, 'task', 9, 'feature', '06-onhold', 4, 'add the error template to be the blank search page', 'add the error template to be the blank search page as follows:
 - an empty search page is displayed with the current db
 - an error msg is displayed informing ', 'ysg', '2018-11-11 12:17:29', '2018-11-11 12:17:29', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b997f867-2c14-430f-8e35-7b2c5996ac0a', 181025082427, NULL, NULL, 'task', 9, 'feature', '03-act', 4, 'enable instance monitoring ', 'Instance monitoring: 
 - each instance has configurable scheduled ( in cron ) monkey benchmarking scripts
 - the results of each call are visible from a benchmarking table as follows: 
 -- start_time , stop_time , url , amount of requests 
 -- average page load time 
 -- average success rate ', 'ysg', '2018-10-25 08:24:10', '2018-10-25 08:24:10', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f4f24c13-415e-4f75-b28c-a795cc074268', 1805282137, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add export to xls from web ui', 'add export to xls from web ui', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 4.00, 0.10, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c3acd505-9d36-4ebc-a8fd-1ad78cc86bc8', 181225204703, NULL, NULL, 'task', 9, 'refactor', '09-done', 5, 'refactor xls export to within expandable factory pattern', 'refactor the export as xls into separate factory ', 'ysg', '2018-12-25 20:37:39', '2018-12-25 20:37:39', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('704de266-036b-4576-a72e-5fb3cff501f3', 181209003007, NULL, NULL, 'task', 5, 'feature', '09-done', 5, 'add the hselect route', 'The hselect route will retrieve from a specific branch a result-set having the nested-set lft and rht nums consistent', 'ysg', '2018-12-09 00:30:07', '2018-12-09 00:30:07', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3fc6e0ca-75eb-4bea-ac34-2681495c119b', 181210105802, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'add new redirects to a faulty url when url has filter', 'RootCause faulty regex for numbers 1-9 as it should have been 0-9
Reproduce by : 
1. Go to : 
http://192.168.56.120:3001/prd_ysg_issues/list/weekly_issues?as=grid&oa=prio&with=status-eq-02-todo&page-num=1&page-size=7

2. Click on add new : 
2.1 Expected result - a new url should be added ... 
2.2 Actual result the dyno appears with the following faulty url: 
http://192.168.56.120:3001/prd_ysg_issues/list/weekly_issues?as=grid02-todo&page-size=7&page-num=1', 'ysg', '2018-12-10 10:58:03', '2018-12-10 10:58:03', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('043b1d6a-2112-4c23-8c06-19e952a2822b', 181211182822, NULL, NULL, 'activity', 9, 'refactor', '03-act', 5, 'remove the "clever" usage of objModel as universal hash', 'IT was simply a "bad idea" ... better to stick with named variables and clean api''s in list context .. ', 'ysg', '2018-12-11 18:28:22', '2018-12-11 18:28:22', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('600e9727-b09d-4e42-933b-06c56392abf4', 181230133612, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'simplify conf files - remove mariadb functionalities', 'remove all mariadb related src and confs confs. All mariadb related code and confs must be deprecated eventually ... ', 'ysg', '2018-12-30 13:36:12', '2018-12-30 13:36:12', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('63e900c9-52c3-4937-ae98-206b341db9fb', 181224222715, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor select clause building', 'In order to be re-used by the HSelect', 'ysg', '2018-12-24 22:27:16', '2018-12-24 22:27:16', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('953b7bd6-d373-45e5-9223-094d1f82cea5', 181005085048, NULL, NULL, 'task', 9, 'major-release', '03-act', 3, 'release v0.6.0', 'Major release containing:
 - universal global txt search on items level for name & desc
 - simplistic JWT authentication
 - simplistic users with roles and authorisation model
 - patterns interpolation setting per column based on cols meta data
 - users, roles , item-level privilege granularity
 - 45 min deployment with 8 min downtime per instance
 - simplistic monitoring & benchmarking
 - list?as=grid page load with 7 items for 0.09 via benchmark
 - perfected GRUD grid with paging, filtering and page-sizing', 'ysg', '2018-10-30 22:00:00', '2019-01-01 22:00:00', NULL, NULL, NULL, '2018-12-25 21:05:05');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f608f1e5-9dc8-425d-85b3-a9210414070f', 181230181018, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'add edit title,desc and src on f2 in view-doc', 'According to the following scenario: 
 - the user selects with the keyboard the control
 - the System provides a visual that this control is selected
 - the user presses F2 ... 
 - the User turns the selected control into editable ... ', 'unknown', '2018-12-30 18:10:18', '2018-12-30 18:10:18', NULL, NULL, NULL, '2018-12-30 18:11:57');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ebedd47d-831e-4dda-a34d-aa15e9dc18b5', 180806102235, 1, NULL, 'task', 9, 'feature', '02-todo', 5, 'add 3D effect on the table cells', 'add 3D effect on the table cells.', 'ysg', '2018-08-07 00:00:00', '2018-08-07 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5b903a9d-f221-486a-a9e2-0517071f2cf3', 181102120826, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'download Roboto Font locally ', 'Removed vuetify dependency ... 
Seems that the Robot font takes too much time ... 
Source: 
https://drupal.stackexchange.com/a/209233', 'ysg', '2018-11-02 11:56:38', '2018-11-02 11:56:38', NULL, NULL, NULL, '2018-12-25 21:05:27');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de0910ff-78fb-4167-be79-f5c63610ede4', 181225211611, NULL, NULL, 'task', 9, 'feature', '06-onhold', 3, 'move all movable issues to the yearly_issues_2018 table', 'Where a "movable" issue means: 
 - having status 09-done
 - having status 04-diss, but not strategical meaning for the curr year
', 'ysg', '2018-12-25 21:06:48', '2018-12-25 21:06:48', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('928a1379-7623-4cdb-b021-9d48e26aa0e8', 181208142118, NULL, NULL, 'task', 9, 'refactor', '06-onhold', 4, 'change the site.html.ep to list.html.ep', 'The site should support also different dependencies for the view pages ... ', 'ysg', '2018-12-08 14:19:56', '2018-12-08 14:19:56', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('237fcff2-a422-4843-905c-a5e3504d0df6', 181224175417, NULL, NULL, 'task', 9, 'feature', '06-onhold', 4, 'add the doc-editable control ', 'The doc-editable should provide inline editing for the description and the source code ... possibly also to the titles ... ', 'ysg', '2018-12-24 17:54:17', '2018-12-24 17:54:17', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ff5afb7-6a17-46fb-83b3-d838c3478e9e', 181114145604, NULL, NULL, 'task', 9, 'refactor', '06-onhold', 4, 'refactor the objModel naming conventions', 'too much different keys in different situations lead to big mishups in refactoring ...
caused by it-181114095907', 'ysg', '2018-11-14 14:41:13', '2018-11-14 14:41:13', NULL, NULL, NULL, '2018-12-30 21:14:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b4682b6-f3a7-488b-847b-20f687875a25', 181106153644, NULL, NULL, 'task', 9, 'refactor', '08-post', 4, 'refactor the setting of url params in the RdrUrl params', 'It should be more generic , there is huge amount of repetitions ... 
Should have more testing as well ... ', 'ysg', '2018-11-06 15:17:55', '2018-11-06 15:17:55', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5c9b3978-94eb-4fcf-953c-1b0d45879c2b', 181103102230, NULL, NULL, 'task', 9, 'feature', '08-post', 5, 'ccs rules clean-up for better performance', 'Any time css files are edited: 
 - refresh tests to remove obsolete css rules
', 'ysg', '2018-11-03 10:17:51', '2018-11-03 10:17:51', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('022f0662-6fe0-4a1f-9072-1f7899c22671', 181126154113, NULL, NULL, 'code-task', 9, 'bug', '08-post', 5, 'if the table is too broad there is no horizontal scrolling', 'This might not be a bug , but kind of quirk ... 
Anyway''s to check whether or not this horizontal bar could be shown IF the table is wider than 100% ... 

The horizontal scrolling appears ONLY when one navigates with the tab, which is rarely the case as the majority of the users will use only the mouse ', 'ysg', '2018-11-26 15:25:21', '2018-11-26 15:25:21', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8146fd79-0625-4133-b518-e8fa9d04f1de', 181127110903, NULL, NULL, 'task', 9, 'docs', '08-post', 5, 'add the Perl Style Guide section in the DevOps document', 'add the Perl Style Guide section in the DevOps document
src: https://docs.scala-lang.org/style/', 'ysg', '2018-11-27 10:49:56', '2018-11-27 10:49:56', NULL, NULL, NULL, '2018-12-30 21:16:02');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0aee1245-f7fc-4c2f-af2f-33af91c893b7', 181019152804, NULL, NULL, 'task', 9, 'bug', '04-diss', 9, 'add tests for the basic auth ', 'Should run the tests ONLY if the http_passwd_file is present: 

 - how-to capture the login dialog box ?!
Might be a waste of time as the basic auth is to be replaced by v0.6.0 by the proper JWT auth ... ', 'ysg', '2018-10-19 15:15:35', '2018-10-19 15:15:35', NULL, NULL, NULL, '2018-12-25 21:05:46');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('584b3bb1-325e-495c-9eee-99a438dc456d', 181230211652, NULL, NULL, 'task', 9, 'refactor', '02-todo', 2, 'if no data is found set the play previous link and rewind prv to page-num 1', 'if no data is found set the play previous link and rewind prv to page-num 1 as it now does not point anywhere ...', 'unknown', '2018-12-30 21:16:52', '2018-12-30 21:16:52', NULL, NULL, NULL, '2018-12-30 21:17:53');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de2eec9b-2335-4552-9780-f29a3f7d00d5', 181002103808, NULL, NULL, 'task', 9, 'refactor', '04-diss', 9, 'move all external dependencies to be locally hosted', 'This "DECREASES" performance in the amnz ec2 prod substantially => no go !!!

Must be rolled back with a separate issue ...
A more clever mechanism must be figured out ... later on ... 

move all external dependencies to be locally hosted. This should improve sudden network
 latencies', 'ysg', '2018-10-02 10:20:24', '2018-10-02 10:20:24', NULL, NULL, NULL, '2018-12-25 21:05:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f0c057b9-f7a9-45c6-acca-60ba750d38f9', 181106101630, NULL, NULL, 'task', 9, 'refactor', '03-act', 5, 'refactor the list and search to share common css rules', 'Both will output the result into table: 
 - the list would have it "blue" with CRUD 
 - the search would have it "white" read-only
 - both should have paging and filtering ... ', 'ysg', '2018-11-06 09:57:32', '2018-11-06 09:57:32', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3bb269b5-a33b-4da7-b83c-0904e6a02719', 181208151140, NULL, NULL, 'task', 1, 'refactor', '09-done', 9, 'remove the list as table page ... ', 'It has the old control flow ... 
The same functionality could be achieved with the combination of meta-data attribute + the list as grid page

This will also decrease the amount of the package and the code to be supported ... ', 'ysg', '2018-12-08 15:10:20', '2018-12-08 15:10:20', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b15f0fce-2bbd-46c2-bcab-058786d8ff76', 181216141631, NULL, NULL, 'task', 9, 'release', '02-todo', 3, 'release v0.5.6 "read-only docs"', 'Should contain the following back-end calls:
 - the naming conventions of the postgres confs has changed !!!
 - select branch with all descendants
 - a read-only doc ', 'ysg', '2018-12-16 14:16:31', '2018-12-16 14:16:31', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('87e730f8-78b6-422c-a53a-66a826a86bf8', 181112093653, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'issue-tracker perspective for the IT System definition', 'As follows:
 - humans
 - infra
 - hardware
 - binaries
 - configuration
 - data
 - source code
', 'ysg', '2018-11-12 09:36:53', '2018-11-12 09:36:53', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4bcd0f14-0102-4969-862b-161827546b0a', 181213210047, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'mallformed url params in :in - to search transitions', ' - the pick=<<list-columns>> was not removed in search - fixed
 - the ?& char seqeuence was not handled properly - ?!
 - the & in the &url-param=url-param-val was not quantified in regex - fixed
uri = uri.replace(/&with=([a-zA-Z_%\-0-9]+)/gi , "")
uri = uri.replace(/[&]{0,1}with=([a-zA-Z_%\-0-9]+)/gi , "")', 'ysg', '2018-12-13 21:00:47', '2018-12-13 21:00:47', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32e05c85-933f-4884-892e-c268a71eb01f', 181212225114, NULL, NULL, 'task', 9, 'refactor', '03-act', 4, 'refactor all the postgres facades to use Mojo::Pg , rv ', 'Which will also change the security model as well as the connection string will the the username and the pw from the configuration file :
 - go route by route
 - run always unit tests
 - a method shoud fill into 1 screen
', 'ysg', '2018-12-12 22:51:14', '2018-12-12 22:51:14', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('667cdebd-c7bc-4420-ad40-2f59eaecf8df', 181207002543, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add a postgres trigger to update the seq attribute', 'Any hierarchical item should have an trigger on update and insert which increases the sequence for the rest of the items having equal or smaller id of the current by 1', 'ysg', '2018-12-07 00:25:43', '2018-12-07 00:25:43', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a8e04300-688b-43c7-906b-f64586914603', 181206125040, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'add the devops_guide table', 'The devops_guide table will be the future dog food table for storing the current isg_pub app DevOps table data ... ', 'ysg', '2018-12-06 12:50:40', '2018-12-06 12:50:40', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('00ada509-05f1-4810-896b-20b89d6fb85a', 181210111035, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'implement the select of hierarchical hash ref from the db', 'By using the : 
https://mojolicious.org/perldoc/DBD/Pg
 As follows:
 - use the proper return value check
 - test for the following cases 
0  Empty query string
1  A command that returns no data successfully completed.
2  A command that returns data successfully completed.
3  A COPY OUT command is still in progress.
4  A COPY IN command is still in progress.
5  A bad response was received from the backend.
6  A nonfatal error occurred (a notice or warning message)
7  A fatal error was returned: the last query failed.', 'ysg', '2018-12-10 11:10:35', '2018-12-10 11:10:35', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('17093701-15d2-4947-8272-ea630e4d2e05', 181230174917, NULL, NULL, 'task', 9, 'setup', '02-todo', 1, 'create the v0.5.6 configuration files', 'Copy locally the amzn host files : 
 - 
 - foreach future version set the v0.5.6 ', 'ysg', '2018-12-30 17:49:17', '2018-12-30 17:49:17', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d3af281-a97c-4384-993e-328cfb6a3081', 181225140446, NULL, NULL, 'task', 9, 'test', '09-done', 9, 'add benchmarking call for the view-doc page', 'As the page seems quite fast for now .. but the performance must be tracked ...', 'ysg', '2018-12-25 13:55:08', '2018-12-25 13:55:08', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de4275e9-5822-4753-bfca-5712ade84fbf', 190106032514, NULL, NULL, 'task', 9, 'feature', '09-done', 1, 'add dynamic right menu in the view-doc page', 'As follows: 
 - easy open and close the right menu 
 - the scrolling for the left body content and the toc in the right works separately', 'unknown', '2019-01-06 03:25:14', '2019-01-06 03:25:14', NULL, NULL, NULL, '2019-01-06 04:07:17');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('91c310e6-73e7-4db2-85cd-8f26cb68be19', 181225184927, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the select of branch by branch-id', 'Add the selection by branch by branch id as follows: 
 - if not provided the default is 0 - the root element - aka -all
 - the root element has ALWAYS id of 0
 - the root element has ALWAYS level of 0
 - if the branch id provided is not number an error msg is returned', 'ysg', '2018-12-25 18:39:58', '2018-12-25 18:39:58', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7cb1a448-76d3-4743-a8af-515b01421f71', 181227164613, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'add read-only static right menu in the view-doc page', 'Which will enable the dog fooding for the docs, as the large documents were really hard to scan trough. 
This is a temporary solution - a quick show/hide functionality will be added later on ... 
', 'ysg', '2018-12-27 16:46:13', '2018-12-27 16:46:13', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('49fb949b-5833-47f2-a862-c79b0b16e152', 181210222404, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor the doReloadProjDbMetaData to onliner - fix the tests as well', 'refactor the doReloadProjDbMetaData method to oneliner in the controller to avoid complex control flow in every controller method 

Fix all the unit tests as well !!!', 'ysg', '2018-12-10 22:24:00', '2018-12-10 22:24:00', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d9e11de6-159c-46e8-b23a-7e5f8865a479', 181210213810, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'morph RdrUrlParams -> CnrUrlPrms', 'To relfect better single purpose according to architecture ... ', 'ysg', '2018-12-10 21:38:10', '2018-12-10 21:38:10', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e65e3af3-9d27-43d0-80f5-62dac0d311c3', 181225204159, NULL, NULL, 'task', 9, 'data', '09-done', 9, 'move all the official docs tables into postgres', 'The following ones:

issue-tracker-installation-and-configuration-guide
issue-tracker-system-guide

 - ok - devops-guide
 - ok - userstories
 - ok - features
 - ok - requirements
 - ok - concepts		



', 'ysg', '2018-12-25 20:32:34', '2018-12-25 20:32:34', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('92b5e4c0-ada9-4e76-afba-d7ea6c116693', 181005075514, NULL, NULL, 'task', 9, 'capability', '09-done', 9, 'achieve capability to deploy 3 instances in the cloud for 1h', 'The deployment of v0.4.9 took 1h as follows:
 - ssh to cloud srvr
 - git clone latest version
 - adjust configuration files ( manual ) 
 - for dev,tst,prod
 -- stop old instance
 -- recreate db 
 -- load data 
-- start new instance
Prd instance downtime - 10 min', 'ysg', '2018-10-05 07:55:14', '2018-10-05 07:55:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('611a0f2d-08e3-489e-af4b-2de3c0f5a2b2', 181230180515, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the export as xls does not take into account the page-size', 'Because of the url setting params ... refactoring need ...', 'ysg', '2018-12-30 18:05:15', '2018-12-30 18:05:15', NULL, NULL, NULL, '2018-12-30 21:34:35');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f2d724ea-b257-45a5-be07-fed8fd8087d8', 181001221108, NULL, NULL, 'task', 9, 'testing', '09-done', 9, 'install and setup the the chrome-driver', 'Install and setup the chrome-driver and run the most simple example:
https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/', 'ysg', '2018-10-01 22:10:58', '2018-10-01 22:10:58', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d4cbfe6b-0a05-415a-8807-26d61f7ca996', 181207001309, NULL, NULL, 'task', 9, 'feature', '09-done', 6, 'port the xls-to-db nested-set load to postgres', 'Was working only on mysql ... Might have been bug ... but anyways the whole feature was not used at all ... at least during the last 4-5 months ..', 'ysg', '2018-12-07 00:13:09', '2018-12-07 00:13:09', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e6761d96-ef60-4d20-98bd-ddf83229f5ba', 181206125937, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'use the issue-tracker userstories', 'move the isg-pub UserStory data into the issue-tracker userstories table ... ', 'ysg', '2018-12-06 12:59:37', '2018-12-06 12:59:37', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b4005629-ef84-40b6-937d-0f4ca050873c', 181214095857, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'multiple occurrences operators are not removed in addNew', 'Because an 1 or many quantifiers MUST be used in the regexes ...
the filter stays when adding a new item .... which is wrong ... 
Use the following url for test : 
http://192.168.56.120:3001/prd_nokia_musa/list/benchmarks?as=grid&page-num=1&page-size=7&like-by=jira_issue_id&like-val=NPOMUSA-540&like-by=jira_issue_id&like-val=NPOMUSA-534
and click the add new button', 'ysg', '2018-12-14 09:58:52', '2018-12-14 09:58:52', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2a515908-c7b2-4fcc-894b-4c34ff1dfc27', 180921152541, NULL, NULL, 'task', 9, 'functionality', '04-diss', 9, 'add the back-end action for select table columns ', 'A duplicate issue:
Prerequisite for the :pick operator in the search-box:
180921085537
chk:
http://192.168.56.120:3001/dev_issue_tracker/select-meta/monthly_issues



http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,weight,name,description&page-size=5&page-num=1&oa=prio&with=id-eq-180921085537', 'ysg', '2018-09-21 15:25:39', '2018-09-21 15:25:39', NULL, NULL, NULL, '2018-12-25 21:06:14');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('628d316a-8439-440a-9c32-35eb92757dfa', 181224175319, NULL, NULL, 'task', 5, 'feature', '09-done', 5, 'add the logical numbers in the view-doc page', 'Add the order numbers such as : 
0.0.0
1.0.0
1.1.0
1.1.1. 

Looks like not much time is added to the addition of the logical numbers', 'ysg', '2018-12-24 17:53:20', '2018-12-24 17:53:20', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12eaae92-7171-4b0e-8e54-6b5fe9444cdd', 181211085709, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'separate the unit-tests from the integration tests ', 'The reason for not-running enough unit tests has been the tight coupling the and the time consuming integration tests ... 
Thus the integration tests have to be separated ... 
There should be probably in the long run be: 
 - integration tests 
 - data-load tests 
 - unit-tests 

each with it''s own starting shell action', 'ysg', '2018-12-11 08:57:05', '2018-12-11 08:57:05', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0662c2ad-7ecc-4f74-8530-24d2283d2f29', 181214152011, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'the hide url operator does not work', 'and the tests pass, because only the hide guid was tested and it is hidden by default !!! 
', 'ysg', '2018-12-14 15:02:57', '2018-12-14 15:02:57', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('54d77e30-aef3-489b-8996-459efaeab494', 181208233500, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor the default content section', 'change to a "cnt_body_controls" ... as part of the future one site, multiple web actions web layout refactoring ... which for now seems quite difficult and time consuming ... ', 'ysg', '2018-12-08 23:35:00', '2018-12-08 23:35:00', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cc64ae35-6085-4132-b851-6fd88a606539', 181210220604, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor the isAuthorized to an oneliner in the controllers', 'refactor the isAuthorized to an oneliner in the controllers to avoid confusion ... ', 'ysg', '2018-12-10 22:06:04', '2018-12-10 22:06:04', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b43a75e8-2fa9-4731-9bdb-5274a87ca411', 181206130318, NULL, NULL, 'task', 9, 'ui', '09-done', 9, 'shorten the page-size to pg-size and page-num to pg-num', 'In the url to safe couple of chars length in the ... 
Those should be preferably stored in the session mainly from now ... on ... 
And change the morph-dir action to use \Qjust-a-string\E ...
Just taking too much space ...
Lessons learned : yet another example why real demand driven development is more efficient way of gaining know-how ... and new ca', 'ysg', '2018-12-06 13:03:18', '2018-12-06 13:03:18', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f3024ef5-7377-4d11-bea7-395072c4ff0c', 181207001452, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'port the isg-pub export as md to issue-tracker', 'Thus the generate docs to mdf will be moved to the postgres db .. 
blocked by the it-monthly_issues-181209003007 issue: 
http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&with=id-eq-181209003007

 Refactor the export as xls to allow factory call ...

This is partial but good enough implementation for now ... ', 'ysg', '2018-12-07 00:14:52', '2018-12-07 00:14:52', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('407a0f70-a3d3-4ad6-ab12-1685df0d2d1c', 181225204409, NULL, NULL, 'task', 9, 'docs', '09-done', 5, 'update the README with links to the official docs', 'The README.md should be updated with the links in the demo to the offical docs', 'ysg', '2018-12-25 20:34:44', '2018-12-25 20:34:44', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('afc2fce8-8981-40c3-81fb-99e652f4e020', 181123171852, NULL, NULL, 'task', 9, 'setup', '09-done', 6, 'start v0.5.5', 'As follows: 
 - ok: update projects confs ...
 - ok for create new instance dir
 - ok for update dev from master
 - ok for make a backup ', 'ysg', '2018-11-23 17:07:29', '2018-11-23 17:07:29', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f1a0987f-f875-4503-8a17-a90948b593db', 181211091057, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the app label unit test ', 'Which is actually a totally separate functionality and/or feature in the ui and deserves a special place .. ', 'ysg', '2018-12-11 09:10:53', '2018-12-11 09:10:53', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7e4c6703-79f4-468f-a38a-b33e27e4cd61', 181125171833, NULL, NULL, 'task', 9, 'setup', '09-done', 5, 'remove the binaries and data from the src package', 'The src package which goes to master should have only txt files - not event pdf, xls or sql dump files with data', 'ysg', '2018-11-25 17:18:33', '2018-11-25 17:18:33', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dc385050-b98b-4d58-9aea-41a556fad57f', 181123155521, NULL, NULL, 'task', 9, 'release', '09-done', 9, 'release v0.5.5 "default hides from table"', 'This release should concentrate of the "default hide columns per table" feature
 - the main benefit will be more space in the omnibox for queries
 - refactoring 
 - performance improvements in ui
 - shell actions performance improvements
 - configuration change for db user pw
 - run preq script

Lessons learned: 
 - keep the dev,tst , prd leaneage also on the db level
 - the meta columns ddls changes break the connectivity between env types - that is app layer to db ... (  a strange id not found error appears which is not bug , however ) 
 - change the setup to upload to an upload dir
 - should first check the running processes for left overs ... ', 'ysg', '2018-11-23 15:43:55', '2018-11-23 15:43:55', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55696674-b8a8-4f1a-b1c1-c2cc4e556b32', 181207002244, NULL, NULL, 'task', 9, 'setup', '02-todo', 3, 'setup a new landing dir in the web host ', 'Because it has caused 2 times downtime in the web !!!
Anyways the lading dir MUST not be /tmp/
Probably something like /home7ubuntu/var/issue-tracker/dat/tmp/landing', 'ysg', '2018-12-07 00:22:44', '2018-12-07 00:22:44', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ba4d9411-f919-4f7c-aa4d-611c26058374', 181113193829, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'v0.5.5 performance recap', 'As follows: 
 - run benchmarks
 - identify optimisations', 'ysg', '2018-11-13 19:38:19', '2018-11-13 19:38:19', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('39291630-8aad-4242-bbd8-2993ccd31ecd', 181224190210, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor site-> site , page->page, component->component in view-doc', 'refactor site-> site , page->page, component->component in view-doc', 'ysg', '2018-12-24 19:02:11', '2018-12-24 19:02:11', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4202a7d3-83fc-46db-815f-738255da7f1f', 181229233517, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the src code in the md files', 'as it was missing ... ', 'ysg', '2018-12-29 23:35:17', '2018-12-29 23:35:17', NULL, NULL, NULL, '2019-01-06 04:07:49');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('eea2a2c4-4476-478e-8580-34a46b451ee4', 180830103358, NULL, NULL, 'task', 9, 'feature-ui', '04-diss', 9, 'query title label', 'Build a human readable query title with the same font and style as the existing app_db label', 'ysg', '2018-08-30 10:16:32', '2018-08-30 10:16:32', NULL, NULL, NULL, '2018-12-25 21:06:29');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a44dda06-f709-4ed6-8ef1-c08def3fedbc', 1805111400, 1, 10, 'activity', 6, 'feature', '04-diss', 9, 'create the select-create form page', 'To test the create action and to start avoiding using the xls', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-25 21:11:32');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('98e6b6fb-e165-41b6-afc8-74d86d18eec6', 180517213101, 1, NULL, 'goal', 9, 'load-testing', '04-diss', 9, 'add load testing to the update back-end web action', 'By simply instantiating ASYNCRONOUSLY 2,4,16,32,64,128,256,512,1024 ajax calls at once non-blocking-wise .Chk the following info src: https://mojolicious.io/blog/2017/12/09/day-9-the-best-way-to-test/http://blogs.perl.org/users/chase_whitener/2016/01/mock-testing-web-services-with-mojo.html', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-12-25 21:11:20');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd73b110-b409-40c1-84b9-8e0f310151a5', 180829090531, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'docs scan trough', 'As there might be logical inconsistencies in the documentation', 'ysg', '2018-08-29 09:02:56', '2018-08-29 09:02:56', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9ef86517-40b3-4ca2-a770-637796d85d7c', 181229072850, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'add app version into db name', 'Implement the data versioning by : 
 - setting the app name in the url vs. the app db name in the cnf
 - each time the app version is increased, db name is changed
 - this means that each app version upgrade is db migration !!!
 
Benefits: 
 - enforce data and ui validity
 - enforce end-to-end testing for each change of the environment
 - remove the striking and not user-friendly suffixes in the urls
 - the version,env-type combination in the ui via the http_port 
 

Cons: 
 - the fetch from one ver-type db to another ver-type ui is removed

', 'ysg', '2018-12-29 07:28:50', '2018-12-29 07:28:50', NULL, NULL, NULL, '2018-12-29 07:37:21');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a563cdc3-f63c-4f59-8567-6e202c91b3df', 181229225428, NULL, NULL, 'task', 9, 'feature', '01-eval', 1, 'add right click menu on the links', 'Chk the following source: 
http://jsfiddle.net/megazd/n6h549f1/
https://www.cssscript.com/demo/css-togglable-fullscreen-side-navigation
https://www.w3schools.com/howto/howto_js_sidenav.asp', 'ysg', '2018-12-29 22:54:28', '2018-12-29 22:54:28', NULL, NULL, NULL, '2019-01-06 03:24:53');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be1561da-7c88-4e2b-83bf-b678477788b5', 181229232905, NULL, NULL, 'task', 9, 'feature', '02-todo', 2, 'remove code repetion in error handling in Select.pm', 'A lot of code repetition ... check the HSelect implementation ...', 'ysg', '2018-12-29 23:29:05', '2018-12-29 23:29:05', NULL, NULL, NULL, '2018-12-29 23:50:20');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('698320a1-7b6f-47c7-a44e-19218ba2bab5', 181002103341, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'dropdown keyboard navigation', 'the scroll down to the search-box dropdown does not work with the keyboard', 'ysg', '2018-10-02 10:15:57', '2018-10-02 10:15:57', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbe11026-4a14-4900-bc80-fa826f296e4d', 1806251101, 1, 10, 'task', 3, 'feature', '04-diss', 9, 'speed-up the xls-to-db action', 'By running in sequence read xls , file, write to db for each table', 'ysg', '2018-07-01 00:00:00', '2018-07-01 00:00:00', 2.00, 0.10, 'feature,xls', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ab5f1dbc-3ad1-4b32-9b0b-cf09655edd42', 181027084201, NULL, NULL, 'task', 9, 'data', '09-done', 9, 'create the jasu project', 'Create the jasu project to test once again the existing proj template.', 'ysg', '2018-10-27 08:42:01', '2018-10-27 08:42:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('42311561-3acc-4b01-a489-bf07253b246a', 180831230324, NULL, NULL, 'task', 9, 'functionality', '09-done', 9, 'version changes in the to-ver action', 'add the version changes in the to-ver action', 'ysg', '2018-08-31 23:03:24', '2018-08-31 23:03:24', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ae1ae9c0-87bc-4384-badb-2ed8b9802c5a', 1807101031, 2, 5, 'feature', 1, 'feature', '09-done', 6, 'add the CREATE for the CRUD table via a single click in etable', 'via a single click in the e-table', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('86bab9d7-f29b-4a41-a173-4b2a711fdf8d', 180822152349, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the backup-postgres-db action does not create instance db dir', 'The error msg was: 

dat/mix/2018/2018-08/2018-08-22/sql/tst_issue_tracker/*'': No such file
or directory

Revealed only on deployment to tst', 'ysg', '2018-08-22 15:23:50', '2018-08-22 15:23:50', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e95f206b-2783-4a1e-b847-64032c90b1aa', 181018131914, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'resize the textareas width on click , focus and tab', 'At least the following events:
 - when typing @input

 - on blur 
 - on click
', 'ysg', '2018-10-18 13:19:14', '2018-10-18 13:19:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('169f00ae-3217-462b-94b2-b1b811a281c8', 1804290100, 1, 10, 'task', 5, ' docs', '09-done', 9, 'fix nasty bug in Initiator cause by related dir in mojo testing framework', 'Or add the ability to resolve the dir structure of any perl script using the Initiator - obs has to be called only once ... 
fix nasty bug in Initiator cause by related dir in mojo testing framework.
The root cause - the Initiator used $0 while it should have used __FILE__. See :
https://stackoverflow.com/a/90721/65706', 'ysg', '2018-04-29 10:21:23', '2018-04-29 13:21:23', 2.00, 3.00, 'docs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('40b10070-5c25-4966-9c82-e82905d5f288', 181004231103, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'change as=etable to as=grid in master', 'In the documentation as the links in the features docs are dead', 'ysg', '2018-10-04 23:11:03', '2018-10-04 23:11:03', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aceefa3f-630c-4f63-85e3-8ee3cda6758c', 181229234842, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'create automation and setup for pdf docs download', NULL, 'ysg', '2018-12-29 23:48:42', '2018-12-29 23:48:42', NULL, NULL, NULL, '2018-12-29 23:50:17');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5145e9f7-dcab-4570-a731-5139ea5eb366', 180927085853, NULL, NULL, 'task', 5, 'bug', '09-done', 7, 'the create new works only on the second click', 'The new redirect has evoked the bug ...
But ONLY in some conditions ?!
Hard to reproduce', 'ysg', '2018-09-27 08:58:53', '2018-09-27 08:58:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5d04f84b-5484-40e6-81cb-fecca5e99fa9', 181229234920, NULL, NULL, 'task', 9, 'feature', '02-todo', 1, 'implement export to pdf', 'Implement the export to pdf action ... 
', 'ysg', '2018-12-29 23:49:20', '2018-12-29 23:49:20', NULL, NULL, NULL, '2018-12-29 23:50:13');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68ba04d8-c819-40ab-b963-65fe1531fcc5', 1805071500, 1, 10, 'task', 1, 'feature', '09-done', 9, 'add the list vue.js poc', 'Create a proof of concept poc page with REST api fetch from the back-end using vue.js and axiom', 'ysg', '2018-05-07 13:38:00', '2018-05-07 13:38:01', 2.00, 3.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d8f1f9d8-bd5a-46b0-9e38-d025392d4407', 181104184025, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'fix git push glitch', 'The checking of the todo:<<owner>> labels does not work ... 
temporary solution - deactivate the scrpt
There is some kind of bug probably in the pre-push script ... resulting in exit code != 0
', 'ysg', '2018-11-04 18:40:24', '2018-11-04 18:40:24', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('502efdc0-c82c-48d8-bf9f-c842def5cd2c', 180815141257, NULL, NULL, 'task', 2, 'feature-ui', '01-eval', 8, 'add drag-and-drop for doc view', 'Evaluate the following component: 
https://github.com/SortableJS/Vue.Draggable

Would require update of the h_table hierarchy', 'ysg', '2018-08-15 14:12:47', '2018-08-15 14:12:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('76d7be3f-d5a8-4ad9-8b64-881cab895daa', 180815125716, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'complete the DELETE web action', 'complete the DELETE web action', 'ysg', '2018-08-15 12:57:16', '2018-08-15 12:57:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('28aaf308-c462-4739-a55a-ad604696e237', 181023141844, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the meta_tables and meta_columns tables', 'Will be used: 
 - for providing interpolation_patterns
 - ui controls guidance', 'ysg', '2018-10-23 14:06:42', '2018-10-23 14:06:42', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b0c27b86-6a5d-4c52-9309-489be31976b4', 1806232301, 1, 10, 'task', 9, 'feature', '09-done', 9, 'add json-to-db shell action', 'In order to achieve independance from the xls run-time for achieving the full CRUD, I wanto to be able to take quickly backup and restore db data from files on timely basis.', 'ysg', '2018-06-23 00:00:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('82721998-9991-46f6-aaeb-07147fde580b', 180818110906, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'walk-trough all the Requirements for the current version.', 'walk-trough all the Requirements for the current version. 
Add the INTRO section with the documentation set - a more formal way of describing the documentation.
Probably there is something in the Requirements doc which is to be updated', 'ysg', '2018-08-18 11:06:58', '2018-08-18 11:06:58', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f98d0280-a3b7-4632-aaab-feba8f0eed56', 1805161614, 2, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the like-by url param for the list web control ', 'add the like-by url param for the list web control 
 - ok path
 - nok path', 'ysg', '2017-05-14 07:00:00', '2017-06-29 07:00:00', 5.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bdcef54c-dda3-4c6a-861b-e17b73d8e9e3', 1807101028, 2, 5, 'feature', 8, 'feature', '02-todo', 7, 'add the CREATE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a0327094-9f28-4bab-8dc6-b4c228bbaeb3', 1805161613, 2, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the filter-by url param for the list web control ', 'add the filter-by url param for the list web control
 - ok path
 - nok path ', 'ysg', '2017-05-14 07:00:00', '2017-06-29 07:00:00', 5.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3761dfcf-91a4-427e-ad1a-f62063ff2008', 1807170141, 1, 10, 'documentation', 1, 'documentation', '04-diss', 9, 'document the list as table control flow in the system guide', 'Update the application control flow descpription', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f13d89f3-b1d4-4d0b-9dcc-f86f6c166a84', 181024095202, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'onEnter + :<<op>> should go to page 1', 'onEnter + :<<op>> should go to page 1
should always set the redirect to page-num=1', 'ysg', '2018-10-24 09:52:02', '2018-10-24 09:52:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1d2744a6-2fcd-46a5-b121-78387616c316', 1805141000, 1, 10, 'docs-addition', 1, 'docs', '01-eval-2019', 9, 'create user manual', 'create the user manual document, which will contain ONLY business rules and logic as well as non-devops related content.', 'ysg', '2018-05-25 20:53:00', '2018-05-30 00:00:00', 0.50, 0.50, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f5942e49-4d52-455a-902e-712f16a7a4db', 1806281841, 2, 2, 'task', 9, 'feature', '09-done', 9, 'add CRUD table control POC with dummy console.log calls', 'So that only the UI interface events will be captured …', 'ysg', '2018-07-01 00:00:00', '2018-07-30 00:00:00', 30.00, 1.00, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('909aa8ac-eb4e-455d-afa2-2c29ad2b29d6', 180807185440, 1, NULL, 'task', 9, 'functionality-back-end', '09-done', 6, 'add quickly the back-end for the DELETE', 'Add quickly the back-end for the DELETE action. because it would help out the usage of the UI ... and reduce the required time for testing ...

OR at least the ok flow ...', 'ysg', '2018-08-07 18:54:40', '2018-08-07 18:54:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3dc882f9-2ee2-4d47-a45f-4740bf0dc054', 180817161549, NULL, NULL, 'task', 9, 'testing', '09-done', 7, 'test db-to-json and json-to-db', 'achieve apply DDL with the same columns and restore table backup from the db-to-json and json-to-db shell actions', 'ysg', '2018-08-17 15:58:39', '2018-08-17 15:58:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5bd1e9cd-f3f4-4b12-bdfd-32283dbd38f1', 180827113929, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'pageNum.trim() bug', 'was due to the delete # bug', 'ysg', '2018-08-27 10:26:23', '2018-08-27 10:46:23', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('417cf290-bc7d-43ac-91eb-320ba5a23492', 1806061000, 1, 6, 'feature', 1, 'feature', '09-done', 9, 'add the concepts document', 'The Concepts document should provide the following sections:
- Introduction
- Mission statement
- Concept illustration

Status update: move to yearly. Too early for this type of docs .. Yet.', 'ysg', '2018-06-01 00:00:00', '2018-12-30 00:00:00', 10.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c78830ab-e68f-4f6f-9c0c-1c71743cf991', 181017223954, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix jqcloud.js absence', 'fix jqcloud.js absence
- it was not detected because there was no test !!!', 'ysg', '2018-10-17 22:39:54', '2018-10-17 22:39:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd4d7032-e6e2-4c59-9e64-688d46f6ba33', 181020230304, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'remove obsolete curl-test-get-item shell action code files', 'remove obsolete curl-test-get-item shell action', 'ysg', '2018-10-20 23:03:04', '2018-10-20 23:03:04', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0b51b8b3-9f37-48e6-ba57-61b256ed4915', 181018080737, NULL, NULL, 'task', 9, 'bug-feature', '09-done', 9, 'kill procs occupying wanted app instance ports', 'add send SIGTERM for procs occupying wanted app instance ports with mojo-morbo-start
To notice: 
 - the scripts stops ANY running instance occupying the starting desired confgirued mojo morbo port instance , not only on the current one, but other versions , or env types as well ( dev,tst , prd ) 
- add check of such instances exists and exit with the proper msg if they don''t to avoid confusion
- improve on-screen logging 
- remove the PS1 env var ( also from cnf repo )', 'ysg', '2018-10-18 08:07:29', '2018-10-18 08:07:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b6b8c67-061d-4def-a306-ff3f5f51206b', 180807184715, NULL, NULL, 'task', 1, 'feature-ui', '09-done', 9, 'quick search sizing', 'make the quick search input slightly larger + add the effect of re-sizing on focus', 'ysg', '2018-08-07 18:47:15', '2018-08-07 18:47:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e79a6d8e-0f86-412a-ac4c-95e6f83c1ba0', 1805060100, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the order-by in url to order by in db reader control flow in List.pm controller', 'add the order-by in url to order by in db reader control flow in List.pm controller.
Changed the format of the dat to array reference  because of the need to be able to pass a sorted data structure to the render json method. ', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:01', 4.00, 3.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('88372df5-f14e-44f3-81ac-fd00275c9fad', 1805202317, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'separate the control and the page code', 'Add include directive in the page:
 - ok for add layout page
 - todo for add the control css from the control to the layout', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 5.00, 3.00, 'refactoring', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5d5189b2-43de-4d92-a3df-7806506c5d6a', 1805222246, 1, 10, 'feature-implementation', 5, 'feature', '09-done', 9, 'add the with-col=val url param', 'add the with-col=val url param', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 4.00, 6.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('357ddadd-601f-4666-8b6d-740a312968ef', 180806214516, 1, NULL, 'task', 9, 'feature-bug', '09-done', 9, 'add select-all on tab press with the keyboard in content-editable', 'When one uses the mouse, nothing is selected ( aka there is no event) , yet when one uses the keyboard the whole content is selected - those faster edition is possible ...

add select-all on focus in content-editable.

It is just annoying to every time Ctrl + E or Ctrl + A first to select all , to go to the end , when one could start typing straight aways', 'ysg', '2018-08-06 21:45:15', '2018-08-06 21:45:15', 1.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be969ff3-eaf5-44ba-8e7e-9f4ac1f578af', 180927095249, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the capability to display user-friendly non-technical errors and log technical errors', 'By using the hacky wackly '' :: '' string separator where the $1 is the human-readable part and the $2 is the nerd readable part of the msg which will be console.errorred in the browser, but not shown on the page', 'ysg', '2018-09-27 09:52:49', '2018-09-27 09:52:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('33fe6333-ed41-4af7-9169-ab353eac431b', 180806163114, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'keyboard scrolling', 'add keyboard scrolling via the selectability of the id''s
Via the tabindex="1" code', 'ysg', '2018-08-06 16:30:32', '2018-08-06 16:30:32', 1.00, 0.20, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('acaa69b2-5ca9-48b5-b547-0d7dd3b49ad9', 180710102901, 1, 1, 'feature', 8, 'feature', '09-done', 6, 'single click CREATE', 'add the CREATE for the CRUD table via a single click in etable
via a single click in the e-table:
- ok for add the button ui 
- ok for click inserts into db
- ok for fetch new item data', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8fb316e3-521f-42b1-88d1-ea7b1ec50e45', 180824130956, NULL, NULL, 'task', 9, 'specs', '09-done', 9, 'users, roles specs', 'Create the requirement specifications for the users and roles
Add the user-stories ...', 'ysg', '2018-09-01 00:00:00', '2018-08-24 13:09:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bf2206c2-0b12-415f-90a0-d008b0d6913a', 180806102543, NULL, NULL, 'task', 9, 'feature', '02-todo', 5, 'add vue calendar on the dates ', 'Basically a good calendar control should be pretty easy to be integrated ... , but it would require "infra" for fetching the meta-data as well ...', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b088632b-1da1-4394-8a5f-e33d34fbc2e4', 1806011703, 1, 5, 'feature', 5, 'feature', '09-done', 9, 'add the "like" operator in the "where" url parameter', 'The like operator would select rows as follows:
- where=<<column>>-<<operator>>-<<value>> , ', 'ysg', '2018-06-05 13:00:00', '2018-06-05 14:00:00', 0.10, 1.50, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('269818c1-3696-4e96-adbe-46d5e868be78', 180919120334, NULL, NULL, 'task', 9, 'bug-feature', '09-done', 9, 'too long pager', 'When there are more than 10 pages ( for example on yearly_issues ) the pager becomes too long and the page clumsy looking. The pager should have some kind', 'ysg', '2018-09-19 12:03:29', '2018-09-19 12:03:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('572afba4-91cc-4b46-aacd-3c6a3cbc8cf0', 180903144343, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the :for <<item-name>> operator', 'The :for <<item-name>> operator would make the usage of the app, much more easy + it would lay the foundations for the omnibox ... 
add the item: operator which will run the same query which is currently but on the selected from the autocomplete item', 'ysg', '2018-09-03 14:43:43', '2018-09-03 14:43:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f6ff9b86-6626-4dea-bcbf-10e18d7240d5', 181011111445, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'Add a defualt size of the html table rows', 'Gained "for free" when changing the content editable to textarea ... 
', 'ysg', '2018-10-11 11:14:45', '2018-10-11 11:14:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f9fd2f96-a5ec-4b01-98ba-b3cb6366d7c6', 181019122040, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add instance info in the proj labels', 'Add the following instance info:

 - project-name : our-project
 - environment-type: dev
 - version: 0.5.2
 - commit hash: 457a57a
 - page-update-time: 2018-10-18 16:57:35

', 'ysg', '2018-10-19 12:08:05', '2018-10-19 12:08:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34074021-70ff-4de6-a711-fb24b3228d42', 180829210354, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'update features & functionalities doc', 'update features & functionalities doc', 'ysg', '2018-08-29 21:03:54', '2018-08-29 21:03:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ec302541-9a9e-45f1-a304-33ae7eff9a5e', 180823112117, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the run-integration-tests should not start', 'the run-integration-tests should not start if the project shell vars are not pre-defined', 'ysg', '2018-08-23 11:21:15', '2018-08-23 11:21:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b75ff3e1-7b19-442e-95fc-6e91ce189cc3', 1805102000, 1, 10, 'bug', 1, ' bugs', '09-done', 9, 'fix bug with non-publishing to google sheets ', 'Due to the non-complience of the googleSheets controller with the Input-Output-Controller-Model architecture', 'ysg', '2018-05-10 20:53:00', '2018-05-30 09:54:00', 0.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0dce513b-4d73-4f91-9623-311220b085c2', 180809105507, NULL, NULL, 'task', 9, 'devops', '09-done', 9, 'figure out how-to backup the whole database', 'By using the following oneliner: 

mkdir -p $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/ ; pg_dump -d $postgres_db_name 
-U ysg > $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.dmp.sql;
ls -1 $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/*|sort -nr', 'ysg', '2018-08-09 10:41:49', '2018-08-09 10:41:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd8c0c50-fde5-401a-ae94-5338794e7146', 180808113027, NULL, NULL, 'task', 5, 'feature-ui', '09-done', 9, 'add key press listener to focus on the quick search input', 'add key press listener to focus on the quick search input Pressing / should activate the quick search input Should the quick search BE THE OMNIBOX ?!! On document.load

Added in the mounted method ... might be a future root cause of bugs ..', 'ysg', '2018-08-08 11:30:08', '2018-08-08 11:30:08', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cabcdd3b-2303-45ad-8399-5655e89ec6e0', 1806061109, 1, 6, 'feature', 1, 'feature', '09-done', 9, 'refactor list web action to support multiple output types', 'From now on the syntax for list?as=<<output-type>> would support multiple page builders for multiple output types.
The same approach could be provided to the following future web actions:
 - view , 
 - edit , 
 - create
 - search', 'ysg', '2018-06-06 09:30:00', '2018-06-06 11:30:00', 2.00, 8.00, 'feature ', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('54a40a00-1db5-4771-9500-de5ae80b9855', 181024094422, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the add new button does not removed the sorting attr', 'The click on the addNew button must: 
 - remove any orderting both in the url and in the grid control
 - remove any filtering ( operators :with :like-by :like-val )
 - set the order by id to bring the new item on the top

Error in the following code: 
                  var deletables = ["page-num", "page-size", "od", "oa", "with", "like-by", "like-val"];
                  for(var kv of url_params.entries()) {
                     if ( deletables.indexOf(kv[0]) != -1 ) {
                        url_params.delete(String(kv[0])) ;
                     }
                  }', 'ysg', '2018-10-24 09:44:22', '2018-10-24 09:44:22', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7390294e-fbe3-4a01-9aea-67acaf25e98f', 180815103724, NULL, NULL, 'task', 9, 'feature-ui', '04-diss-to-yearly', 6, 'table position fix on paging', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'ysg', '2018-08-15 10:25:36', '2018-08-15 10:25:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ce7ef59-d47b-43aa-a162-15b28a02c711', 180925102821, NULL, NULL, 'task', 9, 'docs', '09-done', 8, 'functional requirements update', 'The :for operator has to be updated', 'ysg', '2018-09-25 10:28:21', '2018-09-25 10:28:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13b33dd8-ad91-4183-82c6-598f71355535', 180807172028, NULL, NULL, 'task', 9, 'release', '09-done', 9, 'release v0.4.7', 'The version 0.4.7 will introduce the CRUDs feature ( with a small s , because basically the s would stand for search via the url parameters syntax and not via a real search UI)', 'ysg', '2018-08-07 17:20:28', '2018-08-07 17:20:28', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cdaf325f-3ebb-4e4f-ab7c-69f5eee68a45', 180911203222, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'add the onEscPressed event handler for the db dropdown', 'add the onEscPressed event handler', 'ysg', '2018-09-11 20:32:20', '2018-09-11 20:32:20', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('eebfee94-25d1-4ab7-93cd-83037c69f8d9', 181022214822, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix "cannot find issue_tracker in bin"', 'Caused 5 min downtime in prod !!!
Lessons learned - do ALWAYS test all the actions to be performed in all the instances ... ', 'ysg', '2018-10-22 21:45:49', '2018-10-22 21:45:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b61c735f-8990-4c48-9aa2-b92f7b249069', 180806110235, 1, NULL, 'task', 2, 'feature', '09-done', 5, 'change the accuracy of the date-time in the start_time, stop_time to seconds', 'change the accuracy of the date-time in the start_time, stop_time to seconds and not tics as it is simply annoying to change them by hand and the tics are not human readable ...', 'ysg', '2018-08-06 10:50:12', '2018-08-06 10:50:12.603165', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('daa406e5-55ba-432b-971e-ba4ff1f4ba81', 1806011258, 1, 5, 'bug', 5, 'bug', '09-done', 9, 'fix bug with column orders', 'The column order is shuffling depending on whether or not one choses the pick or leaves the pick url param ...', 'ysg', '2018-06-10 23:56:00', '2018-06-20 00:00:00', 1.00, 0.30, ' bug', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('780168d7-405e-4883-b6e0-7b355e162752', 180919115859, NULL, NULL, 'task', 9, 'bug', '09-done', 7, 'the back-end select action does not return properly on wrong sql syntax error', 'When the query generated has wrong sql syntax : 
for example: 
l 
that is both the oa and od url params are available ... 
"unknown error" is shown ... while a more descriptive error with the sql syntax should be shown ...', 'ysg', '2018-09-19 11:58:55', '2018-09-19 11:58:55', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7da90c90-7b9e-42c6-9915-4959f359c195', 181001102952, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix pager broken for 2 pages', 'If there are 2 pages the pager is broken

The SELECT does not report the number of pages correctly : 
Check : 
http://192.168.56.120:3001/dev_issue_tracker/select/weekly_issues?as=grid&pick=id,category,prio,status,name,weight,description&od=id&page-size=15&page-num=1', 'ysg', '2018-10-01 10:11:57', '2018-10-01 10:11:57', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3f08201-d5fa-468f-9420-802df0bd1138', 180818102636, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'update fail does not present the message from the database', 'Scenario: 
 - save too big string ( over 200 ) into the name
 
Expected outcome: 
 - the error from the db: 
"ERROR: value too long for type character varying(200)" should be presented 

Actual outcome:
only error 400 is shown ...', 'ysg', '2018-08-18 10:24:26', '2018-08-18 10:24:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4fb9343f-8385-49a7-b92e-1f346359b7a3', 181005095415, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'copy the cnf files to the loal conf_repo_dir', 'As too much time is used in adjusting those remotes AND for backup and better configuration management', 'ysg', '2018-10-05 09:50:01', '2018-10-05 09:50:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f75c030d-620d-44d1-a426-f038e51c85cf', 1805242250, 1, 6, 'feature', 6, 'feature', '09-done', 9, 'create a tag cloud page', 'Should increaese the ability to comprehend the issues. 
http://mistic100.github.io/jQCloud/demo.html
 - refactor to factory design pattern ...', 'ysg', '2018-06-01 00:00:00', '2018-12-30 00:00:00', 10.00, 8.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('617f7bb7-d380-4c48-aa86-eddf6c00dd8c', 180802130001, 2, 3, 'task', 7, 'feature', '09-done', 9, 'add the create back-end web action', 'Create the create.pm action and integrate within the existing integration tests', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1d1b656f-460a-4918-9b84-a3b4aee308e7', 181024165734, NULL, NULL, 'task', 9, 'bug', '04-diss', 9, 'change the default location of the .passwd file', 'Create additional dir setting for this one . 
', 'ysg', '2018-10-24 16:57:34', '2018-10-24 16:57:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32133ace-4648-4ad3-a3de-d4b5a5ce9d0d', 180829211042, NULL, NULL, 'task', 9, 'docs', '02-todo', 6, 'separate the Features and Functionalities doc', 'separate the Features and Functionalities doc so that the end-user and ui features should be in one doc and the more technical stuff into another doc
2018-09-20 13:24:20 ::: status change -> 01-eval', 'ysg', '2018-08-29 21:10:42', '2018-08-29 21:10:42', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cac2baa8-db67-4d05-a9e7-9f80c734dd74', 180911151818, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix the quick search', 'the quick search was separated', 'ysg', '2018-09-11 15:18:18', '2018-09-11 15:18:18', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6bde43f8-f794-4b4b-8e50-ffbb1f72057c', 180824074822, NULL, NULL, 'task', 9, 'setup', '04-diss', 9, 'create deploy-proj-db func', 'Could be done via a simple oneliner ... for now not needed ...
Add only db restore , increase date from deployed version', 'ysg', '2018-08-24 07:48:13', '2018-08-24 07:48:13', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('95ab5eb7-d9aa-498a-aae1-74db1eba3bc8', 1804020100, 1, 10, 'feature', 1, 'feature', '09-done', 9, 'add the web select controller', 'add the web select controller “
 - implementation code
 - tests 
 - documentation additions for :
-- requirements
-- userstories
-- tests 
-- features and functionalities', 'ysg', '2018-04-02 18:00:00', '2018-05-30 22:00:00', 3.00, 7.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d0c526a8-75e8-45ad-8824-875cb3405975', 181005085509, NULL, NULL, 'task', 9, 'major-release', '02-todo', 6, 'release v0.7.0', 'Major release containing:
 - secure native authentication via JWT
 - 95% scenario to tests coverage ( including ui )    
 - 35 min deployment with 7 min downtime per instance
 - SSO via JWT via OpenId ( at least Google )
 - generic forms
 - generic drop down control in list ui ', 'ysg', '2019-03-01 22:00:00', '2019-03-01 22:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fa4c2c9a-9504-4430-9285-36d6483cadf4', 181027090033, NULL, NULL, 'task', 9, 'bug', '01-eval', 3, 'morph-dir does not replace multiple occurencies of string to replace', 'morph-dir does not replace multipe occurences of string to replace', 'ysg', '2018-10-27 09:00:33', '2018-10-27 09:00:33', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b13a4e70-f5da-4280-bdc4-1f5f6e138faf', 1707200100, 1, 10, 'task', 6, 'feature', '02-todo', 5, 'implement the copy by id via the back-end api from one table to another', 'implement the copy by id via the back-end api from one table to another', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', 20.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e872158d-3a1f-4a73-9a7e-033813a772f1', 180806173205, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'the sorting does not work after updating and item', 'It works only after refreshing the page

The inline cell update does not probably implement the vue model and life cycle AND 
the way the components work ... the solution was to add a watch to the content editable ... 

Related to the it-180806172736 issue:
http://host-name:3000/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,name,description,planned_hours,actual_hours&page-size=100&page-num=1&with=id-eq-180806172736', 'ysg', '2018-08-06 17:27:08', '2018-08-06 17:27:08', 3.33, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4a93c85-dea7-4f87-b91d-bef897f814b6', 181002111017, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'content editable and update cannot handle html entities', 'Solution: replaced with textarea ... 

The html table cannot handle content with html entities: example greater than and smaller than are presented directly
<<pituus>>', 'ysg', '2018-10-02 10:52:33', '2018-10-02 10:52:33', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('67a4cc42-bfed-42b2-bf8d-e2e61c8839f9', 180815145340, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'fix insert fails on prio not null in problems table', 'fix insert fails on prio not null in problems table
Solution:
 - make db backup
 - change table DDL 
 - re-run run-pgsql-scripts shell action
 - restore the db
Resolution time - 8 min', 'ysg', '2018-08-15 14:53:31', '2018-08-15 14:53:31', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c8d1a986-c67f-4055-a161-c01c308cdb13', 180823190305, NULL, NULL, 'task', 9, 'design-setup', '09-done', 9, 'add morbo listenning on different configurable port', 'the intent is to to have the app-instances : 
 - dev 
 - tst 
 - prd 
operating on different ports 

which would be defined by the configuration files', 'ysg', '2018-08-23 18:54:51', '2018-08-23 18:54:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fab8075d-d6c3-4ef7-af0f-81c246e834f2', 180816103139, NULL, NULL, 'task', 9, 'docs-design', '02-todo', 4, 'design the projects dashboard / projects hub concept', 'As a single user must have access to different projects + the authentication should be at the end both on :  - issue-tracker app-layer instance  - issue-tracker project-db instance

', 'ysg', '2018-08-16 10:31:39', '2018-08-16 10:31:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ee3a3190-5963-4bef-b563-adea0797d673', 180824085622, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'paging does not work because of trailing # after delete', 'The root cause was the href="#" in the btn-del template ... 
The browsers seem to add automatically the trailing number # ( because of http protocol/standard ?! )   
chk:
https://stackoverflow.com/a/17682564/65706

or is it that url contains # somewhere in the middle ?!

Due to the .replace(/\/?(\?|#|$)/, ''

  .replace(/\/?(\?|#|$)/, ''/$1'')', 'ysg', '2018-08-24 08:41:03', '2018-08-24 08:41:03', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('591dbdee-0c89-41a2-b73b-134abbf9f51e', 181012104823, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'on update fail no old value', 'When the update fails the old value is not returned, but rather and empty cell is set, which is MISLEADING ...

', 'ysg', '2018-10-12 10:48:06', '2018-10-12 10:48:06', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('958cbf01-6115-49f7-b535-e79d395e2cd6', 181009151205, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'default db backup', 'add the backing up of the current instance database in the backup-postgres-db shell action if the shell vars were not pre-loaded that is by default ...', 'ysg', '2018-10-09 15:12:06', '2018-10-09 15:12:06', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2576cfcb-ec09-4907-9344-344e9ea553bd', 1805160700, 2, 10, 'task', 5, 'feature', '01-eval', 7, 'add the feature for the validation of the spent time', 'design the validation of the available time and the spent time = registered time', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 15.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cf355eff-1d87-4477-a506-dd1a40309891', 181019175335, NULL, NULL, 'task', 9, 'feature', '01-eval', 9, 'remove vuetify to improve performance', 'As for now only the addNew and the butDelete actually do use it ... 
Try to remove the vuetify.css to improve performance

', 'ysg', '2018-10-19 17:41:11', '2018-10-19 17:41:11', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ffb17f21-d053-41f2-86b7-cfe9e7d7165d', 180921091057, NULL, NULL, 'task', 4, 'feature', '01-eval', 5, 'when the pager is resized', 'When the browser window is resized the pager stays on the right , but it should get bellow the srch box', 'ysg', '2018-09-21 09:10:53', '2018-09-21 09:10:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6ea2aed-4861-4bf9-978e-0869f2ecd16a', 180817173444, NULL, NULL, 'task', 9, 'bug-ui', '09-done', 9, 'visual indication for currently sorted column', 'lost visual indication for current sorting column lost on paging.

after changing the page the visual indication for the currently sorted column is lost !!!

This might solve the problem for the createNewItem as well ... as the createNewItem would be a simple re-direct', 'ysg', '2018-08-17 17:17:35', '2018-08-17 17:17:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4c720b74-7819-4128-8fa6-e63425f230cc', 1807170132, 1, 10, 'bug', 1, 'bugs', '09-done', 9, 'remove the unneeded run-logging', 'There is run-logging which is not used anymore - to remove', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bdef4418-a477-4dcc-90eb-1392f8d2d61b', 181027085203, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fail to select all in textareas by Ctrl + A', 'Chrome update for mac changed somehow the default shortcut which was Ctrl + A , but now is Cmd + A ... => 
This is NOT  a bug in the application ...
Bug in Chrome ?! Or somekind of failed htm syntax ?', 'ysg', '2018-10-27 08:52:03', '2018-10-27 08:52:03', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6b43660d-7378-4ea3-a1a1-3413866c6458', 181005092909, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'start v0.5.0', 'Create new v0.5.0 local instances as follows: 
 - run the to-ver action
 - check the configuration files for the new ver 
 - change the tmux session file
 - merge master into dev, add 0.5.0 tag', 'ysg', '2018-10-05 09:25:00', '2018-10-05 09:25:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('47110ae8-3166-4e52-9caa-153f4d92ac0a', 180925152741, NULL, NULL, 'task', 9, 'feature', '01-eval', 6, 'universal item search', 'Scenario: 
the user types any text without operators in the search box 
The System
- redirects to an url with removed search url params
- uses a new txt-srch='' the actual query'' 
-  builds a dynamic search with all the text attributes of the CURRENT item 
- lists the table', 'ysg', '2018-09-25 15:26:59', '2018-09-25 15:26:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b4d7587a-5f5a-4633-a30f-0c2fada05ace', 1804300100, 1, 10, 'specs', 1, 'specs', '09-done', 9, 'define REST API response structure', 'Should support messages and return codes as well as data transfer. 
Defined : 
 - ret - containing the http status code
 - msg - the msg to be passed to the client
 - dat - the data to be passed to the client', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 1.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55fa01b2-8343-4ffe-95ec-b3e3b17573be', 181009150405, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix mix_data_dir bug', 'backup-postgres-db.func.sh: line 11: mix_data_dir: unbound variable', 'ysg', '2018-10-09 15:04:05', '2018-10-09 15:04:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5c2a3a37-cb14-42de-be84-b1d38c739d54', 181103181908, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'change the pager to play-rewind one', 'The pager should look as follows: 
 - next / "play" button for the next page
 - next 10 / rewind button for the next page + 10 or last
 - previous / back button for the previous page
 - previous 10 / first for the first page', 'ysg', '2018-11-03 18:19:08', '2018-11-03 18:19:08', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8145bc77-49cf-43f9-b546-d1982c19c398', 1805172131, 1, 10, 'goal', 9, 'feature', '03-act', 6, 'implement data load testing', 'Should be single liner:
- very simple
- should have reliable start _time and stop_times
- should be able to verify the executions times per request , request phases to keep track on performance while increasing complexity
- and optionally all this by single user', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('25c65301-2c7e-486e-b8b2-47700bf3fc5f', 180807171630, 1, NULL, 'task', 9, 'bug', '09-done', 9, 'the update fails if the column is nullable', 'Changed behaviour to try to update to NULL aka update table set col = nul where id = <<id>>', 'ysg', '2018-08-07 17:16:30', '2018-08-07 17:16:30', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('87fbf6d7-2ec7-4767-bcdd-eeefc433eb05', 180815133836, 1, NULL, 'task', 9, 'feature', '01-eval', 6, 'improve load testing for the select web action ', 'add load testing for the select web action

Perform asyncrously requests to examine the amount of asyncrounous calls the application "breaks"', 'ysg', '2018-08-15 13:38:36', '2018-08-15 13:38:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9787f4e0-dcbd-4678-8152-1716a42b173e', 181004144853, NULL, NULL, 'task', 9, 'deploy', '09-done', 9, 'deploy v0.4.9', 'deploy 0.4.9 although there are still open bugs ... as there have been 4 weeks without a deployment', 'ysg', '2018-10-04 14:48:54', '2018-10-04 14:48:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('49efe9c1-8757-4850-9d72-4e4e0bf623f5', 1807101029, 2, 5, 'feature', 8, 'feature', '02-todo-to-2019', 8, 'add the DELETE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9b5f133b-71a8-48c7-a4aa-d1536f09e707', 180802130102, 2, 5, 'task', 1, 'feature', '09-done', 9, 'add the delete vue button component poc', 'Add a poc page with a custom vue button component demonstrating the following:
 - ok ability to instantiate multiple independant instances of the button
 - ok - ability to assign different id''s to the buttons
 - todo - ability to present dialog box with ok and cancel after the clicking of the button
 - ok - ability to perform an AJAX call after pressing the button 
 - ok ability to remove the row', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3e97247f-0c0f-499a-a010-d1cf906212a4', 180813215302, 1, NULL, 'task', 2, 'feature-ui', '09-done', 9, 'prevent the on hit keyboard enter posting in quicksearch', 'prevent the on hit keyboard enter posting in quicksearch', 'ysg', '2018-08-13 21:36:12', '2018-08-13 21:36:12', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c0761c85-dc6e-4683-b9b0-a207bad5628d', 180802130101, 1, 4, 'task', 2, 'feature', '09-done', 6, 'add the delete back-end web action', 'delete the delete.pm action and integrate within the existing integration tests', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('11dcb452-53b9-4870-9a55-9c4660a1be2c', 180801152124, 1, NULL, 'task', 9, 'refactoring', '09-done', 6, 'add a check for the generated md docs to have more than 100 lines', 'add a check for the generated md docs to have more than 100 lines', 'ysg', '2018-08-01 14:15:36', '2018-08-01 14:15:36.853822', 1.00, 1.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a90bef98-6b5e-4c4f-99fa-790c4f296e8c', 1805312157, 1, 10, 'bug', 1, ' bugs', '09-done', 9, 'fix bug with non-informance of missing db table on xls-to-db', 'when the xls sheet exists but the table not now the app quites', 'ysg', '2018-05-10 20:53:00', '2018-05-30 09:54:00', 1.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7fafeec5-bf5f-4ec2-98c1-36227baffeb7', 180717013001, 1, NULL, 'bug', 1, 'refactoring', '09-done', 9, 'remove the run-logging', 'There is run-logging which is not used anymore - to remove', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('024a826d-2998-4ae5-bbf3-035bc0aa49d8', 1806281842, 2, 2, 'task', 9, 'feature', '09-done', 9, 'add Update Controller for accepting the edit REST calls', 'The Update Controller return the code of whether of not the update has succeeded:', 'ysg', '2018-07-01 00:00:00', '2018-07-30 00:00:00', 30.00, 1.00, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe3ca692-b9e2-409a-bc77-a246b31ac7d2', 1807162248, 1, 5, 'feature', 4, 'feature', '02-move', 7, 'add the clone with new id html row for table for CREATE', 'chk the following answer:
- wip add the default values for all the non-null columns
- wip create the front-end call by (new Date()).toISOString().replace(/-/g,"").replace(/T/g,"").replace(/:/g,"").slice(2,14)', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8c9551d5-e55c-4073-ae44-ad4fc8d23e79', 180829173937, NULL, NULL, 'task', 9, 'functionality', '09-done', 9, 'add the pre-push script', 'add the pre-push script to git to avoid the tdo:ysg fixme type of strings', 'ysg', '2018-08-29 17:19:53', '2018-08-29 17:19:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8464f9d1-6a9e-42fe-bf2b-edfea1655927', 1805152300, 2, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the hide url param for the list web control', 'add the hide url param for the list web control
 - ok path
 - nok path', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bf1cc98e-6e1c-4615-93cc-643b4a64dd4c', 1805110300, 1, 10, 'activity', 5, 'activities', '09-done', 9, 'aim to use the issue tracker more on the web interface and less on the xls', 'In order to increase the dog food experience and provide base for the creation of issues , userstories , requirements and other specifications', 'ysg', '2018-05-06 07:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd070b3f-ee6a-4ff5-8ad5-9dcf817ec89b', 1805172115, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'poc for client site JavaScript testing', 'Because if you cannot get it right from the very beginning than you will get it never ever right. 
implement a poc for data-load testing with single table load to postgres with start and stop times recording
Add as a non-blocking post update for start_time and stop_time.
Had to increase the whole OS and redo the setup install for the perl modules and the postgres because of this one ... ', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 4.00, 0.50, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a094afaf-b422-47b6-85d6-19b18606cf9a', 1805111100, 1, 10, 'activity', 8, 'feature', '01-eval', 7, 'add the edit web action from the list as labels page', 'Create the update.pm action and integrate within the existing integration tests', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('603bfa1a-2ddd-4ba2-b299-4488510d9545', 180903114019, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'autocomplete databases with the ":in" operator', 'Usage scenario: 
- the users selects the search-box
- the user types the ":in " anywhere in the search-box
- the System presents the drop down filled with the databases
- whenever the user types the list is filtered by the string typed
- on hitting enter the user is redirected to the chosen database', 'ysg', '2018-09-03 11:27:48', '2018-09-03 11:27:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9eebb184-acc9-4555-bb25-2eada3d66f12', 180817194210, NULL, NULL, 'task', 9, 'functionality', '04-diss', 9, 'daily issues trigger / stored procedure', 'creates daily trigger / stored procedure to move the daily 09-done and 04-diss status pocessing issues to the weekly_issues table', 'ysg', '2018-08-17 19:33:32', '2018-08-17 19:33:32', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13cd0a4c-2ce6-4683-8c40-e54615116494', 1807170130, 1, 10, 'bug', 1, 'bug-refactoring', '09-done', 9, 'separate the error msg', 'There is run-logging which is not used anymore - to remove', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('abe45bd8-37ca-4701-92ab-99b981aad0f0', 180920130847, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'adjust the flow of the tab with tabindex', 'Set proper integer values for the tabindex to speed-up the keyboard navigatation on the page.', 'ysg', '2018-09-20 13:08:47', '2018-09-20 13:08:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b9ccfc89-a16a-426f-b325-d92ad47cb04e', 1805130100, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the hide, which should pick the columns'' values but not display them in the result set', 'add the hide, which should pick the columns'' values but not display them in the result set', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 4.00, 7.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7f970e73-2f4a-430c-b9f2-5ce486b97020', 180823155703, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'v0.4.8 - CRUDs to the cloud & documented', 'The version 0.4.8 should :
 - docs up-to-date
 - apply small bug fixes if found
 - change the features and functionalities to point to the deployed v0.4.8 instance', 'ysg', '2018-08-23 15:48:43', '2018-08-23 15:48:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('006dcf0b-d15b-4532-b867-4146e686c995', 180802130002, 2, 2, 'task', 7, 'feature', '09-done', 9, 'add the create vue button component poc', 'Add a poc page with a custom vue button component demonstrating the following:
- ok hardcode the id of the button , make it part of the table
- ok onclick event prints the id into the console
- ok ability to perform an AJAX call after pressing the button from the parent el
- ok - ability to generate the id in the yymmddHHMMSS format
- ok - ability to pass the id to the back-end ajax call as the 
- ok - grasp the child to parent event and data flow : 
https://stackoverflow.com/a/40915910/65706', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 1.00, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('792c2e4a-bc46-49d8-a722-4260d804c283', 180903143847, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor list-etable subcontrols', 'refactor list-etable subcontrols into their own files ... And it took only 30 min ...', 'ysg', '2018-09-03 14:38:47', '2018-09-03 14:38:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('04b98015-e566-48f9-84e7-d5abf8af3950', 180914104512, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'non-existent attribute in url for list-as-grid', 'Solution: refactor properly the 
Lessons learned: the data fetching func might return either the data or a string, which is the error - that is the caller could define what to show to the ui based on the typeof the return var ... which of course will not work if one fetches only a single string from the backend , which is however a pretty rare case .. so this approach should be re-used ... 
on un-existent attribute listing the error for the attribute does not exist is not shown at all', 'ysg', '2018-09-14 10:30:17', '2018-09-14 10:30:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e13014c-c786-4908-a556-84d7dcc05453', 180824090913, NULL, NULL, 'task', 9, 'functionality', '03-act', 9, 'implement authentication till v0.6.0', 'Only authenticated persons should be authorized to access resources in an instance

2018-09-20 13:24:20 - status update -> 01-eval', 'ysg', '2018-09-01 00:00:00', '2018-08-24 08:53:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('25f94c2d-1ec6-4c4a-8de5-7889b2365c43', 180928142720, NULL, NULL, 'task', 9, 'bug', '09-done', 7, 'the principles table did not comply with the item api', 'It basically did not have default value in the DDL for the nullable attributes', 'ysg', '2018-09-28 14:27:20', '2018-09-28 14:27:20', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be016af9-919b-46cb-b1e7-51ef63e7b1b4', 1805120100, 1, 10, 'feature-implementation', 1, 'specs', '09-done', 9, 'change the id''s naming convention to be to hour proximity and not day only ', 'As the day seems to be too less ... As the id''s must be copieable from one table to another and quickly collisions might be created. ', 'ysg', '2018-05-10 20:53:00', '2018-05-30 20:53:00', 2.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('52ac4b70-edf5-400e-8d8d-8c6f394e6867', 180807182904, 1, NULL, 'task', 9, 'feature-ui', '09-done', 6, 'add esc key listener to the content editable', 'pressing esc when the content editable is in focus should preserve the old value and remove the focus', 'ysg', '2018-08-07 18:29:04', '2018-08-07 18:29:04', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dfae179c-06f1-4573-89bd-bf275f22ce8b', 181009195756, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the requirements and userstories tables ddls', 'add the requirements and userstories tables ddls
and ensure the paths are the sam', 'ysg', '2018-10-09 19:57:50', '2018-10-09 19:57:50', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('557c34d8-e2f0-4b8a-958d-ca972eaa24be', 180920103551, NULL, NULL, 'task', 1, 'feature', '02-todo', 4, 'add actions on selected items', 'add the capability to perform actions on selected items. The user performs a search , selects all the checkboxes in the left of the list ( gmail like ) , types <> for example: :do move selected to <> would move the selected items to the table <<test>>', 'ysg', '2018-09-20 10:20:53', '2018-09-20 10:20:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a1667fb2-8d62-4f15-a084-056775f46a68', 181024174217, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add benchmarking monkey script', 'The benchmarking tests should do the following : 
 - run against an already running instance
 - record the current version , commit -hash and start_time to the test_runs table - wip
 - run mojo user agent against the yearly_issues tables with page-size = 7
 - click on the pages 1-10 - ok 
 - record the stop_time to the test_runs table - ok 

', 'ysg', '2018-10-24 17:42:17', '2018-10-24 17:42:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f3951bd2-0bb8-49bc-b680-b99ee8a670c2', 1805111200, 1, 10, 'activity', 6, 'feature', '02-todo', 4, 'add the select-update form page', 'To test the update action and to start avoiding using the xls', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd557f0d-bf6c-4cf1-8c59-f33fe273f25d', 180817194442, NULL, NULL, 'task', 9, 'feature-backend', '01-eval', 6, 'backend post call to move the issues with specific attribute name and like value to another table', 'create a backend post call to move the issues with specific attribute name and like value to another table something like: 

<<db>>/upsert/<<src_table>>/with=<<attr-name>><<operator>><<attribute-value>>&to=<<tgt-table>>', 'ysg', '2018-08-17 19:36:05', '2018-08-17 19:36:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4a303285-271e-46d3-883d-b9325866338a', 180911202830, NULL, NULL, 'task', 9, 'refactoring', '09-done', 9, 'remove the list-etable code', 'as it has been updated by the list-grid control , which has the same features + the change to different db', 'ysg', '2018-09-11 20:28:28', '2018-09-11 20:28:28', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('efe6fb81-aec8-4cbd-a1e6-16b18c75e623', 180801151524, 1, NULL, 'task', 9, 'refactoring', '09-done', 9, 'Refactor the edit web action to reflect the vue page life cycle', 'As shown in the following diagram:info-src:     https://vuejs.org/v2/guide/instance.html#Lifecycle-Diagram
sttus-change: No relevant anymore ... 
status-change: solved', 'ysg', '2018-08-01 14:15:36', '2018-08-01 14:15:36.853822', 4.00, 10.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d7ec6aeb-ca1f-4f87-b2c2-2970c55d1f5d', 180813222648, NULL, NULL, 'task', 9, 'feature-ui', '04-diss', 9, 'add a dropdown for the grid pager /', 'add the grid page component , which would be vuetify select at the botom

https://vuetifyjs.com/en/components/selects', 'ysg', '2018-08-13 22:09:59', '2018-08-13 22:09:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1cee95ee-8067-4783-9e6f-ecbc043c8d72', 180813093900, 1, NULL, 'task', 9, 'feature-ui', '09-done', 7, 'add a "as=print-table" page', 'As an ui user I wanto to be able to quickly print a whole html table OR 
copy paste only the table contents by Ctrl + A , Ctrl + V', 'ysg', '2018-08-13 09:36:43', '2018-08-13 09:36:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('73eda7bc-5600-4a00-bbb3-ae30b0d74ea1', 180813222818, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the page-numberer in the place of the current page-sizer', 'simply because it is confusing. The page-sizer dropdown could be at the bottom of the grid', 'ysg', '2018-08-13 22:11:30', '2018-08-13 22:11:30', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dd52d2ea-f613-4be9-9822-d3fa758ae512', 180827131612, NULL, NULL, 'task', 9, 'bug-feature', '09-done', 9, 'fix bug for cannot insert more than 2 items per seconds', 'The current behaviour is to try 100 times and increase the id ... which should suffice for now ...', 'ysg', '2018-08-27 13:16:10', '2018-08-27 13:16:10', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2220ffb6-88dd-4882-b7e6-c607873e64a3', 181004135232, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'poc for Selenium::Remote::Driver setup', 'Selenium::Remote::Driver setup and call via a simple script', 'ysg', '2018-10-04 13:52:32', '2018-10-04 13:52:32', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c52f0e1b-0dfa-4a3f-8127-2ad13eb1693e', 1806092324, 1, 5, 'task', 5, 'feature', '09-done', 6, 'add server side paging for the list-table ui action', 'Add server side paging with callable page size , and page number, limit:
- todo automated ui testing
- ok for UI testing
- ok add a dummy page sizes list of links setting the size to the num displaed , BUT going always to the first page 
- create test table
- ok default page size - 15
- ok for default page num - 1', 'ysg', '2018-06-08 21:30:00', '2018-10-30 00:00:00', 20.00, 10.00, 'architecture', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1821a48c-f4b0-482b-930d-92c2413faf2d', 181019181533, NULL, NULL, 'task', 9, 'feature', '02-todo', 5, 'dynamically resize the textaread on growing input content', 'Scenario:
- each time the user hits enter 
- the cols wil increase with 2 ... 
 - after leaving the default size will be restored ', 'ysg', '2018-10-19 18:03:09', '2018-10-19 18:03:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c2a20c3d-142b-49e4-8a35-8d58a7fab235', 181017181925, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'replace the content editable with textarea', 'This feature improves dramatically the usability of the grid: 
 - the columns and rows are re-sizable 
 - the columns and rows get a default size
 - the default size is adjustable programatically', 'ysg', '2018-10-17 18:19:25', '2018-10-17 18:19:25', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('480930f1-e28b-408b-b2bf-3754b3000792', 180926224041, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'on unexistent columns hide , met should be 0°', 'In the following url the met should be 0 , but is null: 

http://192.168.56.120:3001/dev_issue_tracker/select/monthly_issues?pick=name,description,prio&hide=guid,prio,non_existent_column', 'ysg', '2018-09-26 22:40:37', '2018-09-26 22:40:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bc8a01c7-eaf1-43bf-949f-701801ae54c3', 180817114023, NULL, NULL, 'task', 9, 'functionality', '09-done', 9, 'add the check for the gmail-package for non-set Emails', 'add the check for the gmail-package for non-set Emails
If the Emails are not set exists with clean msg', 'ysg', '2018-08-17 11:40:24', '2018-08-17 11:40:24', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('492139df-ee9d-4815-8ba0-df9b2b9ed206', 1807101027, 2, 2, 'feature', 9, 'feature', '09-done', 9, 'add UPDATE for the CRUD table inline', '- ok - for fragile ok case 
 - ok - for the preserving of the new lines
 - ok - for the ok test
 - ok - for preventing the id, and guid from editing
- ok - handle error on non-db
- ok - handle error on non-table
- ok - handle error on non-column
- diss - handle error on non-id
- ok - handle any other error
- diss - try multiple columns', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d703d532-267d-429f-9075-a6a8be824a9d', 180926113604, NULL, NULL, 'task', 9, 'docs', '01-eval', 7, 'add the ReleaseNotes document', 'The ReleaseNotes should contain all the releases with the following info per release:
 - release intro 
 - performance and stability (refactoring)
 - api changes - changes of behaviours
 - known issues', 'ysg', '2018-09-26 11:26:44', '2018-09-26 11:26:44', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('403c1135-5279-47b7-8f37-3783bacd1142', 180920075214, NULL, NULL, 'task', 9, 'feature-bug', '09-done', 5, 'fix the pager''s pager', 'Should be human and not machine readable : 
 The cases are : 
 - from 0 to 10 >> 
 - from -10 to last << 
 - all others ...', 'ysg', '2018-09-20 07:52:02', '2018-09-20 07:52:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('803e2652-5908-4209-99b7-ab72a02b4f9c', 1807142230, 1, 5, 'feature', 2, 'testing', '09-done', 9, 'add a proper ui effect and (dis)appearance of the error msg', 'As it looks quite clumsy right now …', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 1.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13719d73-1216-4896-9a13-a0e3aa3944e6', 180829090358, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'docs english grammar errors check', 'Because there are probably still some grammar errors, which ARE embarrassing', 'ysg', '2018-08-29 09:01:23', '2018-08-29 09:01:23', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2bfa5d36-40e8-4e7f-8be6-0fc8a0ff2772', 180914111431, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'stuck morbo server', 'Whenever the morbo server is stuck, one has to kill manually the instances of the perl as the socket is occuped ...
To be resolved as soon as it occurs', 'ysg', '2018-09-14 10:59:37', '2018-09-14 10:59:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b293825f-8152-49e8-9ef2-bbf084ee3bd4', 180920104140, NULL, NULL, 'task', 9, 'feature', '02-todo', 9, 'add the json backup to the increase-date action', 'The "increase-date" action should create a json backup as well ... 
Because it will provide a double daily backup of the data', 'ysg', '2018-09-20 10:26:43', '2018-09-20 10:26:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cabd54d8-d56c-458c-9ce9-821561ce716a', 180717013101, 1, NULL, 'bug', 9, 'bug', '09-done', 9, 'fix the bug "for updating the cell content in table inline edit on error, while it shouldn''t"', 'related to the it-180801151524

... this is more of a generic question - how-to keep in sync the client-side and server side data structures - perhabs must update the client side array too ?!After the user updates the cell conent the post fires, the error msg is displayed but the content stays changed while it is not changed in the db … which is misleading … 
The behaviour should be changed so that the content will preserve its original state ...', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd9688b9-f859-4c67-b6ba-a98d003f932e', 180920102836, NULL, NULL, 'task', 7, 'feature', '04-diss', 9, 'show 1 page if page x did not contain data', 'Add the "page <<GreatPage>>" did not return any data showing page 1 feature by displaying the warning at the bottom of the page', 'ysg', '2018-09-20 10:13:39', '2018-09-20 10:13:39', NULL, NULL, NULL, '2018-12-25 21:06:19');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3fed31d4-63b5-4cee-8194-84d955e88870', 181022170059, NULL, NULL, 'task', 9, 'code', '04-diss', 9, 'convert the basic auth to be global for each request via app hook', 'Did not find any proper hook ... 
Not needed for now ( till v0.6.0 ?! ) as 
For the basic auth probably not needed', 'ysg', '2018-10-22 17:00:59', '2018-10-22 17:00:59', NULL, NULL, NULL, '2018-12-25 21:11:25');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('881e685c-5a2b-40d9-b566-6bb451b9f6f3', 181005095108, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the configuration repo dir', 'Add the notion for configuration repository directory: 
- add the reload-conf shell action, which will reload the current instance configuration shell variables by name and version from the conf_repo_dir', 'ysg', '2018-10-05 09:46:54', '2018-10-05 09:46:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a83bebb-7e57-4955-a744-df64f8fec4f0', 1805301624, 1, 4, 'bug', 4, 'issue-tracker', '04-diss', 9, 'issue_tracker.pl.log appearance in product instance dir', 'Occurs when one runs the "run-integration-tests" action', 'ysg', '2018-05-29 20:53:00', '2018-06-30 00:00:00', 0.00, 0.10, 'bugs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3f2a34f3-bc1b-4b15-99a1-d71995b958f5', 180926181042, NULL, NULL, 'task', 9, 'bug-feature', '09-done', 9, 'pick un-existent col name results in wrong error', 'Re-factor setErrorMsg function
The wrong error msg appears after picking un-existent attribute:

Expected : 
The column <<xyz>> does not exist !!
Actual: 
unknown error occurred !!!', 'ysg', '2018-09-26 18:02:27', '2018-09-26 18:02:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8378d9b3-df85-407b-a436-f5b0af2be856', 180816091936, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'single shell call daily backup', 'Add a single shell-call for : 

- creating a zip daily backup of an issue-tracker project
- add the db dump to the daily data dir
- package both the current issue-tracker dir and the proj dir', 'ysg', '2018-08-16 09:04:59', '2018-08-16 09:04:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0f6686f3-1608-4e09-a546-710201280231', 1807101032, 3, 3, 'feature', 5, 'feature', '04-diss', 9, 'place the cursor at the end of the txt in content editable during update', 'chk:
https://stackoverflow.com/a/19588665/65706

replaced with select all on tab with the keboard ... 


as the click is usually "I wanto to click in a specific part of the text"', 'ysg', '2018-07-20 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c5fc532a-4c4a-4dcc-aa8a-1f2d8c4f8d5a', 1806231403, 3, 5, 'feature', 1, 'feature', '09-done', 9, 'add a visual indication for the active page SIZE in the list tables view', 'Well, good enough for now ... Later one ... probably would need more stylingAs currently it is not exactly clear which page is the current one … The less experience is the user the more urgent this feature is …', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c021ba38-1796-4570-9b10-a8eb87e8aa78', 180822210340, NULL, NULL, 'task', 4, 'feature-ui', '02-todo', 6, 'add undelete function', 'As an UI user I would like to revoke a deleted item', 'ysg', '2018-11-01 00:00:00', '2018-08-22 21:03:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c5d61163-ddba-448a-93a8-dbe18392ff50', 180823113509, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'db-to-json file creation bug in run-integration-tests', 'not ok 3 - test-03:
# for the create of json file: /opt/csitea/issue-tracker/issue-tracker.0.4.7.prd.ysg/dat/json/daily_issues.json
# Failed test ''test-03:
# for the create of json file: /opt/csitea/issue-tracker/issue-tracker.0.4.7.prd.ysg/dat/json/daily_issues.json ''
# at src/perl/issue_tracker/t/TestIssueTracker.pl line 66.', 'ysg', '2018-08-23 11:35:07', '2018-08-23 11:35:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8356cac1-3223-431a-b001-507c753ae738', 180920105012, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'adjustable default column length ...', 'Add the capability of setting default column length in the metadata, as well as presenting <<too-long-content-with-dots-at-the-end>> ... and the capability to display on hover the whole content of the cell', 'ysg', '2018-09-20 10:35:07', '2018-09-20 10:35:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2b0455c4-ffd5-4283-99c4-c022ba103d8d', 180806163116, NULL, NULL, 'task', 9, 'feature-bug', '09-done', 9, 'add proper error handling on insert of duplicate id''s', 'Test by quick double-clicking the addNew button. A proper message should appear prompting to try again', 'ysg', '2018-08-06 16:30:34', '2018-08-06 16:30:34', 0.10, 4.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cac69e18-0777-4adf-a7fd-c485fa364d21', 180921085537, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add asyncrounous load of the select columns', 'The use case should be as follows:
 - the user requests the page
 - the System loads the list of dbs and tables on page load
 - WHEN the user types the :pick or :select operator 
 - the system loads the lists of the current item attributes and displays it into the autocomplete', 'ysg', '2018-09-21 08:55:32', '2018-09-21 08:55:32', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ff8b0a3c-fc1e-4f20-8034-089c30708ba1', 181023161301, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'deploy v0.5.2', 'Deploy final v0.5.2 : 

- deploy from master
- preq run for Time::HiRes
- practice the hypnotoad start on dev,tst and prd instances !!!
- collect the cnf files for v0.5.3
- make db backup and xls , export
- send to collaborators', 'ysg', '2018-10-23 16:01:03', '2018-10-23 16:01:03', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cc9ebc4c-6c53-4bb9-9b29-17665af6c421', 1806071734, 1, 5, 'bug', 5, 'setup', '09-done', 5, 'create scalable css dir structure for screen and print ', 'This will enable the definition of printable css styles completely independent from the desktop print styles … 
- for now only print and screen are supported ... 
- probably a new level for mobile / tablets would be needed ... ', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 1.00, 2.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e5de541-69e6-4ab4-8b1b-694b065d8ccf', 180927085858, NULL, NULL, 'task', 7, 'bug', '09-done', 9, 'on fail db update the grid does not update the old value', 'on fail db update the grid does not update the old value', 'ysg', '2018-09-27 08:58:58', '2018-09-27 08:58:58', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12f6689a-fa8e-4024-a693-9d1e5cd5dffc', 180517213501, 1, NULL, 'goal', 2, 'bug', '06-onhold', 6, 'pager should re-drow based on the current sort', 'or should there be simply redirect ... 

The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a253a101-29b2-4ea2-9819-6dfeda4e8b58', 181022165836, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'update v0.5.2 docs', 'update v0.5.2 docs
 - features
 - user-stories', 'ysg', '2018-10-22 16:58:36', '2018-10-22 16:58:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a7f158b-806a-40f6-a307-56df4cdfa842', 180920104520, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'onEnter for :for should pick the upper most item in the drop down list', 'On click enter should select the upper most item of the list in the :for EVEN if the list has not been selected ...', 'ysg', '2018-09-20 10:30:16', '2018-09-20 10:30:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b33291c0-9311-4c64-815c-31dde6ee6779', 180806213141, 1, NULL, 'task', 7, 'feature', '01-eval', 5, 'add Excel like moving with the keys also move and down with the cursor keys', 'add Excel like moving with the keys also move and down with the cursor keys', 'ysg', '2018-08-06 21:31:40', '2018-08-06 21:31:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9202d5ed-ae9f-4fc0-a210-df9a66641f25', 1806281840, 1, 1, 'feature', 8, 'feature', '09-done', 5, 'add CRUD table', 'Add CRUDs table:   
- qas for CREATE 
- qas for UPDATE
- qas for DELETE
- qas for search', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 100.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a2dd6c06-45f9-4415-ae1e-f40c83ba6041', 1804020101, 2, 10, 'feature', 5, 'feature', '09-done', 9, 'add the web list controller', 'add the web list controller “
 - implementation code
 - tests 
 - documentation additions for :
-- requirements
-- userstories
-- tests 
-- features and functionalities', 'ysg', '2018-04-02 18:00:00', '2018-05-02 18:00:00', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ea3aaf3c-ef88-4faf-9727-fac91782f71a', 1805091300, 2, 10, 'feature', 4, 'feature', '02-todo', 6, 'create the view doc ui with vue.js', 'Create a simple list labels view interface which will use the list web action: 
- evaluete both server and client side html generation and compare performance', 'ysg', '2018-05-12 20:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('36a15918-7526-4c3f-9f8a-3682d8456d44', 180817232013, NULL, NULL, 'task', 9, 'bug', '01-eval', 7, 'The pager should re-draw based on the current sort', 'The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown

So the feature is to enable update of the url params when one clicks on the columns sorting - aka clicking on the update_time asc should change the od=update_time to oa=udpate_tim', 'ysg', '2018-08-17 23:20:14', '2018-08-17 23:20:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f74837ce-5163-44b9-9a0f-f7dfb15a1c42', 180809105613, 2, NULL, 'task', 9, 'devops', '09-done', 9, 'figure out how-to dump only the data of a table', 'Use the following one-liner
psql -d $postgres_db_name < psql -d $postgres_db_name < /opt/ysg/dat/mix/sql/pgsql/dbdumps/dev_ysg_issues/dev_ysg_issues.daily_issues.20180809_101926.insrt.dmp.sql

And how-to restore it ...', 'ysg', '2018-08-09 10:42:56', '2018-08-09 10:42:56', 0.00, 0.30, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cfb65b19-88d6-439c-810e-a243bc1b94bc', 1806110059, 1, 5, 'feature', 5, 'feature', '02-todo-2019', 6, 'add the weight-by-<<attribute-name>> for the list cloud page', 'This would enable for example the visualization of the sizes based on actual hours , planned hours ...', 'ysg', '2018-07-04 04:06:05', '2018-07-04 04:06:05', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8de84df4-24a6-4322-8d76-d8b2b4662868', 180806125535, 2, NULL, 'task', 9, 'feature-ui-keyboard', '09-done', 9, 'add key press listener to focus on the quick search input', 'probably related to the structure of the page 
add key press listener to focus on the quick search input
Pressing / should activate the quick search input', 'ysg', '2018-08-06 12:55:35.853206', '2018-08-06 12:55:35.853206', 3.00, 1.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('705f0256-33d4-40e7-962e-63be910edb1a', 180808111808, NULL, NULL, 'task', 9, 'functionality-back-end', '09-done', 9, 'where in the url should act the same way as with', 'Because simply technical personnel would rather use where ...

Even updated the test ...', 'ysg', '2018-08-08 11:17:47', '2018-08-08 11:17:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e75d84ad-abb9-4b23-9b73-a2e1c39fc2a8', 180824081033, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'add Concepts document', 'Add the concepts to the mysql doc app', 'ysg', '2018-08-24 07:57:37', '2018-08-24 07:57:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0d2dbe46-082a-435c-aba1-01839f2458f2', 180802110002, 2, NULL, 'task', 1, 'feature', '09-done', 9, 'select all the txt on focus during inline-cell-edit', 'or consider it not part of MVP and use simply Ctrl + E short cut workaround … 
chck the following info-src: https://stackoverflow.com/questions/6139107/programmatically-select-text-in-a-contenteditable-html-element', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d8e12d7-29ed-44f0-8e7e-117aecec4414', 180820212740, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'the add new fails on the second page', 'Scenario: 
 - open table with more than <<page-size>> items
 - click on the second page
 - click on the "addNew" button 

Expected Result
 - a new item should be added on top of the table 

Actual Result :
 - the item is added in the model but somewhere else in the page and there is no indication for the user that a new item has been added ...', 'ysg', '2018-08-20 21:27:40', '2018-08-20 21:27:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bb9062ad-e773-4900-a52e-555c074e7955', 181018175218, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix the mojo-hypnotoad-start', 'As follows: 
 - the stop does not work , fix as mojo-morbo-stop
 - add configurability for the mojo_hypnotoad_port - 8080 as the default
 - test start and stop till it works ... 
', 'ysg', '2018-10-18 17:52:18', '2018-10-18 17:52:18', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2c73d462-6f0e-4fa4-b339-d10d24e1fc87', 180806170653, NULL, NULL, 'task', 8, 'bug', '09-done', 7, 'the chaining of the "with" url params does not work', 'The chaining of "with" url params does not work , or it has not been implemented f probably implementation fold. For example the following query:  list all the early bug issues, which are not-done. http://192.168.56.120:3000/dev_issue_tracker/list/monthly_issues?as=etable&pick=id,category,status,prio,weight,name,description&where=category-eq-bug&where=status-ne-09-done

the fix for the url_params fixed this one as well .. .', 'ysg', '2018-08-06 17:01:56', '2018-08-06 17:01:56', 2.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('98dbea27-563f-406d-b85e-12416ad6f3b6', 180808235133, NULL, NULL, 'task', 1, 'feature', '09-done', 9, 'add a small indication in the upper left corner for the db name', 'Just because it is confusing in which application one is ... 

to avoid mish-ups between the different applications', 'ysg', '2018-08-08 23:51:33', '2018-08-08 23:51:33', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59ac746a-b143-426e-8b69-10d142ce9282', 1804260100, 1, 10, 'task', 6, ' docs', '09-done', 9, 'add the issue-tracker control flow diagram to the DevOps guide', 'And move it to the System Guide , which seems to be a more logical place
Add it to the devops guide', 'ysg', '2017-09-21 07:00:00', '2017-09-21 07:00:00', 2.00, 0.10, 'docs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e93b1a24-b512-4b33-808f-cd5f22e13add', 1807170131, 1, 10, 'bug', 9, 'bugs', '09-done', 9, 'fix the bug "for updating the cell content in table inline edit on error, while it shouldn''t"', 'this is more of a generic question - how-to keep in sync the client-side and server side data structures - perhabs must update the client side array too ?!After the user updates the cell conent the post fires, the error msg is displayed but the content stays changed while it is not changed in the db … which is misleading … 
The behaviour should be changed so that the content will preserve its original state ...', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2e3abb56-2eda-4353-a0db-fc524fa187cb', 181020221234, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'deploy v0.5.2 in under 50 min', 'use repo configuration dir deployment technique. Deploy to each product version instance as follows: 
 - extract cnf to repo on server , download locally 
 - extract cnf repo zip locally , increase version 
 - create-full-package locally 
 - upload full-package to server 
 - deploy full package 
 - upload cnf repo zip to server 
 - unpack cnf repo zip to product instance dir
 - mojo-morbo-start , smoke test 
 - mojo-hypnotoad-start , smoke test

FIRST DEPLOYMENT WITHOUT GLITCHES ... ', 'ysg', '2018-10-20 22:12:35', '2018-10-20 22:12:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8c4b53c2-d719-4285-9639-95fd0dd786df', 181027094317, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'testCreate.pl fail on default ddls vals change', 'As the default vars in the cread ddl were changes ... ', 'ysg', '2018-10-27 09:43:18', '2018-10-27 09:43:18', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0be434f5-1066-43dd-be7e-053de08c5447', 1806060841, 1, 6, 'feature', 6, 'testing', '06-onhold', 9, 'poc for client side testing for all the client side functionalities', 'Evaluate:
- pure selenium 
- https://github.com/jhthorsen/test-mojo-role-selenium
poc for client side testing for all the client side functionalities

Might be too time-consuming', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 10.00, 7.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55247f93-4bd6-4b1e-8b31-6c35f8d5baab', 1806261101, 1, 6, 'feature', 5, 'feature', '09-done', 9, 'add support for multi-project data backup via the db-to-json and json-to-db actions', 'add support for multi-project data backup via the db-to-json and json-to-db actions. Before the data backed-up went only to the product instance dir and now to the project''s mix data daily dir.', 'ysg', '2018-06-26 10:00:00', '2018-06-26 11:00:00', 0.00, 2.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3f604b7-d422-49e7-ab4e-50dcafcf44d3', 180925215439, NULL, NULL, 'task', 9, 'docs', '02-todo', 6, 'create security component diagram', 'Create and add to docs the security compoent diagram:
 - list the main compoents and their responsibilities
 - list the security subjects', 'ysg', '2018-09-25 21:54:37', '2018-09-25 21:54:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('826161d5-9afc-47fb-b759-d777087cb3ad', 181102110528, NULL, NULL, 'task', 9, 'feature', '02-todo', 3, 'minify JavaScript to improve performance', 'The performance could be improved by minifying the Javascript, as follows: 
 - should be configurable  - aka on , off
 - should be proved by benchmarking for ', 'ysg', '2018-11-02 10:53:39', '2018-11-02 10:53:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a72ad39e-4bf0-43fa-953e-50e99db86537', 181022141252, NULL, NULL, 'task', 1, 'feature', '04-diss', 9, 'add the :width operator', 'Add the :width operator with the column name suggestions only ... 

Disgarded as entirely new heuristics for determining the syntax should be added ...', 'ysg', '2018-10-22 14:12:52', '2018-10-22 14:12:52', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7648e5da-2310-4826-b65b-81c19a15d5d9', 181011111738, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'client-side UI automation testing for JS events', 'Deploy the "textarea release" - version 0.5.1 to the amzn ec2 cloud, as follows: 

 - deploy from zip package - ok
 - prepare configuration files - ok
 - ensure no errors with cnf apply - ok
 - start and stop the dev,tst,prd mojo instances - ok
 - leave the tst mojo instance up-and-running - ok
 - start and stop the hypnotoad instance - fail

', 'ysg', '2018-10-11 11:17:38', '2018-10-11 11:17:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c9ec0d30-0f18-4094-b748-80c6bb6c0eaa', 181002113222, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add basic authentication', 'configure basic auth in the amzn instance IF there is a real biz need arrises:
 - confguration change - add the proj_instance_dir concept
 - security change add the htpasswd file per project if neeedd
 - binaries change - add the BasicAuthPlus module
Lessons learned: If something could go wrong it will go wrong , and even it if cannot go wrong something else will go wrong ...', 'ysg', '2018-10-02 11:14:40', '2018-10-02 11:14:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f89119f5-b0f8-4846-9bdc-89bf4a0a7991', 181019162457, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'resize the largest textareas in an on-click event', NULL, 'ysg', '2018-10-19 16:12:31', '2018-10-19 16:12:31', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('83182443-1c85-4ed2-810d-90d333d4d673', 1806251545, 1, 10, 'task', 3, 'documentation', '02-todo', 9, 'add a component diagram', 'Add an official component diagram UML-wise:
http://agilemodeling.com/artifacts/componentDiagram.htm', 'ysg', '2018-10-01 00:00:00', '2018-12-31 00:00:00', 3.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('71477531-2a74-453b-9d79-c87a43713767', 180813230115, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'table rows height default by "30"', 'update: 2018-10-11 11:00 
Achieved by changing the content editable div to text area and a simple title attribute interpolated with vue. 

For monthProbably not worth wasting time as of now ... Set the min-height however .... which brings some uniformity ...and show the full content on hover and on editThis will make the paging much more smoother and will prevent the jumping of the table back and forth', 'ysg', '2018-08-13 22:44:27', '2018-08-13 22:44:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('29ee77cb-8b2a-4fde-8b22-b1748f283aec', 181024105010, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'duplicate sorting onEnter with :order-by and :desc-by', 'The System should replace the currently set sortign operator od or oa to the one which has been chosen in the search box ', 'ysg', '2018-10-24 10:50:10', '2018-10-24 10:50:10', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6be91fa8-4688-4a53-bc62-570d9177c851', 181029141815, NULL, NULL, 'task', 9, 'release', '09-done', 9, 'start v0.5.3', 'increase ver', 'ysg', '2018-10-29 14:18:15', '2018-10-29 14:18:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbc92c1f-7b6b-4bce-bd0a-d0e4bd50db0f', 181019122441, NULL, NULL, 'task', 9, 'feature', '01-eval', 5, 'add smart column suggestions for the :pick operator', 'add a metatable called meta_autocompletes as follows: 
 - will contain the mostly used columns lists
 - only requested table columns from the list will be suggested
 - will contain the list of the page-sizes
 - will contain the list of the data-bases FOR THIS PROJ DB ( Security !!!)
', 'ysg', '2018-10-19 12:12:07', '2018-10-19 12:12:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3c20d2aa-addd-42be-9ea1-e3490fc3ee73', 180920075303, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix the "undefined" bug in :for and :in operators', 'fix the "undefined" bug in :for and :in operators', 'ysg', '2018-09-20 07:52:51', '2018-09-20 07:52:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('313bbbef-f9c3-48d9-940d-96bc2e92f1c8', 181010214611, NULL, NULL, 'task', 9, 'refactoring', '09-done', 9, 'rollback js and css libs local fetch', 'Simply because it slows performance and increases complexity !!! ', 'ysg', '2018-10-10 21:46:11', '2018-10-10 21:46:11', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6fd72ccb-ea9f-4bbb-924d-4cb598760a6b', 1806241429, 1, 1, 'task', 5, 'feature', '09-done', 9, 'add poc for vue modal dialog page', 'The modal dialog will be used for the CRUD functionality from the list table view and for the search … 
Seems too primitive - for example does not have the close by pressing escape', 'ysg', '2018-06-24 00:00:00', '2018-06-30 00:00:00', 3.00, 0.70, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('69002c7e-fdd5-4547-b213-d865a8474c56', 1805110200, 1, 10, 'feature', 1, 'feature', '09-done', 9, 'create the list page with vue.js', 'Create a simple list labels view interface which will use the list web action: 
 - evaluate both server and client side html generation and compare performance
- ok add error handling for missing db
 - add error handling for missing table
- add error handling for wrong hidable column
 - add error handling for wrong pickable column
 - add error handling for wrong filterable col
 - add error handling for wrong col in like', 'ysg', '2018-05-10 20:53:00', '2018-12-31 07:00:00', 10.00, 12.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c338e622-7a77-46aa-b2c4-676d2ecacafa', 181022124036, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the :order-by and the :desc-by operators', '
Implementation time - 1h 
Comparably easy ones the database lists and tables lists implementations existed ... 
add the :order-by and / or the sort-by operator  in the search box:

on enter the page should redirect and display the new listing with the new ordering', 'ysg', '2018-10-22 12:40:36', '2018-10-22 12:40:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b364c690-7e6f-47df-b3ee-2b9959aec629', 180925102758, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'update the docs for the :in , :for ops and keyboard nav', 'update the docs for the :in , :for ops and keyboard nav', 'ysg', '2018-09-25 10:27:58', '2018-09-25 10:27:58', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('872773cb-d638-442a-ac25-8115bf632a7f', 180807161151, 1, NULL, 'task', 9, 'design-concepts-docs', '02-todo', 6, 'define copy and move operations of items', 'The thing is that those are much more complex than it seems and thus they first be designed and defined and AFTER that implement

For example: 
 - "same table item copy action"  ( newid and new guid must be created ) 
 - "different table item copy action" 
 - "different database , same table item copy action"
 - "different database , different table item copy action"', 'ysg', '2018-08-07 16:11:51', '2018-08-07 16:11:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ee61ab80-f648-4d9a-99fe-0f7c785c2c1c', 180815110339, NULL, NULL, 'task', 9, 'feature-ui', '01-eval', 5, 'add vue calendar page', 'For example from the following GitHub project: 
https://github.com/richardtallent/vue-simple-calendar', 'ysg', '2018-08-15 10:51:51', '2018-08-15 10:51:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5eaf91a-b401-4a2e-acf1-c79d2892536d', 180806212213, 1, NULL, 'task', 9, 'feature', '09-done', 9, 'add scroll till the top', 'related to the it-180801151524

Add scroll till the top when the table ends ...

Add more space in the page 

Related to the', 'ysg', '2018-08-06 21:22:13', '2018-08-06 21:22:13', 3.00, 0.30, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d4e20248-a559-441f-87f4-0f89cdaa18a6', 180914105643, NULL, NULL, 'task', 9, 'refactor', '09-done', 5, 'avoid the warning for exiting last', 'when detecting the bug for the failing column :
https://stackoverflow.com/a/44310352/65706', 'ysg', '2018-09-14 10:41:48', '2018-09-14 10:41:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23061a5a-42d2-4c4d-8d31-8fd16ff75ae7', 180815140522, 2, NULL, 'task', 9, 'functionality', '09-done', 5, 'add the db restore to the integration testing', 'add the db restore to the integration testing as the xls call will not be used so heavily anymore ... 
 - add additional db-re-create after the xls-to-db load
 - add the load from the latest db dump', 'ysg', '2018-08-15 14:05:12', '2018-08-15 14:05:12', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('75b0a34b-30dd-4122-9ea6-4cf0d9d0cd67', 180821205727, NULL, NULL, 'task', 6, 'bug', '09-done', 9, 'clear the content of the quick-search input on new item adding', 'Solution: add a redirect with clearing of the filtering url params.

clear the filtering when new item is added

Changed the behaviour to just make the add new button transparent, which will indicate that the behaviour is different', 'ysg', '2018-08-21 20:57:26', '2018-08-21 20:57:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1ca71c00-9eef-4272-88da-fa4504118390', 180830215227, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'add the :in<<db-name>> syntax for redirect into the same page', '2018-09-25 09:37:03 -> 09-done , alpha
add in:<<database-name>> syntax , which could direct to the current url but in the chosen from the dropbox database', 'ysg', '2018-08-30 21:39:31', '2018-08-30 21:39:31', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('540961a6-46ee-4943-a081-6ea7bc7f15b8', 1805172116, 1, 10, 'feature-implementation', 1, 'setup', '09-done', 9, 'upgrade Ubuntu 17.04->17.10', 'Upgrade zesty to artful:
 - had to pre-install the whole perl modules package bundle
 - had to pre-install postgres ... Althought it would have worked probably by just installing the Perl postgres related modules.', 'ysg', '2018-05-20 19:10:00', '2018-05-20 23:10:00', 0.10, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('83384e1b-1ba3-4720-bf73-3799ec622883', 181022164253, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'xls-to-db bug with unclarity of error for data validation ', 'Root cause: unclear msg in the hash to hierarchy hash conversion
        issue_tracker::__ANON__("Can''t use string (\"the Level increased with more th\"...) as a"...) called at /vagrant/opt/csitea/issue-tracker/issue-tracker.0.5.2.dev.ysg/src/perl/issue_tracker/lib/IssueTracker/App/Db/Out/MariaDb/WtrMariaDb.pm line 376
', 'ysg', '2018-10-22 16:42:53', '2018-10-22 16:42:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('43929f18-b1d1-43ee-921d-13f49133a291', 180921091752, NULL, NULL, 'task', 9, 'feature-ui', '02-todo-to-2019', 9, 'add icon for the pager', 'The pager on the top is kind of strange - new users would know what is it all about ...

https://www.storyblocks.com/stock-image/page-pdf-glyph-icon-bdigvdpe7uzj6gmsu0c', 'ysg', '2018-09-21 09:17:48', '2018-09-21 09:17:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6e0db40-6aed-405d-acd2-ee77abd717ac', 180806172736, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'fix the headers and the search form', 'The inline cell update does not probably implement the vue model and life cycle ..   

The table headers and the search form should stay at the top - 2% of the page', 'ysg', '2018-08-06 17:22:39', '2018-08-06 17:22:39', 3.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('459ffadd-8f23-4295-b8ef-bb73e98fd5a5', 1806281041, 1, 5, 'feature', 9, 'testing', '09-done', 9, 'fix bug for increase-date', 'The increase date shell action now:
 - supports different sub-dirs - xls,json,txt', 'ysg', '2018-06-28 20:53:00', '2018-06-30 00:00:00', 1.00, 2.00, 'bug,feature-root-cause', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('efa98faa-af81-4bea-97dc-969b4c79e825', 181003124555, NULL, NULL, 'task', 9, 'feature-bug', '09-done', 9, 'change content editable to textarea for html entities display', 'Add the capability to display any text regardless of the html rendering for example: 
- rendering anything which has html tags - <<var>>
- rendering html code - forexample table
<table> 
</table>

This was achieved by replacing the content editable div with a textarea ...
And naturally a lot of other features and capabilities were gained "for free" ... such as resizing of the columns and rows ... tooltips etc. ', 'ysg', '2018-10-03 12:45:55', '2018-10-03 12:45:55', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('44fda35e-21b5-4af9-b148-1552a2fb7cf8', 1806011701, 1, 5, 'setup', 5, 'setup', '01-eval-2019', 6, 'configure web-pack packaging', 'configure web-pack packaging
Is it even feasible to have the web-pack in the current setup ?!', 'ysg', '2018-06-01 00:00:00', '2018-06-10 00:00:00', 2.00, 2.00, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('82940b36-3aea-4d5e-8d34-312c3921561e', 1807031421, 1, 6, 'task', 5, 'setup', '09-done', 9, 'update installation instructions with aws deployment', 'update the aws instructions with aws deployment', 'ysg', '2018-07-04 04:06:05', '2018-07-04 23:06:05', 2.00, 2.00, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4a564c84-dd69-46ad-90fe-e1640efaba9c', 1807031419, 1, 5, 'task', 9, 'setup', '09-done', 9, 'deploy demo instance to aws', 'Iterate the installation documentation.', 'ysg', '2018-07-04 04:06:05', '2018-07-04 23:06:05', 3.00, 3.00, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9df5b82c-2d86-4967-8bb7-26871427a568', 1806291841, 1, 1, 'task', 6, 'feature', '02-todo', 5, 'add columns stickiness in list as table ui', 'When the ui scrolls a table with page containing more items than the height of the screen the headers of the table must stick to the top of the page. 
Quite difficult with pure css … this one has been the best so far : 
https://jsfiddle.net/dPixie/byB9d/3/', 'ysg', '2018-07-10 00:00:00', '2018-08-30 00:00:00', 3.00, 1.50, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('78d22cd6-864c-4219-ab1e-d29fc8b63e6a', 1806011256, 1, 10, 'feature', 5, 'feature', '01-eval', 7, 'implement a time report web ui page_', 'The time report web ui page will :
- fetch the daily,weekly,monthly and yearly hours
- get the allocated hours per time period
- calculate the registered actual hours to the went-by hours of the start of the period
- calculate the diff between the actual and passed-by hours
- accessible from the list/table-name/?as=table url
- should be able t osort the data', 'ysg', '2018-12-01 00:00:00', '2018-12-31 07:00:00', 20.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('36a82200-0972-4dcc-9ab0-2458c36a6d75', 1806011702, 1, 5, 'bug', 1, 'setup', '09-done', 9, 'fix bug for non-aplying multiple with url params', 'Root cause - simple return in the wrong way of the loop ', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 0.00, 1.50, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b938410-fd24-400a-b690-a056c0a8840f', 181001113115, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'pager sets wrong page numbers', 'Because the page sizer line of code was moved 3 lines bellow ...', 'ysg', '2018-10-01 11:31:15', '2018-10-01 11:31:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7a5be76d-8f3b-44d2-b494-3effdaea78e6', 181017183758, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'asyncronous load for page and db lists', 'Improve performance changing the loading of the tables list and databases list on page load to be on search inbox <<operator>> added', 'ysg', '2018-10-17 18:37:58', '2018-10-17 18:37:58', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b25dbe49-ff4a-489a-a78d-2fe4dddb7a59', 1805102300, 1, 10, 'feature-implementation', 5, 'feature', '02-todo', 5, 'add a default route for the "/" web address', 'add a default route for the "/" web address.
May be something like forward to the list view ?!

Should be time-wise actual, when the authentication and the login with landing is developed ...', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 2.00, 1.00, ' feature,', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe1eeae3-5fb4-46df-b1de-6b62d9229be6', 180807153751, 1, NULL, 'task', 6, 'bug', '09-done', 9, 'add resizing of the columns', 'update: 2018-10-11 11:00 
Achieved by changing the content editable div to text area and a simple title attribute interpolated with vue. 

For monthProbably not worth wasting time as of now ... Set the min-height however .... which brings some uniformity ...and show the full content on hover and on editThis will make the paging much more smoother and will prevent the jumping of the table back and forth', 'ysg', '2018-08-07 15:37:51', '2018-08-07 15:37:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4c42e5cb-b106-4aba-8b0a-835c6dca261d', 181024173243, NULL, NULL, 'task', 2, 'testing', '09-done', 6, 'add benchmarking 1000 pages test ', 'The benchmarking tests should do the following : 
 - run against an already running instance
 - record the current version , commit -hash and start_timeto the test_runs table
 - run mojo user agent against the yearly_issues tables with page-size = 7
 - click on the pages 1-10
 - record the stop_time to the test_runs table

', 'ysg', '2018-10-24 17:32:43', '2018-10-24 17:32:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f083ef98-957d-4b27-b28e-04b7697c51cd', 180808143653, 1, NULL, 'task', 9, 'docs', '09-done', 7, 'Add aknowledgement in the ReadMe.md', 'Add aknowledgement in the ReadMe.md file

 - Mojolicious
 - Vue 
 - Perl
 - GNU / Linux

Add aknowledgement for all the collegues ...', 'ysg', '2018-08-08 14:36:53', '2018-08-08 14:36:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13079a57-1954-4efb-a8f5-f5badaea6496', 181008184250, NULL, NULL, 'task', 9, 'setup', '09-done', 9, 'refactor configuration repo dir structure', 'The configuration repo must comply with: 
 - /var/<<orgname>>/<<tool>>

naming convention
 - one liner for packing
 - one liner for unpacking 
 - one liner for creation
', 'ysg', '2018-10-08 18:24:21', '2018-10-08 18:24:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8d614c06-74b2-4cb1-9382-8ee7d07a59e5', 1805010100, 1, 10, 'task', 5, 'docs', '09-done', 9, 'add the Get.pm web app controller', 'The get controller will fetch a single item based on either on the id or the guid', 'ysg', '2017-09-21 07:00:00', '2017-09-21 07:00:00', 2.00, 10.10, 'docs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e9b20874-18f8-46ba-ab6b-7708876c4af7', 1806091100, 1, 4, 'bug', 5, 'bug', '09-done', 9, 'fix bug for non-arranging the column in the list labels as specified in the pick order', 'Due to false logic in the implementation', 'ysg', '2018-05-30 20:53:00', '2018-06-09 10:00:00', 1.00, 0.20, 'bugs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a0c169ed-7c1a-4789-a48d-58dc9c3080ef', 180824093501, NULL, NULL, 'task', 5, 'bug', '09-done', 9, 'xls increase-date name bug', 'the increase-date does not change the name of the xls with the date', 'ysg', '2018-08-24 09:19:43', '2018-08-24 09:19:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12190348-4e10-481b-a816-fb3f67f38a44', 1805152400, 2, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the order-by url param for the list web control', 'add the order-by url param for the list web control 
 - ok path
 - nok path', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7c3da050-81e0-4ac0-b74d-940415360773', 1805140900, 1, 5, 'feature-implementation', 2, 'feature', '06-onhold', 6, 'implement data-load testing with 3 tables x 10 000 rows', 'This is partially implemented witht the benchmarking ... 

As follows:


- At least 3 tables
 - with at least 10 000 rows load
 - Because if you cannot get it right from the very beginning than you will get it never ever right
 implement a poc for data-load testing with single table load to postgres with start and stop times recordingAdd as a non-blocking post update for start_time and stop_time', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd5f22aa-6349-42a5-8526-d29f06bc192d', 181022131409, NULL, NULL, 'task', 9, 'biz', '02-todo', 5, 'restrict the amount of databases one which could be fetched ', 'restrict the amount of databases one which could be fetched with the :for operator in the select-databases route

Create a custom table per database which contains a list for the db''s this project has access to ... 
', 'ysg', '2018-10-22 13:14:09', '2018-10-22 13:14:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d09a0fd7-67ce-4bfc-9420-141c91a32136', 180912103334, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'specs for users, roles', 'Add minimalistic specs for authenticated users and 2 roles: 
 - authenticated users
 - unauthenticated users
src: https://github.com/jberger/Mojo-JWT', 'ysg', '2018-09-12 10:18:02', '2018-09-12 10:18:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dd534f01-54ff-44e5-9617-1a0bfb1f87e9', 181005114324, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'base url fails to retrieve data', 'The 
http://192.168.56.120:3001/dev_issue_tracker/list/principles?as=grid
page is empty
Root cause: bug in setting deefault params: 
fix: if ( url_params.has("page-size") === false) { url_params.append("page-size" , 5); }
source:  https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams/entries', 'ysg', '2018-10-05 11:43:19', '2018-10-05 11:43:19', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3749b409-3733-40dd-a18e-27d815e96ba3', 180814182141, NULL, NULL, 'task', 1, 'code', '09-done', 9, 'get table cols one-liner', 'produce one-liner to get he columns of a table in postgres
Because it will be used thousands of times ... 
And it will be used in the upsert from one table to another code', 'ysg', '2018-08-14 18:14:17', '2018-08-14 18:14:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5ed88231-4de2-4a6a-a8fe-4ca50719fe38', 181008183922, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix ALL the failing regression tests', 'As their amount has start going up ...
 - ok - for remove the hide ie', 'ysg', '2018-10-08 18:20:52', '2018-10-08 18:20:52', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ec67678-7532-4b72-b07d-38cfb13e834e', 1805221029, 1, 10, 'feature', 6, 'feature', '04-diss', 9, 'add form order in url params', 'The ability to order the form elements from the url ... By using the pick order and not a separate fo= ...', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8f4bfa4c-9aa9-4a18-abcb-f956b9349217', 180810093609, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'ensure the update bug does not re-occur', 'The vue model is not updated - and this IS the root cause for both the sorting and the other strange issues which happen', 'ysg', '2018-08-10 09:36:09', '2018-08-10 09:36:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2a52cd-c4b9-4248-8665-9dc0df6e9f63', 180803093321, 1, 10, 'task', 3, 'feature', '03-act', 5, 'release process automation', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process
add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'ysg', '2018-09-01 12:00:00', '2018-09-30 12:00:00', 10.00, 0.10, 'setup,feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68627bf3-af35-4f8b-b607-021eceb71f17', 1805160800, 2, 10, 'task', 1, 'feature', '09-done', 9, 'add the where url operator for quick sql liker filtering', 'add the where url operator for quick sql liker filtering', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 15.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8c959f2c-6db0-433d-815f-ba49208ab1d7', 181005084525, NULL, NULL, 'task', 9, 'major-release', '09-done', 9, 'release v0.5.0', 'Major release having: 
 - stable and reliable crud grid with paging and filtering
 - search-box with autocomplete for dbs,tables and cols
 - ui and back-end covering test suite
 - 1h deployment time with 10 min per instancerow-2row-3
 - simplistic basic auth with levels access', 'ysg', '2018-06-01 12:00:00', '2018-10-30 22:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ed980933-5f7d-4f35-9bf6-d82e94d4ba83', 180806212921, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'develop basic authentication setup', 'Develop a per Issue-Tracker instance basic authentication
If easy develop a per db authentication ....', 'ysg', '2018-08-06 21:29:19', '2018-08-06 21:29:19', 2.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('73ac6332-7b44-4baa-ba03-c31f65472f11', 180814101238, NULL, NULL, 'task', 1, 'bug', '09-done', 9, 'fix bug with esc.', 'This was the obsolete line: 

this.$el.setAttribute(''contenteditable'', ''false'')', 'ysg', '2018-08-14 10:12:38', '2018-08-14 10:12:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dc91451d-460f-4092-9f6b-ae85e5ed0699', 180802105623, 1, NULL, 'task', 9, 'release', '09-done', 9, 'release v0.4.6', 'Couple of small fixes in the integration tests ... 
release v0.4.6 should be considered "transitional" release as it contains only the update of the CRUDS feature, although there is some need for refactoring and additional testing the "create " and "delete" features must be added asap to avoid wasting time with additional tools and Excel. 
Also this should be the first release to be released to the cloud as well.', 'ysg', '2018-08-02 10:56:49', '2018-08-05 22:56:49', 3.00, 0.00, 'release', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d1831d21-c0f0-428e-aee3-c7346e82e3f2', 1805172135, 1, 10, 'goal', 9, 'feature', '06-onhold', 6, 'client-side UI automation testing for JS events', 'By using the Mojo::Chrome module:Should be able to capture JS events:Vue induced changes on the page. ', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('218c1b15-0a7c-4b0b-86ca-0b5a586b7ac4', 1806011111, 1, 10, 'task', 9, 'architure', '06-onhold', 5, 'change Front-End architecture to use Web Pack', 'As Web Pack seems to be the best in town package manager and a lot of JS code is distributed as npm packages.', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c6dcd926-1c4d-4a38-a86c-d8d7a69c6e2a', 181017214639, NULL, NULL, 'task', 9, 'tests', '09-done', 9, 'restrict the amount of tables in the select tests', 'restrict the amount of tables in the select tests to prevent data related errors', 'ysg', '2018-10-17 21:46:31', '2018-10-17 21:46:31', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3b210ebd-7a52-42f7-989f-eb02aaf119b9', 1806232256, 1, 5, 'task', 5, 'feature', '02-todo-2019', 6, 'add modal dialog for item-edit in the list table ui', 'add modal dialog for item-edit in the list table ui. 
Status change -> 04-diss . No time till the end of this monthly …', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature ', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('495f36ea-ea34-403c-93df-b7a8c11e9ab8', 180927084435, NULL, NULL, 'task', 9, 'feature-bug', '04-diss', 9, 'replace redirects with partial page updates', 'The whole ui ideology of the navigation is based on the fact that it should be easy to move back and forther between the result sets ...
In the cases when the grid has to be updated a partial page refresh only on the grid root div is needed as the page blinks annoyingly', 'ysg', '2018-09-27 08:44:35', '2018-09-27 08:44:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4e73627-74fd-49b8-b83a-d2d761f997e1', 180827110649, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'implement 2-stage create-id for create new item', 'Because the generation of the id if 2 users clicked or one user clicked too fast is rare but confusing bug', 'ysg', '2018-08-27 10:53:43', '2018-08-27 10:53:43', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6d9005a-525d-4288-88d8-9fb561f5f105', 1805301337, 1, 10, 'bug', 4, 'bug', '09-done', 6, 'fix the NULL.md generated in generate-docs action', 'Due to the non availability of the relative path', 'ysg', '2018-05-28 20:53:00', '2018-05-30 00:00:00', 2.00, 3.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d4740701-7593-442c-9b3c-7a642d575cef', 181009105544, NULL, NULL, 'task', 9, 'setup', '04-diss', 9, 'add the /opt/csitea symlnk in ec2 env', 'Not needed. The setup should be ~/opt and ~/var as default 
Update accordingly the user-guides etc. 

export link_path=/opt/csiteaexport 
tgt_path=/home/usr_it/opt/csiteamkdir -p `dirname $link_path`unlink $link_pathln -s "$tgt_path" "$link_path"ls -la $link_path; # add both for /opt and /v', 'ysg', '2018-10-09 10:55:38', '2018-10-09 10:55:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('58564210-d843-4436-94f6-109242a5aeba', 180806125917, 1, NULL, 'task', 1, 'feature', '09-done', 9, 'Change the background on the editable on focus', 'Change the background on the editable on focus', 'ysg', '2018-08-06 12:59:17.629376', '2018-08-06 12:59:17.629376', 0.50, 0.55, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7c353415-1c6e-45e6-86f1-e5bdbc07ae87', 180903130418, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor controls templates', 'add the control templates into their own dirs. fix the missing dist , move js controls to own dirs', 'ysg', '2018-09-03 12:51:50', '2018-09-03 12:51:50', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('881dd1a1-044d-42e3-9119-ce5d0d1cb568', 180824130856, NULL, NULL, 'task', 9, 'specs', '02-todo-monthly', 6, 'login , logout requirements specifications', 'Create the requirements for the login and logout operations

Add the user-stories for the login and logout operations', 'ysg', '2018-09-01 00:00:00', '2018-08-24 13:08:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8fe8ad4c-fb37-481a-8a3b-9264e2bcfcc6', 181012103713, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'async load of db and tables list', 'add asyncronous load of the databases'' list and the tables list AFTER typging the ":in" or ":for" operator', 'ysg', '2018-10-12 10:36:54', '2018-10-12 10:36:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5bff873b-49fe-4d5a-be56-bbcd4c70945f', 1805112000, 1, 10, 'bug', 5, 'feature', '09-done', 9, 'add error handler for xls-to-db when postgres and db table does not exist ', 'Some kind of proper error msg
', 'ysg', '2018-05-11 21:10:00', '2018-06-11 19:20:31', 3.00, 0.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c40550e3-97cf-4ced-9b43-8aab2c13f109', 1807030408, 1, 5, 'task', 3, 'testing', '09-done', 6, 'convert the start_time and stop_time attributes to datetime format', 'The text format was justified for agility in the beginning , but now with the existing of so much data it is not justified anymore.Need to ensure that the', 'ysg', '2018-07-04 04:06:05', '2018-07-04 04:06:05', 3.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f98a0dab-ff80-4b9a-8356-0fb7607a1286', 180817165902, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 6, 'the tabing should work on top of the delete button too', 'The navigation with the tab key does not work currently on top of the delete button

it works BUT , the order is really freaky !!!

This is part of a larger problem .... how-to design the table so that the cursor will move with the same direction as components have been drown visually on the screen ...', 'ysg', '2018-08-17 16:41:54', '2018-08-17 16:41:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fa5dca34-e6dd-4a75-8a60-fbe5a03d1c1c', 181024103906, NULL, NULL, 'task', 9, 'setup', '09-done', 6, 'create the our-proj project template ', 'The our-proj project template should contain the following:
 - the configuration files for the project
 - the xls file + daily dir structure for the project
 - the sql scripts for the project', 'ysg', '2018-10-24 10:39:06', '2018-10-24 10:39:06', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ae71d31-263b-430f-998e-58bd5dee2814', 181027084820, NULL, NULL, 'task', 9, 'bug', '05-tst', 5, 'failed to choose non-first entry from dropdown in the srch box', 'The dropdown looses the state somehow its state
 - caused by arrow down ...', 'ysg', '2018-10-27 08:48:20', '2018-10-27 08:48:20', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('331aaf30-45a2-45c0-a5fa-a19b9d513aa9', 1806241213, 1, 6, 'task', 9, 'feature', '02-todo-2019', 7, 'add poc for the vue-js-modal dialog page', 'Add the poc from the following source: 
https://github.com/euvl/vue-js-modal/blob/master/README.md

Probably all the node_modules must be installed globally, because there is dependency between the mojo morbo web server … which gets REAAALly SLOW …', 'ysg', '2018-06-24 00:00:00', '2018-06-30 00:00:00', 2.00, 0.30, 'poc', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd7cd0ea-7c3c-44f7-97ba-6a72260e2d93', 180903114100, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'redirect dialog box', 'add showing the dialog box for the redirect', 'ysg', '2018-09-03 11:28:29', '2018-09-03 11:28:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('50a360df-2b66-4b93-a42c-3f85e388b48e', 180717013201, 1, NULL, 'bug', 1, 'bug', '09-done', 9, 'remove the unneeded run-logging', 'Should be removed ... if more *.run.log files appear open a bug ...

There is run-logging which is not used anymore - to remove', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5ad90b5-cfc5-4223-a119-5030e4c8e3f4', 180818104209, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'usage scenarios to ReadMe.md', 'Add the usage scenario in ReadMe for: 

 - deploy to trusted environment
 - everyone has CRUD access via http
 - the admins can create whatever tables having guid and id params
 - tables could be preloaded with xls
 - describe the server-side paging quirks openly', 'ysg', '2018-08-18 10:40:00', '2018-08-18 10:40:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('20f646a7-c322-40f1-b0bf-777fff8f3e5e', 1805110400, 2, 10, 'feature-implementation', 1, 'feature', '01-eval', 6, 'improve the select-tables web action', 'Add the following:
- list of views
- ability to specify order by table name and/or creation date 
creation date is important fo rthe population for the primary and foreign key tables 
  - ok - convert result-set to array and not hash', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 1.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65384aa9-1ef5-466f-bc57-ed139a7f5505', 180828103943, NULL, NULL, 'task', 9, 'bug-ui', '09-done', 9, 'bug for non-reported missing column in list ui', 'Scenario: 
- choose url to table not-having picked in the url , for example: 
http://192.168.56.120:3001/prd_nokia_musa/list/questions?as=etable&pick=id,level,category,status,prio,weight,name,description,start_time,stop_time&page-size=5&oa=prio&page-num=1

Expected: 
- error msg prompting that start_time and stop_time attributes do not exist 

Actual
- dat is undefined', 'ysg', '2018-08-28 11:00:00', '2018-08-28 12:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e3a3ff71-3133-4258-87a1-104ee13e2007', 180806125916, 1, NULL, 'task', 1, 'bug', '09-done', 9, 'the inline-cell update removes the new lines from the cell', 'the inline-cell update removes the new lines from the cell 

ops - wrongly used ev.target.textContent when ev.target.innerText should have been used', 'ysg', '2018-08-06 12:59:16.274161', '2018-08-06 12:59:16.274161', 1.00, 0.70, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d1da2cc5-6f48-4fef-b992-a5cd4d784f85', 180814080139, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'a "null" string appears after empty cell', 'a "null" string appears after empty cell has been updated - try with description', 'ysg', '2018-08-14 08:01:39', '2018-08-14 08:01:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('30243762-f0c3-4747-a573-6710f19ee71f', 1806110038, 1, 5, 'bug', 1, 'setup', '09-done', 7, 'the client side ui sorter does not support soring by numbers', 'Need to implement own sorting method. 
This is complete no-go for correct financial data !!!', 'ysg', '2018-06-10 21:30:00', '2018-12-31 07:00:00', 5.00, 0.30, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('95b9aead-2235-4812-b774-165e490ee6e9', 1807170133, 1, 10, 'bug', 9, 'refactoring', '09-done', 9, 'improve the error msg behaviour and outlook in the site template', 'It just looked too clumsy. Now it looks more prefessional …', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e69cd654-9bfe-4565-ba09-390f391892a8', 181019123648, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add shortcuts for textarea resizing', 'Scenario: 
- user clicks on the textarea : 
 - the system listens for the Shfit + Arrows keys shortcut
 - one pressed the System resizes the textarea to the desired direction', 'ysg', '2018-10-19 12:24:14', '2018-10-19 12:24:14', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34072102-26e1-4995-8aab-496c0cbdc363', 180926103938, NULL, NULL, 'task', 9, 'docs', '04-diss', 9, 'update way of working section', 'Update the System Guide with the way of working section: 
 - requirements should have explicitly written deadline', 'ysg', '2018-09-26 10:39:38', '2018-09-26 10:39:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3ae86f77-04e6-4cb1-b689-c64af8617dc9', 180807184617, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'document the db-dump and the db-restore operations in the DevOps guide', 'document the db-dump and the db-restore operations in the DevOps guide f', 'ysg', '2018-08-07 18:46:17', '2018-08-07 18:46:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e4b365af-e883-4139-8c1b-32ff361de43d', 180925102926, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'update the docs for the ability to use the new button via the keyboard', 'The new button is cycleable via the tab and can be clicked via the keyboard', 'ysg', '2018-09-25 10:29:26', '2018-09-25 10:29:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('004d8fd5-4124-426e-a661-831658f699e6', 181103164723, NULL, NULL, 'task', 9, 'feature', '02-todo', 6, 'make the search-box global for all the views', 'As it is for now only for the list-grid and search page. As follows: 
 - add for the as=cloud page view
 - add for the as=labels page view', 'ysg', '2018-11-03 16:36:27', '2018-11-03 16:36:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2b407437-102a-4a56-8145-d49b49f9df31', 181023110608, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'onArrow down event fails with the :order-by op', 'onArrow down event does not work with the :order-by , yet it works with the :for operator !!!

Not a bug, but a feature - 
It should be stated somewhere in the docs that a search operator REQUIRES space afteritself ... otherwise only the value from the dropdown is taken , which is also convinient if you would like to copy let say only a column name ... ', 'ysg', '2018-10-23 10:54:13', '2018-10-23 10:54:13', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8f20c787-3668-4793-b156-76c9ff05a30f', 180829090616, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'same item on multiple pages', 'When a single non definitive order by is applied , some of the items appear on several pages , because of the randomness of the ordering, which occurs server-side ... 
Proposed solution:
add the additional ORDER BY id desc at the end of every query. 
Cases : 
 - no order by provided -> will order by id desc
 - oa=prio => order by prio asc , id desc
 - od=prio => order by prio desc , id desc', 'ysg', '2018-08-29 09:03:40', '2018-08-29 09:03:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6845c2be-d505-4cde-a016-04fe751340d0', 1805111300, 1, 10, 'activity', 1, 'feature', '09-done', 9, 'add the create back-end web action', 'Create the create.pm action and integrate within the existing integration tests', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6687ea3a-39f5-4ece-b353-4e90aa3ac371', 180817105857, NULL, NULL, 'task', 9, 'feature', '09-done', 7, 'add the db-backup call to the increase-date shell action', 'add the db-backup call to the increase-date shell action

This will ensure that backups are done on daily schedule !!!
That is administrators will not be able to work on the system without having run the increase -date , which automatically will perform backup of the System', 'ysg', '2018-08-17 10:58:57', '2018-08-17 10:58:57', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3f0d7194-c7ce-4848-8a54-1260efbd5eee', 1805172136, 1, 10, 'goal', 5, 'deployment', '09-done', 6, 'deploy a web accessible instance with basic authentication for demo purposes in amzn', 'To be done straight after the CRUDS completion.

Deploy an instance of the issue-tracker application, which will be www readable, but editable via a simple authentication.', 'ysg', '2018-05-17 00:00:00', '2018-12-30 00:00:00', 20.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59ee1acf-fdb1-40a6-85ac-1221e687834f', 181011111334, NULL, NULL, 'task', 1, 'bug', '09-done', 8, 'rollback js and css libs local fetch', 'Roll back the fetching of the js and css libs locally ... 
Related to it-181002103808', 'ysg', '2018-10-11 11:13:34', '2018-10-11 11:13:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('269866fd-6fa6-48ef-bfca-26c69dfb335a', 180914105804, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'fix the bug for un-existing attribute not shown when requested', 'for example request the principles page by requesting the status attribute as well ... 

Probably the real feature should be just to issue a warning of the bottom of the page stating, that showing the query without the ''<<unexistent-attribute>>'' as it does not exist in the <<item>>', 'ysg', '2018-09-14 10:43:09', '2018-09-14 10:43:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d2da9c89-3711-44be-a52f-4abe463794f3', 1805110500, 1, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the like-by and like-val in url to implement the like operator for filtering', 'add the like-by and like-val in url to implement the like operator for filtering', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 5.00, 3.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4f6934a-ee5a-4a71-87c9-5984c1c1a9e1', 181011195040, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'freaky duplication on edited row ', 'THIS IS THE MOST IMPORTANT ONE !!!
SINCE IT CHANGES THE DATA !!!!

 - sort by prio
 - F5 to refresh
 - click on prio twice to ensure sorting works
 -  ', 'ysg', '2018-10-11 19:50:40', '2018-10-11 19:50:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b05cb51f-b4d0-4257-a3f6-ba1a8611370a', 1806011257, 1, 5, 'feature', 9, 'feature', '09-done', 9, 'implement a sortable list table ui', 'Should be able : 
- with alternative row backgrounds for odd and even
- to choose the order of the colums as the pick 
- to choose which columns to hide
- to list ANY db table
- provide the same url params as in the list labels page to the back-end 
', 'ysg', '2018-06-08 21:30:00', '2018-12-31 07:00:00', 20.00, 3.00, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('877c70d2-b186-44e5-b852-3c125aece449', 180925085248, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'add dropdown close on Esc', 'When the dropdown is opened clicking escape should close it
added on blur eh', 'ysg', '2018-09-25 08:52:48', '2018-09-25 08:52:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('318d2067-1897-404b-aa18-4785d2ccf4d2', 180817194616, NULL, NULL, 'task', 9, 'bug-ui', '09-done', 6, 'the focus quick search input should not fire when typing in an editable', 'the focus quick search input should not fire when typing in an editable

It is really annoying when one types in the editable field to jump to the quick search ...', 'ysg', '2018-08-17 19:37:39', '2018-08-17 19:37:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32fc6df6-c236-432b-b79e-78de7099c7b3', 180813191652, NULL, NULL, 'task', 1, 'functionality', '09-done', 5, 'back-end testing for DELETE', 'Complete the back-end testing for the DELETE web action

The back-end calls for delete went whithout tests ... 
Not ready for merge !!!', 'ysg', '2018-08-13 19:16:50', '2018-08-13 19:16:50', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8fade974-c629-4ab9-adfe-ff1523364f4b', 181021100816, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor app class for better scalability', 'refactor the app class for better scalability for : 
 - app hooks
 - sessions 
 - plugins handling', 'ysg', '2018-10-21 10:08:07', '2018-10-21 10:08:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a2c413bc-f733-40a8-a8e7-562fc77f51a2', 180817132816, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 7, 'change colouring of the current sorted columns', 'the sorting column is not obvious - untrained users cannot grasp the concept of the sorting and the current sorted column - it might need to be emphasized by colouring or something else ...', 'ysg', '2018-08-17 13:11:02', '2018-08-17 13:11:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('428b55bd-8ef4-4f30-9c7f-5fe29057dad9', 180803161926, 1, NULL, 'task', 6, 'feature', '02-todo', 5, 'implement a new hierarchy model', 'implement a new hierarchy model by using the seq into a separate items_hierarchy table , which will have the following attributes:
id - the FK pointing to the items id 
seq - the sequence in the hierarchy 
item_nam e- the name of the item''s table to refer to 
( all those should comprise an unique PK ) 

Change in the hierarchy would mean changing the seq number - those not all issues will be hierarchical, but those which are could be seen in an hierarchy UI !!!', 'ysg', '2018-10-01 20:53:00', '2018-12-31 20:53:00', 30.00, 0.10, 'hierarchy', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('88848c01-3925-4dce-a474-0aa35cfdd88e', 1805152200, 2, 10, 'feature-implementation', 1, 'feature', '09-done', 9, 'add the pick url param for the list web control', 'add the pick url param for the list web control', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3f8617f-bc8e-4b0a-9e68-2e1c8ea999a1', 180817140314, NULL, NULL, 'task', 9, 'refactor', '09-done', 5, 'add the doBackupPostgresDb function', 'Refactor the db backup into a separate function', 'ysg', '2018-08-17 13:46:01', '2018-08-17 13:46:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0ac4be02-e209-4e1a-b790-aa5c22143122', 1806011648, 1, 5, 'setup', 2, 'setup', '09-done', 8, 'Install FE required binaries', 'setup nodejs, webpack and bower for Front-End development', 'ysg', '2018-06-01 00:00:00', '2018-06-01 00:00:00', 2.00, 2.00, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68fd878b-e311-4a54-b03a-eddf2fb09dcb', 180808110559, 1, NULL, 'task', 6, 'bug', '09-done', 7, 'fiix error msg verbosity', 'If the table DOES NOT obey the requirement ( by design ) to have default values for the non-nullable columns the inserts fails with really badly verbose message ... 

 - create a table with non-nullable column
 - click on the add new button
 - chk where the error msg is comming from ( "cannot sed dat on undefined object " ) 
 - add verbosity to the msg', 'ysg', '2018-08-08 11:05:39', '2018-08-08 11:05:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('78eb7e84-a262-4beb-b487-c7b770673a35', 180816091746, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'single shell call daily backup', 'Add a single shell-call for : 

 - creating a zip daily backup of an issue-tracker project
 - sending that daily backup via gmail', 'ysg', '2018-08-16 09:03:09', '2018-08-16 09:03:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0353cdb3-55fe-481f-9215-d18d5ffe2887', 181102211528, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'remove the obsolete vuetify.js', 'Marked as a bug, since decreased peformance by 30% ...
remove the obsolete vuetify.js and axious.js  from the local file system', 'ysg', '2018-11-02 21:15:29', '2018-11-02 21:15:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ae963e98-c5fc-40fe-b832-850d0b2a4bf2', 1805111000, 1, 10, 'feature-implementation', 1, 'setup', '09-done', 9, 'add the pre-loading of the env shell configuration files', 'the run-integration tests should pre-load the configuration file of the current instance in order to match the full environment as it is run usually. 
Solution : 
The call has to be changed to : 
export issue_tracker_project=""; bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests
And documented the change in the DevOps guide', 'ysg', '2018-05-10 20:53:00', '2018-05-31 17:00:00', 2.00, 2.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('851443ca-a66f-430a-83e7-a8d9f4c2dcba', 181024091444, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'double item on :operator in search when space + enter', 'double item on :operator in search when space + enter
Scenario: 
 - the User clicks on the search-box , types:" :order-by prio " ( with the space at the end
Expected outcome:
 - the System should set the content of the search box to ":order-by prio" 
Actual outcome:
 - the System sets the item chosen ( prio ) twice !!! aka
":order-by prio prio"


', 'ysg', '2018-10-24 09:14:45', '2018-10-24 09:14:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3f25f22-0e8a-4f91-ba90-801069ec0b36', 180822145244, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the add new item fails on quick search full', 'Now it does not fail , but actually "discurrages" the user to add new item by making the add new button transperent

Scenario: 
- focus the quick search
- type some search 
- click on the add new

Expected result 
 - a new item on the top of the first page should be added 

Actual result: 
Nothing happends

I', 'ysg', '2018-08-22 14:52:44', '2018-08-22 14:52:44', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a02d3ebc-5c89-4f71-a36e-ce1c7cc9d252', 1807030420, 1, 6, 'bug', 5, 'feature-ui', '09-done', 9, 'add a "as=print-table" page', 'Which will be used for simply print the whole table 
 - copy the e-table template
 - change the editable to a simple td
 - remove the page-sizer+code
 - remove the page-numberer+code
 - remove the CRUD methods
 - keep the styling', 'ysg', '2018-07-04 04:06:05', '2018-10-31 12:00:00', 5.00, 0.50, 'bugs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd42cd73-38b7-400f-a30d-ac47735e328f', 181011103249, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the capability to adjust the column widths ', '
The default width of the columns is calculated from the actuall cell content size , but :
The capability can be achieved by dragging the size of the textareas, which is supported by most of the modern browsers: 
- chrome
- safari 
- firefox

- set default widths by em units - add logic for short , middle and long cols', 'ysg', '2018-10-11 10:32:49', '2018-10-11 10:32:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b860d07-344d-4809-9639-52f2c8a3414c', 180902003233, NULL, NULL, 'task', 9, 'feature-ui', '09-done', 9, 'pager to the pager', 'If there are more than 10 pages the whole paging becomes confusing ... 
Add a pager to the pager, which will scroll till the next 10 items , so show first 1..10 >> when clicked show 10..20 and so forth', 'ysg', '2018-09-02 00:32:34', '2018-09-02 00:32:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e6dc3786-5c39-444d-bde5-3d06ba70bdac', 180818105658, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'increase-date , xls file copy fail', 'The increase-date action does not copy the staging xls file, when it must.', 'ysg', '2018-08-18 10:54:49', '2018-08-18 10:54:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2d9a6e-5a29-4365-a4db-cf9f7165ba65', 1806232300, 1, 1, 'task', 1, 'feature', '09-done', 9, 'add json-to-db shell action', 'Add the following tests:
 - ensure all the tables have a generated json file from the db-to-json action
 - ensure the number of elements in each json files corresponds to the number of rows in the postgres table - back and forth

In order to achieve independance from the xls run-time for achieving the full CRUD, I wanto to be able to take quickly backup and restore db data from files on timely basis.', 'ysg', '2018-06-23 00:00:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('91bc9e6f-cd99-46be-b405-ac511d3fa6e7', 180814105454, NULL, NULL, 'task', 2, 'devops', '09-done', 5, 'add how-to-copy-items script', '+ figure-out the beginning of the process of copying items from one table to another', 'ysg', '2018-08-14 10:42:52', '2018-08-14 10:42:52', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be547364-3ed7-43f2-a92f-0df3e6fbddc4', 1805110201, 1, 10, 'feature', 5, 'feature', '09-done', 9, 'create the plain list labels view ui  with vue.js', 'Create a simple list labels view interface which will use the list web action: 
 - evaluete both server and client side html generation and compare performance', 'ysg', '2018-05-10 20:53:00', '2018-12-31 07:00:00', 0.10, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('793cc854-22dd-4c7a-9a9a-442e6ce3147a', 180828100245, NULL, NULL, 'task', 4, 'bug', '09-done', 9, 'addNew with filter url params', 'Solution: add a redirect with clearing of the filtering url params.
if one has a filter in the global search when clicking create new , the filter stays and the new items are not shown . Scenario: 
 - have a global search with=status-eq-09-done
- click on add new

Expected behaviour: 
- the new items will be shown 
- the global search will be cleared
Actual behaviour:
 - the global search is not cleared 
 - the new rows are not shown ...', 'ysg', '2018-08-28 10:01:21', '2018-08-28 10:01:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('86f6bcb6-aba8-42ba-9a58-ffc138350b05', 180830202826, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add select-databases', 'add the select-databases in the same way as select-tables url is implemented in the back-end + test', 'ysg', '2018-08-30 20:15:26', '2018-08-30 20:15:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1749f537-2230-4f6f-af18-5b5b4c890025', 1805110600, 1, 10, 'activity', 5, 'activities', '09-done', 9, 'publish a read-only issue-tracker MVP to a host in the cloud for demo purposes', 'publish a read-only issue-tracker MVP to a host in the cloud for demo purposes', 'ysg', '2018-05-06 07:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d2ef5ff1-14c5-49e2-82c3-743e2bf65123', 180919115535, NULL, NULL, 'task', 7, 'feature', '09-done', 9, 'add the :in<<db-name>> syntax for redirect into the same page', 'When a db is fully normalized and the foreign keys are set , a dropbox must be added to select from the human readable valuesCould be implemented first with the status table ... Implement with smart meta data handling ... no table hooks ..', 'ysg', '2018-09-19 11:55:30', '2018-09-19 11:55:30', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4f26d3ad-ced9-45c8-905f-a134428686bf', 180829200359, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'add error for wrong operator in url where param syntax', 'A wrong syntax in the url with url param does not bring the correct message: 
http://192.168.56.120:3001/prd_ysg_issues/list/daily_issues?as=etable&pick=id,category,status,prio,weight,name,description,start_time,stop_time&page-size=5&oa=prio&page-num=1&where=status-ef-09-done', 'ysg', '2018-08-29 20:03:59', '2018-08-29 20:03:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e3ea4cd4-1ef6-4f1e-ba15-f7d0c5636369', 1806062255, 1, 5, 'setup', 5, 'setup', '09-done', 9, 'add the phppgadmin to the configurtion setup', 'Installed and documented the installation - this starts the solution of the crashing xls problem which is a blocker. ', 'ysg', '2018-06-08 14:00:00', '2018-06-08 16:00:00', 0.00, 2.00, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('006f6640-27ad-413a-bee9-b2576db67bde', 181009205519, NULL, NULL, 'task', 9, 'feature', '06-onhold', 8, 'initial hierarchical docs modelling', 'The item and item_hierarchy combined will server as the storage mechanism for the doc_itemA doc_item has logical and consistent hierarchy

- one
- two', 'ysg', '2018-10-09 20:55:15', '2018-10-09 20:55:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a5764fdb-213c-488f-925d-af7f9aae440b', 1806302301, 1, 5, 'refactor', 5, 'feature', '09-done', 9, 'add support for multiple css themes', 'Just move the directory structure of the css''s one level bellow … ', 'ysg', '2018-06-26 10:00:00', '2018-06-29 11:00:00', 1.00, 0.20, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0b2ee6b1-2f94-43de-8933-ed5223c67fd9', 181003125316, NULL, NULL, 'task', 9, 'feature', '06-onhold', 9, 'achieve capability to write client side tests', 'Obtain the capability to write selenium web driver UI automation scripts on the mac:  - install node - ok  - install atom - ok - install the chrome-driver - done - run js script get response in perl - foo- todo', 'ysg', '2018-10-03 12:53:16', '2018-10-03 12:53:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a234ead-76ed-4dfc-9768-0dc5ddb12ae6', 180925220009, NULL, NULL, 'task', 9, 'docs', '04-diss', 9, 'add login sequence diagram', 'Create and store for future maintenance a login authentication sequence diagram', 'ysg', '2018-09-25 22:00:07', '2018-09-25 22:00:07', NULL, NULL, NULL, '2018-12-25 21:11:22');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a455442-1a47-4f2a-9565-52161b0bf7b4', 180824132128, NULL, NULL, 'task', 9, 'feature-ui', '02-todo-to-2019', 9, 'add a search button in the bottom', 'When using with mobile to select the global search is too much of a hassle, if the button is on the bottom of the page it would be much easier to just click on the bottom of the screen ( the size of the button might be the same as the add - new ) , and click on the search , which would than open the modal dialog with the global search window', 'ysg', '2018-10-15 00:00:00', '2018-08-24 13:21:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('681b3805-c434-45e2-9616-6d2c58e2aa04', 1806110020, 1, 6, 'activity', 6, 'security', '04-diss-to-yearly', 6, 'add validation of ui params against SQL injections _', 'Each time a new data param is to be parametrized till the db ... A validation must be added to it.', 'ysg', '2018-06-10 23:00:00', '2018-12-31 07:00:00', 5.00, 3.00, ' security', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d9ffb12-960a-4648-b288-9cd435838abe', 1805110401, 1, 10, 'feature-implementation', 5, 'feature', '04-diss', 9, 'add db-to-json export for all the issues tables in the integration tests', 'To enable later the avoidance of the xls file ...', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 4.00, 0.10, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b9f0becc-db54-4638-b8d2-daf3b5c4c281', 1806062253, 1, 10, 'bug', 1, 'setup', '04-diss', 9, 'poc for print-to-pdf via headless chrome', 'Could be achieved via UI , not so often used - no sence to spend time automating it … at least for now …', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 3.00, 1.00, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4939f666-8b0a-4450-9bb2-56537e74f60d', 1806231402, 3, 5, 'feature', 2, 'feature', '09-done', 7, 'add a visual indication for the active page number in the list tables view', 'Well, good enough for now ... Later one ... probably would need more styling ... As currently it is not exactly clear which page is the current one … The less experience is the user the more urgent this feature is …', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 0.10, 'feature', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59da9507-e762-4975-a0b0-03f6affe94be', 180806110417, 1, NULL, 'task', 9, 'bug', '02-todo', 5, 'add error on non-existent network', '2018-09-25 09:37:03 for next month
 ...basically if vue , vuetify etc. libs cannot be loaded via the cdn - aka if there is no connectivity a basic error message should be added to indicate that ...', 'ysg', '2018-08-06 10:51:54.714225', '2018-08-06 10:51:54.714225', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9d3a14a2-f401-44c3-ae0a-5d7d8c844d86', 180822180521, NULL, NULL, 'task', 9, 'feature-bug', '09-done', 9, 'change behavour on inp_quick_search on txt change', 'indicate that the add new behavour is different

that is it really adds an item, but it does not "recommend" to do so ...', 'ysg', '2018-08-22 18:05:20', '2018-08-22 18:05:20', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('70830eb8-5029-4ad3-8438-ec6f225613ee', 1806071735, 1, 5, 'capability', 1, 'setup', '09-done', 9, 'achieve capability to export to pdf list-cloud and list-lbls pages via chrome UI', 'Could be done only via the Chrome UI', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 1.00, 2.00, ' setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d10e1e5c-e87e-4be2-b9e8-9e4e52aba93f', 180815171338, NULL, NULL, 'task', 2, 'feature-ui', '02-todo-2019', 9, 'added draggability in the labels page', 'add drability and sorting by attribute ( prio , weight ) for the labels page', 'ysg', '2018-08-15 17:07:22', '2018-08-15 17:07:22', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a34bcb5e-bcb2-4414-a926-427172c83781', 180806102413, 1, NULL, 'task', 9, 'feature-ui-usability', '01-eval', 5, 'add fixing of the table header , page-sizer and the quick-search text-box on table scroll', 'Basically the upper part of the ui should stay fixed, while scrolling the table', 'ysg', '2018-09-01 00:00:00', '2018-09-30 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55fcc574-63fd-45a9-922e-6ddad61d1ac1', 1806281111, 1, 5, 'bug', 9, 'feature', '09-done', 9, 'fix bug with incorrectly calculated page nums', 'The page nums are not correctly displayed', 'ysg', '2018-06-28 18:00:00', '2018-06-29 18:00:00', 1.00, 0.20, 'bugs', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('24889a37-4362-4012-aeee-ded06d590f4a', 180920104253, NULL, NULL, 'task', 9, 'feature', '01-eval', 6, 'add the Ctrl+N should click on the add new item', 'The keyboard combination of Ctrl + N should create a new combination - it will make the addition of items much more faster ...
chk https://stackoverflow.com/a/7296303/65706
add to global events', 'ysg', '2018-09-20 10:27:48', '2018-09-20 10:27:48', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9677f7c2-7028-4033-b174-a3dc98737738', 181102115933, NULL, NULL, 'task', 9, 'feature', '01-eval', 5, 'improve performance by changing setup with Nginx for static files', 'Could it be worth it to improve performance for adding Nginx into the setup ?!
Source: https://blog.localh0rst.de/mojolicious-hypnotoad-and-nginx/
pros: 
 - more RAM for hypnotoad
 - less optimizations for static files 

cons : 
 - more complexity in system administration
 - greater deviation between dev and prod setups', 'ysg', '2018-11-02 11:47:45', '2018-11-02 11:47:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('daf1a325-594e-4212-af0f-2ea42e022278', 181005090038, NULL, NULL, 'task', 9, 'major-release', '02-todo', 9, 'release v0.8.0', 'Major release containing:  
- 25 min deployment with 6 min downtime per instance 
- global per role-level visibility menu - personal links save
- view/item?as=doc with CRUD 
- list?as=grid page load with 7 items for 0.07 via benchmark
- export as pdf for all the pages generically via as=pdf 
- generic calendar control in list ui', 'ysg', '2019-06-01 22:00:00', '2019-06-01 22:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d6e029c-b823-474e-86c6-5a8e6b44e3ad', 181031173728, NULL, NULL, 'task', 9, 'major-release', '02-todo', 9, 'release v0.9.0', 'Major release containing containing: 
 - public api 
 - own data handling - downloads to the interested parties
 - deployment under 5 min , 0 downtime 
 - LDAP integration for security 
 - integrated cubernetes / docker infra in src code ?', 'ysg', '2018-10-31 17:37:28', '2018-10-31 17:37:28', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a013b45a-0600-40e5-ad02-07536e075af9', 181106093939, NULL, NULL, 'task', 9, 'refactor', '02-todo', 5, 'refactor the doSelectTablesColumnList function calls in the shell actions', 'Benefits : 
 - alignment to the common meta-model
 - less round trips back and forth to the database ... 
 - cleaner separation between readers and writers ( no readers code in writes etc. ) 

find . -type f -name ''*.pm'' -exec grep -nHi doSelectTablesColumnList {} \;
', 'ysg', '2018-11-06 09:20:39', '2018-11-06 09:20:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4d7094b5-4033-4f3d-b003-d311e60952ed', 181128132640, NULL, NULL, 'task', 9, 'refactor', '01-eval', 7, 'fetch the default values for the insert from the meta-data', 'fetch the default values for the insert from the meta-data and do not set them in the create-table ... ?!', 'ysg', '2018-11-28 13:15:01', '2018-11-28 13:15:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8a127f15-a399-452a-a530-ff64ae8f9f26', 1807101030, 2, 4, 'feature', 5, 'feature', '02-todo', 3, 'add the UPDATE for the CRUD table via the vue-js-modal form', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item 
I want to be able to click on the edit button , fill in the poping-up dialog with the form of the full data of the item and clicking the Save button.', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-12-25 21:04:36');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('665f009d-3b27-4e70-ac00-f77b716fb3d4', 180921091603, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add icon for the page-sizer', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'ysg', '2018-09-21 09:15:59', '2018-09-21 09:15:59', NULL, NULL, NULL, '2018-12-25 21:06:16');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('58a91acd-c2f3-448e-8ecd-b39418cbd3c4', 181102214552, NULL, NULL, 'task', 9, 'feature', '02-todo', 4, 'start using the met/.src.issue-tracker', 'which will be used as the meta relative file ONLY for the source code .. ', 'ysg', '2018-11-02 21:45:52', '2018-11-02 21:45:52', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('295bcab9-567c-481e-8de5-5ec7fededfc3', 181023102836, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add base controller', 'The BaseControler provides the api for calling common to ALL services ... ', 'ysg', '2018-10-23 10:16:40', '2018-10-23 10:16:40', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('37eb9dfd-48e0-4d90-be14-1117dc50435b', 181114170016, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor control flow in select with super doRender', 'As follows: 
 - establish a global naming convention for the back-end api ', 'ysg', '2018-11-14 16:45:30', '2018-11-14 16:45:30', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('868f28a4-162c-4f5a-9c58-af7e40843f0c', 181022114517, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'make the id column collapsed by default , but allow horizontal resizing', 'make the id column colapsed by default , but allow horizontal resizing', 'ysg', '2018-10-22 11:45:18', '2018-10-22 11:45:18', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d8c9374e-34e7-486d-a3f0-a173e4942411', 181105104306, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add a minimalistic search route', 'Add a separate template:
 - create the search-grid template
 - reuse one by one the components from the list-grid template
 - change table.css -> srch-table.css
 - add paging and page-sizing', 'ysg', '2018-11-05 10:31:02', '2018-11-05 10:31:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('89906ba7-228f-4225-a659-6edbcf4ebfe0', 181113111455, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'hide control failing on null ', 'Solution : 
When checking for element by document.getElementById( ... do always : 
if ( typeof(btnNew) !== "undefined" && btnNew != null )', 'ysg', '2018-11-13 11:01:26', '2018-11-13 11:01:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c7b1a869-9425-4dbf-9d27-e0811e4afc1c', 181112180304, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'remove the numeric pager add play next and play prev img buttons', 'With the respective event handlers ... 
Now the annoying flashing of the numeric pager is removed ...', 'ysg', '2018-11-12 18:03:04', '2018-11-12 18:03:04', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('62cca0df-1483-4202-8c5a-39fb749846b1', 181031172723, NULL, NULL, 'task', 5, 'bug', '09-done', 9, 'page numbering failing in non-url params urls', 'the pager generated links for the next page get broken if the no parameters are specified ... 

That is the pager should check that the "?" char exists and if not add the "?as=string" to the page-num url', 'ysg', '2018-10-31 17:27:23', '2018-10-31 17:27:23', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('04be8c85-85f3-490a-8abd-ca533645b5b9', 181103103837, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'start v0.5.4', 'As follows: 
 - create dev,tst,prd instances
 - create branch
 - create 0.5.4 cnf files for host-name
 - create 0.5.4 cnf files for amzn host', 'ysg', '2018-11-03 10:33:59', '2018-11-03 10:33:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2dc1f433-e999-4f13-a939-805f88643006', 181104183748, NULL, NULL, 'task', 9, 'refactor', '09-done', 6, 'remove our proj ddl scripts', 'They will be added via the future automation action ... 
It''s pure code duplication .... for now ... ', 'ysg', '2018-11-04 18:37:47', '2018-11-04 18:37:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('19c2966a-f433-4079-aafe-659bec039b0b', 181017185647, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'speed-up the loading of the css files by caching', 'As they take half of the load time and not so much css is out there yet !!!

 - add asynchronous loading
 - nope: tech: <link rel="preload" href="/css/styles.css" as="style">', 'ysg', '2018-10-17 18:56:47', '2018-10-17 18:56:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7f0a63e1-71cf-4a05-87bb-852efa8caf74', 181105190319, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'add linking to the search route', 'As follows: 
 - textareas -> divs
 - remove CRUD handlers
', 'ysg', '2018-11-05 18:51:29', '2018-11-05 18:51:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe35f367-904d-4112-af6d-8d8d96854b7a', 181102163217, NULL, NULL, 'task', 9, 'feature', '09-done', 6, 'remove the vuetify dependency', 'As it takes 30% of the page load time !!! And really it is not used that much ...', 'ysg', '2018-11-02 16:20:38', '2018-11-02 16:20:38', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ff0a61e1-f2c1-428f-98c8-1619afeaa314', 181101191311, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'move common app level headers to the app hook', 'The headers could be set on 3 levels : 
 - the app hooks 
 - the base controller 
 - the web action controller', 'ysg', '2018-11-01 19:13:11', '2018-11-01 19:13:11', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dfbd2ce0-4ddd-4fe3-ba87-3b7ae2f78783', 181102110318, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'improve performance by adding txt compression', 'By implementing the hook after_render or after_dispatch hook : 

https://mojolicious.org/perldoc/Mojolicious/Guides/Rendering#Post-processing-dynamic-content

Seems to have improved perf in the UI , but decreased in the benchmarking script , because of the additional overhead in the user agent to set the headers ?!', 'ysg', '2018-11-02 10:51:29', '2018-11-02 10:51:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6738b63d-77bf-4e8e-a8f5-07d1a98beb1c', 181106222335, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'change the url params naming conventions', 'Because of the appearance of the search web action the new url params naming conventions should be like: 
 - :of for the list of databases 
 - :in for the list of tables 
 - :for for the txt to search for ', 'ysg', '2018-11-06 22:23:35', '2018-11-06 22:23:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('06584532-39ca-48d5-8dce-c49ae4163955', 181112150815, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'onInputChange in-page filtering does not work the otherway arround', 'When one starts writing amount of rows is reduced , but when one starts taking off the already written the filter stays , while it should be removed ... ', 'ysg', '2018-11-12 15:08:09', '2018-11-12 15:08:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('acce3986-9edc-410e-a4a5-1631d0e35687', 181105131035, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'improve the app-name pop-up', 'Improve the lay-out and the behaviour of the app-name pop-up', 'ysg', '2018-11-05 12:58:36', '2018-11-05 12:58:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b9f8c9e-70f1-42c9-9747-dae8152dbfca', 181114155351, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'warning for no-data in list web action', 'display warning instead of error in request with no data in list web action', 'ysg', '2018-11-14 15:39:01', '2018-11-14 15:39:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f97df0f-b7f6-4da2-8699-3e2aa1c9f357', 181031142547, NULL, NULL, 'task', 1, 'bug', '09-done', 9, 'remove mets/ cn  f fir ss', 'proably some erroneus cp .. ... Those seem to occur when templating code is added ... ', 'ysg', '2018-10-31 14:25:47', '2018-10-31 14:25:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aafbd08b-58ca-4d46-8a48-8ba61a6f0424', 181112143633, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'add the notice ui element for warning', 'add the notice ui element for warning with: 
 - capability to display notices ( aka warning msgs, from the back-end )
 - re-factor the error msg displaying logic, to suite future warnings', 'ysg', '2018-11-12 14:36:27', '2018-11-12 14:36:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('95189f51-77e8-46c3-8c12-906add357748', 181105111328, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add :active, :hover and :focus css for the add-new button', 'A the whole button was too static ...
add :active, :hover and :focus css for the add-new button', 'ysg', '2018-11-05 11:01:26', '2018-11-05 11:01:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d59fb70c-dbd9-4d69-90fc-f25e5aa4d607', 181105133401, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'improve the css for active page-num and page-size', 'Much more stylish outlook + better usability for which is the active page and which is the active page size ...', 'ysg', '2018-11-05 13:22:02', '2018-11-05 13:22:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3d9f216e-5be4-4cb4-87d5-dee97d7f74d2', 181106112206, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor the global msg template to be part of the site template dir structure', 'change the global msg template to be part of the site template dir structure , as now it is under the list-grid dir structure ... ', 'ysg', '2018-11-06 11:03:09', '2018-11-06 11:03:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b45d2bc9-49e8-47a9-821c-cbd0547d7161', 181102101908, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'pass the item meta model to the client', 'As follows: 
 - pass as array/hash of objects in the met
 - set to gridMetaData', 'ysg', '2018-11-02 10:19:08', '2018-11-02 10:19:08', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23cd62e9-e3b4-42f2-b6ca-76ad11820f5b', 181102102501, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'ensure the update does not fail', 'Some kind of de-bounce bug from the meta model or it does not fail, but the retrieving of the elements after refresh is confusing ... 
The update failed on missign meta data ', 'ysg', '2018-11-02 10:25:01', '2018-11-02 10:25:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b0975c71-fe73-45cf-beca-e596b0d4d406', 181105134047, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'the srchbox dropdown was behing the page sizer sizes', 'fix with z-index in css', 'ysg', '2018-11-05 13:28:50', '2018-11-05 13:28:50', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('62788673-1c5d-4433-83b6-364fdefefa30', 181109140902, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'srch_control not found', 'Appears when only the search page without the as=grid&for url is provided ... ', 'ysg', '2018-11-09 14:09:02', '2018-11-09 14:09:02', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cfb7480b-5933-42bf-9cfa-fd713375d72e', 181109134159, NULL, NULL, 'task', 9, 'setp', '09-done', 9, 'add the staging logical environment', 'The staging ( "stg" ) logical environment could be used instead of / or addtionally to the tst and/or qas enviroinments', 'ysg', '2018-11-09 13:42:00', '2018-11-09 13:42:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('633cee5b-d3f9-4eea-8477-af229f83ef2e', 181105172304, NULL, NULL, 'task', 97777, 'feature', '09-done', 9, 'change the back-end api for response.met to response.cnt', 'As the meta should be reserved for the whole meta model ... with 2 possible options: 
 - the whole model for the whole app ( later on menus etc. ) 
 - the whole model for this item ( menus , etc ... straight from server )', 'ysg', '2018-11-05 17:11:12', '2018-11-05 17:11:12', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('66e20631-0504-4692-a87e-80dce38e8b70', 181111220025, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'change the pager ui to be play/rewind one', 'The pager should look as follows: 
 - next / "play" button for the next page
 - next 10 / rewind button for the next page + 10 or last
 - previous / back button for the previous page
 - previous 10 / first for the first page
 - display current-page/amount-of-pages in the right of the pager', 'ysg', '2018-11-11 22:00:25', '2018-11-11 22:00:25', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ad4089d7-72ca-4441-ac99-d16c9febdb8f', 181105191128, NULL, NULL, 'task', 9, 'refactor', '09-done', 6, 'refactor the doSelectTablesColumnList function calls in the web-actions', 'Force usage of the common meta model, which WILL increase performance as well ... 

find . -type f -name ''*.pm'' -exec grep -nHi doSelectTablesColumnList {} \;', 'ysg', '2018-11-05 18:59:39', '2018-11-05 18:59:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('947bf212-99f4-4c22-b10c-ee4e0d91c01f', 181111220654, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'onEnter should select the first one', 'Typo in the filtering method ?! 
Lessons learned - it takes 2 months to apply such a simple UI concept ???!!!!', 'ysg', '2018-11-11 22:06:54', '2018-11-11 22:06:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ef2f9f16-e290-4977-9840-240e981c7f15', 181102213201, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'Add src product_type', 'As follows: 
 - dev,tst, prd and src
 - dev, tst , prd & master
 - dev -> dev
 - tst -> tst 
 - prd -> prd 
 - src -> master
Pushes ONLY from the a product instance dir belonging to their respective branches. This will achieve process scalability for segregation of duties ... ', 'ysg', '2018-11-02 21:32:01', '2018-11-02 21:32:01', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('05d45170-f989-4a3b-8d47-46734514318f', 181103103156, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'the hover with the mouse over the first page does not work', 'As the width of the search-box is too big probably ...', 'ysg', '2018-11-03 10:27:18', '2018-11-03 10:27:18', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ea2bdefa-795f-4a5d-9399-085ffbd1f6d4', 181101100449, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'hide the id column, but make it resizable', 'This way the user could copy an id WHEN needed , by first resizing the column of the id and than selecting it with the keyboard ', 'ysg', '2018-11-01 10:04:49', '2018-11-01 10:04:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5dfe1ef0-6e1f-4511-bdcf-1eb012a5be76', 181113174523, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'more than 1 digit is not displayed properly', 'Because of the width calculation change ...', 'ysg', '2018-11-13 17:31:57', '2018-11-13 17:31:57', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e187cea7-a2cf-4a18-9601-e0aef3f50365', 181102110806, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'onDownArrowKey sets undefined in the searchbox', 'The onDownArrayKey event handler sets in really rare cases undefined as value in the ', 'ysg', '2018-11-02 10:56:17', '2018-11-02 10:56:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6a5e5745-2601-4aa3-9354-0b168ed32116', 181105101238, NULL, NULL, 'task', 9, 'setup', '09-done', 6, 'prepare amzn instance v0.5.4 cnf files', 'prepare amzn instance v0.5.4 cnf files', 'ysg', '2018-11-05 10:11:54', '2018-11-05 10:11:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2770049e-cefe-48fd-906a-ae35ab090998', 181114155455, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'warning for no-data in query web action', 'display warning instead of error in request with no data in list web action', 'ysg', '2018-11-14 15:40:06', '2018-11-14 15:40:06', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4deaead1-721e-4bee-93ce-22d7e01dd511', 180806103105, 1, NULL, 'task', 9, 'feature', '09-done', 6, 'add fetching of the meta-data in the select web-action', 'The meta-data could be added to the met , as the data is set in the dat of the json ...
Because this will also enable the display of the warning msgs capability', 'ysg', '2018-09-01 00:00:00', '2018-09-30 00:00:00', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6aeffafc-d6ad-4cf4-90f0-e3eaa6cf3b93', 181120224937, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix alternating rows formatting in db-to-xls', 'fix alternating rows formatting in db-to-xls', 'ysg', '2018-11-20 22:49:26', '2018-11-20 22:49:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7e178f99-dd78-4e6a-8eff-53af7e8617e9', 181120224802, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'fix & refactor db-to-xls bug', 'Because of changed API ... of the SelectTableIntoHashRef', 'ysg', '2018-11-20 22:47:51', '2018-11-20 22:47:51', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2e90f131-1125-48ac-8c46-e40d113bc68b', 181107111719, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add search button for mobile ui usage', 'Although it is not needed the search button is a must have because of the end-users not customized to keyboard driven interactivity in web apps ... The button could re-use the onEnter action ... ', 'ysg', '2018-11-07 11:01:34', '2018-11-07 11:01:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3fdabca3-e6a1-42e6-885c-318ab753c70f', 181113215954, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'strange bug while switching for the with url param', 'due to the with regex in the url replace ...
The url param changes as follows: 
 - old: with=status-eq-09-done
 - new: ,description-09-done', 'ysg', '2018-11-13 21:59:54', '2018-11-13 21:59:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ef12bb71-c243-4b7d-911c-85f7d8354963', 181111115034, NULL, NULL, 'task', 9, 'release', '09-done', 9, 'deploy v0.5.4 dev instance', 'v0.5.4 named "poc for global search"
 - deploy dev instance from full package- ok 
', 'ysg', '2018-11-11 11:50:35', '2018-11-11 11:50:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7b478a8b-824b-4bdf-ba3b-f2da9952bd4d', 181102145504, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add the git hash for the benchmarking', 'Because one looses track of what was the change , and now the exact git short hash could be tracked ... 
Add the short git hash to the benchmarking script ... ', 'ysg', '2018-11-02 14:43:22', '2018-11-02 14:43:22', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6b54ab40-58c8-4ff0-83d1-71864c97b612', 181023100716, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'poc for grid interpolations pattern', 'POC with hardcoding via v-html and computed property in vue ... 
Need to figure way to make it totally dynamic ...
add the functionality for the grid control to interpolate based on pattern ...
Dependant on the it-181023100621 

', 'ysg', '2018-10-23 10:07:16', '2018-10-23 10:07:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('85e536ec-9abe-4e0d-8055-bf6245280a21', 181102194748, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'pager links effects', 'add on hover and on focus effect on the pager links', 'ysg', '2018-11-02 19:42:26', '2018-11-02 19:42:26', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e43e07f-bdd2-4f29-92ae-a6de127d2310', 181113110228, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'set the textareas width based on the metadata', 'nullAs follows: 
 - create a mechanism to handle the meta in the front-end
 - establish new lengths based on the db max lengh', 'ysg', '2018-11-13 10:48:59', '2018-11-13 10:48:59', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('60a3d65c-9c18-4162-b417-ffd2a53e7136', 181101205215, NULL, NULL, 'task', 9, 'feature', '09-done', 6, 'global meta model adaptation', 'adapt the existing columns handling to the global meta model. 
Implementation notes: 
  - extremely complex in terms of interdependencies ... 
  - might cause unexpected bugs .. ', 'ysg', '2018-11-01 20:52:15', '2018-11-01 20:52:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5599b506-80c9-4b0f-96fa-c8ec9d3d164b', 181114095907, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'change the http response code for "no data" to 204 in select and query', 'Because : https://stackoverflow.com/a/27101750/65706
+ now there is the capability to display warnings ...

introduce new var in the api in the db layer ... , which is http_code', 'ysg', '2018-11-14 09:44:07', '2018-11-14 09:44:07', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6d856b7-0373-4b88-998f-0cdad6f6ce70', 181031173205, NULL, NULL, 'task', 5, 'bug', '09-done', 6, 'wrongly wrapped textarea text', 'when the text length is too short in the text area it gets wrapped ... 
Is some kind of onMounted event ON THE GRID levels needed to decide the damn lengths of the textareas ?!', 'ysg', '2018-10-31 17:32:05', '2018-10-31 17:32:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6591482d-7b41-4236-ae9a-67136517a42e', 181114165829, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'refactor control flow in query with super doRender', 'As follows: 
 - establish a global naming convention for the back-end api ', 'ysg', '2018-11-14 16:43:44', '2018-11-14 16:43:44', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0cf5b81a-a70b-4de8-a610-c79262620fa6', 181128185949, NULL, NULL, 'code-task', 9, 'bug', '09-done', 9, 'the page-sizing link does not take ? into consideration', 'and produces the following result: 
http://192.168.56.120:3001/prd_nokia_musa/list/benchmarks&page-size=100', 'ysg', '2018-11-28 18:47:36', '2018-11-28 18:47:36', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13801d65-9d13-4e02-8a71-3e0b4130e113', 181107110327, NULL, NULL, 'task', 9, 'bug', '09-done', 6, 'switch of databases by :in operator does not work', 'The :in operator does not work for change the databases ... Caused by the global search implementation ... The implementation could be combined by the implementation of the refactoring and renaming of the operators', 'ysg', '2018-11-07 10:47:42', '2018-11-07 10:47:42', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5152f4a-f390-47ba-b9e3-c6e3aceb221f', 181104184738, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'add minimalistic query route', 'The query route will query the db with a like cloud in all the varchar columns and return the similar type of listing format as the listing:
 - for url param correct passing to db rdr - ok 
 - tests for empty for , non-existent for - ok
 - add docs for all the test cases - ok 
 - add the srch result set count into the met key - ok
 - keep the same format as in the Select.pm - ok
 - leave room for page count and page size expandability', 'ysg', '2018-11-04 18:47:37', '2018-11-04 18:47:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('63b28417-595a-4b33-8b62-253264bc1255', 181111112753, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'default redirect on existing db route', 'add a default dummy redirect on any non specified route for an existing db, which will result into a blank search page , thus the user could start just searching ...', 'ysg', '2018-11-11 11:27:53', '2018-11-11 11:27:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0151024d-acca-4557-a6ea-9b7f6fbe07e8', 180818112727, NULL, NULL, 'task', 7, 'bug', '09-done', 5, 'clear display on error "table does not exist"', 'On "table does not exist" error the page-sizer and the pager vue code is shown ... 

Nothing should be displayed - not even the quick search , but only the error message', 'ysg', '2018-08-18 11:20:42', '2018-08-18 11:20:42', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7f783700-ec34-47f6-b9e4-0633acf2eb9c', 181114095309, NULL, NULL, 'task', 9, 'feature', '09-done', 9, 'reduce the size of the font in the id col', 'and dimm the color as well, because the 18 is simply annoying ... it''s only function should be to make the uneducated user check what the heck is that and get it that this is an id to be used to identify the current row ... ', 'ysg', '2018-11-14 09:38:09', '2018-11-14 09:38:09', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f859746b-e3e8-431e-a4c6-1537375f8c19', 180920102952, NULL, NULL, 'task', 9, 'feature', '09-done', 8, 'add the capability of displaying warnings at the bottom right of the page', 'Implement the warning with the no data for search case ... 
Whenever the System, "considers" an erroneous request it should provide a better answer by argumenting  itself via a warning at the bottom right of the page. 

For example: 
The user has requested page <<great-page-number>> which does not contain any data ... The system should present the warning that the page <<great-page-number>> does not contain any data, displaying the page number 1 warning msg.', 'ysg', '2018-09-20 10:14:54', '2018-09-20 10:14:54', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5c2c4c48-8ac7-48d3-ac65-a81e6d99d54e', 180927110017, NULL, NULL, 'task', 9, 'bug', '09-done', 5, 'null string on update', 'when a cell if left blank the null string appears on update.
This one breaks heavily the 181011195040 bug !!!', 'ysg', '2018-09-27 11:00:17', '2018-09-27 11:00:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ea747922-8e1b-49de-a557-8a7399f2e332', 181112093225, NULL, NULL, 'task', 9, 'release', '09-done', 9, 'release v0.5.4', 'As usually : 
 - docs in-line with existing features - ok
 - complete set of integration tests with the new features - ok
 - code deployment from PRD branch - ok
 - conf application from cnf repo - fail
 - data load from local env - ok', 'ysg', '2018-11-12 09:32:25', '2018-11-12 09:32:25', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('161b3f6d-c85c-4193-93a4-47842df5d46d', 181112143422, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'hide the result table in the list on error', 'via the global-msg handling
A lot of refactoring ... probably needs some time to chew off ... ', 'ysg', '2018-11-12 14:34:16', '2018-11-12 14:34:16', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('57c8162e-45f1-43a4-9624-3e9b54d5bc4b', 181114223553, NULL, NULL, 'task', 9, 'refactor', '09-done', 9, 'implement orthodox front-end to back-end control flow in list-grid', 'As follows: 
 - data is fetched vai a data method
 - both the error and the reponse are returned to the ui method
 - the ui investigages the reponse.status and controls what is shown', 'ysg', '2018-11-14 22:35:53', '2018-11-14 22:35:53', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('29692580-d97e-4d1c-b423-678aa9e4ab82', 181123155157, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'default hide columns per table', 'Add the list of default pick columns into the meta_columns table
 - the user specified hide=<<cols-list>> overrides the default ones in the meta_colums
 - change the linkable to pick the whole table - bonus feature !!!
 - the user specified pick=<<cols-list>> overrides the meta_columns default ones
', 'ysg', '2018-11-23 15:40:31', '2018-11-23 15:40:31', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aa446edc-9975-45d3-9131-230c59a630e5', 181125114720, NULL, NULL, 'task', 9, 'code', '09-done', 9, 'change the global search result links to bare item-name ones', 'That is remove the pick=col,col2 ', 'ysg', '2018-11-25 11:47:21', '2018-11-25 11:47:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('425faf71-8403-41c3-b367-035a3b39d58b', 181125113127, NULL, NULL, 'task', 9, 'code', '09-done', 9, 'add the select-meta rote', 'the select-meta route returns the meta data of all tables , while the select-meta/:item gets ONLY the meta data of that particular table', 'ysg', '2018-11-25 11:31:27', '2018-11-25 11:31:27', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('390d76ec-2b03-4c47-8d6d-7ebbada4cab5', 181126075447, NULL, NULL, 'task', 9, 'bug', '09-done', 9, 'double column in listing due if skip_in_list is set to false', 'The meta_columns should have unique index for the table_name and the column_name combination', 'ysg', '2018-11-26 07:54:47', '2018-11-26 07:54:47', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a9bf5e63-980b-4eae-bd0e-a49516ee5cfc', 181126151241, NULL, NULL, 'code-task', 9, 'bug', '09-done', 5, 'update fail case in list-as-grid hides erroneously the grid & controls', 'caused by the "hide grid on warning" feature
the update fail use case in list hides the grid when it should not', 'ysg', '2018-11-26 14:56:49', '2018-11-26 14:56:49', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a114ae08-3bf0-4c17-b013-c7a324ab5350', 181123162900, NULL, NULL, 'task', 9, 'docs', '09-done', 9, 'update the ReadMe file ', ' - ok for update in master straight as it is easier
 - todo update in ReadMe xls', 'ysg', '2018-11-23 16:17:35', '2018-11-23 16:17:35', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32a6e81e-a203-4c60-8010-8b123661fda8', 181126133211, NULL, NULL, 'code-task', 9, 'feature', '09-done', 6, 'add the export as xls web action', 'This feature was fast-tracked, because of the real need from work ... 

should be accessible from the following type of syntax:
http://192.168.56.120:3001/dev_issue_tracker/export/monthly_issues?as=xls&page-num=1&page-size=7

Should be able to generate exactly the same result sets as the list in order to be able to support the benchmarking data collection and presentation ... 
', 'ysg', '2018-11-26 13:16:15', '2018-11-26 13:16:15', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6550ea01-532d-498b-8926-dc1c45f37823', 1806062254, 1, 5, 'feature', 9, 'setup', '09-done', 9, 'add the create-table-backups shell action', 'Disgard - could use the json-to-db shell action to achieve the same , or quick pgsql one-liner ad-hoc ... 
Which would dump every table''s data into the daily dir and NOT the dat dir of the product instance dir ... 
Might be timely ONLY after the edit action is started for the implementation ...', 'ysg', '2018-06-08 21:00:00', '2018-06-25 22:30:00', 3.00, 0.10, 'setup', '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('67a22bed-5162-44d2-adc1-77b19a7104b8', 181126163229, NULL, NULL, 'task', 9, 'feature', '09-done', 5, 'add the width meta_columns attribute', 'and set to null ... because it will be much easier to set the default width of the textareas in the grid by specifying the sizes in the meta_columns table

-- almost there ...', 'ysg', '2018-11-26 16:32:29', '2018-11-26 16:32:29', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5d48d63a-89f4-44c5-a2c1-bbd750b3ceb6', 181128140452, NULL, NULL, 'code-task', 9, 'bug', '09-done', 5, 'add new fails on filtered list with the "with operator"', 'Probably related to the regex missing values with - or taking into account only single dashes and not multiple ... ', 'ysg', '2018-11-28 13:53:13', '2018-11-28 13:53:13', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('698d2c81-8ee2-42ef-877d-c1b4a97c6ed6', 181128171353, NULL, NULL, 'code-task', 9, 'feature', '09-done', 9, 'create the naming_conventions table', 'Fasttracked - with 5min execution time ... 
to store well the naming conventions ... ', 'ysg', '2018-11-28 17:01:37', '2018-11-28 17:01:37', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aa590a02-6576-4640-b3e4-b137e03ac426', 181127215257, NULL, NULL, 'code-task', 9, 'feature', '09-done', 9, 'add a stop_time-start_time diff trigger', 'A fast track issue - to be able to calculate the benchmarks ... 
add a postgres trigger to calculate the diff between stop_time - start_time', 'ysg', '2018-11-27 21:52:05', '2018-11-27 21:52:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('64eb9126-e643-4945-b3b4-93b14672777f', 181129074105, NULL, NULL, 'code-task', 9, 'bug', '09-done', 9, 'numbers are not replaced properly in the add new event in the url', NULL, 'ysg', '2018-11-29 07:41:05', '2018-11-29 07:41:05', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4eded046-53d4-4a53-ad63-550f777bbc72', 181102121443, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'try to speed-up the woff2 font usage', 'Was not faster ... stored the attempt into the following branch : 

Speed up the woff2 font usage by : 
https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/webfont-optimization

https://stackoverflow.com/a/37271195/65706
', 'ysg', '2018-11-02 12:02:56', '2018-11-02 12:02:56', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8e0a8c6e-e254-48a9-8617-cacc1807d878', 181023100621, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'implement global meta_columns model', 'Too fuzzy definition ...
Change the tables listing to arrive from the meta_tables table. For each table: 
 - there might 1..* columns with interpolation patterns
 - there will be 1..1 interpolation pattern per column', 'ysg', '2018-10-23 10:06:21', '2018-10-23 10:06:21', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65357b2e-7966-4097-9535-141ec5518c7d', 181113220139, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'omit non-existing columns with warning while picking non-existent column', 'This is against the best practices for back-end api''s ... 
Better to implement default set of columns to pick and always redirect to a table without the picks
When the url contains a column which does not exist while switching between pages :', 'ysg', '2018-11-13 22:01:39', '2018-11-13 22:01:39', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5f9ed1a7-87df-4758-b1c3-24408375af2a', 181024092334, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'add cols_pick_list attribute in the meta_columns table', 'The cols_pick_list which will be setable for each attribute IN THE ORDER of preference based on the  seq attribute in the meta_columns order should: 
 - contain the pick lists for the columns of this table in the order above
 - if left empty all the columns in the attribute order should be used', 'ysg', '2018-10-24 09:23:34', '2018-10-24 09:23:34', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f54c4e12-5d7a-4af4-baab-1306132127ff', 181123154943, NULL, NULL, 'task', 9, 'refactor', '04-diss', 9, 'implement one JS best practice', 'pick the most newbie implementation currently in code going against the JS best practice AND implement it:
https://www.w3.org/wiki/JavaScript_best_practices
Keep DOM access to a minimum
Accessing the DOM in browsers is an expensive thing to do. The DOM is a very complex API and rendering in browsers can take up a lot of time. You can see this when running complex web applications when your computer is already maxed out with other work — changes take longer or get shown half way through and so on.

To make sure that your code is fast and doesn’t slow down the browser to a halt try to keep DOM access to a bare minimum. Instead of constantly creating and applying elements, have a tool function that turns a string into DOM elements and call this function at the end of your generation process to disturb the browser rendering once rather than continually.', 'ysg', '2018-11-23 15:38:17', '2018-11-23 15:38:17', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5c9d52d-fad8-431a-8ca5-177202a63748', 181114081113, NULL, NULL, 'task', 9, 'feature', '04-diss', 9, 'preserve url in add-new by ordering only in select by id', 'could the add new only fetch the data ordered by id, but preserve the url ?!
And achieve that without an redirect - that is remove the annoying flashing of the table ... ', 'ysg', '2018-11-14 08:07:45', '2018-11-14 08:07:45', NULL, NULL, NULL, '2018-12-06 12:49:11');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('53a196e1-cb9b-4e93-9cc7-00a91173c549', 181204162246, NULL, NULL, 'task', 9, 'failure', '09-done', 9, 'resolve the cannot connect to db issue', 'due to inproperly running globally chmod command: 
/var/lib/postgresql/9.6/main

# check the log file for errors
tail /var/log/postgresql/postgresql-9.6-main.log
# set the proper conditions
sudo chmod 0700 /var/lib/postgresql/9.6/main
# restart the server 
sudo /etc/init.d/postgresql restart', 'ysg', '2018-12-04 16:22:46', '2018-12-04 16:22:46', NULL, NULL, NULL, '2018-12-25 21:03:18');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f03e0d83-f1ba-4ca2-9c4b-3a4ee570dff5', 1806081610, 1, 10, 'poc-feature', 5, 'feature', '04-diss', 9, 'add omnibox poc page with web service for projects search', '2018-11-11 11:55:24 : change of intentions ... and expression  - the search page is actually this one... 
add omnibox poc page with web service for projects search. The end goal should be pop-up omnibox which will present the results on enter lepton like...', 'ysg', '2018-08-01 00:00:00', '2018-08-31 00:00:00', 3.00, 2.50, NULL, '2018-12-25 21:11:27');
INSERT INTO public.yearly_issues_2018 (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('162fd56d-ff0d-4171-ba3e-a0e8bce60b1c', 1806281640, 1, 10, 'task', 7, 'feature', '04-diss', 9, 'add pages minification on deployment', 'The pages should be always minified ... Chrome has the feature to format minified content
Pages must be minified as 1/3 of the data is white space …', 'ysg', '2018-10-01 00:00:00', '2018-12-30 00:00:00', 20.00, 1.00, 'setup', '2018-12-25 21:11:30');


--
-- PostgreSQL database dump complete
--

