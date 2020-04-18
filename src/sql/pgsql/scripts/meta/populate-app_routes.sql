CREATE TABLE meta_cols as
         SELECT DISTINCT
             ROW_NUMBER () OVER (ORDER BY pgc.relname , a.attnum) as id,gen_random_uuid() as guid
             , pgc.relname as table_name
             , a.attnum as attribute_number
             , a.attname as attribute_name
             , format_type(a.atttypid, a.atttypmod) as data_type
             , a.atttypmod as char_max_length
             , a.attnotnull as not_null
             , com.description as comment
             , coalesce(i.indisprimary,false) as is_primary_key
         FROM pg_attribute a
         JOIN pg_class pgc ON pgc.oid = a.attrelid
         LEFT JOIN pg_index i ON
             (pgc.oid = i.indrelid AND i.indkey[0] = a.attnum)
         LEFT JOIN pg_description com on
             (pgc.oid = com.objoid AND a.attnum = com.objsubid)
         LEFT JOIN pg_attrdef def ON
             (a.attrelid = def.adrelid AND a.attnum = def.adnum)
         LEFT JOIN pg_catalog.pg_namespace n ON n.oid = pgc.relnamespace
         WHERE 1=1
            AND pgc.relkind IN ('r','')
             AND n.nspname <> 'pg_catalog'
             AND n.nspname <> 'information_schema'
             AND n.nspname !~ '^pg_toast'
         AND a.attnum > 0 AND pgc.oid = a.attrelid
         AND pg_table_is_visible(pgc.oid)
         AND NOT a.attisdropped
         ORDER BY id
;

