CREATE OR REPLACE TRIGGER playermatch_b_trg
  BEFORE INSERT ON player_match
  FOR EACH ROW
BEGIN
  IF :new.id IS NULL
  THEN
    :new.id := seq_player_match.nextval;
  END IF;
END;
/
