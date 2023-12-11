CREATE OR REPLACE TRIGGER charachter_b_trg
  BEFORE INSERT OR UPDATE OR DELETE ON charachter
  FOR EACH ROW
BEGIN

  IF deleting
  THEN
    INSERT INTO charachter_h
        (id
        ,charachter_name
        ,player_id
        ,charachter_class
        ,weapon_id
        ,charachter_level
        ,creation_time
        ,creator_user
        ,mod_user
        ,mod_time
        ,dml_flag
        ,version)
      VALUES
        (:old.id
        ,:old.charachter_name
        ,:old.player_id
        ,:old.charachter_class
        ,:old.weapon_id
        ,:old.charachter_level
        ,SYSDATE
        ,sys_context('USERENV', 'OS_USER')
        ,sys_context('USERENV', 'OS_USER')
        ,SYSDATE
        ,'D'
        ,:old.version + 1);
  ELSE
    :new.mod_user := sys_context('USERENV', 'OS_USER');
    :new.mod_time := SYSDATE;
    IF inserting
    THEN
      IF :new.id IS NULL
      THEN
        :new.id := seq_charachter.nextval;
      END IF;
      :new.creation_time := SYSDATE;
      :new.creator_user  := sys_context('USERENV', 'OS_USER');
      :new.version       := 1;
      :new.dml_flag := 'I';
      :new.charachter_level := 1;
      --check if char exists
      INSERT INTO charachter_h
        (id
        ,charachter_name
        ,player_id
        ,charachter_class
        ,weapon_id
        ,charachter_level
        ,creation_time
        ,creator_user
        ,mod_user
        ,mod_time
        ,dml_flag
        ,version)
      VALUES
        (:new.id
        ,:new.charachter_name
        ,:new.player_id
        ,:new.charachter_class
        ,:new.weapon_id,
        :new.charachter_level
        ,SYSDATE
        ,sys_context('USERENV', 'OS_USER')
        ,sys_context('USERENV', 'OS_USER')
        ,SYSDATE
        ,'I'
        ,1);
    
    ELSE
    
      :new.version := :old.version + 1;
      if :new.dml_flag = 'I' OR :new.dml_flag is null then
        :new.dml_flag := 'U';
      end if;
      INSERT INTO charachter_h
        (id
        ,charachter_name
        ,player_id
        ,charachter_class
        ,weapon_id
        ,charachter_level
        ,creation_time
        ,creator_user
        ,mod_user
        ,mod_time
        ,dml_flag
        ,version)
      VALUES
        (:new.id
        ,:new.charachter_name
        ,:new.player_id
        ,:new.charachter_class
        ,:new.weapon_id
        ,:new.charachter_level
        ,:old.creation_time
        ,:old.creator_user
        ,sys_context('USERENV', 'OS_USER')
        ,SYSDATE
        ,:new.dml_flag
        ,:new.version);
    
    END IF;
  END IF;

END;
/
