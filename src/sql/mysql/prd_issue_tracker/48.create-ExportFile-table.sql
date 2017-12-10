	DROP TABLE IF EXISTS `ExportFile`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


CREATE TABLE `ExportFile` (
	`ExportFileId` 				bigint NOT NULL UNIQUE			-- the same id's in the MetaEntity table
 , `Level`						smallint 		NOT NULL 
 , `SeqId`						bigint 			NOT NULL 
 , `LeftRank`					bigint			NOT NULL
 , `RightRank`					bigint			NOT NULL
 , `BranchId` 					bigint 			DEFAULT '1'		-- the description of this item
 , `Name` 						varchar(200) 	NOT NULL			-- the human readable name of the item as presented 
 , `Description` 				varchar(4000) 	DEFAULT NULL	-- the description of this item
 , `RelativePath` 			varchar(200) 	NOT NULL			-- the human readable name of the item as presented 
 , `Type`						varchar(30) 	DEFAULT 'md'	-- the description of this item
 , `ItemViewId` 		bigint 			NOT NULL 
		REFERENCES ItemView(ItemViewId)
 ,  PRIMARY KEY (ExportFileId)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


	-- now check that the table exists 
	SHOW TABLES LIKE 'ExportFile';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='ExportFile' ; 



-- ========================================================
--  VersionHistory
-- ========================================================
-- 
-- 1.0.0. -- 2014-08-12 11:05:37 -- ysg -- copy paste from the Item table
-- ========================================================
