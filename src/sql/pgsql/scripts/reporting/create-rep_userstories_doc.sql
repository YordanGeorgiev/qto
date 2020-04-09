-- remove REFERENCES userstories_doc(guid) if necessary
CREATE TABLE rep_userstories_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid() REFERENCES userstories_doc(guid)
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , prio           integer NOT NULL DEFAULT 1
    , name           varchar (200) NOT NULL DEFAULT 'name/title...'
    , description    varchar (4000)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_rep_userstories_doc_guid PRIMARY KEY (guid)
)
WITH (
	OIDS=FALSE
);