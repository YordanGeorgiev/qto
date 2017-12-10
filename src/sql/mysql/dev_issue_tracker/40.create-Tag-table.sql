	DROP TABLE IF EXISTS `Tag`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


	CREATE TABLE `Tag` (
		`TagId` 			bigint 			NOT NULL UNIQUE
	 , `Level`				smallint 		NOT NULL 
	 , `SeqId`				decimal 			NOT NULL -- because there must be order !!!
	 , `LeftRank`			bigint			NOT NULL
	 , `RightRank`			bigint			NOT NULL
	 , `LogicalOrder`		varchar(30) 	NOT NULL
	 , `Name` 				varchar(200) 	NOT NULL
	 , `Description` 		varchar(4000) 	DEFAULT NULL
	 
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	/*!40101 SET character_set_client = @saved_cs_client */;
	
	
	-- now check that the table exists 
	SHOW TABLES LIKE 'Tag';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='Tag' ; 




/*
-- VersionHistory
1.0.2. -- 2014-11-27 09:37:45 -- ysg -- added DocId
1.0.1. -- 2014-06-29 19:41:18 -- ysg -- removed attributes
1.0.0. -- 2014-07-19 09:43:38 -- ysg -- init 

*/
