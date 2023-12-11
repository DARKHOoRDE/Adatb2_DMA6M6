CREATE OR REPLACE TRIGGER match_b_trg
  BEFORE INSERT ON match_history
  FOR EACH ROW
BEGIN
  IF :new.id IS NULL
  THEN
    :new.id := seq_match.nextval;
  END IF;
END;
/
