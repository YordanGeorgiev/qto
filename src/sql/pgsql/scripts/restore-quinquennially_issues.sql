
-- Data for Name: quinquennially_issues; Type: TABLE DATA; Schema: public; Owner: usrqtoadmin
--
TRUNCATE TABLE quinquennially_issues ;

INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('02cab5c6-72a0-473b-940b-307e4cb6759e', 1806110013, 1, NULL, 5, 5, '03-act', 'ui', 'add dynamic switch of pre-defined ui themes', 'would require a totally new approach to ui design + possibly changes to the css dir structure', 'milestone', 'ysg', '2019-01-01 00:00:00', '2020-01-01 00:00:00', 100.00, 0.10, NULL, '2018-08-06 18:23:46');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('5cee88d2-1ee7-44dd-8398-56ec74e29ac0', 1707200100, 1, NULL, 9, 1, '02-todo', 'feature', 'implement the copy by id via the back-end api from one table to another', 'implement the copy by id via the back-end api from one table to another', 'task', 'ysg', '2019-01-01 00:00:00', '2018-05-07 10:26:09', 20.00, 0.20, NULL, '2018-08-06 18:23:46');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('3ac67766-7613-488d-b55e-86907133f55b', 180824090642, NULL, NULL, 6, 9, '02-todo', 'feature-ui', 'e-table with websockets', 'add instant update of the e-table via web-sockets

If one users updates the data, after it has been stored in the db it should be reflected in the contents of another user e-table', 'task', 'unknown', '2018-08-24 08:51:23', '2020-01-01 00:00:00', NULL, NULL, NULL, '2018-08-30 14:17:27');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('d3201908-eebd-4370-a81b-a59d35889046', 1806011302, 1, NULL, 1, 5, '03-act', 'qto', 'minimalistic MVP with basic auth in the web', 'Deploy to an amzn instance :
 - minimalistic mvp with gruds and basic ui
 - basic auth
 - multiple projects', 'goal', 'ysg', '2018-06-01 00:00:00', '2019-01-01 00:00:00', 450.00, 0.10, NULL, '2018-09-26 22:23:24');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('636d6a11-0c75-43ea-8856-b66bce3df1e7', 1807031404, 1, NULL, 2, 5, '02-todo', 'ui', 'add hierarchichal table listing page', 'Add listing for the hierarchical data:
 - should have visual differentiation between first level and sub-levels … ', 'milestone', 'ysg', '2019-06-01 00:00:00', '2019-12-31 00:00:00', 30.00, 1.00, 'ui', '2018-09-26 22:23:31');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('f6e7301b-96d3-4c07-9240-ed3a35bbf6af', 1806011301, 1, NULL, 5, 5, '03-act', 'qto', 'complete secured instance in the web', 'complete secured instance in the web:
- OAuth2 , authorization and authentication 
- full CRUD ui for issues,projects,problems,questions,principles
- history data management
- time tracking biz features', 'goal', 'ysg', '2019-01-01 00:00:00', '2019-06-30 00:00:00', 450.00, 0.10, NULL, '2018-09-26 22:24:03');
INSERT INTO public.quinquennially_issues (guid, id, level, seq, prio, weight, status, category, name, description, type, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) VALUES ('aebb44b0-2d4b-4b6d-855e-204a39986c4c', 181005081114, NULL, NULL, 5, 9, '04-move-to-2019', 'capability', 'achieve capability for 5 min deployment', 'achieve capability for 5 min deployment to the cloud', 'task', 'unknown', '2018-10-05 08:08:14', '2018-12-30 22:00:00', NULL, NULL, NULL, '2018-10-19 18:49:10');

SELECT * FROM public.quinquennially_issues ; 
