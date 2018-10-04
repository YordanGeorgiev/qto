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
-- Data for Name: check_lists; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('ee4b8303-435f-467e-8b28-fab1175805df', 180801162744, 1, 5, '02-todo', 'before-merge-into-develop', 'The feature or functionality current description is added in the Features doc', 'The feature or functionality current description is added in the Features and Functionalities document. ', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('472418b5-5d46-4d4b-b29e-f650220d5027', 180801162753, 7, 5, '02-todo', 'before-merge-into-develop', 'Deployment to the test environment', 'Deploy to the test environment as follows:', '2018-09-26 22:22:19');
INSERT INTO public.check_lists (guid, id, seq, prio, status, category, name, description, update_time) VALUES ('c03526e5-75e9-4485-9a3c-f1db28eb490c', 180801162754, 8, 5, '02-todo', 'before-merge-into-develop', 'Check that all the files in the deployment package are the same as those in the latest commit of the dev git branch. ', 'Deploy to the test environment as follows:', '2018-09-26 22:22:19');
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
-- Data for Name: confs; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('cee8a395-e4e5-41a7-9c1f-9600cb633890', 1806011296, 1, 5, 'postgres-tables', 'principles', 'principles', 'principles', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('31839256-9b52-423c-af36-99e80f99daf1', 1806011295, 1, 5, 'postgres-tables', 'daily_issues', 'daily_issues', 'daily_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('2b4c2745-3bba-42d4-a953-5dc3636732d9', 1806011294, 1, 5, 'postgres-tables', 'problems', 'problems', 'problems', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('674d5b4a-c68f-4502-beee-e1bae81abfb9', 1806011293, 1, 5, 'postgres-tables', 'yearly_issues', 'yearly_issues', 'yearly_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('44e73ab8-856b-4ca6-8ecb-136acd000325', 1806011292, 1, 5, 'postgres-tables', 'monthly_issues', 'monthly_issues', 'monthly_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('4367351a-b443-4104-a9cf-c2f8f011a7d5', 1806011304, 1, 5, 'postgres-tables', 'quinquennially_issues', 'quinquennially_issues', 'quinquennially_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('888d4a1c-ed1d-404b-b6ad-20914ac93826', 1806011303, 1, 5, 'postgres-tables', 'confs', 'confs', 'confs', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('1f3fc9ed-e46f-413c-8a96-fd9b8528d36c', 1806011302, 1, 5, 'postgres-tables', 'weekly_issues', 'weekly_issues', 'weekly_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('1862dbf7-840d-4da2-a440-1cb81ddf733e', 1806011301, 1, 5, 'postgres-tables', 'purchases', 'purchases', 'purchases', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('f0bd0a8d-d9b1-4ac2-ab19-91a1117d277d', 1806011300, 1, 5, 'postgres-tables', 'ideas', 'ideas', 'ideas', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('6a6eccf6-af4a-448d-a76a-76c245dc4688', 1806011299, 1, 5, 'postgres-tables', 'tst_paging', 'tst_paging', 'tst_paging', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('effd5e55-6c10-4b8e-885f-32c310ecbcb5', 1806011298, 1, 5, 'postgres-tables', 'decadally_issues', 'decadally_issues', 'decadally_issues', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('5a713f2f-f804-4ed2-9815-ac5a61f2830a', 1806011297, 1, 5, 'postgres-tables', 'procurement_items', 'procurement_items', 'procurement_items', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.confs (guid, id, seq, prio, category, name, value, description, owner, update_time) VALUES ('6d92dd42-b504-40bf-8d20-804fb33b7c78', 1806011305, 1, 1, 'postgres-tables', 'questions', 'questions', 'questions', 'ysg', '2018-09-26 22:25:38');


--
-- Data for Name: daily_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.daily_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('698320a1-7b6f-47c7-a44e-19218ba2bab5', 181002103341, NULL, NULL, 1, 9, '02-todo', 'bug', 'dropdown keyboard navigation', 'the scroll down to the search-box dropdown does not work with the keyboard', 'task', 'unknown', '2018-10-02 10:15:57', '2018-10-02 10:15:57', NULL, NULL, NULL, '2018-10-02 10:18:33');


--
-- Data for Name: decadally_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.decadally_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a276d737-5a69-4897-912e-4a8877b67ca7', 180817105624, NULL, NULL, 1, 9, '03-act', 'georgi', 'up-and-running aws instance', 'up-and-running aws instance', 'task', 'unknown', '2018-07-15 00:00:00', '2020-01-01 00:00:00', NULL, NULL, NULL, '2018-08-30 14:18:54');


--
-- Data for Name: ideas; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time) VALUES ('178dacc9-e922-4603-8346-88d36962b5e2', 180724175434, 10, 5, '01-eval', 'create the Promoters Guide', 'The Promoters Guide should be a document, which guides the way of promoting the issue-tracker application', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time) VALUES ('81f1cfed-651a-417c-ba1f-f5bcb65adb6b', 180724180934, 10, 5, '02-todo', 'add default values for all the tables', 'Otherwise the inserts will fail ... The idea is to be able to :', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time) VALUES ('bd1664b2-619c-4916-bdb2-51f65c5222c8', 180724175934, 10, 5, '01-eval', 'define the roles in the application', 'Define the roles of the application, first on the UserStories level, than in the ArchitectureGuide', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time) VALUES ('622e776e-df75-4a54-822a-9d8e372a426e', 180724180734, 10, 1, '02-todo', 'try the page life cycle', 'The page life cycle must be figured out so that:- a single method for the AJAX call 
- the insert should insert with the default values', 'ysg', '2018-09-26 22:06:27');
INSERT INTO public.ideas (guid, id, seq, prio, status, name, description, owner, update_time) VALUES ('a667692e-81ec-40cf-9304-de2dd3ad3327', 180519211901, 10, 5, '02-todo', 'why the README.md does not get updated ...', 'add configuration table for the master-app db so that by editing it once could later on spown new app dbs from this one ...', 'ysg', '2018-09-26 22:07:21');


--
-- Data for Name: monthly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b293825f-8152-49e8-9ef2-bbf084ee3bd4', 180920104140, NULL, NULL, 5, 9, '02-todo', 'feature', 'add the json backup to the increase-date action', 'The "increase-date" action should take a json backup as well ... 
Because it will provide a double daily backup of the data', 'task', 'unknown', '2018-09-20 10:26:43', '2018-09-20 10:26:43', NULL, NULL, NULL, '2018-09-25 10:13:09');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('47110ae8-3166-4e52-9caa-153f4d92ac0a', 180925152741, NULL, NULL, 5, 9, '01-eval', 'feature-ui', 'universal item search', 'Scenario: 
the user types any text without operators in the search box 
The System
- redirects to an url with removed search url params
- uses a new txt-srch='' the actual query'' 
-  builds a dynamic search with all the text attributes of the CURRENT item 
- lists the table', 'task', 'unknown', '2018-09-25 15:26:59', '2018-09-25 15:26:59', NULL, NULL, NULL, '2018-10-03 12:48:38');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2bfa5d36-40e8-4e7f-8be6-0fc8a0ff2772', 180914111431, NULL, NULL, 5, 9, '03-flow', 'bug-feature', 'stuck morbo server', 'Whenever the morbo server is stuck, one has to kill manually the instances of the perl as the socket is occuped ...
To be resolved as soon as it occurs', 'task', 'unknown', '2018-09-14 10:59:37', '2018-09-14 10:59:37', NULL, NULL, NULL, '2018-10-01 15:18:46');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d703d532-267d-429f-9075-a6a8be824a9d', 180926113604, NULL, NULL, 4, 9, '02-todo', 'docs', 'add the ReleaseNotes document', 'The ReleaseNotes should contain all the releases with the following info per release:
 - release intro 
 - performance and stability (refactoring)
 - api changes - changes of behaviours
 - known issues', 'task', 'unknown', '2018-09-26 11:26:44', '2018-09-26 11:26:44', NULL, NULL, NULL, '2018-10-03 12:45:51');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f2d724ea-b257-45a5-be07-fed8fd8087d8', 181001221108, NULL, NULL, 5, 9, '09-done', 'testing', 'install and setup the the chrome-driver', 'Install and setup the chrome-driver and run the most simple example:
https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/', 'task', 'unknown', '2018-10-01 22:10:58', '2018-10-01 22:10:58', NULL, NULL, NULL, '2018-10-03 12:48:36');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('780168d7-405e-4883-b6e0-7b355e162752', 180919115859, NULL, NULL, 5, 9, '03-wip', 'bug', 'the back-end select action does not return properly on wrong sql syntax error', 'When the query generated has wrong sql syntax : 
for example: 
l 
that is both the oa and od url params are available ... 
"unknown error" is shown ... while a more descriptive error with the sql syntax should be shown ...', 'task', 'unknown', '2018-09-19 11:58:55', '2018-09-19 11:58:55', NULL, NULL, NULL, '2018-10-01 15:18:54');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('324755df-a7aa-4e2c-a3d9-5da4aa20ee2c', 180925230044, NULL, NULL, 6, 8, '02-todo', 'docs', 'functional requirements update', 'Update the functional requirements: 
 - what is the maximum amount of rows per table which should be supported
 - how-many users at once should be supported', 'task', 'unknown', '2018-09-25 23:00:45', '2018-09-25 23:00:45', NULL, NULL, NULL, '2018-10-01 15:20:42');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('87fbf6d7-2ec7-4767-bcdd-eeefc433eb05', 180815133836, 1, NULL, 6, 9, '01-eval', 'feature', 'improve load testing for the select web action _', 'add load testing for the select web action

Perform asyncrously requests to examine the amount of asyncrounous calls the application "breaks"', 'task', 'unknown', '2018-08-15 13:38:36', '2018-08-15 13:38:36', NULL, NULL, NULL, '2018-10-03 12:48:46');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34072102-26e1-4995-8aab-496c0cbdc363', 180926103938, NULL, NULL, 6, 9, '02-todo', 'docs', 'update way of working section', 'Update the System Guide with the way of working section: 
 - requirements should have explicitly written deadline', 'task', 'unknown', '2018-09-26 10:39:38', '2018-09-26 10:39:38', NULL, NULL, NULL, '2018-10-03 12:48:48');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12f6689a-fa8e-4024-a693-9d1e5cd5dffc', 180517213501, 1, NULL, 5, 2, '02-todo', 'feature', 'implement client-side testing', 'or should there be simply redirect ... 

The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown', 'goal', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-09-27 10:02:35');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('665f009d-3b27-4e70-ac00-f77b716fb3d4', 180921091603, NULL, NULL, 6, 9, '01-eval', 'feature', 'add icon for the page-sizer', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'task', 'unknown', '2018-09-21 09:15:59', '2018-09-21 09:15:59', NULL, NULL, NULL, '2018-10-02 10:21:44');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('43929f18-b1d1-43ee-921d-13f49133a291', 180921091752, NULL, NULL, 9, 9, '01-eval', 'feature-ui', 'add icon for the pager', 'The pager on the top is kind of strange - new users would know what is it all about ...

https://www.storyblocks.com/stock-image/page-pdf-glyph-icon-bdigvdpe7uzj6gmsu0c', 'task', 'unknown', '2018-09-21 09:17:48', '2018-09-21 09:17:48', NULL, NULL, NULL, '2018-10-03 12:49:19');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('480930f1-e28b-408b-b2bf-3754b3000792', 180926224041, NULL, NULL, 5, 5, '02-todo', 'bug', 'on unexistent columns hide , met should be 0°', 'In the following url the met should be 0 , but is null: 

http://192.168.56.120:3001/dev_issue_tracker/select/monthly_issues?pick=name,description,prio&hide=guid,prio,non_existent_column', 'task', 'unknown', '2018-09-26 22:40:37', '2018-09-26 22:40:37', NULL, NULL, NULL, '2018-10-03 12:45:48');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cac69e18-0777-4adf-a7fd-c485fa364d21', 180921085537, NULL, NULL, 4, 9, '01-eval', 'feature', 'add asyncrounous load of the select columns', 'The use case should be as follows:
 - the user requests the page
 - the System loads the list of dbs and tables on page load
 - WHEN the user types the :pick or :select operator 
 - the system loads the lists of the current item attributes and displays it into the autocomplete', 'task', 'unknown', '2018-09-21 08:55:32', '2018-09-21 08:55:32', NULL, NULL, NULL, '2018-10-02 10:21:49');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2a515908-c7b2-4fcc-894b-4c34ff1dfc27', 180921152541, NULL, NULL, 5, 9, '01-eval', 'functionality', 'add the back-end action for select table columns', 'This has been done - aka this issue is duplicate: 


Prerequisite for the :pick operator in the search-box:
180921085537



http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,weight,name,description&page-size=5&page-num=1&oa=prio&with=id-eq-180921085537', 'task', 'unknown', '2018-09-21 15:25:39', '2018-09-21 15:25:39', NULL, NULL, NULL, '2018-10-02 10:21:39');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f859746b-e3e8-431e-a4c6-1537375f8c19', 180920102952, NULL, NULL, 3, 9, '02-todo', 'feature', 'add the capability of displaying warnings at the bottom right of the page', 'Whenever the System, "considers" an erroneus request it should provide a better answer by argumenting itself via a warning at the bottom right of the page. For example: 
The user has requested page <<great-page-number>> which does not contain any data ... The system should present the warning that the page <<great-page-number>> does not contain any data, displaying the page number 1 warning msg.', 'task', 'unknown', '2018-09-20 10:14:54', '2018-09-20 10:14:54', NULL, NULL, NULL, '2018-10-01 15:17:36');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a234ead-76ed-4dfc-9768-0dc5ddb12ae6', 180925220009, NULL, NULL, 4, 9, '02-todo', 'docs', 'add login sequence diagram', 'Create and store for future maintenance a login authentication sequence diagram', 'task', 'unknown', '2018-09-25 22:00:07', '2018-09-25 22:00:07', NULL, NULL, NULL, '2018-10-01 15:18:44');
INSERT INTO public.monthly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0be434f5-1066-43dd-be7e-053de08c5447', 1806060841, 1, 6, 1, 6, '02-todo', 'testing', 'poc for client side testing for all the client side functionalities', 'Evaluate:
- pure selenium 
- https://github.com/jhthorsen/test-mojo-role-selenium
poc for client side testing for all the client side functionalities

Might be too time-consuming', 'feature', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 10.00, 7.00, 'feature', '2018-10-01 21:24:26');


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
INSERT INTO public.principles (guid, id, prio, weight, category, name, description, update_time, tags) VALUES ('195ab7a5-22a1-4ffb-85ea-da5797ba6b09', 180927105742, 1, 1, 'ui', 'The rule of 7 in UI', 'Humans usually do not grasp more than 7 items on a page', '2018-09-27 11:00:03', NULL);


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('00458856-b96f-4d4b-a325-ec31844c64aa', 1806102335, 1, 2, 5, 5, '02-todo', 'setup', 'npm modules', 'the installed with npm installed modules are not transfered in the', 'One of those ?! : 
 - npm install commands in the product instance install shell call ...', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('e6f23d12-1430-4165-89bb-fbda9ad8a2f0', 1805010100, 1, 2, 9, 9, '09-done', 'testing', 'how-to describe the unit tests texts', 'The test names and descriptions should be part of the application content, linked to the requirements and userstories. ', 'Do not describe tests at all - tests are code and they should remain code , but do describe features and functionalities with guids. ', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('23b855ea-b061-454a-b98e-7eef11380cd8', 1805172131, 1, 1, 3, 7, '03-act', 'testing', 'the long term goals are quite ambitions compared to the allocated time', 'The scope of the application in terms of features is enourmous compared to the available allocated time ...', 'Try:
- work smarter, not harder
- attract more developers, by opennes and userfriendliness', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('65c22915-6d1f-4513-9c0d-9a977c2226a5', 1805181956, 1, 1, 3, 7, '03-wip', 'testing', 'complexity is building up ...', 'The more complexity is added to the system the more regression bugs occur:', 'More :
 - end-to-end testing
 - client side JS testing', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('72219045-040c-42c9-8cbe-689ada2f58e2', 1805171359, 1, 1, 4, 5, '03-act', 'performance', 'how-to implement minification ?!', 'A lot of data is lost when the code is not minified - this is also a potential financial cost ...', 'Some kind of Mojo::Plugin ?! Or external plugin ...', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('92ab00e9-f521-434b-a885-3dcf06439fe6', 1805312200, 1, 2, 2, 8, '02-todo', 'architecture', 'too much msgs floating around', 'the amount of messages becomes overwellming , one cannot be able to manage them from a central location', '- keep the ( ret , msg , whatever , else ) in list context call order ... it just works ... - keep using the msg var for a msg , but what if there are other msgs ...  some kind of hash with message return code ? CallStatus type of object ?!', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('9e51fbb3-e1ba-4ca1-8ef7-54522095fcd4', 1807031157, 1, 2, 5, 5, '03-act', 'architecture', 'documentation overbloat', 'The amount of the documentation becomes huge :
 - time consuming to keep up-to-date
 - who is going to read that ?!', 'Activate on those:
- split into smaller documents
- remove content which is developer oriented - they should know how-to check from the src code', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('abc77ce6-2b59-46e7-b404-8d28003bee72', 1805070100, 1, 2, 7, 5, '06-onhold', 'architecture', 'the xls is crashing all the time', 'Ain''t crashing so often when ran straight from the mac … 
use it as less as possible. Recreate it from scratch by copying only the data. 
And data is lost when the vm is put into sleep mode … ', 'Activate on those:- run on mac- install the phppgadmi
 - create web json update and insert ui
 - enable db-to-json - json-do-db
 - php-admin ?!', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('b6925e6d-90c1-497e-9e12-e1dbc824c4af', 1706010100, 1, 1, 5, 5, '02-todo', 'testing', 'unit controls testing', 'how-to unit test ui controls', 'Install Joe Bergers chrome', 'ysg', '2018-08-06 18:23:47');
INSERT INTO public.problems (guid, id, level, seq, prio, weight, status, category, name, description, solution_proposal, owner, update_time) VALUES ('c54b25e1-b80e-457c-ba31-98fae149fa64', 1804010100, 1, 2, 5, 5, '06-onhold', 'architecture', 'full stack architecture definition', 'Probably obsoleteGaps in the skills to define the full-stack architecture ...', 'Activate on those:
 - end-to-end testability', 'ysg', '2018-08-06 18:23:47');


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('29f6a55a-2872-4760-89b5-38ebb9890fff', 1806130914, 1, 1, 1, 9, '09-done', 'ui-vue', 'how-to get a dynamic string into attribute with vue to generate the paging urls', 'The paging utilizes as much as possible simplified html pager, which should get the dynamic urls from the vue app methods.', 'ysg', '2018-08-12 14:37:45');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('b1719a77-4533-4ac9-b036-557c269625b5', 1805070101, 1, 1, 2, 8, '02-todo', 'data-etl', 'how-to copy autogenerated data', 'we know how-to copy the non-autogenerated data from src db to another , yet has to copy it with the autogenerated uuid''s', 'ysg', '2018-08-12 14:37:27');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('fddb9c58-c70e-4b4d-94e5-ce4ff3bfa2da', 1808010101, 1, 1, 1, 9, '02-todo', 'issuee-tracker', 'should the data be fetched from the server on cell update in the list-as-etable page', 'Because the sorting does not work', 'ysg', '2018-08-12 16:22:34');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('333ee90d-0dbe-43c1-8b34-f6d5d2c11367', 1805020101, 1, 1, 1, 9, '02-todo', 'issuee-tracker', 'how-to copy autogenerated data', 'we know how-to copy the non-autogenerated data from src db to another , yet has to copy it with the autogenerated uuid''s', 'ysg', '2018-08-07 08:34:53');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('8afc5b28-21b7-4228-a83a-44dfefbe90c8', 180807084003, NULL, NULL, 2, 9, '02-todo', 'ui-concept', 'how-to populate a hidden modal dialog with data from the back-end on-click', 'According to the following scenario :

 - list items 
 - click on edit item on the left 
 - the system fetches the data by the id of the row AFTER the click
 - the system shows the modal dialog with the form filled with the fetched data', NULL, '2018-08-12 14:36:57');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('e65e582b-a0ac-4b0d-9558-8cb1401137f5', 1806011127, 1, 1, 3, 8, '06-onhold', 'data-etl-fullstack', 'how-to copy efficiently items rows froom one project to another', 'the copy of items data from one project to another includes the copying via ui ( google sheet , xls )', 'ysg', '2018-08-12 14:37:34');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('1af39311-d9c4-4acd-b20c-7473b3175cb9', 180812143532, NULL, NULL, 4, 9, '02-todo', 'fullstack', 'why back-end fetch is needed in deleteItem', 'why on the delete item one must fetch the data from the back-end and only client-side it does not work ?!', NULL, '2018-09-01 19:01:11');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('a4b2fe97-db4d-4a71-8128-3e0111d959ef', 180901190013, NULL, NULL, 1, 9, '01-eval', 'ui', 'client-side changes to browser url', 'how-to learn to update the url params as soon as someone does stuff client-side on the browser without page refresh', NULL, '2018-09-01 19:01:04');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('009c4b63-191d-4da2-9eee-b1e49754a057', 180807091915, NULL, NULL, 5, 9, '02-todo', 'ui', 'how-to implement minification', 'A lot of data is lost over the wite as white space as minification has not yet been implemented', NULL, '2018-09-01 19:01:16');
INSERT INTO public.questions (guid, id, level, seq, prio, weight, status, category, name, description, owner, update_time) VALUES ('4eb51ad8-bd3f-4faf-96e5-d2938c735422', 180828103835, NULL, NULL, 1, 4, '01-eval', 'unknown', 'level attribute design for non-hierarchy items - non-hitems', 'should non hierarchy items have or not have defined level attribute', NULL, '2018-09-01 19:01:04');


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


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.skills (guid, id, seq, prio, name, description, update_time) VALUES ('1ee8e1ea-9f5a-44b8-a278-97627fe3d004', 180926181013, NULL, 1, 'a skill', 'a desc', '2018-09-26 22:24:42');


--
-- Data for Name: test_create_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_create_table (guid, id, name, description) VALUES ('5e586c62-8c06-4f62-bc69-b4efd54cf659', 20180106170815, 'type the name ...', 'type the description ...');


--
-- Data for Name: test_delete_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_delete_table (guid, id, seq, name, description) VALUES ('9b7c0775-f995-4d0f-8e36-cd355df3e429', 1, 1, 'name-1', 'the name should be deleted to deleted-name-1');
INSERT INTO public.test_delete_table (guid, id, seq, name, description) VALUES ('a4e0be75-6db5-409e-b639-b959ad2a5d5e', 2, 2, 'name-2', 'the name attr should NOT be deleted');
INSERT INTO public.test_delete_table (guid, id, seq, name, description) VALUES ('6200405c-46d4-4c8f-bb5e-393b478ab1d7', 3, 3, 'name-3', 'the name attr should be deleted to deleted-name-3');


--
-- Data for Name: test_hierarchy_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('d594380e-728f-4c9f-b52f-4f9180d45fe6', 1, NULL, 1, 1, 2, 'the title', 'This is the root element of the document - all other ');
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('7854e508-9050-4b88-9299-776301a17f6f', 2, NULL, 2, 1, 2, '1.0 name ', 'The first title');
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('ab633562-f9ab-4d0c-92a8-5b60f70a900a', 3, NULL, 3, 1, 2, '2.0 name ', 'The second title');
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('c3aad988-f7cf-4a70-91f5-8ad06ab34b46', 4, NULL, 4, 1, 2, '2.1 name ', 'Second level');
INSERT INTO public.test_hierarchy_table (guid, id, level, seq, lft, rgt, name, description) VALUES ('23fc1d95-e320-49e9-af86-e00077192b12', 5, NULL, 4, 1, 2, '3.0 name ', 'Second level Thid title');


--
-- Data for Name: test_update_table; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('3107dde8-474e-446f-9a2b-75de1863da8d', 1, 1, 'name-1', 'the name should be updated to updated-name-1');
INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('5d72576c-a19f-4db8-a79e-57b750488fd4', 2, 2, 'name-2', 'the name attr should NOT be updated');
INSERT INTO public.test_update_table (guid, id, seq, name, description) VALUES ('ad431120-84d6-4365-ae84-ed43b0245947', 3, 3, 'name-3', 'the name attr should be updated to updated-name-3');


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
-- Data for Name: weekly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e8f0a841-f199-45d8-a47a-8cd275e6c634', 180925092952, NULL, NULL, 5, 9, '03-act', 'bug', 'content-editable update duplicates values on sorted column', 'When the currently sorted column is updated and the grid should redrow based on the new updated value the content editable updates both the same cell which WAS the one to be updated And the correct one which is after the sort', 'task', 'unknown', '2018-09-25 09:29:52', '2018-09-25 09:29:52', NULL, NULL, NULL, '2018-10-03 12:51:05');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7da90c90-7b9e-42c6-9915-4959f359c195', 181001102952, NULL, NULL, 9, 9, '09-done', 'bug', 'fix pager broken for 2 pages', 'If there are 2 pages the pager is broken

The SELECT does not report the number of pages correctly : 
Check : 
http://192.168.56.120:3001/dev_issue_tracker/select/weekly_issues?as=grid&pick=id,category,prio,status,name,weight,description&od=id&page-size=15&page-num=1', 'task', 'unknown', '2018-10-01 10:11:57', '2018-10-01 10:11:57', NULL, NULL, NULL, '2018-10-04 15:44:29');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2a52cd-c4b9-4248-8665-9dc0df6e9f63', 180803093321, 1, 10, 5, 3, '03-act', 'feature', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'task', 'ysg', '2018-09-01 12:00:00', '2018-09-30 12:00:00', 10.00, 0.10, 'setup,feature', '2018-10-03 12:51:05');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d1831d21-c0f0-428e-aee3-c7346e82e3f2', 1805172135, 1, 10, 4, 9, '06-onhold', 'feature', 'client-side UI automation testing for JS events', 'By using the Mojo::Chrome module:
Should be able to capture JS events:
Vue induced changes on the page.', 'goal', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-10-04 14:51:21');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5145e9f7-dcab-4570-a731-5139ea5eb366', 180927085853, NULL, NULL, 5, 5, '03-flow', 'bug', 'the create new works only on the second click', 'The new redirect has evoked the bug ...
But ONLY in some conditions ?!
Hard to reproduce', 'task', 'unknown', '2018-09-27 08:58:53', '2018-09-27 08:58:53', NULL, NULL, NULL, '2018-10-04 14:52:10');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5c2c4c48-8ac7-48d3-ac65-a81e6d99d54e', 180927110017, NULL, NULL, 4, 9, '06-onhold', 'bug', 'when a cell if left blank the null string appears on update', 'when a cell if left blank the null string appears on update', 'task', 'unknown', '2018-09-27 11:00:17', '2018-09-27 11:00:17', NULL, NULL, NULL, '2018-10-04 15:45:00');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('002f5f34-e217-4242-a02c-39f5cf363b30', 181004145228, NULL, NULL, 1, 9, '03-wip', 'bug', 'test null', NULL, 'task', 'unknown', '2018-10-04 14:52:28', '2018-10-04 14:52:28', NULL, NULL, NULL, '2018-10-04 15:45:02');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2220ffb6-88dd-4882-b7e6-c607873e64a3', 181004135232, NULL, NULL, 6, 9, '09-done', 'setup', 'poc for Selenium::Remote::Driver setup', 'Selenium::Remote::Driver setup and call via a simple script', 'task', 'unknown', '2018-10-04 13:52:32', '2018-10-04 13:52:32', NULL, NULL, NULL, '2018-10-04 13:55:09');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a83bebb-7e57-4955-a744-df64f8fec4f0', 1805301624, 1, 4, 9, 4, '03-flow', 'issue-tracker', 'fix bug for the issue_tracker.pl.log appearance in product instance dir', 'Occurs when one runs the "run-integration-tests" action', 'bug', 'ysg', '2018-05-29 20:53:00', '2018-06-30 00:00:00', 0.00, 0.10, 'bugs', '2018-10-04 15:44:24');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('efa98faa-af81-4bea-97dc-969b4c79e825', 181003124555, NULL, NULL, 3, 9, '02-todo', 'bug', 'html entities display', 'html entities shuch as greater than and less than chas cannot  be displayed as cell content in the list/item?as=grid page', 'task', 'unknown', '2018-10-03 12:45:55', '2018-10-03 12:45:55', NULL, NULL, NULL, '2018-10-04 14:48:42');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0b2ee6b1-2f94-43de-8933-ed5223c67fd9', 181003125316, NULL, NULL, 4, 9, '06-onhold', 'feature', 'achieve capability to write', 'Obtain the capability to write selenium web driver UI automation scripts on the mac: 
 - install node - ok 
 - install atom - ok
 - install the chrome-driver - todo', 'task', 'unknown', '2018-10-03 12:53:16', '2018-10-03 12:53:16', NULL, NULL, NULL, '2018-10-04 14:47:33');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('698320a1-7b6f-47c7-a44e-19218ba2bab5', 181002103341, NULL, NULL, 9, 9, '09-done', 'bug', 'dropdown keyboard navigation', 'the scroll down to the search-box dropdown does not work with the keyboard', 'task', 'unknown', '2018-10-02 10:15:57', '2018-10-02 10:15:57', NULL, NULL, NULL, '2018-10-04 15:48:36');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('de2eec9b-2335-4552-9780-f29a3f7d00d5', 181002103808, NULL, NULL, 5, 9, '02-todo', 'refactor', 'move all external dependencies to be locally hosted', 'move all external dependencies to be locally hosted. This should improve sudden network latencies', 'task', 'unknown', '2018-10-02 10:20:24', '2018-10-02 10:20:24', NULL, NULL, NULL, '2018-10-04 14:50:32');
INSERT INTO public.weekly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9787f4e0-dcbd-4678-8152-1716a42b173e', 181004144853, NULL, NULL, 3, 9, '02-todo', 'deploy', 'deploy v0.4.9', 'deploy 0.4.9 although there are still open bugs ... as there have been 4 weeks without a deployment', 'task', 'unknown', '2018-10-04 14:48:54', '2018-10-04 14:48:54', NULL, NULL, NULL, '2018-10-04 14:54:26');


--
-- Data for Name: yearly_issues; Type: TABLE DATA; Schema: public; Owner: ysg
--

INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('78d22cd6-864c-4219-ab1e-d29fc8b63e6a', 1806011256, 1, 10, 7, 5, '01-eval', 'feature', 'implement a time report web ui page', 'The time report web ui page will :
- fetch the daily,weekly,monthly and yearly hours
- get the allocated hours per time period
- calculate the registered actual hours to the went-by hours of the start of the period
- calculate the diff between the actual and passed-by hours
- accessible from the list/table-name/?as=table url
- should be able t osort the data', 'feature', 'ysg', '2018-12-01 00:00:00', '2018-12-31 07:00:00', 20.00, 0.10, NULL, '2018-09-25 15:25:10');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd9688b9-f859-4c67-b6ba-a98d003f932e', 180920102836, NULL, NULL, 7, 7, '01-eval', 'feature', 'show 1 page if page x did not contain data', 'Add the "page <<GreatPage>>" did not return any data showing page 1 feature by displaying the warning at the bottom of the page', 'task', 'unknown', '2018-09-20 10:13:39', '2018-09-20 10:13:39', NULL, NULL, NULL, '2018-09-20 11:03:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bd557f0d-bf6c-4cf1-8c59-f33fe273f25d', 180817194442, NULL, NULL, 6, 9, '01-eval', 'feature-backend', 'backend post call to move the issues with specific attribute name and like value to another table', 'create a backend post call to move the issues with specific attribute name and like value to another table something like: 

<<db>>/upsert/<<src_table>>/with=<<attr-name>><<operator>><<attribute-value>>&to=<<tgt-table>>', 'task', 'unknown', '2018-08-17 19:36:05', '2018-08-17 19:36:05', NULL, NULL, NULL, '2018-09-25 15:13:00');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('024a826d-2998-4ae5-bbf3-035bc0aa49d8', 1806281842, 2, 2, 9, 9, '09-done', 'feature', 'add Update Controller for accepting the edit REST calls', 'The Update Controller return the code of whether of not the update has succeeded:', 'task', 'ysg', '2018-07-01 00:00:00', '2018-07-30 00:00:00', 30.00, 1.00, 'setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6bde43f8-f794-4b4b-8e50-ffbb1f72057c', 180824074822, NULL, NULL, 9, 9, '04-diss', 'setup', 'create deploy-proj-db func', 'Could be done via a simple oneliner ... for now not needed ...
Add only db restore , increase date from deployed version', 'task', 'unknown', '2018-08-24 07:48:13', '2018-08-24 07:48:13', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8de84df4-24a6-4322-8d76-d8b2b4662868', 180806125535, 2, NULL, 5, 9, '09-done', 'feature-ui-keyboard', 'add key press listener to focus on the quick search input', 'probably related to the structure of the page 
add key press listener to focus on the quick search input
Pressing / should activate the quick search input', 'task', 'ysg', '2018-08-06 12:55:35.853206', '2018-08-06 12:55:35.853206', 3.00, 1.10, NULL, '2018-09-19 13:32:10');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3f604b7-d422-49e7-ab4e-50dcafcf44d3', 180925215439, NULL, NULL, 1, 9, '02-todo', 'docs', 'create security component diagram', 'Create and add to docs the security compoent diagram:
 - list the main compoents and their responsibilities
 - list the security subjects', 'task', 'unknown', '2018-09-25 21:54:37', '2018-09-25 21:54:37', NULL, NULL, NULL, '2018-09-25 21:57:08');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c5fc532a-4c4a-4dcc-aa8a-1f2d8c4f8d5a', 1806231403, 3, 5, 9, 1, '09-done', 'feature', 'add a visual indication for the active page SIZE in the list tables view', 'Well, good enough for now ... Later one ... probably would need more stylingAs currently it is not exactly clear which page is the current one … The less experience is the user the more urgent this feature is …', 'feature', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e3a3ff71-3133-4258-87a1-104ee13e2007', 180806125916, 1, NULL, 5, 1, '09-done', 'bug', 'the inline-cell update removes the new lines from the cell', 'the inline-cell update removes the new lines from the cell 

ops - wrongly used ev.target.textContent when ev.target.innerText should have been used', 'task', 'ysg', '2018-08-06 12:59:16.274161', '2018-08-06 12:59:16.274161', 1.00, 0.70, NULL, '2018-09-19 13:32:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d10e1e5c-e87e-4be2-b9e8-9e4e52aba93f', 180815171338, NULL, NULL, 9, 2, '01-eval', 'feature-ui', 'added draggability in the labels page', 'add drability and sorting by attribute ( prio , weight ) for the labels page', 'task', 'unknown', '2018-08-15 17:07:22', '2018-08-15 17:07:22', NULL, NULL, NULL, '2018-09-25 15:25:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f3b6a5cf-60af-4321-9997-48464ea4f3e6', 1805050102, 1, 10, 9, 1, '09-done', 'feature', 'add the filter-by in url to where in db reader control flow for List.pm controller', 'add the filter-by in url to where in db reader control flow for List.pm controller: 
 - ok for ok case
 - add nok for col does not exist', 'feature-implementation-implementation', 'ysg', '2018-05-02 10:35:53', '2018-06-30 00:00:00', 7.00, 6.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b61c735f-8990-4c48-9aa2-b92f7b249069', 180806110235, 1, NULL, 5, 2, '09-done', 'feature', 'change the accuracy of the date-time in the start_time, stop_time to seconds', 'change the accuracy of the date-time in the start_time, stop_time to seconds and not tics as it is simply annoying to change them by hand and the tics are not human readable ...', 'task', 'ysg', '2018-08-06 10:50:12', '2018-08-06 10:50:12.603165', NULL, NULL, NULL, '2018-09-19 13:32:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('36a15918-7526-4c3f-9f8a-3682d8456d44', 180817232013, NULL, NULL, 7, 9, '01-eval', 'bug-feature', 'The pager should re-draw based on the current sort', 'The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown

So the feature is to enable update of the url params when one clicks on the columns sorting - aka clicking on the update_time asc should change the od=update_time to oa=udpate_tim', 'task', 'unknown', '2018-08-17 23:20:14', '2018-08-17 23:20:14', NULL, NULL, NULL, '2018-09-26 13:23:40');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('881dd1a1-044d-42e3-9119-ce5d0d1cb568', 180824130856, NULL, NULL, 6, 9, '00-late-to-yearly', 'specs', 'login , logout requirements specifications', 'Create the requirements for the login and logout operations

Add the user-stories for the login and logout operations', 'task', 'unknown', '2018-09-01 00:00:00', '2018-08-24 13:08:54', NULL, NULL, NULL, '2018-09-22 11:17:41');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('459ffadd-8f23-4295-b8ef-bb73e98fd5a5', 1806281041, 1, 5, 5, 9, '09-done', 'testing', 'fix bug for increase-date', 'The increase date shell action now:
 - supports different sub-dirs - xls,json,txt', 'feature', 'ysg', '2018-06-28 20:53:00', '2018-06-30 00:00:00', 1.00, 2.00, 'bug,feature-root-cause', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4939f666-8b0a-4450-9bb2-56537e74f60d', 1806231402, 3, 5, 7, 2, '09-done', 'feature', 'add a visual indication for the active page number in the list tables view', 'Well, good enough for now ... Later one ... probably would need more styling ... As currently it is not exactly clear which page is the current one … The less experience is the user the more urgent this feature is …', 'feature', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4a564c84-dd69-46ad-90fe-e1640efaba9c', 1807031419, 1, 5, 9, 9, '09-done', 'setup', 'deploy demo instance to aws', 'Iterate the installation documentation.', 'task', 'ysg', '2018-07-04 04:06:05', '2018-07-04 23:06:05', 3.00, 3.00, 'setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('557c34d8-e2f0-4b8a-958d-ca972eaa24be', 180920103551, NULL, NULL, 4, 9, '02-todo', 'feature', 'add actions on selected items', 'add the capability to perform actions on selected items. 
The user performs a search , selects all the checkboxes in the left of the list ( gmail like ) , types <> for example: 
:do move selected to <> would move the selected items to the <> table', 'task', 'unknown', '2018-09-20 10:20:53', '2018-09-20 10:20:53', NULL, NULL, NULL, '2018-10-01 14:26:32');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('428b55bd-8ef4-4f30-9c7f-5fe29057dad9', 180803161926, 1, NULL, 5, 6, '02-todo', 'feature', 'implement a new hierarchy model', 'implement a new hierarchy model by using the seq into a separate items_hierarchy table , which will have the following attributes:
id - the FK pointing to the items id 
seq - the sequence in the hierarchy 
item_nam e- the name of the item''s table to refer to 
( all those should comprise an unique PK ) 

Change in the hierarchy would mean changing the seq number - those not all issues will be hierarchical, but those which are could be seen in an hierarchy UI !!!', 'task', 'ysg', '2018-10-01 20:53:00', '2018-12-31 20:53:00', 30.00, 0.10, 'hierarchy', '2018-09-19 13:32:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('70830eb8-5029-4ad3-8438-ec6f225613ee', 1806071735, 1, 5, 9, 1, '09-done', 'setup', 'achieve capability to export to pdf list-cloud and list-lbls pages via chrome UI', 'Could be done only via the Chrome UI', 'capability', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 1.00, 2.00, ' setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7ceb5f7a-e803-43ad-a3a9-eb3b7de1f2e2', 1805082200, 1, 10, 9, 1, '09-done', 'feature', 'improve integration testing', 'add the mysql db creation and population, add the documentation generation', 'feature', 'ysg', '2018-05-12 20:00:00', '2018-05-12 21:00:00', 2.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('33fe6333-ed41-4af7-9169-ab353eac431b', 180806163114, NULL, NULL, 5, 9, '09-done', 'feature', 'keyboard scrolling', 'add keyboard scrolling via the selectability of the id''s
Via the tabindex="1" code', 'task', 'ysg', '2018-08-06 16:30:32', '2018-08-06 16:30:32', 1.00, 0.20, NULL, '2018-09-19 13:32:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c52f0e1b-0dfa-4a3f-8127-2ad13eb1693e', 1806092324, 1, 5, 6, 5, '09-done', 'feature', 'add server side paging for the list-table ui action', 'Add server side paging with callable page size , and page number, limit:
- todo automated ui testing
- ok for UI testing
- ok add a dummy page sizes list of links setting the size to the num displaed , BUT going always to the first page 
- create test table
- ok default page size - 15
- ok for default page num - 1', 'task', 'ysg', '2018-06-08 21:30:00', '2018-10-30 00:00:00', 20.00, 10.00, 'architecture', '2018-09-21 09:01:50');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('169f00ae-3217-462b-94b2-b1b811a281c8', 1804290100, 1, 10, 5, 5, '09-done', ' docs', 'fix nasty bug in Initiator cause by related dir in mojo testing framework', 'Or add the ability to resolve the dir structure of any perl script using the Initiator - obs has to be called only once ... 
fix nasty bug in Initiator cause by related dir in mojo testing framework.
The root cause - the Initiator used $0 while it should have used __FILE__. See :
https://stackoverflow.com/a/90721/65706', 'task', 'ysg', '2018-04-29 10:21:23', '2018-04-29 13:21:23', 2.00, 3.00, 'docs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('44fda35e-21b5-4af9-b148-1552a2fb7cf8', 1806011701, 1, 5, 6, 5, '01-eval', 'setup', 'configure web-pack packaging', 'configure web-pack packaging
Is it even feasible to have the web-pack in the current setup ?!', 'setup', 'ysg', '2018-06-01 00:00:00', '2018-06-10 00:00:00', 2.00, 2.00, ' setup', '2018-09-25 15:19:36');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f2d416a0-c99f-4b09-9653-34d060fcdc48', 180807161137, NULL, NULL, 6, 9, '02-todo-to-yearly', 'ui-usability', 'add column delete button', 'add a small button in the top right corner of the column titles

Scenario:
 - the user clicks the button 
 - the System removes visually the column with ajax call - no full page redrow !!!
 - the url is changed accordingly', 'task', 'unknown', '2018-09-20 16:11:37', '2018-08-07 16:11:37', NULL, NULL, NULL, '2018-09-22 11:17:41');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6845c2be-d505-4cde-a016-04fe751340d0', 1805111300, 1, 10, 9, 1, '09-done', 'feature', 'add the create back-end web action', 'Create the create.pm action and integrate within the existing integration tests', 'activity', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e872158d-3a1f-4a73-9a7e-033813a772f1', 180806173205, NULL, NULL, 6, 9, '09-done', 'bug', 'the sorting does not work after updating and item', 'It works only after refreshing the page

The inline cell update does not probably implement the vue model and life cycle AND 
the way the components work ... the solution was to add a watch to the content editable ... 

Related to the it-180806172736 issue:
http://host-name:3000/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,name,description,planned_hours,actual_hours&page-size=100&page-num=1&with=id-eq-180806172736', 'task', 'ysg', '2018-08-06 17:27:08', '2018-08-06 17:27:08', 3.33, 0.10, NULL, '2018-09-19 13:34:34');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5a455442-1a47-4f2a-9565-52161b0bf7b4', 180824132128, NULL, NULL, 9, 9, '04-diss-to-yearly', 'feature-ui', 'add a search button in the bottom', 'When using with mobile to select the global search is too much of a hassle, if the button is on the bottom of the page it would be much easier to just click on the bottom of the screen ( the size of the button might be the same as the add - new ) , and click on the search , which would than open the modal dialog with the global search window', 'task', 'unknown', '2018-10-15 00:00:00', '2018-08-24 13:21:26', NULL, NULL, NULL, '2018-09-22 11:17:41');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a34bcb5e-bcb2-4414-a926-427172c83781', 180806102413, 1, NULL, 4, 9, '04-diss-to-yearly', 'feature-ui-usability', 'add fixing of the table header , page-sizer and the quick-search text-box on table scroll', 'Basically the upper part of the ui should stay fixed, while scrolling the table', 'task', 'ysg', '2018-09-01 00:00:00', '2018-09-30 00:00:00', NULL, NULL, NULL, '2018-09-25 15:09:47');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ffb17f21-d053-41f2-86b7-cfe9e7d7165d', 180921091057, NULL, NULL, 5, 4, '01-eval', 'feature', 'when the pager is resized', 'When the browser window is resized the pager stays on the right , but it should get bellow the srch box', 'task', 'unknown', '2018-09-21 09:10:53', '2018-09-21 09:10:53', NULL, NULL, NULL, '2018-09-25 21:57:29');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bf2206c2-0b12-415f-90a0-d008b0d6913a', 180806102543, NULL, NULL, 5, 9, '02-todo', 'feature', 'add vue calendar on the dates', 'Basically a good calendar control should be pretty easy to be integrated ... , but it would require "infra" for fetching the meta-data as well ...', 'task', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', NULL, NULL, NULL, '2018-09-25 15:13:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('318d2067-1897-404b-aa18-4785d2ccf4d2', 180817194616, NULL, NULL, 6, 9, '09-done', 'bug-ui', 'the focus quick search input should not fire when typing in an editable', 'the focus quick search input should not fire when typing in an editable

It is really annoying when one types in the editable field to jump to the quick search ...', 'task', 'unknown', '2018-08-17 19:37:39', '2018-08-17 19:37:39', NULL, NULL, NULL, '2018-09-19 13:34:35');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7c3da050-81e0-4ac0-b74d-940415360773', 1805140900, 1, 5, 5, 2, '04-diss-to-yearly', 'feature', 'poc for data-load testing', 'As follows:At least 3 tables with at least 10 000 rows load. Because if you cannot get it right from the very beginning than you will get it never ever right. implement a poc for data-load testing with single table load to postgres with start and stop times recordingAdd as a non-blocking post update for start_time and stop_time', 'feature-implementation', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 0.10, 'feature', '2018-09-25 15:06:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('73ac6332-7b44-4baa-ba03-c31f65472f11', 180814101238, NULL, NULL, 9, 1, '09-done', 'bug', 'fix bug with esc.', 'This was the obsolete line: 

this.$el.setAttribute(''contenteditable'', ''false'')', 'task', 'unknown', '2018-08-14 10:12:38', '2018-08-14 10:12:38', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f98a0dab-ff80-4b9a-8356-0fb7607a1286', 180817165902, NULL, NULL, 6, 9, '09-done', 'feature-ui', 'the tabing should work on top of the delete button too', 'The navigation with the tab key does not work currently on top of the delete button

it works BUT , the order is really freaky !!!

This is part of a larger problem .... how-to design the table so that the cursor will move with the same direction as components have been drown visually on the screen ...', 'task', 'unknown', '2018-08-17 16:41:54', '2018-08-17 16:41:54', NULL, NULL, NULL, '2018-09-19 13:34:36');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b33291c0-9311-4c64-815c-31dde6ee6779', 180806213141, 1, NULL, 3, 7, '02-move', 'feature', 'add Excel like moving with the keys also move and down with the cursor keys', 'add Excel like moving with the keys also move and down with the cursor keys', 'task', 'unknown', '2018-08-06 21:31:40', '2018-08-06 21:31:40', NULL, NULL, NULL, '2018-10-01 14:25:54');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8356cac1-3223-431a-b001-507c753ae738', 180920105012, NULL, NULL, 3, 9, '02-todo', 'feature', 'adjustable default column length ...', 'Add the capability of setting default column length in the metadata, as well as presenting <<too-long-content-with-dots-at-the-end>> ... and the capability to display on hover the whole content of the cell', 'task', 'unknown', '2018-09-20 10:35:07', '2018-09-20 10:35:07', NULL, NULL, NULL, '2018-10-01 14:30:10');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d2da9c89-3711-44be-a52f-4abe463794f3', 1805110500, 1, 10, 9, 1, '09-done', 'feature', 'add the like-by and like-val in url to implement the like operator for filtering', 'add the like-by and like-val in url to implement the like operator for filtering', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 5.00, 3.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be547364-3ed7-43f2-a92f-0df3e6fbddc4', 1805110201, 1, 10, 5, 5, '09-done', 'feature', 'create the plain list labels view ui  with vue.js', 'Create a simple list labels view interface which will use the list web action: 
 - evaluete both server and client side html generation and compare performance', 'feature', 'ysg', '2018-05-10 20:53:00', '2018-12-31 07:00:00', 0.10, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c40550e3-97cf-4ced-9b43-8aab2c13f109', 1807030408, 1, 5, 6, 3, '09-done', 'testing', 'convert the start_time and stop_time attributes to datetime format', 'The text format was justified for agility in the beginning , but now with the existing of so much data it is not justified anymore.Need to ensure that the', 'task', 'ysg', '2018-07-04 04:06:05', '2018-07-04 04:06:05', 3.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e3ea4cd4-1ef6-4f1e-ba15-f7d0c5636369', 1806062255, 1, 5, 5, 5, '09-done', 'setup', 'add the phppgadmin to the configurtion setup', 'Installed and documented the installation - this starts the solution of the crashing xls problem which is a blocker. ', 'setup', 'ysg', '2018-06-08 14:00:00', '2018-06-08 16:00:00', 0.00, 2.00, ' setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59ac746a-b143-426e-8b69-10d142ce9282', 1804260100, 1, 10, 4, 6, '09-done', ' docs', 'add the issue-tracker control flow diagram to the DevOps guide', 'And move it to the System Guide , which seems to be a more logical place
Add it to the devops guide', 'task', 'ysg', '2017-09-21 07:00:00', '2017-09-21 07:00:00', 2.00, 0.10, 'docs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('71477531-2a74-453b-9d79-c87a43713767', 180813230115, NULL, NULL, 3, 9, '02-todo', 'feature', 'table rows height default by "30"', 'For month
Probably not worth wasting time as of now ... 
Set the min-height however .... which brings some uniformity ...
and show the full content on hover and on edit
This will make the paging much more smoother and will prevent the jumping of the table back and forth', 'task', 'unknown', '2018-08-13 22:44:27', '2018-08-13 22:44:27', NULL, NULL, NULL, '2018-09-25 15:13:43');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('98e6b6fb-e165-41b6-afc8-74d86d18eec6', 180517213101, 1, NULL, 5, 9, '04-diss', 'load-testing', 'add load testing to the update back-end web action', 'By simply instantiating ASYNCRONOUSLY 
2,4,16,32,64,128,256,512,1024 ajax calls at once non-blocking-wise .
Chk the following info src: 
https://mojolicious.io/blog/2017/12/09/day-9-the-best-way-to-test/
http://blogs.perl.org/users/chase_whitener/2016/01/mock-testing-web-services-with-mojo.html', 'goal', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c021ba38-1796-4570-9b10-a8eb87e8aa78', 180822210340, NULL, NULL, 6, 4, '02-todo', 'feature-ui', 'add undelete function', 'As an UI user I would like to revoke a deleted item', 'task', 'unknown', '2018-11-01 00:00:00', '2018-08-22 21:03:37', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9eebb184-acc9-4555-bb25-2eada3d66f12', 180817194210, NULL, NULL, 9, 9, '04-diss', 'functionality', 'daily issues trigger / stored procedure', 'creates daily trigger / stored procedure to move the daily 09-done and 04-diss status pocessing issues to the weekly_issues table', 'task', 'unknown', '2018-08-17 19:33:32', '2018-08-17 19:33:32', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d7ec6aeb-ca1f-4f87-b2c2-2970c55d1f5d', 180813222648, NULL, NULL, 9, 9, '04-diss', 'feature-ui', 'add a dropdown for the grid pager /', 'add the grid page component , which would be vuetify select at the botom

https://vuetifyjs.com/en/components/selects', 'task', 'unknown', '2018-08-13 22:09:59', '2018-08-13 22:09:59', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3761dfcf-91a4-427e-ad1a-f62063ff2008', 1807170141, 1, 10, 9, 1, '04-diss', 'documentation', 'document the list as table control flow in the system guide', 'Update the application control flow descpription', 'documentation', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cabcdd3b-2303-45ad-8399-5655e89ec6e0', 1806061109, 1, 6, 9, 1, '09-done', 'feature', 'refactor list web action to support multiple output types', 'From now on the syntax for list?as=<<output-type>> would support multiple page builders for multiple output types.
The same approach could be provided to the following future web actions:
 - view , 
 - edit , 
 - create
 - search', 'feature', 'ysg', '2018-06-06 09:30:00', '2018-06-06 11:30:00', 2.00, 8.00, 'feature ', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cc9ebc4c-6c53-4bb9-9b29-17665af6c421', 1806071734, 1, 5, 5, 5, '09-done', 'setup', 'create scalable css dir structure for screen and print ', 'This will enable the definition of printable css styles completely independent from the desktop print styles … 
- for now only print and screen are supported ... 
- probably a new level for mobile / tablets would be needed ... ', 'bug', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 1.00, 2.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd070b3f-ee6a-4ff5-8ad5-9dcf817ec89b', 1805172115, 1, 10, 9, 1, '09-done', 'feature', 'poc for client site JavaScript testing', 'Because if you cannot get it right from the very beginning than you will get it never ever right. 
implement a poc for data-load testing with single table load to postgres with start and stop times recording
Add as a non-blocking post update for start_time and stop_time.
Had to increase the whole OS and redo the setup install for the perl modules and the postgres because of this one ... ', 'feature-implementation', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 4.00, 0.50, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d0874fda-e35a-4049-8345-e2a2f0d23091', 1806262001, 1, 5, 9, 9, '09-done', 'feature', 'refactor, update docs, features - regression tests walktrough', 'Prepare for stable monthly release - v0.4.5', 'refactor', 'ysg', '2018-06-26 10:00:00', '2018-06-29 11:00:00', 4.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('daa406e5-55ba-432b-971e-ba4ff1f4ba81', 1806011258, 1, 5, 5, 5, '09-done', 'bug', 'fix bug with column orders', 'The column order is shuffling depending on whether or not one choses the pick or leaves the pick url param ...', 'bug', 'ysg', '2018-06-10 23:56:00', '2018-06-20 00:00:00', 1.00, 0.30, ' bug', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6e0db40-6aed-405d-acd2-ee77abd717ac', 180806172736, NULL, NULL, 5, 9, '02-todo', 'feature', 'fix the headers and the search form', 'The inline cell update does not probably implement the vue model and life cycle ..   

The table headers and the search form should stay at the top - 2% of the page', 'task', 'ysg', '2018-08-06 17:22:39', '2018-08-06 17:22:39', 3.00, 0.10, NULL, '2018-09-25 15:20:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8fb316e3-521f-42b1-88d1-ea7b1ec50e45', 180824130956, NULL, NULL, 9, 9, '04-diss-to-yearly', 'specs', 'users, roles specs', 'Create the requirement specifications for the users and roles
Add the user-stories ...', 'task', 'unknown', '2018-09-01 00:00:00', '2018-08-24 13:09:54', NULL, NULL, NULL, '2018-09-25 15:06:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e79a6d8e-0f86-412a-ac4c-95e6f83c1ba0', 1805060100, 1, 10, 9, 1, '09-done', 'feature', 'add the order-by in url to order by in db reader control flow in List.pm controller', 'add the order-by in url to order by in db reader control flow in List.pm controller.
Changed the format of the dat to array reference  because of the need to be able to pass a sorted data structure to the render json method. ', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:01', 4.00, 3.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e93b1a24-b512-4b33-808f-cd5f22e13add', 1807170131, 1, 10, 9, 9, '09-done', 'bugs', 'fix the bug "for updating the cell content in table inline edit on error, while it shouldn''t"', 'this is more of a generic question - how-to keep in sync the client-side and server side data structures - perhabs must update the client side array too ?!After the user updates the cell conent the post fires, the error msg is displayed but the content stays changed while it is not changed in the db … which is misleading … 
The behaviour should be changed so that the content will preserve its original state ...', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('59da9507-e762-4975-a0b0-03f6affe94be', 180806110417, 1, NULL, 6, 9, '04-diss-to-yearly', 'bug', 'add error on non-existent network', '2018-09-25 09:37:03 for next month
 ...basically if vue , vuetify etc. libs cannot be loaded via the cdn - aka if there is no connectivity a basic error message should be added to indicate that ...', 'task', 'ysg', '2018-08-06 10:51:54.714225', '2018-08-06 10:51:54.714225', NULL, NULL, NULL, '2018-10-01 14:33:27');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e9b20874-18f8-46ba-ab6b-7708876c4af7', 1806091100, 1, 4, 9, 5, '09-done', 'bug', 'fix bug for non-arranging the column in the list labels as specified in the pick order', 'Due to false logic in the implementation', 'bug', 'ysg', '2018-05-30 20:53:00', '2018-06-09 10:00:00', 1.00, 0.20, 'bugs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bf1cc98e-6e1c-4615-93cc-643b4a64dd4c', 1805110300, 1, 10, 9, 5, '09-done', 'activities', 'aim to use the issue tracker more on the web interface and less on the xls', 'In order to increase the dog food experience and provide base for the creation of issues , userstories , requirements and other specifications', 'activity', 'ysg', '2018-05-06 07:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('681b3805-c434-45e2-9616-6d2c58e2aa04', 1806110020, 1, 6, 6, 6, '04-diss-to-yearly', 'security', 'add validation of ui params against SQL injections _', 'Each time a new data param is to be parametrized till the db ... A validation must be added to it.', 'activity', 'ysg', '2018-06-10 23:00:00', '2018-12-31 07:00:00', 5.00, 3.00, ' security', '2018-09-25 15:19:39');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('417cf290-bc7d-43ac-91eb-320ba5a23492', 1806061000, 1, 6, 9, 1, '09-done', 'feature', 'add the concepts document', 'The Concepts document should provide the following sections:
- Introduction
- Mission statement
- Concept illustration

Status update: move to yearly. Too early for this type of docs .. Yet.', 'feature', 'ysg', '2018-06-01 00:00:00', '2018-12-30 00:00:00', 10.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f5942e49-4d52-455a-902e-712f16a7a4db', 1806281841, 2, 2, 9, 9, '09-done', 'feature', 'add CRUD table control POC with dummy console.log calls', 'So that only the UI interface events will be captured …', 'task', 'ysg', '2018-07-01 00:00:00', '2018-07-30 00:00:00', 30.00, 1.00, 'setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f75c030d-620d-44d1-a426-f038e51c85cf', 1805242250, 1, 6, 9, 6, '09-done', 'feature', 'create a tag cloud page', 'Should increaese the ability to comprehend the issues. 
http://mistic100.github.io/jQCloud/demo.html
 - refactor to factory design pattern ...', 'feature', 'ysg', '2018-06-01 00:00:00', '2018-12-30 00:00:00', 10.00, 8.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f98d0280-a3b7-4632-aaab-feba8f0eed56', 1805161614, 2, 10, 9, 1, '09-done', 'feature', 'add the like-by url param for the list web control ', 'add the like-by url param for the list web control 
 - ok path
 - nok path', 'feature-implementation', 'ysg', '2017-05-14 07:00:00', '2017-06-29 07:00:00', 5.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fabe5107-ebcf-4ebe-869c-dc5e86e160f6', 1805050100, 1, 10, 9, 1, '09-done', 'feature', 'add the filter-by in url to where in db reader control flow for List.pm controller', 'add the filter-by in url to where in db reader control flow for List.pm controller: 
 - ok for ok case
 - add nok for col does not exist', 'feature-implementation-implementation', 'ysg', '2018-05-02 10:35:00', '2018-06-30 00:00:00', 7.00, 6.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('30243762-f0c3-4747-a573-6710f19ee71f', 1806110038, 1, 5, 7, 1, '09-done', 'setup', 'the client side ui sorter does not support soring by numbers', 'Need to implement own sorting method. 
This is complete no-go for correct financial data !!!', 'bug', 'ysg', '2018-06-10 21:30:00', '2018-12-31 07:00:00', 5.00, 0.30, ' setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('36a82200-0972-4dcc-9ab0-2458c36a6d75', 1806011702, 1, 5, 9, 1, '09-done', 'setup', 'fix bug for non-aplying multiple with url params', 'Root cause - simple return in the wrong way of the loop ', 'bug', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 0.00, 1.50, ' setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0ac4be02-e209-4e1a-b790-aa5c22143122', 1806011648, 1, 5, 8, 2, '09-done', 'setup', 'Install FE required binaries', 'setup nodejs, webpack and bower for Front-End development', 'setup', 'ysg', '2018-06-01 00:00:00', '2018-06-01 00:00:00', 2.00, 2.00, ' setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('218c1b15-0a7c-4b0b-86ca-0b5a586b7ac4', 1806011111, 1, 10, 5, 9, '06-onhold', 'architure', 'change Front-End architecture to use Web Pack', 'As Web Pack seems to be the best in town package manager and a lot of JS code is distributed as npm packages.', 'task', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 0.10, NULL, '2018-09-19 14:31:59');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cfb65b19-88d6-439c-810e-a243bc1b94bc', 1806110059, 1, 5, 6, 5, '01-eval', 'feature', 'add the weight-by-<<attribute-name>> for the list cloud page', 'This would enable for example the visualization of the sizes based on actual hours , planned hours ...', 'feature', 'ysg', '2018-07-04 04:06:05', '2018-07-04 04:06:05', 3.00, 0.10, 'feature', '2018-09-25 15:20:17');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0151024d-acca-4557-a6ea-9b7f6fbe07e8', 180818112727, NULL, NULL, 8, 7, '02-todo', 'bug-feature-ui', 'clear display on error "table does not exist"', 'On "table does not exist" error the page-sizer and the pager vue code is shown ... 

Nothing should be displayed - not even the quick search , but only the error message', 'task', 'unknown', '2018-08-18 11:20:42', '2018-08-18 11:20:42', NULL, NULL, NULL, '2018-09-26 13:25:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ebedd47d-831e-4dda-a34d-aa15e9dc18b5', 180806102235, 1, NULL, 5, 9, '02-todo', 'feature', 'add 3D effect on the table cells', 'add 3D effect on the table cells.', 'task', 'ysg', '2018-08-07 00:00:00', '2018-08-07 00:00:00', NULL, NULL, NULL, '2018-09-25 15:13:22');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ed426826-27f6-4442-bc36-7e85261d1f62', 1805282138, 1, 10, 9, 5, '01-eval', 'feature', 'add export to txt from web ui', 'add export to txt from web ui', 'feature-implementation', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 4.00, 0.10, NULL, '2018-09-25 15:25:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9bb1568f-e3fb-4830-9668-8759bc1e82eb', 180807153721, 3, NULL, 7, 3, '01-eval', 'feature', 'add push update to the table on db update', 'add push update to the table on db update

This one is hard !!!
It would require websockets ... as well as somekind of trigger which "knows" what is the last selected "area" of table check that area and push to the client the info to refresh !!!!', 'task', 'unknown', '2018-08-07 15:37:21', '2018-08-07 15:37:21', NULL, NULL, NULL, '2018-09-25 15:25:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2576cfcb-ec09-4907-9344-344e9ea553bd', 1805160700, 2, 10, 7, 5, '01-eval', 'feature', 'add the feature for the validation of the spent time', 'design the validation of the available time and the spent time = registered time', 'task', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 15.00, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ea3aaf3c-ef88-4faf-9727-fac91782f71a', 1805091300, 2, 10, 6, 4, '02-todo', 'feature', 'create the view doc ui with vue.js', 'Create a simple list labels view interface which will use the list web action: 
- evaluete both server and client side html generation and compare performance', 'feature', 'ysg', '2018-05-12 20:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-09-25 15:19:33');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f4f24c13-415e-4f75-b28c-a795cc074268', 1805282137, 1, 10, 9, 1, '04-diss', 'feature', 'add export to xls from web ui', 'add export to xls from web ui', 'feature-implementation', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 4.00, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8464f9d1-6a9e-42fe-bf2b-edfea1655927', 1805152300, 2, 10, 9, 1, '09-done', 'feature', 'add the hide url param for the list web control', 'add the hide url param for the list web control
 - ok path
 - nok path', 'feature-implementation', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e6dc3786-5c39-444d-bde5-3d06ba70bdac', 180818105658, NULL, NULL, 9, 9, '09-done', 'bug', 'increase-date , xls file copy fail', 'The increase-date action does not copy the staging xls file, when it must.', 'task', 'unknown', '2018-08-18 10:54:49', '2018-08-18 10:54:49', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('492139df-ee9d-4815-8ba0-df9b2b9ed206', 1807101027, 2, 2, 9, 9, '09-done', 'feature', 'add UPDATE for the CRUD table inline', '- ok - for fragile ok case 
 - ok - for the preserving of the new lines
 - ok - for the ok test
 - ok - for preventing the id, and guid from editing
- ok - handle error on non-db
- ok - handle error on non-table
- ok - handle error on non-column
- diss - handle error on non-id
- ok - handle any other error
- diss - try multiple columns', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3b210ebd-7a52-42f7-989f-eb02aaf119b9', 1806232256, 1, 5, 6, 5, '02-todo', 'feature', 'add modal dialog for item-edit in the list table ui', 'add modal dialog for item-edit in the list table ui. 
Status change -> 04-diss . No time till the end of this monthly …', 'task', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature ', '2018-10-01 14:33:25');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2d9a6e-5a29-4365-a4db-cf9f7165ba65', 1806232300, 1, 1, 9, 1, '09-done', 'feature', 'add json-to-db shell action', 'Add the following tests:
 - ensure all the tables have a generated json file from the db-to-json action
 - ensure the number of elements in each json files corresponds to the number of rows in the postgres table - back and forth

In order to achieve independance from the xls run-time for achieving the full CRUD, I wanto to be able to take quickly backup and restore db data from files on timely basis.', 'task', 'ysg', '2018-06-23 00:00:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('540961a6-46ee-4943-a081-6ea7bc7f15b8', 1805172116, 1, 10, 9, 1, '09-done', 'setup', 'upgrade Ubuntu 17.04->17.10', 'Upgrade zesty to artful:
 - had to pre-install the whole perl modules package bundle
 - had to pre-install postgres ... Althought it would have worked probably by just installing the Perl postgres related modules.', 'feature-implementation', 'ysg', '2018-05-20 19:10:00', '2018-05-20 23:10:00', 0.10, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('54dce9ec-1054-41cf-9bc1-3cecb02c6fd7', 1805040100, 1, 10, 9, 1, '09-done', 'feature', 'add the pick in url to select in db reader control flow for List.pm controller', 'add the pick in url to select in db reader control flow', 'feature-implementation-implementation', 'ysg', '2018-05-02 10:35:00', '2018-06-30 00:00:00', 5.00, 7.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55247f93-4bd6-4b1e-8b31-6c35f8d5baab', 1806261101, 1, 6, 9, 5, '09-done', 'feature', 'add support for multi-project data backup via the db-to-json and json-to-db actions', 'add support for multi-project data backup via the db-to-json and json-to-db actions. Before the data backed-up went only to the product instance dir and now to the project''s mix data daily dir.', 'feature', 'ysg', '2018-06-26 10:00:00', '2018-06-26 11:00:00', 0.00, 2.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('55fcc574-63fd-45a9-922e-6ddad61d1ac1', 1806281111, 1, 5, 9, 9, '09-done', 'feature', 'fix bug with incorrectly calculated page nums', 'The page nums are not correctly displayed', 'bug', 'ysg', '2018-06-28 18:00:00', '2018-06-29 18:00:00', 1.00, 0.20, 'bugs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5bff873b-49fe-4d5a-be56-bbcd4c70945f', 1805112000, 1, 10, 5, 5, '09-done', 'feature', 'add error handler for xls-to-db when postgres and db table does not exist ', 'Some kind of proper error msg
', 'bug', 'ysg', '2018-05-11 21:10:00', '2018-06-11 19:20:31', 3.00, 0.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5d5189b2-43de-4d92-a3df-7806506c5d6a', 1805222246, 1, 10, 5, 5, '09-done', 'feature', 'add the with-col=val url param', 'add the with-col=val url param', 'feature-implementation', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 4.00, 6.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4c720b74-7819-4128-8fa6-e63425f230cc', 1807170132, 1, 10, 9, 1, '09-done', 'bugs', 'remove the unneeded run-logging', 'There is run-logging which is not used anymore - to remove', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68627bf3-af35-4f8b-b607-021eceb71f17', 1805160800, 2, 10, 9, 1, '09-done', 'feature', 'add the where url operator for quick sql liker filtering', 'add the where url operator for quick sql liker filtering', 'task', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 15.00, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68ba04d8-c819-40ab-b963-65fe1531fcc5', 1805071500, 1, 10, 9, 1, '09-done', 'feature', 'add the list vue.js poc', 'Create a proof of concept poc page with REST api fetch from the back-end using vue.js and axiom', 'task', 'ysg', '2018-05-07 13:38:00', '2018-05-07 13:38:01', 2.00, 3.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('69002c7e-fdd5-4547-b213-d865a8474c56', 1805110200, 1, 10, 9, 1, '09-done', 'feature', 'create the list page with vue.js', 'Create a simple list labels view interface which will use the list web action: 
 - evaluate both server and client side html generation and compare performance
- ok add error handling for missing db
 - add error handling for missing table
- add error handling for wrong hidable column
 - add error handling for wrong pickable column
 - add error handling for wrong filterable col
 - add error handling for wrong col in like', 'feature', 'ysg', '2018-05-10 20:53:00', '2018-12-31 07:00:00', 10.00, 12.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12190348-4e10-481b-a816-fb3f67f38a44', 1805152400, 2, 10, 9, 1, '09-done', 'feature', 'add the order-by url param for the list web control', 'add the order-by url param for the list web control 
 - ok path
 - nok path', 'feature-implementation', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7390294e-fbe3-4a01-9aea-67acaf25e98f', 180815103724, NULL, NULL, 6, 9, '04-diss-to-yearly', 'feature-ui', 'table position fix on paging', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'task', 'unknown', '2018-08-15 10:25:36', '2018-08-15 10:25:36', NULL, NULL, NULL, '2018-09-25 15:06:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23c3fd72-679c-4f45-a4b0-ba33485e4bf4', 1806110034, 1, 10, 6, 7, '02-todo', 'feature', 'add a modal dialog edit form for the edit action', 'Could be either from the list as html page or from the list as lables page', 'task', 'ysg', '2018-07-30 00:00:00', '2018-08-31 00:00:00', 30.00, 0.20, NULL, '2018-09-25 15:20:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0f6686f3-1608-4e09-a546-710201280231', 1807101032, 3, 3, 9, 5, '04-diss', 'feature', 'place the cursor at the end of the txt in content editable during update', 'chk:
https://stackoverflow.com/a/19588665/65706

replaced with select all on tab with the keboard ... 


as the click is usually "I wanto to click in a specific part of the text"', 'feature', 'ysg', '2018-07-20 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fab8075d-d6c3-4ef7-af0f-81c246e834f2', 180816103139, NULL, NULL, 4, 9, '02-todo', 'docs-design', 'design the projects dashboard / projects hub concept', 'As a single user must have access to different projects + the authentication should be at the end both on : 

 - issue-tracker app-layer instance 
 - issue-tracker project-db instance', 'task', 'unknown', '2018-08-16 10:31:39', '2018-08-16 10:31:39', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ee61ab80-f648-4d9a-99fe-0f7c785c2c1c', 180815110339, NULL, NULL, 5, 9, '01-eval', 'feature-ui', 'add vue calendar page', 'For example from the following GitHub project: 
https://github.com/richardtallent/vue-simple-calendar', 'task', 'unknown', '2018-08-15 10:51:51', '2018-08-15 10:51:51', NULL, NULL, NULL, '2018-09-25 15:18:54');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('82940b36-3aea-4d5e-8d34-312c3921561e', 1807031421, 1, 6, 9, 5, '09-done', 'setup', 'update installation instructions with aws deployment', 'update the aws instructions with aws deployment', 'task', 'ysg', '2018-07-04 04:06:05', '2018-07-04 23:06:05', 2.00, 2.00, 'setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('88372df5-f14e-44f3-81ac-fd00275c9fad', 1805202317, 1, 10, 9, 1, '09-done', 'feature', 'separate the control and the page code', 'Add include directive in the page:
 - ok for add layout page
 - todo for add the control css from the control to the layout', 'feature-implementation', 'ysg', '2018-05-16 21:10:00', '2018-05-16 22:10:00', 5.00, 3.00, 'refactoring', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('88848c01-3925-4dce-a474-0aa35cfdd88e', 1805152200, 2, 10, 9, 1, '09-done', 'feature', 'add the pick url param for the list web control', 'add the pick url param for the list web control', 'feature-implementation', 'ysg', '2018-05-14 07:00:00', '2018-06-29 07:00:00', 5.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f03e0d83-f1ba-4ca2-9c4b-3a4ee570dff5', 1806081610, 1, 10, 5, 5, '02-todo', 'feature', 'add omnibox poc page with web service for projects search', 'To be moved to the next month. 
add omnibox poc page with web service for projects search. The end goal should be pop-up omnibox which will present the results on enter lepton like...', 'poc-feature', 'ysg', '2018-08-01 00:00:00', '2018-08-31 00:00:00', 3.00, 2.50, NULL, '2018-10-01 14:24:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ec67678-7532-4b72-b07d-38cfb13e834e', 1805221029, 1, 10, 4, 6, '04-diss', 'feature', 'add form order in url params', 'The ability to order the form elements from the url ... By using the pick order and not a separate fo= ...', 'feature', 'ysg', '2018-01-01 00:00:00', '2018-12-30 00:00:00', 3.00, 0.10, 'feature', '2018-10-01 14:27:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1d2744a6-2fcd-46a5-b121-78387616c316', 1805141000, 1, 10, 9, 1, '01-eval', 'docs', 'create user manual', 'create the user manual document, which will contain ONLY business rules and logic as well as non-devops related content.', 'docs-addition', 'ysg', '2018-05-25 20:53:00', '2018-05-30 00:00:00', 0.50, 0.50, NULL, '2018-10-01 14:34:53');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13cd0a4c-2ce6-4683-8c40-e54615116494', 1807170130, 1, 10, 9, 1, '09-done', 'bug-refactoring', 'separate the error msg', 'There is run-logging which is not used anymore - to remove', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6550ea01-532d-498b-8926-dc1c45f37823', 1806062254, 1, 5, 9, 9, '04-diss-move-to-yearlies', 'setup', 'add the create-table-backups shell action', 'Disgard - could use the json-to-db shell action to achieve the same , or quick pgsql one-liner ad-hoc ... 
Which would dump every table''s data into the daily dir and NOT the dat dir of the product instance dir ... 
Might be timely ONLY after the edit action is started for the implementation ...', 'feature', 'ysg', '2018-06-08 21:00:00', '2018-06-25 22:30:00', 3.00, 0.10, 'setup', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8d614c06-74b2-4cb1-9382-8ee7d07a59e5', 1805010100, 1, 10, 5, 5, '09-done', 'docs', 'add the Get.pm web app controller', 'The get controller will fetch a single item based on either on the id or the guid', 'task', 'ysg', '2017-09-21 07:00:00', '2017-09-21 07:00:00', 2.00, 10.10, 'docs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('803e2652-5908-4209-99b7-ab72a02b4f9c', 1807142230, 1, 5, 9, 2, '09-done', 'testing', 'add a proper ui effect and (dis)appearance of the error msg', 'As it looks quite clumsy right now …', 'feature', 'ysg', '2018-05-25 20:53:00', '2018-06-30 00:00:00', 0.10, 1.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('95ab5eb7-d9aa-498a-aae1-74db1eba3bc8', 1804020100, 1, 10, 9, 1, '09-done', 'feature', 'add the web select controller', 'add the web select controller “
 - implementation code
 - tests 
 - documentation additions for :
-- requirements
-- userstories
-- tests 
-- features and functionalities', 'feature', 'ysg', '2018-04-02 18:00:00', '2018-05-30 22:00:00', 3.00, 7.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('95b9aead-2235-4812-b774-165e490ee6e9', 1807170133, 1, 10, 9, 9, '09-done', 'refactoring', 'improve the error msg behaviour and outlook in the site template', 'It just looked too clumsy. Now it looks more prefessional …', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a0327094-9f28-4bab-8dc6-b4c228bbaeb3', 1805161613, 2, 10, 9, 1, '09-done', 'feature', 'add the filter-by url param for the list web control ', 'add the filter-by url param for the list web control
 - ok path
 - nok path ', 'feature-implementation', 'ysg', '2017-05-14 07:00:00', '2017-06-29 07:00:00', 5.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a2dd6c06-45f9-4415-ae1e-f40c83ba6041', 1804020101, 2, 10, 5, 5, '09-done', 'feature', 'add the web list controller', 'add the web list controller “
 - implementation code
 - tests 
 - documentation additions for :
-- requirements
-- userstories
-- tests 
-- features and functionalities', 'feature', 'ysg', '2018-04-02 18:00:00', '2018-05-02 18:00:00', 3.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a5764fdb-213c-488f-925d-af7f9aae440b', 1806302301, 1, 5, 5, 5, '09-done', 'feature', 'add support for multiple css themes', 'Just move the directory structure of the css''s one level bellow … ', 'refactor', 'ysg', '2018-06-26 10:00:00', '2018-06-29 11:00:00', 1.00, 0.20, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8a127f15-a399-452a-a530-ff64ae8f9f26', 1807101030, 2, 4, 5, 5, '02-todo', 'feature', 'add the UPDATE for the CRUD table via the vue-js-modal form', 'As an UI user of the issue-tracker application 
In order to be able to quickly edit the data of ANY item 
I want to be able to click on the edit button , fill in the poping-up dialog with the form of the full data of the item and clicking the Save button.', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6fd72ccb-ea9f-4bbb-924d-4cb598760a6b', 1806241429, 1, 1, 3, 5, '09-done', 'feature', 'add poc for vue modal dialog page', 'The modal dialog will be used for the CRUD functionality from the list table view and for the search … 
Seems too primitive - for example does not have the close by pressing escape', 'task', 'ysg', '2018-06-24 00:00:00', '2018-06-30 00:00:00', 3.00, 0.70, 'feature', '2018-09-22 11:28:30');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a90bef98-6b5e-4c4f-99fa-790c4f296e8c', 1805312157, 1, 10, 9, 1, '09-done', ' bugs', 'fix bug with non-informance of missing db table on xls-to-db', 'when the xls sheet exists but the table not now the app quites', 'bug', 'ysg', '2018-05-10 20:53:00', '2018-05-30 09:54:00', 1.00, 1.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('acde0b8d-f8ea-428e-a1de-f8537f7d2d3c', 1805070100, 1, 10, 9, 1, '09-done', 'feature', 'add the error halding for non-existent db in List.pm controller', 'add the error halding for non-existent db in List.pm controller', 'feature-implementation-implementation', 'ysg', '2018-05-02 10:35:00', '2018-06-30 00:00:01', 0.10, 0.25, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ae963e98-c5fc-40fe-b832-850d0b2a4bf2', 1805111000, 1, 10, 9, 1, '09-done', 'setup', 'add the pre-loading of the env shell configuration files', 'the run-integration tests should pre-load the configuration file of the current instance in order to match the full environment as it is run usually. 
Solution : 
The call has to be changed to : 
export issue_tracker_project=""; bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests
And documented the change in the DevOps guide', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-31 17:00:00', 2.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b05cb51f-b4d0-4257-a3f6-ba1a8611370a', 1806011257, 1, 5, 5, 9, '09-done', 'feature', 'implement a sortable list table ui', 'Should be able : 
- with alternative row backgrounds for odd and even
- to choose the order of the colums as the pick 
- to choose which columns to hide
- to list ANY db table
- provide the same url params as in the list labels page to the back-end 
', 'feature', 'ysg', '2018-06-08 21:30:00', '2018-12-31 07:00:00', 20.00, 3.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b088632b-1da1-4394-8a5f-e33d34fbc2e4', 1806011703, 1, 5, 5, 5, '09-done', 'feature', 'add the "like" operator in the "where" url parameter', 'The like operator would select rows as follows:
- where=<<column>>-<<operator>>-<<value>> , ', 'feature', 'ysg', '2018-06-05 13:00:00', '2018-06-05 14:00:00', 0.10, 1.50, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b0c27b86-6a5d-4c52-9309-489be31976b4', 1806232301, 1, 10, 9, 9, '09-done', 'feature', 'add json-to-db shell action', 'In order to achieve independance from the xls run-time for achieving the full CRUD, I wanto to be able to take quickly backup and restore db data from files on timely basis.', 'task', 'ysg', '2018-06-23 00:00:00', '2018-06-30 00:00:00', 2.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ae1ae9c0-87bc-4384-badb-2ed8b9802c5a', 1807101031, 2, 5, 6, 1, '09-done', 'feature', 'add the CREATE for the CRUD table via a single click in etable', 'via a single click in the e-table', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3b94d22-7a86-4ef1-99ee-a4d6e3b9be97', 1808012100, 2, 10, 9, 1, '09-done', 'bug', 'the sorting does not work after the inline cell update', 'list as etable -> update cell content inline -> sort by this column does not work …', 'task', 'ysg', '2017-08-06 00:00:00', '2017-08-07 00:00:00', 8.00, 0.50, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a094afaf-b422-47b6-85d6-19b18606cf9a', 1805111100, 1, 10, 7, 8, '01-eval', 'feature', 'add the edit web action from the list as labels page', 'Create the update.pm action and integrate within the existing integration tests', 'activity', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4deaead1-721e-4bee-93ce-22d7e01dd511', 180806103105, 1, NULL, 9, 9, '02-todo-monthly', 'feature', 'add fetching of the meta-data in the select web-action', 'The meta-data could be added to the met , as the data is set in the dat of the json ...
Because this will also enable the display of the warning msgs capability', 'task', 'ysg', '2018-09-01 00:00:00', '2018-09-30 00:00:00', NULL, NULL, NULL, '2018-10-01 14:35:10');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bbe11026-4a14-4900-bc80-fa826f296e4d', 1806251101, 1, 10, 9, 3, '04-diss', 'feature', 'speed-up the xls-to-db action', 'By running in sequence read xls , file, write to db for each table', 'task', 'ysg', '2018-07-01 00:00:00', '2018-07-01 00:00:00', 2.00, 0.10, 'feature,xls', '2018-10-01 14:35:14');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d9ffb12-960a-4648-b288-9cd435838abe', 1805110401, 1, 10, 9, 5, '04-diss', 'feature', 'add db-to-json export for all the issues tables in the integration tests', 'To enable later the avoidance of the xls file ...', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 4.00, 0.10, NULL, '2018-10-01 14:35:15');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('83182443-1c85-4ed2-810d-90d333d4d673', 1806251545, 1, 10, 9, 3, '02-todo', 'documentation', 'add a component diagram', 'Add an official component diagram UML-wise:
http://agilemodeling.com/artifacts/componentDiagram.htm', 'task', 'ysg', '2018-10-01 00:00:00', '2018-12-31 00:00:00', 3.00, 0.10, NULL, '2018-10-01 14:35:39');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b4d7587a-5f5a-4633-a30f-0c2fada05ace', 1804300100, 1, 10, 9, 1, '09-done', 'specs', 'define REST API response structure', 'Should support messages and return codes as well as data transfer. 
Defined : 
 - ret - containing the http status code
 - msg - the msg to be passed to the client
 - dat - the data to be passed to the client', 'specs', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 1.00, 2.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b75ff3e1-7b19-442e-95fc-6e91ce189cc3', 1805102000, 1, 10, 9, 1, '09-done', ' bugs', 'fix bug with non-publishing to google sheets ', 'Due to the non-complience of the googleSheets controller with the Input-Output-Controller-Model architecture', 'bug', 'ysg', '2018-05-10 20:53:00', '2018-05-30 09:54:00', 0.00, 1.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b9ccfc89-a16a-426f-b325-d92ad47cb04e', 1805130100, 1, 10, 9, 1, '09-done', 'feature', 'add the hide, which should pick the columns'' values but not display them in the result set', 'add the hide, which should pick the columns'' values but not display them in the result set', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 4.00, 7.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be016af9-919b-46cb-b1e7-51ef63e7b1b4', 1805120100, 1, 10, 9, 1, '09-done', 'specs', 'change the id''s naming convention to be to hour proximity and not day only ', 'As the day seems to be too less ... As the id''s must be copieable from one table to another and quickly collisions might be created. ', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 20:53:00', 2.00, 1.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1749f537-2230-4f6f-af18-5b5b4c890025', 1805110600, 1, 10, 9, 5, '09-done', 'activities', 'publish a read-only issue-tracker MVP to a host in the cloud for demo purposes', 'publish a read-only issue-tracker MVP to a host in the cloud for demo purposes', 'activity', 'ysg', '2018-05-06 07:00:00', '2018-12-31 07:00:00', 0.10, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('502efdc0-c82c-48d8-bf9f-c842def5cd2c', 180815141257, NULL, NULL, 8, 2, '01-eval', 'feature-ui', 'add drag-and-drop for doc view', 'Evaluate the following component: 
https://github.com/SortableJS/Vue.Draggable

Would require update of the h_table hierarchy', 'task', 'unknown', '2018-08-15 14:12:47', '2018-08-15 14:12:47', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1cee95ee-8067-4783-9e6f-ecbc043c8d72', 180813093900, 1, NULL, 7, 9, '09-done', 'feature-ui', 'add a "as=print-table" page', 'As an ui user I wanto to be able to quickly print a whole html table OR 
copy paste only the table contents by Ctrl + A , Ctrl + V', 'task', 'unknown', '2018-08-13 09:36:43', '2018-08-13 09:36:43', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('86f6bcb6-aba8-42ba-9a58-ffc138350b05', 180830202826, NULL, NULL, 9, 9, '09-done', 'feature', 'add select-databases', 'add the select-databases in the same way as select-tables url is implemented in the back-end + test', 'task', 'unknown', '2018-08-30 20:15:26', '2018-08-30 20:15:26', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b13a4e70-f5da-4280-bdc4-1f5f6e138faf', 1707200100, 1, 10, 5, 6, '02-todo', 'feature', 'implement the copy by id via the back-end api from one table to another', 'implement the copy by id via the back-end api from one table to another', 'task', 'ysg', '2019-01-01 00:00:00', '2019-01-01 00:00:00', 20.10, 0.10, NULL, '2018-09-19 14:31:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6d9005a-525d-4288-88d8-9fb561f5f105', 1805301337, 1, 10, 6, 4, '09-done', 'bug', 'fix the NULL.md generated in generate-docs action', 'Due to the non availability of the relative path', 'bug', 'ysg', '2018-05-28 20:53:00', '2018-05-30 00:00:00', 2.00, 3.00, NULL, '2018-09-21 09:01:51');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('872773cb-d638-442a-ac25-8115bf632a7f', 180807161151, 1, NULL, 4, 9, '02-todo', 'design-concepts-docs', 'define copy and move operations of items', 'The thing is that those are much more complex than it seems and thus they first be designed and defined and AFTER that implement

For example: 
 - "same table item copy action"  ( newid and new guid must be created ) 
 - "different table item copy action" 
 - "different database , same table item copy action"
 - "different database , different table item copy action"', 'task', 'unknown', '2018-08-07 16:11:51', '2018-08-07 16:11:51', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9b5f133b-71a8-48c7-a4aa-d1536f09e707', 180802130102, 2, 5, 9, 1, '09-done', 'feature', 'add the delete vue button component poc', 'Add a poc page with a custom vue button component demonstrating the following:
 - ok ability to instantiate multiple independant instances of the button
 - ok - ability to assign different id''s to the buttons
 - todo - ability to present dialog box with ok and cancel after the clicking of the button
 - ok - ability to perform an AJAX call after pressing the button 
 - ok ability to remove the row', 'task', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe1eeae3-5fb4-46df-b1de-6b62d9229be6', 180807153751, 1, NULL, 9, 6, '01-eval', 'bug-feature', 'add resizing of the columns', 'Probably some kind of listener , which would change the As the current UI does not support a form for the performing of the insert , but the insert straight away inserts a default value , the clicking of the insert button always succeeds ( as the default values are provided by the database ) 

This one might be added once the meta-data handling has been implemented as well ... 

aka it might be blocked by the meta-data retrieval issue ...
td and th ''s padding', 'task', 'unknown', '2018-08-07 15:37:51', '2018-08-07 15:37:51', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('20f646a7-c322-40f1-b0bf-777fff8f3e5e', 1805110400, 2, 10, 6, 1, '01-eval', 'feature', 'improve the select-tables web action', 'Add the following:
- list of views
- ability to specify order by table name and/or creation date 
creation date is important fo rthe population for the primary and foreign key tables 
  - ok - convert result-set to array and not hash', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 1.00, 0.10, NULL, '2018-09-25 15:19:19');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c5d61163-ddba-448a-93a8-dbe18392ff50', 180823113509, NULL, NULL, 9, 9, '09-done', 'bug', 'db-to-json file creation bug in run-integration-tests', 'not ok 3 - test-03:
# for the create of json file: /opt/csitea/issue-tracker/issue-tracker.0.4.7.prd.ysg/dat/json/daily_issues.json
# Failed test ''test-03:
# for the create of json file: /opt/csitea/issue-tracker/issue-tracker.0.4.7.prd.ysg/dat/json/daily_issues.json ''
# at src/perl/issue_tracker/t/TestIssueTracker.pl line 66.', 'task', 'unknown', '2018-08-23 11:35:07', '2018-08-23 11:35:07', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('86bab9d7-f29b-4a41-a173-4b2a711fdf8d', 180822152349, NULL, NULL, 9, 9, '09-done', 'bug', 'the backup-postgres-db action does not create instance db dir', 'The error msg was: 

dat/mix/2018/2018-08/2018-08-22/sql/tst_issue_tracker/*'': No such file
or directory

Revealed only on deployment to tst', 'task', 'unknown', '2018-08-22 15:23:50', '2018-08-22 15:23:50', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('25c65301-2c7e-486e-b8b2-47700bf3fc5f', 180807171630, 1, NULL, 9, 9, '09-done', 'bug', 'the update fails if the column is nullable', 'Changed behaviour to try to update to NULL aka update table set col = nul where id = <<id>>', 'task', 'unknown', '2018-08-07 17:16:30', '2018-08-07 17:16:30', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b9f0becc-db54-4638-b8d2-daf3b5c4c281', 1806062253, 1, 10, 9, 1, '04-diss', 'setup', 'poc for print-to-pdf via headless chrome', 'Could be achieved via UI , not so often used - no sence to spend time automating it … at least for now …', 'bug', 'ysg', '2018-06-04 21:00:00', '2018-06-04 22:30:00', 3.00, 1.00, NULL, '2018-10-01 14:35:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b59ddf99-8f16-422e-9500-1949caab4f90', 1806232302, 1, 10, 6, 5, '02-todo', 'feature', 'evaluate a lib for the generic forms creation', 'The CRUD functionality will require a generic forms creation', 'task', 'ysg', '2018-06-30 00:00:00', '2018-07-15 00:00:00', 5.00, 0.30, 'poc', '2018-10-01 14:25:49');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('162fd56d-ff0d-4171-ba3e-a0e8bce60b1c', 1806281640, 1, 10, 6, 7, '02-todo', 'feature', 'add pages minification on deployment', 'Pages must be minified as 1/3 of the data is white space …', 'task', 'ysg', '2018-10-01 00:00:00', '2018-12-30 00:00:00', 20.00, 1.00, 'setup', '2018-10-01 14:26:24');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('efe6fb81-aec8-4cbd-a1e6-16b18c75e623', 180801151524, 1, NULL, 5, 9, '09-done', 'refactoring', 'Refactor the edit web action to reflect the vue page life cycle', 'As shown in the following diagram:info-src:     https://vuejs.org/v2/guide/instance.html#Lifecycle-Diagram
sttus-change: No relevant anymore ... 
status-change: solved', 'task', 'ysg', '2018-08-01 14:15:36', '2018-08-01 14:15:36.853822', 4.00, 10.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e13014c-c786-4908-a556-84d7dcc05453', 180824090913, NULL, NULL, 9, 9, '04-diss-to-yearly', 'functionality', 'implement authentication till v0.6.0', 'Only authenticated persons should be authorized to access resources in an instance

2018-09-20 13:24:20 - status update -> 01-eval', 'task', 'unknown', '2018-09-01 00:00:00', '2018-08-24 08:53:54', NULL, NULL, NULL, '2018-09-22 11:17:41');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b25dbe49-ff4a-489a-a78d-2fe4dddb7a59', 1805102300, 1, 10, 5, 5, '02-todo', 'feature', 'add a default route for the "/" web address', 'add a default route for the "/" web address.
May be something like forward to the list view ?!

Should be time-wise actual, when the authentication and the login with landing is developed ...', 'feature-implementation', 'ysg', '2018-05-10 20:53:00', '2018-05-30 00:00:00', 2.00, 1.00, ' feature,', '2018-09-25 15:13:15');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32133ace-4648-4ad3-a3de-d4b5a5ce9d0d', 180829211042, NULL, NULL, 6, 9, '02-todo', 'docs', 'separate the Features and Functionalities doc', 'separate the Features and Functionalities doc so that the end-user and ui features should be in one doc and the more technical stuff into another doc
2018-09-20 13:24:20 ::: status change -> 01-eval', 'task', 'unknown', '2018-08-29 21:10:42', '2018-08-29 21:10:42', NULL, NULL, NULL, '2018-09-25 15:08:27');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3f25f22-0e8a-4f91-ba90-801069ec0b36', 180822145244, NULL, NULL, 9, 9, '09-done', 'bug', 'the add new item fails on quick search full', 'Now it does not fail , but actually "discurrages" the user to add new item by making the add new button transperent

Scenario: 
- focus the quick search
- type some search 
- click on the add new

Expected result 
 - a new item on the top of the first page should be added 

Actual result: 
Nothing happends

I', 'task', 'unknown', '2018-08-22 14:52:44', '2018-08-22 14:52:44', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9d3a14a2-f401-44c3-ae0a-5d7d8c844d86', 180822180521, NULL, NULL, 9, 9, '09-done', 'feature-bug', 'change behavour on inp_quick_search on txt change', 'indicate that the add new behavour is different

that is it really adds an item, but it does not "recommend" to do so ...', 'task', 'unknown', '2018-08-22 18:05:20', '2018-08-22 18:05:20', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ee3a3190-5963-4bef-b563-adea0797d673', 180824085622, NULL, NULL, 5, 9, '09-done', 'bug', 'pagin does not work because of trailing # after delete', 'The root cause was the href="#" in the btn-del template ... 
The browsers seem to add automatically the trailing number # ( because of http protocol/standard ?! )   
chk:
https://stackoverflow.com/a/17682564/65706

or is it that url contains # somewhere in the middle ?!

Due to the .replace(/\/?(\?|#|$)/, ''

  .replace(/\/?(\?|#|$)/, ''/$1'')', 'task', 'unknown', '2018-08-24 08:41:03', '2018-08-24 08:41:03', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('78eb7e84-a262-4beb-b487-c7b770673a35', 180816091746, NULL, NULL, 9, 9, '09-done', 'feature', 'single shell call daily backup', 'Add a single shell-call for : 

 - creating a zip daily backup of an issue-tracker project
 - sending that daily backup via gmail', 'task', 'unknown', '2018-08-16 09:03:09', '2018-08-16 09:03:09', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dc91451d-460f-4092-9f6b-ae85e5ed0699', 180802105623, 1, NULL, 9, 9, '09-done', 'release', 'release v0.4.6', 'Couple of small fixes in the integration tests ... 
release v0.4.6 should be considered "transitional" release as it contains only the update of the CRUDS feature, although there is some need for refactoring and additional testing the "create " and "delete" features must be added asap to avoid wasting time with additional tools and Excel. 
Also this should be the first release to be released to the cloud as well.', 'task', 'ysg', '2018-08-02 10:56:49', '2018-08-05 22:56:49', 3.00, 0.00, 'release', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('50a360df-2b66-4b93-a42c-3f85e388b48e', 180717013201, 1, NULL, 9, 1, '09-done', 'bug', 'remove the unneeded run-logging', 'Should be removed ... if more *.run.log files appear open a bug ...

There is run-logging which is not used anymore - to remove', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c0761c85-dc6e-4683-b9b0-a207bad5628d', 180802130101, 1, 4, 6, 2, '09-done', 'feature', 'add the delete back-end web action', 'delete the delete.pm action and integrate within the existing integration tests', 'task', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e75d84ad-abb9-4b23-9b73-a2e1c39fc2a8', 180824081033, NULL, NULL, 5, 9, '09-done', 'docs', 'add Concepts document', 'Add the concepts to the mysql doc app', 'task', 'unknown', '2018-08-24 07:57:37', '2018-08-24 07:57:37', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f74837ce-5163-44b9-9a0f-f7dfb15a1c42', 180809105613, 2, NULL, 5, 9, '09-done', 'devops', 'figure out how-to dump only the data of a table', 'Use the following one-liner
psql -d $postgres_db_name < psql -d $postgres_db_name < /opt/ysg/dat/mix/sql/pgsql/dbdumps/dev_ysg_issues/dev_ysg_issues.daily_issues.20180809_101926.insrt.dmp.sql

And how-to restore it ...', 'task', 'unknown', '2018-08-09 10:42:56', '2018-08-09 10:42:56', 0.00, 0.30, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('11dcb452-53b9-4870-9a55-9c4660a1be2c', 180801152124, 1, NULL, 6, 9, '09-done', 'refactoring', 'add a check for the generated md docs to have more than 100 lines', 'add a check for the generated md docs to have more than 100 lines', 'task', 'ysg', '2018-08-01 14:15:36', '2018-08-01 14:15:36.853822', 1.00, 1.00, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a02d3ebc-5c89-4f71-a36e-ce1c7cc9d252', 1807030420, 1, 6, 9, 5, '09-done', 'feature-ui', 'add a "as=print-table" page', 'Which will be used for simply print the whole table 
 - copy the e-table template
 - change the editable to a simple td
 - remove the page-sizer+code
 - remove the page-numberer+code
 - remove the CRUD methods
 - keep the styling', 'bug', 'ysg', '2018-07-04 04:06:05', '2018-10-31 12:00:00', 5.00, 0.50, 'bugs', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('617f7bb7-d380-4c48-aa86-eddf6c00dd8c', 180802130001, 2, 3, 5, 7, '09-done', 'feature', 'add the create back-end web action', 'Create the create.pm action and integrate within the existing integration tests', 'task', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2c73d462-6f0e-4fa4-b339-d10d24e1fc87', 180806170653, NULL, NULL, 7, 8, '09-done', 'bug', 'the chaining of the "with" url params does not work', 'The chaining of "with" url params does not work , or it has not been implemented f probably implementation fold. For example the following query:  list all the early bug issues, which are not-done. http://192.168.56.120:3000/dev_issue_tracker/list/monthly_issues?as=etable&pick=id,category,status,prio,weight,name,description&where=category-eq-bug&where=status-ne-09-done

the fix for the url_params fixed this one as well .. .', 'task', 'ysg', '2018-08-06 17:01:56', '2018-08-06 17:01:56', 2.00, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2b0455c4-ffd5-4283-99c4-c022ba103d8d', 180806163116, NULL, NULL, 5, 9, '09-done', 'feature-bug', 'add proper error handling on insert of duplicate id''s', 'Test by quick double-clicking the addNew button. A proper message should appear prompting to try again', 'task', 'ysg', '2018-08-06 16:30:34', '2018-08-06 16:30:34', 0.10, 4.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13b33dd8-ad91-4183-82c6-598f71355535', 180807172028, NULL, NULL, 9, 9, '09-done', 'release', 'release version v0.4.7', 'The version 0.4.7 will introduce the CRUDs feature ( with a small s , because basically the s would stand for search via the url parameters syntax and not via a real search UI)', 'task', 'unknown', '2018-08-07 17:20:28', '2018-08-07 17:20:28', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5eaf91a-b401-4a2e-acf1-c79d2892536d', 180806212213, 1, NULL, 9, 9, '09-done', 'feature', 'add scroll till the top', 'related to the it-180801151524

Add scroll till the top when the table ends ...

Add more space in the page 

Related to the', 'task', 'unknown', '2018-08-06 21:22:13', '2018-08-06 21:22:13', 3.00, 0.30, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bdcef54c-dda3-4c6a-861b-e17b73d8e9e3', 1807101028, 2, 5, 5, 8, '02-todo', 'feature', 'add the CREATE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-10-01 14:24:59');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('eea2a2c4-4476-478e-8580-34a46b451ee4', 180830103358, NULL, NULL, 6, 9, '02-todo', 'feature-ui', 'query title label', 'No time for this one this month ...
Build a human readable query title with the same font and style as the existing app_db label', 'task', 'unknown', '2018-08-30 10:16:32', '2018-08-30 10:16:32', NULL, NULL, NULL, '2018-10-01 14:33:24');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('006dcf0b-d15b-4532-b867-4146e686c995', 180802130002, 2, 2, 9, 7, '09-done', 'feature', 'add the create vue button component poc', 'Add a poc page with a custom vue button component demonstrating the following:
- ok hardcode the id of the button , make it part of the table
- ok onclick event prints the id into the console
- ok ability to perform an AJAX call after pressing the button from the parent el
- ok - ability to generate the id in the yymmddHHMMSS format
- ok - ability to pass the id to the back-end ajax call as the 
- ok - grasp the child to parent event and data flow : 
https://stackoverflow.com/a/40915910/65706', 'task', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 0.10, 1.00, ' feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3ae86f77-04e6-4cb1-b689-c64af8617dc9', 180807184617, NULL, NULL, 9, 9, '09-done', 'docs', 'document the db-dump and the db-restore operations in the DevOps guide', 'document the db-dump and the db-restore operations in the DevOps guide f', 'task', 'unknown', '2018-08-07 18:46:17', '2018-08-07 18:46:17', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('823e35ad-4c67-4b1d-9fd2-958475eef3e6', 180806112810, 1, NULL, 5, 4, '09-done', 'feature', 'add automatic addition of the update_time via trigger for all tables having the update_time attribute', 'add automatic addition of the update_time via trigger for all tables having the update_time attribute', 'task', 'ysg', '2018-08-06 11:15:48.325569', '2018-08-06 11:15:48.325569', 1.00, 1.50, 'feature', '2018-09-19 13:32:12');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('909aa8ac-eb4e-455d-afa2-2c29ad2b29d6', 180807185440, 1, NULL, 6, 9, '09-done', 'functionality-back-end', 'add quickly the back-end for the DELETE', 'Add quickly the back-end for the DELETE action. because it would help out the usage of the UI ... and reduce the required time for testing ...

OR at least the ok flow ...', 'task', 'unknown', '2018-08-07 18:54:40', '2018-08-07 18:54:40', NULL, NULL, NULL, '2018-09-19 13:34:33');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cabd54d8-d56c-458c-9ce9-821561ce716a', 180717013101, 1, NULL, 9, 9, '09-done', 'bug', 'fix the bug "for updating the cell content in table inline edit on error, while it shouldn''t"', 'related to the it-180801151524

... this is more of a generic question - how-to keep in sync the client-side and server side data structures - perhabs must update the client side array too ?!After the user updates the cell conent the post fires, the error msg is displayed but the content stays changed while it is not changed in the db … which is misleading … 
The behaviour should be changed so that the content will preserve its original state ...', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-17 02:00:00', 50.00, 8.00, 'feature,msg', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b6b8c67-061d-4def-a306-ff3f5f51206b', 180807184715, NULL, NULL, 9, 1, '09-done', 'feature-ui', 'quick search sizing', 'make the quick search input slightly larger + add the effect of re-sizing on focus', 'task', 'unknown', '2018-08-07 18:47:15', '2018-08-07 18:47:15', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('68fd878b-e311-4a54-b03a-eddf2fb09dcb', 180808110559, 1, NULL, 7, 6, '09-done', 'bug', 'fiix error msg verbosity', 'If the table DOES NOT obey the requirement ( by design ) to have default values for the non-nullable columns the inserts fails with really badly verbose message ... 

 - create a table with non-nullable column
 - click on the add new button
 - chk where the error msg is comming from ( "cannot sed dat on undefined object " ) 
 - add verbosity to the msg', 'task', 'unknown', '2018-08-08 11:05:39', '2018-08-08 11:05:39', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3749b409-3733-40dd-a18e-27d815e96ba3', 180814182141, NULL, NULL, 9, 1, '09-done', 'code', 'get table cols one-liner', 'produce one-liner to get he columns of a table in postgres
Because it will be used thousands of times ... 
And it will be used in the upsert from one table to another code', 'task', 'unknown', '2018-08-14 18:14:17', '2018-08-14 18:14:17', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('73eda7bc-5600-4a00-bbb3-ae30b0d74ea1', 180813222818, NULL, NULL, 4, 9, '09-done', 'feature', 'add the page-numberer in the place of the current page-sizer', 'simply because it is confusing. The page-sizer dropdown could be at the bottom of the grid', 'task', 'unknown', '2018-08-13 22:11:30', '2018-08-13 22:11:30', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('357ddadd-601f-4666-8b6d-740a312968ef', 180806214516, 1, NULL, 5, 9, '09-done', 'feature-bug', 'add select-all on tab press with the keyboard in content-editable', 'When one uses the mouse, nothing is selected ( aka there is no event) , yet when one uses the keyboard the whole content is selected - those faster edition is possible ...

add select-all on focus in content-editable.

It is just annoying to every time Ctrl + E or Ctrl + A first to select all , to go to the end , when one could start typing straight aways', 'task', 'unknown', '2018-08-06 21:45:15', '2018-08-06 21:45:15', 1.00, 1.00, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('acaa69b2-5ca9-48b5-b547-0d7dd3b49ad9', 180710102901, 1, 1, 6, 8, '09-done', 'feature', 'single click CREATE', 'add the CREATE for the CRUD table via a single click in etable
via a single click in the e-table:
- ok for add the button ui 
- ok for click inserts into db
- ok for fetch new item data', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('98dbea27-563f-406d-b85e-12416ad6f3b6', 180808235133, NULL, NULL, 9, 1, '09-done', 'feature', 'add a small indication in the upper left corner for the db name', 'Just because it is confusing in which application one is ... 

to avoid mish-ups between the different applications', 'task', 'unknown', '2018-08-08 23:51:33', '2018-08-08 23:51:33', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('76d7be3f-d5a8-4ad9-8b64-881cab895daa', 180815125716, NULL, NULL, 4, 9, '09-done', 'feature', 'complete the DELETE web action', 'complete the DELETE web action', 'task', 'unknown', '2018-08-15 12:57:16', '2018-08-15 12:57:16', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8f4bfa4c-9aa9-4a18-abcb-f956b9349217', 180810093609, NULL, NULL, 5, 9, '09-done', 'bug', 'ensure the update bug does not re-occur', 'The vue model is not updated - and this IS the root cause for both the sorting and the other strange issues which happen', 'task', 'unknown', '2018-08-10 09:36:09', '2018-08-10 09:36:09', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('91bc9e6f-cd99-46be-b405-ac511d3fa6e7', 180814105454, NULL, NULL, 5, 2, '09-done', 'devops', 'add how-to-copy-items script', '+ figure-out the beginning of the process of copying items from one table to another', 'task', 'unknown', '2018-08-14 10:42:52', '2018-08-14 10:42:52', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8378d9b3-df85-407b-a436-f5b0af2be856', 180816091936, NULL, NULL, 9, 9, '09-done', 'feature', 'single shell call daily backup', 'Add a single shell-call for : 

- creating a zip daily backup of an issue-tracker project
- add the db dump to the daily data dir
- package both the current issue-tracker dir and the proj dir', 'task', 'unknown', '2018-08-16 09:04:59', '2018-08-16 09:04:59', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fd8c0c50-fde5-401a-ae94-5338794e7146', 180808113027, NULL, NULL, 9, 5, '09-done', 'feature-ui', 'add key press listener to focus on the quick search input', 'add key press listener to focus on the quick search input Pressing / should activate the quick search input Should the quick search BE THE OMNIBOX ?!! On document.load

Added in the mounted method ... might be a future root cause of bugs ..', 'task', 'unknown', '2018-08-08 11:30:08', '2018-08-08 11:30:08', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3e97247f-0c0f-499a-a010-d1cf906212a4', 180813215302, 1, NULL, 9, 2, '09-done', 'feature-ui', 'prevent the on hit keyboard enter posting in quicksearch', 'prevent the on hit keyboard enter posting in quicksearch', 'task', 'unknown', '2018-08-13 21:36:12', '2018-08-13 21:36:12', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0dce513b-4d73-4f91-9623-311220b085c2', 180809105507, NULL, NULL, 5, 9, '09-done', 'devops', 'figure out how-to backup the whole database', 'By using the following oneliner: 

mkdir -p $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/ ; pg_dump -d $postgres_db_name 
-U ysg > $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.dmp.sql;
ls -1 $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/*|sort -nr', 'task', 'unknown', '2018-08-09 10:41:49', '2018-08-09 10:41:49', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('23061a5a-42d2-4c4d-8d31-8fd16ff75ae7', 180815140522, 2, NULL, 5, 9, '09-done', 'functionality', 'add the db restore to the integration testing', 'add the db restore to the integration testing as the xls call will not be used so heavily anymore ... 
 - add additional db-re-create after the xls-to-db load
 - add the load from the latest db dump', 'task', 'unknown', '2018-08-15 14:05:12', '2018-08-15 14:05:12', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e5ad90b5-cfc5-4223-a119-5030e4c8e3f4', 180818104209, NULL, NULL, 9, 9, '09-done', 'docs', 'usage scenarios to ReadMe.md', 'Add the usage scenario in ReadMe for: 

 - deploy to trusted environment
 - everyone has CRUD access via http
 - the admins can create whatever tables having guid and id params
 - tables could be preloaded with xls
 - describe the server-side paging quirks openly', 'task', 'unknown', '2018-08-18 10:40:00', '2018-08-18 10:40:00', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5bd1e9cd-f3f4-4b12-bdfd-32283dbd38f1', 180827113929, NULL, NULL, 9, 9, '09-done', 'bug', 'pageNum.trim() bug', 'was due to the delete # bug', 'task', 'unknown', '2018-08-27 10:26:23', '2018-08-27 10:46:23', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d1da2cc5-6f48-4fef-b992-a5cd4d784f85', 180814080139, NULL, NULL, 6, 9, '09-done', 'bug', 'a "null" string appears after empty cell', 'a "null" string appears after empty cell has been updated - try with description', 'task', 'unknown', '2018-08-14 08:01:39', '2018-08-14 08:01:39', NULL, NULL, NULL, '2018-09-19 13:34:34');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('52ac4b70-edf5-400e-8d8d-8c6f394e6867', 180807182904, 1, NULL, 6, 9, '09-done', 'feature-ui', 'add esc key listener to the content editable', 'pressing esc when the content editable is in focus should preserve the old value and remove the focus', 'task', 'unknown', '2018-08-07 18:29:04', '2018-08-07 18:29:04', NULL, NULL, NULL, '2018-09-19 13:34:35');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('0d2dbe46-082a-435c-aba1-01839f2458f2', 180802110002, 2, NULL, 9, 1, '09-done', 'feature', 'select all the txt on focus during inline-cell-edit', 'or consider it not part of MVP and use simply Ctrl + E short cut workaround … 
chck the following info-src: https://stackoverflow.com/questions/6139107/programmatically-select-text-in-a-contenteditable-html-element', 'task', 'ysg', '2018-08-02 10:56:49', '2018-06-30 07:00:00', 3.00, 0.10, 'feature', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('58564210-d843-4436-94f6-109242a5aeba', 180806125917, 1, NULL, 9, 1, '09-done', 'feature', 'Change the background on the editable on focus', 'Change the background on the editable on focus', 'task', 'ysg', '2018-08-06 12:59:17.629376', '2018-08-06 12:59:17.629376', 0.50, 0.55, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('32fc6df6-c236-432b-b79e-78de7099c7b3', 180813191652, NULL, NULL, 5, 1, '09-done', 'functionality', 'back-end testing for DELETE', 'Complete the back-end testing for the DELETE web action

The back-end calls for delete went whithout tests ... 
Not ready for merge !!!', 'task', 'unknown', '2018-08-13 19:16:50', '2018-08-13 19:16:50', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('67a4cc42-bfed-42b2-bf8d-e2e61c8839f9', 180815145340, NULL, NULL, 5, 9, '09-done', 'bug', 'fix insert fails on prio not null in problems table', 'fix insert fails on prio not null in problems table
Solution:
 - make db backup
 - change table DDL 
 - re-run run-pgsql-scripts shell action
 - restore the db
Resolution time - 8 min', 'task', 'unknown', '2018-08-15 14:53:31', '2018-08-15 14:53:31', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ec302541-9a9e-45f1-a304-33ae7eff9a5e', 180823112117, NULL, NULL, 5, 9, '09-done', 'bug', 'the run-integration-tests should not start', 'the run-integration-tests should not start if the project shell vars are not pre-defined', 'task', 'unknown', '2018-08-23 11:21:15', '2018-08-23 11:21:15', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7fafeec5-bf5f-4ec2-98c1-36227baffeb7', 180717013001, 1, NULL, 9, 1, '09-done', 'refactoring', 'remove the run-logging', 'There is run-logging which is not used anymore - to remove', 'bug', 'ysg', '2018-07-17 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a3f8617f-bc8e-4b0a-9e68-2e1c8ea999a1', 180817140314, NULL, NULL, 5, 9, '09-done', 'refactor', 'add the doBackupPostgresDb function', 'Refactor the db backup into a separate function', 'task', 'unknown', '2018-08-17 13:46:01', '2018-08-17 13:46:01', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3dc882f9-2ee2-4d47-a45f-4740bf0dc054', 180817161549, NULL, NULL, 7, 9, '09-done', 'testing', 'test db-to-json and json-to-db', 'achieve apply DDL with the same columns and restore table backup from the db-to-json and json-to-db shell actions', 'task', 'unknown', '2018-08-17 15:58:39', '2018-08-17 15:58:39', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6687ea3a-39f5-4ece-b353-4e90aa3ac371', 180817105857, NULL, NULL, 7, 9, '09-done', 'feature', 'add the db-backup call to the increase-date shell action', 'add the db-backup call to the increase-date shell action

This will ensure that backups are done on daily schedule !!!
That is administrators will not be able to work on the system without having run the increase -date , which automatically will perform backup of the System', 'task', 'unknown', '2018-08-17 10:58:57', '2018-08-17 10:58:57', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('82721998-9991-46f6-aaeb-07147fde580b', 180818110906, NULL, NULL, 9, 9, '09-done', 'docs', 'walk-trough all the Requirements for the current version.', 'walk-trough all the Requirements for the current version. 
Add the INTRO section with the documentation set - a more formal way of describing the documentation.
Probably there is something in the Requirements doc which is to be updated', 'task', 'unknown', '2018-08-18 11:06:58', '2018-08-18 11:06:58', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b6ea2aed-4861-4bf9-978e-0869f2ecd16a', 180817173444, NULL, NULL, 9, 9, '09-done', 'bug-ui', 'visual indication for currently sorted column', 'lost visual indication for current sorting column lost on paging.

after changing the page the visual indication for the currently sorted column is lost !!!

This might solve the problem for the createNewItem as well ... as the createNewItem would be a simple re-direct', 'task', 'unknown', '2018-08-17 17:17:35', '2018-08-17 17:17:35', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('6d8e12d7-29ed-44f0-8e7e-117aecec4414', 180820212740, NULL, NULL, 6, 9, '09-done', 'bug', 'the add new fails on the second page', 'Scenario: 
 - open table with more than <<page-size>> items
 - click on the second page
 - click on the "addNew" button 

Expected Result
 - a new item should be added on top of the table 

Actual Result :
 - the item is added in the model but somewhere else in the page and there is no indication for the user that a new item has been added ...', 'task', 'unknown', '2018-08-20 21:27:40', '2018-08-20 21:27:40', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('bc8a01c7-eaf1-43bf-949f-701801ae54c3', 180817114023, NULL, NULL, 4, 9, '09-done', 'functionality', 'add the check for the gmail-package for non-set Emails', 'add the check for the gmail-package for non-set Emails
If the Emails are not set exists with clean msg', 'task', 'unknown', '2018-08-17 11:40:24', '2018-08-17 11:40:24', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('705f0256-33d4-40e7-962e-63be910edb1a', 180808111808, NULL, NULL, 9, 9, '09-done', 'functionality-back-end', 'where in the url should act the same way as with', 'Because simply technical personnel would rather use where ...

Even updated the test ...', 'task', 'unknown', '2018-08-08 11:17:47', '2018-08-08 11:17:47', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3f08201-d5fa-468f-9420-802df0bd1138', 180818102636, NULL, NULL, 9, 9, '09-done', 'bug', 'update fail does not present the message from the database', 'Scenario: 
 - save too big string ( over 200 ) into the name
 
Expected outcome: 
 - the error from the db: 
"ERROR: value too long for type character varying(200)" should be presented 

Actual outcome:
only error 400 is shown ...', 'task', 'unknown', '2018-08-18 10:24:26', '2018-08-18 10:24:26', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('dd52d2ea-f613-4be9-9822-d3fa758ae512', 180827131612, NULL, NULL, 5, 9, '09-done', 'bug-feature', 'fix bug for cannot insert more than 2 items per seconds', 'The current behaviour is to try 100 times and increase the id ... which should suffice for now ...', 'task', 'unknown', '2018-08-27 13:16:10', '2018-08-27 13:16:10', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4e73627-74fd-49b8-b83a-d2d761f997e1', 180827110649, NULL, NULL, 9, 9, '09-done', 'feature', 'implement 2-stage create-id for create new item', 'Because the generation of the id if 2 users clicked or one user clicked too fast is rare but confusing bug', 'task', 'unknown', '2018-08-27 10:53:43', '2018-08-27 10:53:43', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7f970e73-2f4a-430c-b9f2-5ce486b97020', 180823155703, NULL, NULL, 3, 9, '09-done', 'setup', 'v0.4.8 - CRUDs to the cloud & documented', 'The version 0.4.8 should :
 - docs up-to-date
 - apply small bug fixes if found
 - change the features and functionalities to point to the deployed v0.4.8 instance', 'task', 'unknown', '2018-08-23 15:48:43', '2018-08-23 15:48:43', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f083ef98-957d-4b27-b28e-04b7697c51cd', 180808143653, 1, NULL, 7, 9, '09-done', 'docs', 'Add aknowledgement in the ReadMe.md', 'Add aknowledgement in the ReadMe.md file

 - Mojolicious
 - Vue 
 - Perl
 - GNU / Linux

Add aknowledgement for all the collegues ...', 'task', 'unknown', '2018-08-08 14:36:53', '2018-08-08 14:36:53', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a2c413bc-f733-40a8-a8e7-562fc77f51a2', 180817132816, NULL, NULL, 7, 9, '09-done', 'feature-ui', 'change colouring of the current sorted columns', 'the sorting column is not obvious - untrained users cannot grasp the concept of the sorting and the current sorted column - it might need to be emphasized by colouring or something else ...', 'task', 'unknown', '2018-08-17 13:11:02', '2018-08-17 13:11:02', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c8d1a986-c67f-4055-a161-c01c308cdb13', 180823190305, NULL, NULL, 5, 9, '09-done', 'design-setup', 'add morbo listenning on different configurable port', 'the intent is to to have the app-instances : 
 - dev 
 - tst 
 - prd 
operating on different ports 

which would be defined by the configuration files', 'task', 'unknown', '2018-08-23 18:54:51', '2018-08-23 18:54:51', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a0c169ed-7c1a-4789-a48d-58dc9c3080ef', 180824093501, NULL, NULL, 9, 5, '09-done', 'bug', 'xls increase-date name bug', 'the increase-date does not change the name of the xls with the date', 'task', 'unknown', '2018-08-24 09:19:43', '2018-08-24 09:19:43', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4f26d3ad-ced9-45c8-905f-a134428686bf', 180829200359, NULL, NULL, 9, 9, '09-done', 'bug', 'add error for wrong operator in url where param syntax', 'A wrong syntax in the url with url param does not bring the correct message: 
http://192.168.56.120:3001/prd_ysg_issues/list/daily_issues?as=etable&pick=id,category,status,prio,weight,name,description,start_time,stop_time&page-size=5&oa=prio&page-num=1&where=status-ef-09-done', 'task', 'unknown', '2018-08-29 20:03:59', '2018-08-29 20:03:59', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13719d73-1216-4896-9a13-a0e3aa3944e6', 180829090358, NULL, NULL, 4, 9, '09-done', 'docs', 'docs english grammar errors check', 'Because there are probably still some grammar errors, which ARE embarrassing', 'task', 'unknown', '2018-08-29 09:01:23', '2018-08-29 09:01:23', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8c9551d5-e55c-4073-ae44-ad4fc8d23e79', 180829173937, NULL, NULL, 5, 9, '09-done', 'functionality', 'add the pre-push script', 'add the pre-push script to git to avoid the tdo:ysg fixme type of strings', 'task', 'unknown', '2018-08-29 17:19:53', '2018-08-29 17:19:53', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('65384aa9-1ef5-466f-bc57-ed139a7f5505', 180828103943, NULL, NULL, 9, 9, '09-done', 'bug-ui', 'bug for non-reported missing column in list ui', 'Scenario: 
- choose url to table not-having picked in the url , for example: 
http://192.168.56.120:3001/prd_nokia_musa/list/questions?as=etable&pick=id,level,category,status,prio,weight,name,description,start_time,stop_time&page-size=5&oa=prio&page-num=1

Expected: 
- error msg prompting that start_time and stop_time attributes do not exist 

Actual
- dat is undefined', 'task', 'unknown', '2018-08-28 11:00:00', '2018-08-28 12:00:00', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34074021-70ff-4de6-a711-fb24b3228d42', 180829210354, NULL, NULL, 9, 9, '09-done', 'docs', 'update features & functionalities doc', 'update features & functionalities doc', 'task', 'unknown', '2018-08-29 21:03:54', '2018-08-29 21:03:54', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8f20c787-3668-4793-b156-76c9ff05a30f', 180829090616, NULL, NULL, 5, 9, '09-done', 'bug', 'same item on multiple pages', 'When a single non definitive order by is applied , some of the items appear on several pages , because of the randomness of the ordering, which occurs server-side ... 
Proposed solution:
add the additional ORDER BY id desc at the end of every query. 
Cases : 
 - no order by provided -> will order by id desc
 - oa=prio => order by prio asc , id desc
 - od=prio => order by prio desc , id desc', 'task', 'unknown', '2018-08-29 09:03:40', '2018-08-29 09:03:40', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd73b110-b409-40c1-84b9-8e0f310151a5', 180829090531, NULL, NULL, 9, 9, '09-done', 'docs', 'docs scan trough', 'As there might be logical inconsistencies in the documentation', 'task', 'unknown', '2018-08-29 09:02:56', '2018-08-29 09:02:56', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('49efe9c1-8757-4850-9d72-4e4e0bf623f5', 1807101029, 2, 5, 8, 8, '02-todo', 'feature', 'add the DELETE for the CRUD table via a vue-js-modal form', 'via a vue-js-modal form', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4c5e6d1d-c1fc-4f10-a2bd-500ce40b608f', 180823111548, NULL, NULL, 9, 9, '04-diss', 'feature', 'add a dropbox for the app-layer instance', 'This will be replaced by the in: operator in the omnibox search

add a dropbox for the app-layer instance containing the list of the project db instances
Raised priority as this one is used WAAY TO OFTEN - that is all the time', 'task', 'unknown', '2018-08-23 11:15:45', '2018-08-23 11:15:45', NULL, NULL, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3f0d7194-c7ce-4848-8a54-1260efbd5eee', 1805172136, 1, 10, 9, 5, '04-diss', 'deployment', 'deploy a web accessible instance with basic authentication for demo purposes in amzn', 'To be done straight after the CRUDS completion.

Deploy an instance of the issue-tracker application, which will be www readable, but editable via a simple authentication.', 'goal', 'ysg', '2018-05-17 00:00:00', '2018-12-30 00:00:00', 20.10, 0.10, NULL, '2018-09-02 00:39:46');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9202d5ed-ae9f-4fc0-a210-df9a66641f25', 1806281840, 1, 1, 5, 8, '09-done', 'feature', 'add CRUD table', 'Add CRUDs table:   
- qas for CREATE 
- qas for UPDATE
- qas for DELETE
- qas for search', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 100.00, 8.00, 'feature,CRUD', '2018-09-20 10:35:50');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('ed980933-5f7d-4f35-9bf6-d82e94d4ba83', 180806212921, NULL, NULL, 5, 9, '02-todo', 'feature', 'develop basic authentication setup', 'Develop a per Issue-Tracker instance basic authentication
If easy develop a per db authentication ....', 'task', 'unknown', '2018-08-06 21:29:19', '2018-08-06 21:29:19', 2.00, 0.10, NULL, '2018-09-20 10:36:19');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8145bc77-49cf-43f9-b546-d1982c19c398', 1805172131, 1, 10, 6, 9, '00-late', 'feature', 'implement data load testing', 'Should be single liner:
- very simple
- should have reliable start _time and stop_times
- should be able to verify the executions times per request , request phases to keep track on performance while increasing complexity
- and optionally all this by single user', 'goal', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 2.00, 'feature', '2018-09-25 15:19:28');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b860d07-344d-4809-9639-52f2c8a3414c', 180902003233, NULL, NULL, 9, 9, '09-done', 'feature-ui', 'pager to the pager', 'If there are more than 10 pages the whole paging becomes confusing ... 
Add a pager to the pager, which will scroll till the next 10 items , so show first 1..10 >> when clicked show 10..20 and so forth', 'task', 'unknown', '2018-09-02 00:32:34', '2018-09-02 00:32:34', NULL, NULL, NULL, '2018-09-27 08:47:27');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b293825f-8152-49e8-9ef2-bbf084ee3bd4', 180920104140, NULL, NULL, 5, 9, '02-todo', 'feature', 'add the json backup to the increase-date action', 'The "increase-date" action should take a json backup as well ... 
Because it will provide a double daily backup of the data', 'task', 'unknown', '2018-09-20 10:26:43', '2018-09-20 10:26:43', NULL, NULL, NULL, '2018-09-25 10:13:09');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('04b98015-e566-48f9-84e7-d5abf8af3950', 180914104512, NULL, NULL, 9, 9, '09-done', 'bug', 'non-existent attribute in url for list-as-grid', 'Solution: refactor properly the 
Lessons learned: the data fetching func might return either the data or a string, which is the error - that is the caller could define what to show to the ui based on the typeof the return var ... which of course will not work if one fetches only a single string from the backend , which is however a pretty rare case .. so this approach should be re-used ... 
on un-existent attribute listing the error for the attribute does not exist is not shown at all', 'task', 'unknown', '2018-09-14 10:30:17', '2018-09-14 10:30:17', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('abe45bd8-37ca-4701-92ab-99b981aad0f0', 180920130847, NULL, NULL, 5, 9, '09-done', 'feature', 'adjust the flow of the tab with tabindex', 'Set proper integer values for the tabindex to speed-up the keyboard navigatation on the page.', 'task', 'unknown', '2018-09-20 13:08:47', '2018-09-20 13:08:47', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('495f36ea-ea34-403c-93df-b7a8c11e9ab8', 180927084435, NULL, NULL, 5, 9, '01-eval', 'feature-bug', 'replace redirects with partial page updates', 'In the cases when the grid has to be updated a partial page refresh only on the grid root div is needed as the page blinks annoyingly', 'task', 'unknown', '2018-09-27 08:44:35', '2018-09-27 08:44:35', NULL, NULL, NULL, '2018-10-01 14:30:25');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('24889a37-4362-4012-aeee-ded06d590f4a', 180920104253, NULL, NULL, 6, 9, '01-eval', 'feature', 'add the Ctrl+N should click on the add new item', 'The keyboard combination of Ctrl + N should create a new combination - it will make the addition of items much more faster ...
chk https://stackoverflow.com/a/7296303/65706
add to global events', 'task', 'unknown', '2018-09-20 10:27:48', '2018-09-20 10:27:48', NULL, NULL, NULL, '2018-10-01 14:30:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a83bebb-7e57-4955-a744-df64f8fec4f0', 1805301624, 1, 4, 9, 4, '02-todo', 'issue-tracker', 'fix bug for the issue_tracker.pl.log appearance in product instance dir', 'Occurs when one runs the "run-integration-tests" action', 'bug', 'ysg', '2018-05-29 20:53:00', '2018-06-30 00:00:00', 0.00, 0.10, 'bugs', '2018-10-01 11:40:29');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('47110ae8-3166-4e52-9caa-153f4d92ac0a', 180925152741, NULL, NULL, 5, 9, '02-todo', 'feature-ui', 'universal item search', 'Scenario: 
the user types any text without operators in the search box 
The System
- redirects to an url with removed search url params
- uses a new txt-srch='' the actual query'' 
-  builds a dynamic search with all the text attributes of the CURRENT item 
- lists the table', 'task', 'unknown', '2018-09-25 15:26:59', '2018-09-25 15:26:59', NULL, NULL, NULL, '2018-09-26 22:04:58');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('13470d36-b11a-427e-bc3a-85c1e1ef1b07', 180925103014, NULL, NULL, 5, 9, '02-todo', 'docs', 'perform syntax check for all the docs', 'All the docs changed have to be checked for syntax errors', 'task', 'unknown', '2018-09-25 10:30:14', '2018-09-25 10:30:14', NULL, NULL, NULL, '2018-09-26 22:05:01');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d703d532-267d-429f-9075-a6a8be824a9d', 180926113604, NULL, NULL, 5, 9, '02-todo', 'docs', 'add the ReleaseNotes document', 'The ReleaseNotes should contain all the releases with the following info per release:
 - release intro 
 - performance and stability (refactoring)
 - api changes - changes of behaviours
 - known issues', 'task', 'unknown', '2018-09-26 11:26:44', '2018-09-26 11:26:44', NULL, NULL, NULL, '2018-09-27 10:11:38');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2bfa5d36-40e8-4e7f-8be6-0fc8a0ff2772', 180914111431, NULL, NULL, 5, 9, '03-flow', 'bug-feature', 'stuck morbo server', 'Whenever the morbo server is stuck, one has to kill manually the instances of the perl as the socket is occuped ...
To be resolved as soon as it occurs', 'task', 'unknown', '2018-09-14 10:59:37', '2018-09-14 10:59:37', NULL, NULL, NULL, '2018-09-27 10:12:42');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4b2a52cd-c4b9-4248-8665-9dc0df6e9f63', 180803093321, 1, 10, 5, 3, '03-act', 'feature', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'add and automate as much as possible the deployment of a new released version to the cloud as part of the release process', 'task', 'ysg', '2018-09-01 12:00:00', '2018-09-30 12:00:00', 10.00, 0.10, 'setup,feature', '2018-10-01 11:40:29');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3a7f158b-806a-40f6-a307-56df4cdfa842', 180920104520, NULL, NULL, 4, 9, '09-done', 'feature', 'onEnter for :for should pick the upper most item in the drop down list', 'On click enter should select the upper most item of the list in the :for EVEN if the list has not been selected ...', 'task', 'unknown', '2018-09-20 10:30:16', '2018-09-20 10:30:16', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d4e20248-a559-441f-87f4-0f89cdaa18a6', 180914105643, NULL, NULL, 5, 9, '09-done', 'refactor', 'avoid the warning for exiting last', 'when detecting the bug for the failing column :
https://stackoverflow.com/a/44310352/65706', 'task', 'unknown', '2018-09-14 10:41:48', '2018-09-14 10:41:48', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cd7cd0ea-7c3c-44f7-97ba-6a72260e2d93', 180903114100, NULL, NULL, 9, 9, '09-done', 'feature-ui', 'redirect dialog box', 'add showing the dialog box for the redirect', 'task', 'unknown', '2018-09-03 11:28:29', '2018-09-03 11:28:29', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3c20d2aa-addd-42be-9ea1-e3490fc3ee73', 180920075303, NULL, NULL, 9, 9, '09-done', 'bug', 'fix the "undefined" bug in :for and :in operators', 'fix the "undefined" bug in :for and :in operators', 'task', 'unknown', '2018-09-20 07:52:51', '2018-09-20 07:52:51', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('b364c690-7e6f-47df-b3ee-2b9959aec629', 180925102758, NULL, NULL, 9, 9, '09-done', 'docs', 'update the docs for the :in , :for ops and keyboard nav', 'update the docs for the :in , :for ops and keyboard nav', 'task', 'unknown', '2018-09-25 10:27:58', '2018-09-25 10:27:58', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('87fbf6d7-2ec7-4767-bcdd-eeefc433eb05', 180815133836, 1, NULL, 6, 9, '04-diss-to-month-09', 'feature', 'add load testing for the select web action _', 'add load testing for the select web action

Perform asyncrously requests to examine the amount of asyncrounous calls the application "breaks"', 'task', 'unknown', '2018-08-15 13:38:36', '2018-08-15 13:38:36', NULL, NULL, NULL, '2018-10-01 11:40:29');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('43929f18-b1d1-43ee-921d-13f49133a291', 180921091752, NULL, NULL, 9, 9, '04-diss-to-yearly', 'feature-ui', 'add icon for the pager', 'The pager on the top is kind of strange - new users would know what is it all about ...

https://www.storyblocks.com/stock-image/page-pdf-glyph-icon-bdigvdpe7uzj6gmsu0c', 'task', 'unknown', '2018-09-21 09:17:48', '2018-09-21 09:17:48', NULL, NULL, NULL, '2018-09-26 22:05:05');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('665f009d-3b27-4e70-ac00-f77b716fb3d4', 180921091603, NULL, NULL, 5, 9, '04-diss-to-yearly', 'feature', 'add icon for the page-sizer', 'fix the table position on paging

The table goes up and down annoyingly when the next page is clicked ... 
The table should be fixed according to the columns row', 'task', 'unknown', '2018-09-21 09:15:59', '2018-09-21 09:15:59', NULL, NULL, NULL, '2018-09-27 10:13:13');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('34072102-26e1-4995-8aab-496c0cbdc363', 180926103938, NULL, NULL, 6, 9, '02-todo', 'docs', 'update way of working section', 'Update the System Guide with the way of working section: 
 - requirements should have explicitly written deadline', 'task', 'unknown', '2018-09-26 10:39:38', '2018-09-26 10:39:38', NULL, NULL, NULL, '2018-09-27 10:10:40');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('324755df-a7aa-4e2c-a3d9-5da4aa20ee2c', 180925230044, NULL, NULL, 9, 8, '02-todo', 'docs', 'functional requirements update', 'Update the functional requirements: 
 - what is the maximum amount of rows per table which should be supported
 - how-many users at once should be supported', 'task', 'unknown', '2018-09-25 23:00:45', '2018-09-25 23:00:45', NULL, NULL, NULL, '2018-09-27 10:11:50');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('12f6689a-fa8e-4024-a693-9d1e5cd5dffc', 180517213501, 1, NULL, 5, 2, '02-todo', 'feature', 'implement client-side testing', 'or should there be simply redirect ... 

The pager should re-drow based on the current sort. Scenario: 
- get url with o=update_time , pg-size=100
-  click on sort ascending - the last update time is shown
- click on page-size = 5

Expected behavour
- still the last updated one is shown as the top row

Actual behavour
- the first updated one is shown', 'goal', 'ysg', '2018-06-01 00:00:00', '2018-07-30 00:00:00', 50.00, 5.00, 'feature', '2018-09-27 10:02:35');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('2a515908-c7b2-4fcc-894b-4c34ff1dfc27', 180921152541, NULL, NULL, 5, 9, '04-diss', 'functionality', 'add the back-end action for select table columns', 'This has been done - aka this issue is duplicate: 


Prerequisite for the :pick operator in the search-box:
180921085537



http://192.168.56.120:3001/dev_issue_tracker/list/monthly_issues?as=lbls&pick=id,category,status,prio,weight,name,description&page-size=5&page-num=1&oa=prio&with=id-eq-180921085537', 'task', 'unknown', '2018-09-21 15:25:39', '2018-09-21 15:25:39', NULL, NULL, NULL, '2018-09-28 14:31:23');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('1ca71c00-9eef-4272-88da-fa4504118390', 180830215227, NULL, NULL, 5, 9, '09-done', 'feature-ui', 'add the :in<<db-name>> syntax for redirect into the same page', '2018-09-25 09:37:03 -> 09-done , alpha
add in:<<database-name>> syntax , which could direct to the current url but in the chosen from the dropbox database', 'task', 'unknown', '2018-08-30 21:39:31', '2018-08-30 21:39:31', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('9df5b82c-2d86-4967-8bb7-26871427a568', 1806291841, 1, 1, 5, 6, '02-todo', 'feature', 'add columns stickiness in list as table ui', 'When the ui scrolls a table with page containing more items than the height of the screen the headers of the table must stick to the top of the page. 
Quite difficult with pure css … this one has been the best so far : 
https://jsfiddle.net/dPixie/byB9d/3/', 'task', 'ysg', '2018-07-10 00:00:00', '2018-08-30 00:00:00', 3.00, 1.50, 'setup', '2018-10-01 14:24:42');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('42311561-3acc-4b01-a489-bf07253b246a', 180831230324, NULL, NULL, 5, 9, '09-done', 'functionality', 'version changes in the to-ver action', 'add the version changes in the to-ver action', 'task', 'unknown', '2018-08-31 23:03:24', '2018-08-31 23:03:24', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('7c353415-1c6e-45e6-86f1-e5bdbc07ae87', 180903130418, NULL, NULL, 5, 9, '09-done', 'refactor', 'refactor controls templates', 'add the control templates into their own dirs. fix the missing dist , move js controls to own dirs', 'task', 'unknown', '2018-09-03 12:51:50', '2018-09-03 12:51:50', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('780168d7-405e-4883-b6e0-7b355e162752', 180919115859, NULL, NULL, 5, 9, '09-done', 'bug', 'the back-end select action does not return properly on wrong sql syntax error', 'When the query generated has wrong sql syntax : 
for example: 
l 
that is both the oa and od url params are available ... 
"unknown error" is shown ... while a more descriptive error with the sql syntax should be shown ...', 'task', 'unknown', '2018-09-19 11:58:55', '2018-09-19 11:58:55', NULL, NULL, NULL, '2018-10-01 14:29:16');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cdaf325f-3ebb-4e4f-ab7c-69f5eee68a45', 180911203222, NULL, NULL, 9, 9, '09-done', 'feature-ui', 'add the onEscPressed event handler for the db dropdown', 'add the onEscPressed event handler', 'task', 'unknown', '2018-09-11 20:32:20', '2018-09-11 20:32:20', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3f2a34f3-bc1b-4b15-99a1-d71995b958f5', 180926181042, NULL, NULL, 6, 9, '09-done', 'bug-feature', 'pick un-existent col name results in wrong error', 'Re-factor setErrorMsg function
The wrong error msg appears after picking un-existent attribute:

Expected : 
The column <<xyz>> does not exist !!
Actual: 
unknown error occurred !!!', 'task', 'unknown', '2018-09-26 18:02:27', '2018-09-26 18:02:27', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('331aaf30-45a2-45c0-a5fa-a19b9d513aa9', 1806241213, 1, 6, 7, 9, '02-todo', 'feature', 'add poc for the vue-js-modal dialog page', 'Add the poc from the following source: 
https://github.com/euvl/vue-js-modal/blob/master/README.md

Probably all the node_modules must be installed globally, because there is dependency between the mojo morbo web server … which gets REAAALly SLOW …', 'task', 'ysg', '2018-06-24 00:00:00', '2018-06-30 00:00:00', 2.00, 0.30, 'poc', '2018-10-01 14:25:04');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('fe3ca692-b9e2-409a-bc77-a246b31ac7d2', 1807162248, 1, 5, 7, 4, '02-move', 'feature', 'add the clone with new id html row for table for CREATE', 'chk the following answer:
- wip add the default values for all the non-null columns
- wip create the front-end call by (new Date()).toISOString().replace(/-/g,"").replace(/T/g,"").replace(/:/g,"").slice(2,14)', 'feature', 'ysg', '2018-07-03 00:00:00', '2018-07-30 00:00:00', 50.00, 8.00, 'feature,CRUD', '2018-10-01 14:25:01');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f3951bd2-0bb8-49bc-b680-b99ee8a670c2', 1805111200, 1, 10, 4, 6, '02-todo', 'feature', 'add the select-update form page', 'To test the update action and to start avoiding using the xls', 'activity', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-10-01 14:26:54');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a44dda06-f709-4ed6-8ef1-c08def3fedbc', 1805111400, 1, 10, 4, 6, '04-diss', 'feature', 'create the select-create form page', 'To test the create action and to start avoiding using the xls', 'activity', 'ysg', '2018-05-30 07:00:00', '2018-06-30 07:00:00', 0.10, 0.10, ' feature', '2018-10-01 14:27:11');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('403c1135-5279-47b7-8f37-3783bacd1142', 180920075214, NULL, NULL, 5, 9, '09-done', 'feature-bug', 'fix the pager''s pager', 'Should be human and not machine readable : 
 The cases are : 
 - from 0 to 10 >> 
 - from -10 to last << 
 - all others ...', 'task', 'unknown', '2018-09-20 07:52:02', '2018-09-20 07:52:02', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('792c2e4a-bc46-49d8-a722-4260d804c283', 180903143847, NULL, NULL, 9, 9, '09-done', 'refactor', 'refactor list-etable subcontrols', 'refactor list-etable subcontrols into their own files ... And it took only 30 min ...', 'task', 'unknown', '2018-09-03 14:38:47', '2018-09-03 14:38:47', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('e4b365af-e883-4139-8c1b-32ff361de43d', 180925102926, NULL, NULL, 9, 9, '09-done', 'docs', 'update the docs for the ability to use the new button via the keyboard', 'The new button is cycleable via the tab and can be clicked via the keyboard', 'task', 'unknown', '2018-09-25 10:29:26', '2018-09-25 10:29:26', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('cac2baa8-db67-4d05-a9e7-9f80c734dd74', 180911151818, NULL, NULL, 9, 9, '09-done', 'bug', 'fix the quick search', 'the quick search was separated', 'task', 'unknown', '2018-09-11 15:18:18', '2018-09-11 15:18:18', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('877c70d2-b186-44e5-b852-3c125aece449', 180925085248, NULL, NULL, 9, 9, '09-done', 'feature-ui', 'add dropdown close on Esc', 'When the dropdown is opened clicking escape should close it
added on blur eh', 'task', 'unknown', '2018-09-25 08:52:48', '2018-09-25 08:52:48', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d09a0fd7-67ce-4bfc-9420-141c91a32136', 180912103334, NULL, NULL, 5, 9, '09-done', 'feature', 'specs for users, roles', 'Add minimalistic specs for authenticated users and 2 roles: 
 - authenticated users
 - unauthenticated users
src: https://github.com/jberger/Mojo-JWT', 'task', 'unknown', '2018-09-12 10:18:02', '2018-09-12 10:18:02', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4a303285-271e-46d3-883d-b9325866338a', 180911202830, NULL, NULL, 5, 9, '09-done', 'refactoring', 'remove the list-etable code', 'as it has been updated by the list-grid control , which has the same features + the change to different db', 'task', 'unknown', '2018-09-11 20:28:28', '2018-09-11 20:28:28', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('603bfa1a-2ddd-4ba2-b299-4488510d9545', 180903114019, NULL, NULL, 1, 9, '09-done', 'feature-ui', 'autocomplete databases with the ":in" operator', 'Usage scenario: 
- the users selects the search-box
- the user types the ":in " anywhere in the search-box
- the System presents the drop down filled with the databases
- whenever the user types the list is filtered by the string typed
- on hitting enter the user is redirected to the chosen database', 'task', 'unknown', '2018-09-03 11:27:48', '2018-09-03 11:27:48', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d2ef5ff1-14c5-49e2-82c3-743e2bf65123', 180919115535, NULL, NULL, 4, 7, '09-done', 'feature', 'add the :in<<db-name>> syntax for redirect into the same page', 'When a db is fully normalized and the foreign keys are set , a dropbox must be added to select from the human readable valuesCould be implemented first with the status table ... Implement with smart meta data handling ... no table hooks ..', 'task', 'unknown', '2018-09-19 11:55:30', '2018-09-19 11:55:30', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('4ce7ef59-d47b-43aa-a162-15b28a02c711', 180925102821, NULL, NULL, 8, 9, '09-done', 'docs', 'functional requirements update', 'The :for operator has to be updated', 'task', 'unknown', '2018-09-25 10:28:21', '2018-09-25 10:28:21', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('75b0a34b-30dd-4122-9ea6-4cf0d9d0cd67', 180821205727, NULL, NULL, 5, 6, '09-done', 'bug', 'clear the content of the quick-search input on new item adding', 'Solution: add a redirect with clearing of the filtering url params.

clear the filtering when new item is added

Changed the behaviour to just make the add new button transparent, which will indicate that the behaviour is different', 'task', 'unknown', '2018-08-21 20:57:26', '2018-08-21 20:57:26', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('269818c1-3696-4e96-adbe-46d5e868be78', 180919120334, NULL, NULL, 9, 9, '09-done', 'bug-feature', 'too long pager', 'When there are more than 10 pages ( for example on yearly_issues ) the pager becomes too long and the page clumsy looking. The pager should have some kind', 'task', 'unknown', '2018-09-19 12:03:29', '2018-09-19 12:03:29', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('572afba4-91cc-4b46-aacd-3c6a3cbc8cf0', 180903144343, NULL, NULL, 4, 9, '09-done', 'feature', 'add the :for <<item-name>> operator', 'The :for <<item-name>> operator would make the usage of the app, much more easy + it would lay the foundations for the omnibox ... 
add the item: operator which will run the same query which is currently but on the selected from the autocomplete item', 'task', 'unknown', '2018-09-03 14:43:43', '2018-09-03 14:43:43', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('269866fd-6fa6-48ef-bfca-26c69dfb335a', 180914105804, NULL, NULL, 6, 9, '09-done', 'bug', 'fix the bug for un-existing attribute not shown when requested', 'for example request the principles page by requesting the status attribute as well ... 

Probably the real feature should be just to issue a warning of the bottom of the page stating, that showing the query without the ''<<unexistent-attribute>>'' as it does not exist in the <<item>>', 'task', 'unknown', '2018-09-14 10:43:09', '2018-09-14 10:43:09', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('793cc854-22dd-4c7a-9a9a-442e6ce3147a', 180828100245, NULL, NULL, 5, 4, '09-done', 'bug', 'addNew with filter url params', 'Solution: add a redirect with clearing of the filtering url params.
if one has a filter in the global search when clicking create new , the filter stays and the new items are not shown . Scenario: 
 - have a global search with=status-eq-09-done
- click on add new

Expected behaviour: 
- the new items will be shown 
- the global search will be cleared
Actual behaviour:
 - the global search is not cleared 
 - the new rows are not shown ...', 'task', 'unknown', '2018-08-28 10:01:21', '2018-08-28 10:01:21', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5e5de541-69e6-4ab4-8b1b-694b065d8ccf', 180927085858, NULL, NULL, 3, 7, '09-done', 'bug', 'on fail db update the grid does not update the old value', 'on fail db update the grid does not update the old value', 'task', 'unknown', '2018-09-27 08:58:58', '2018-09-27 08:58:58', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('8b938410-fd24-400a-b690-a056c0a8840f', 181001113115, NULL, NULL, 5, 9, '09-done', 'bug', 'pager sets wrong page numbers', 'Because the page sizer line of code was moved 3 lines bellow ...', 'task', 'unknown', '2018-10-01 11:31:15', '2018-10-01 11:31:15', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('be969ff3-eaf5-44ba-8e7e-9f4ac1f578af', 180927095249, NULL, NULL, 9, 9, '09-done', 'feature', 'add the capability to display user-friendly non-technical errors and log technical errors', 'By using the hacky wackly '' :: '' string separator where the $1 is the human-readable part and the $2 is the nerd readable part of the msg which will be console.errorred in the browser, but not shown on the page', 'task', 'unknown', '2018-09-27 09:52:49', '2018-09-27 09:52:49', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('25f94c2d-1ec6-4c4a-8de5-7889b2365c43', 180928142720, NULL, NULL, 7, 9, '09-done', 'bug', 'the principles table did not comply with the item api', 'It basically did not have default value in the DDL for the nullable attributes', 'task', 'unknown', '2018-09-28 14:27:20', '2018-09-28 14:27:20', NULL, NULL, NULL, '2018-10-01 15:10:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('a4a93c85-dea7-4f87-b91d-bef897f814b6', 181002111017, NULL, NULL, 3, 9, '02-todo', 'bug', 'content editable and update cannot handle html entities', 'The html table cannot handle content with html entities: 
example greater than and smaller than are presented directly', 'task', 'unknown', '2018-10-02 10:52:33', '2018-10-02 10:52:33', NULL, NULL, NULL, '2018-10-02 10:54:26');
INSERT INTO public.yearly_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('c9ec0d30-0f18-4094-b748-80c6bb6c0eaa', 181002113222, NULL, NULL, 1, 9, '03-flow', 'feature', 'add basic auth IF NEEDED', 'configure basic auth in the amzn instance IF there is a real biz need arrises', 'task', 'unknown', '2018-10-02 11:14:40', '2018-10-02 11:14:40', NULL, NULL, NULL, '2018-10-04 15:38:24');


--
-- PostgreSQL database dump complete
--

