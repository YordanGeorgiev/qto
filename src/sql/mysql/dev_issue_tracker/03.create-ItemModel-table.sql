	DROP TABLE IF EXISTS `ItemModel`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;


	CREATE TABLE `ItemModel` (

		`ItemModelId`       	bigint NOT NULL UNIQUE
	 , `Level`					smallint 		NOT NULL 
	 , `SeqId`					bigint 			NOT NULL 
 	 , `LeftRank`				bigint			NOT NULL
 	 , `RightRank`				bigint			NOT NULL
	 , `Name`     				varchar (50) 	NOT NULL
	 , `TableNameLC`    		varchar (50) 	NOT NULL
	 , `TableName`      		varchar 	(50) 	NOT NULL
	 , `Description`   		varchar (200) 	NOT NULL
	 , `LoadOrder`				bigint 			NOT NULL 
	 , `IsItem`					boolean 			NOT NULL 
 	 , `ItemControllerId` 	bigint 			NOT NULL 
	 			REFERENCES ItemController(ItemControllerId)
	 , `FileType`             	varchar 	(10) NOT NULL
	 ,  PRIMARY KEY (ItemModelId)

	) 
	ENGINE=InnoDB DEFAULT CHARSET=utf8;
	/*!40101 SET character_set_client = @saved_cs_client */;




	-- now check that the table exists 
	SHOW TABLES LIKE 'ItemModel';
	
	SELECT FOUND_ROWS() AS 'FOUND'  ;

	-- NOW CHECK THE COLUMNS
	SELECT CONCAT ( TABLE_NAME  , '.' , COLUMN_NAME  )
	AS 'TABLE.COLUMNS'
	from information_schema.COLUMNS
	WHERE 1=1
	AND TABLE_SCHEMA=DATABASE()
	AND TABLE_NAME='ItemModel' ; 
