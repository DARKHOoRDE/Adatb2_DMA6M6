CREATE OR REPLACE TRIGGER player_b_trg
  BEFORE INSERT OR UPDATE ON player --might disable delete(players shouldnt be deletable)
  FOR EACH ROW
BEGIN

  :new.mod_user := sys_context('USERENV', 'OS_USER');
  :new.mod_time := SYSDATE;

  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := seq_player.nextval;
    END IF;
    :new.version       := 1;
    :new.creation_time := SYSDATE;
    :new.creator_user  := sys_context('USERENV', 'OS_USER');
    :new.dml_flag := 'I';
    INSERT INTO player_h
      (id
      ,player_name
      ,email
      ,birth_date
      ,creation_time
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.player_name
      ,:new.email
      ,:new.birth_date
      ,:new.creation_time
      ,:new.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,'I'
      ,1);
  ELSE
    :new.version := :old.version + 1;
    :new.dml_flag := 'U';
    INSERT INTO player_h
      (id
      ,player_name
      ,email
      ,birth_date
      ,creation_time
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version)
    VALUES
      (:new.id
      ,:new.player_name
      ,:new.email
      ,:new.birth_date
      ,:old.creation_time
      ,:old.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,'U'
      ,:new.version);
  END IF;

END;
/
