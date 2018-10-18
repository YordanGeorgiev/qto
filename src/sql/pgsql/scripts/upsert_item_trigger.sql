CREATE FUNCTION reshuffle() RETURNS trigger AS $trigger_bound$
BEGIN
    INSERT INTO ACCOUNTS (id, balance)
    VALUES (NEW.user_id, get_balance(NEW.user_id))
    ON CONFLICT (id) DO
    UPDATE SET balance = get_balance(NEW.user_id);

    RETURN NEW;
END;
$trigger_bound$
LANGUAGE plpgsql;

CREATE TRIGGER update_balance_on_inserting_transfer
AFTER INSERT OR UPDATE ON transfers
FOR EACH ROW
EXECUTE PROCEDURE reshuffle();
