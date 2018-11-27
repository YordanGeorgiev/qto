--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.8

-- Started on 2018-11-27 05:19:47 EET

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
-- TOC entry 3328 (class 0 OID 298816)
-- Dependencies: 213
-- Data for Name: benchmarks; Type: TABLE DATA; Schema: public; Owner: ysg
--

COPY public.benchmarks (guid, id, git_hash, category, status, name, start_time, stop_time, duration_min, duration_seconds, duration_hours, settings, log, description, update_time) FROM stdin;
1d856db8-9388-4211-b063-fdd90852f46c	181126154503	0b047a0e	sandbox	04-failed	test run in sandbox with data loader v1.0.1	2018-11-26 15:29:11	2018-11-26 15:30:17	0.00	0.00	0.00	Dependencies\ncom.datastax.spark:spark-cassandra-connector_2.11:2.0.7 \t\ncom.nokia.npoengine:data-loader_2.11:0.0.3 \t\ncom.nokia.gs.npo.ae:rfco-pixelling_2.11:1.1.0-NPOMUSA-527-replace-rdd-for-df-in-dupl-server-stage-SNAPSHOT 	Result:\njava.lang.NullPointerException at org.apache.zeppelin.spark.Utils.invokeMethod(Utils.java:40) at org.apache.zeppelin.spark.Utils.invokeMethod(Utils.java:35) at org.apache.zeppelin.spark.SparkInterpreter.createSparkContext_2(SparkInterpreter.java:429) at org.apache.zeppelin.spark.SparkInterpreter.createSparkContext(SparkInterpreter.java:418) at org.apache.zeppelin.spark.SparkInterpreter.getSparkContext(SparkInterpreter.java:157) at org.apache.zeppelin.spark.SparkInterpreter.open(SparkInterpreter.java:872) at org.apache.zeppelin.interpreter.	the test failed	2018-11-26 15:39:29
06acf9c8-5db2-40ad-8ebb-ac3fb7e8c3f4	1	0b047a0e	sandbox	04-failed	the test run in the sandbox	2018-11-26 15:22:44	2018-11-26 15:22:44	0.00	0.00	0.00	Dependencies\ncom.datastax.spark:spark-cassandra-connector_2.11:2.0.1 \t\ncom.nokia.npoengine:data-loader_2.11:0.0.3 \t\ncom.nokia.gs.npo.ae:rfco-pixelling_2.11:1.1.0-NPOMUSA-527-replace-rdd-for-df-in-dupl-server-stage-SNAPSHOT 	java.lang.NullPointerException\n\tat org.apache.zeppelin.spark.Utils.invokeMethod(Utils.java:40)\n\tat org.apache.zeppelin.spark.Utils.invokeMethod(Utils.java:35)\n\tat org.apache.zeppelin.spark.SparkInterpreter.createSparkContext_2(SparkInterpreter.java:429)\n\tat org.apache.zeppelin.spark.SparkInterpreter.createSparkContext(SparkInterpreter.java:418)\n\tat org.apache.zeppelin.spark.SparkInterpreter.getSparkContext(SparkInterpreter.java:157)\n\tat org.apache.zeppelin.spark.SparkInterpreter.open(SparkInterpreter.java:872)\n\tat org.apache.zeppelin.interpreter.LazyOpenInterpreter.open(LazyOpenInterpreter.java:69)\n\tat org.apache.zeppelin.interpreter.remote.RemoteInterpreterServer$InterpretJob.jobRun(RemoteInterpreterServer.java:499)\n\tat org.apache.zeppelin.scheduler.Job.run(Job.java:181)\n\tat org.apache.zeppelin.scheduler.FIFOScheduler$1.run(FIFOScheduler.java:139)\n\tat java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n\tat java.util.concurrent.FutureTask.run(FutureTask.java:266)\n\tat java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$201(ScheduledThreadPoolExecutor.java:180)\n\tat java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:293)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)\n\tat java.lang.Thread.run(Thread.java:748)\nERROR\nTook 1 min 6 sec. Last updated by ygeorgie at November 26 2018, 3:45:18 PM.	the test failed	2018-11-26 15:39:39
8991785c-88bb-4d17-97b1-bbc28c693c15	181126160226	716cf2ce	proj-665	09-done	develop run in the ava-europe-espoo proj-665	2018-11-26 15:46:36	2018-11-26 15:46:36	101.33	6063.00	1.68	settings ...	using spark version: 2.1.1 using scala version : version 2.11.8 import org.apache.spark.sql.SparkSession import org.apache.spark.sql.DataFrame import com.nokia.ava.npo.hive.Esri import com.nokia.gs.npo.ae.rfco.main.PixellingWorkflow spark: org.apache.spark.sql.SparkSession = org.apache.spark.sql.SparkSession@29c1fb02 RootPath: s3a://phub-1540286622-665 Looking for BasicCM file (s3a://phub-1540286622-665/landing/lte_cm.csv) Reading BasicCM... Executing pixelling process... Pixelling process completed.	Took 1 hrs 41 min 21 sec. Last updated by ygeorgie at November 26 2018, 3:10:19 PM.	2018-11-26 22:14:25
fe9bb7ab-0aa1-4dd8-99b5-fe4be1b42ee8	181126155531	1651b991	proj-716	03-running	NPOMUSA-527 run in ava-europe-espoo proj-716	2018-11-26 10:56:40	2018-11-26 15:39:40	0.00	0.00	4.00	Dependencies\nartifact \texclude\ncom.nokia.ava:map-visualization-backend_2.11:0.8.152 \t\norg.apache.commons:commons-lang3\ncom.datastax.spark:spark-cassandra-connector_2.11:2.0.2 \t\ncom.nokia.npoengine:data-loader_2.11:0.0.4 \t\ncom.nokia.gs.npo.ae:rfco-pixelling_2.11:1.1.0-NPOMUSA-527-replace-rdd-for-df-in-dupl-server-stage-SNAPSHOT 	log...	desc...	2018-11-26 15:42:43
\.


-- Completed on 2018-11-27 05:19:47 EET

--
-- PostgreSQL database dump complete
--

