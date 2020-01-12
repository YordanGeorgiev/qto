
CREATE OR REPLACE FUNCTION fnc_his_create_quinquennially_issues()
  RETURNS trigger AS
$BODY$
   BEGIN
      INSERT INTO his_quinquennially_issues 
         (hguid , hid , action_type, category , type , status , prio , name , description , start_time , stop_time , owner , update_time)  
      VALUES 
         (NEW.guid , NEW.id , 'CREATE' , NEW.category , NEW.type , NEW.status , NEW.prio , NEW.name , NEW.description , NEW.start_time , NEW.stop_time , NEW.owner , NEW.update_time);
      RETURN NEW;
   END;
$BODY$
LANGUAGE plpgsql VOLATILE 
-- VOLATILE says the function has side effects.
;

-- DROP TRIGGER IF EXISTS trg_his_before_create_on_quinquennially_issues on "public"."quinquennially_issues"
;

CREATE TRIGGER trg_his_before_create_on_quinquennially_issues
   BEFORE INSERT
   ON quinquennially_issues
   FOR EACH ROW
EXECUTE PROCEDURE fnc_his_create_quinquennially_issues()
;

select tgname from pg_trigger
where not tgisinternal
and tgname = 'trg_his_before_create_on_quinquennially_issues'
; 

