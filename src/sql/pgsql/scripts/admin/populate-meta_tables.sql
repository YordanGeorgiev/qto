   INSERT INTO meta_tables
   ( name , description)

   select tablename as name , tablename as description 
   from pg_tables 
   where 1=1
   and schemaname='public'
   ORDER BY name
   ON CONFLICT (id) DO UPDATE SET
   guid = excluded.guid, id = excluded.id, prio = excluded.prio, name = excluded.name, description = excluded.description, update_time = excluded.update_time;

