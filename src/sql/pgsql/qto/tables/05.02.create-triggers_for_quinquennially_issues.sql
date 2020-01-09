
CREATE OR REPLACE FUNCTION fnc_his_update_quinquennially_issues()
  RETURNS trigger AS
$BODY$
   BEGIN
      INSERT INTO his_quinquennially_issues 
         (guid , id , category , type , status , prio , name , description , start_time , stop_time , owner , update_time)  
      VALUES 
         (OLD.guid , OLD.id , OLD.category , OLD.type , OLD.status , OLD.prio , OLD.name , OLD.description , OLD.start_time , OLD.stop_time , OLD.owner , OLD.update_time);
      RETURN NEW;
   END;
$BODY$
LANGUAGE plpgsql VOLATILE 
-- VOLATILE says the function has side effects.
;

DROP TRIGGER IF EXISTS trg_his_before_update_on_quinquennially_issues on "public"."quinquennially_issues"
;

CREATE TRIGGER trg_his_before_update_on_quinquennially_issues
   BEFORE UPDATE
   ON quinquennially_issues
   FOR EACH ROW
EXECUTE PROCEDURE fnc_his_update_quinquennially_issues()
;

select tgname from pg_trigger
where not tgisinternal
and tgname = 'trg_his_before_update_on_quinquennially_issues'
; 

