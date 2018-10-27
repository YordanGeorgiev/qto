	DROP TABLE IF EXISTS `ItemView`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


CREATE TABLE `ItemView` (
	`ItemViewId` 				bigint NOT NULL UNIQUE			-- the same id's in the MetaEntity table
 , `Level`						smallint 		NOT NULL 
 , `SeqId`						bigint 			NOT NULL 
 , `LeftRank`					bigint			NOT NULL
 , `RightRank`					bigint			NOT NULL
 , `Name` 						varchar(200) 	NOT NULL			-- the human readable name of the item as presented 
 , `Description` 				varchar(4000) 	DEFAULT NULL	-- the description of this item
 , `Type`						varchar(30) 	DEFAULT NULL	-- the description of this item
 , `BranchId` 					bigint 			DEFAULT '1'		-- the description of this item
 , `doGenerateUi`				boolean NOT NULL DEFAULT true				-- whether or not to generate html page for this item
 , `doGeneratePdf`			boolean NOT NULL					-- whether or not to generate the pdf files per page
 , `doExportToPdf`			boolean NOT NULL					-- whether or not to export to pdf this document
 , `doExportToMd`				boolean NOT NULL					-- whether or not to export to mdf this entry
 , `doExportToXls`		   boolean NOT NULL					-- whether or not to export to mdf this entry
 , `doGenerateLeftMenu`		boolean NOT NULL DEFAULT true -- whether or not to generate the pdf files per page
 , `ItemControllerId` 		bigint 			NOT NULL 
 			REFERENCES ItemController(ItemControllerId)
 , `FileType`  			varchar (10) NULL
 ,  PRIMARY KEY (ItemViewId)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


	-- now check that the table exists 
	SHOW TABLES LIKE 'ItemView';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='ItemView' ; 



-- ========================================================
--  VersionHistory
-- ========================================================
-- 
-- 1.0.0. -- 2014-08-12 11:05:37 -- ysg -- copy paste from the Item table
-- ========================================================
