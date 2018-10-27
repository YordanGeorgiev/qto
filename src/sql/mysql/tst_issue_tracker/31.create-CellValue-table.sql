	DROP TABLE IF EXISTS `CellValue`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


	/* Some description for the table : CellValue */
  CREATE TABLE `CellValue` (

	  `CellValueId` 		bigint 			NOT NULL AUTO_INCREMENT UNIQUE /* a technical id - OBLIGATORY */
	, `BookItemId` 		varchar(200)	NOT NULL -- the concat of the <<book_name>>_<<item_id>>
	, `RowId` 				bigint 			NOT NULL -- the row num starting at 0
	, `ColumnName` 		varchar(200)	NOT NULL -- the name of the column / header 
	, `CellValue` 			varchar(4000)	NOT NULL -- the actual value of the cell 
	, `UpdateTime`			datetime			NOT NULL /* the update time for this record - OBLIGATORY */

	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	/*!40101 SET character_set_client = @saved_cs_client */;
	DROP TRIGGER IF EXISTS `trgOnInsertCellValueUpdateTime` ;

	CREATE TRIGGER `trgOnInsertCellValueUpdateTime` BEFORE INSERT ON  `CellValue` 
	FOR EACH ROW 
	SET NEW.UpdateTime = NOW()
	; 


	DROP TRIGGER IF EXISTS `trgOnUpdateCellValueUpdateTime` ;
	
	CREATE TRIGGER `trgOnUpdateCellValueUpdateTime` BEFORE UPDATE ON  `CellValue` 
	FOR EACH ROW 
	SET NEW.UpdateTime = NOW()
	; 

	-- now check that the table exists 
	SHOW TABLES LIKE 'CellValue';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='CellValue' ; 



/*

-- VersionHistory
1.0.0. -- 2015-01-06 20:48:52 -- init 

*/
