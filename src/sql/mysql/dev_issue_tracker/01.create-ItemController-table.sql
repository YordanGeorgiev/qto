	DROP TABLE IF EXISTS `ItemController`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


	CREATE TABLE `ItemController` (
		`ItemControllerId` 	bigint NOT NULL UNIQUE			-- the same id's in the MetaEntity table
	 , `Level`					smallint 		NOT NULL 
	 , `SeqId`					bigint 			NOT NULL 
	 , `LeftRank`				bigint			NOT NULL
	 , `RightRank`				bigint			NOT NULL
	 , `doTruncTable`			boolean NOT NULL					-- whether or not to truncate the table before load
	 , `doLoadData`			boolean NOT NULL					-- whether or not to load the data for this item
	 , `IsBook`					boolean NOT NULL					-- whether or not to fetch this as part of the app doc model
	 , `Name` 					varchar (200) NOT NULL			-- the technical name of this item
	 , `Sheet` 					varchar (200) NOT NULL			-- the technical Sheet name in the xls file
	 , `Description` 			varchar (4000) DEFAULT NULL		-- the description of this item
	 , `FileType`  			varchar (10) NOT NULL
	 
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	/*!40101 SET character_set_client = @saved_cs_client */;


	-- now check that the table exists 
	SHOW TABLES LIKE 'ItemController';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='ItemController' ; 



-- ========================================================
--  VersionHistory
-- ========================================================
-- 
-- 1.0.0. -- 2014-08-12 11:05:37 -- ysg -- copy paste from the Item table
-- ========================================================
