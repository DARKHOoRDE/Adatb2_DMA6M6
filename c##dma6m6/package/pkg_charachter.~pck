CREATE OR REPLACE PACKAGE pkg_charachter IS

  gv_char_exists_exc EXCEPTION;
  PRAGMA EXCEPTION_INIT(gv_char_exists_exc, -20003);
  gv_champ_stat_error_exc EXCEPTION;
  PRAGMA EXCEPTION_INIT(gv_champ_stat_error_exc, -20006);

  FUNCTION get_weapon_of_char(p_char_id NUMBER) RETURN ty_char_details;

  PROCEDURE delete_charachter(p_char_id        IN NUMBER
                             ,p_result_message OUT VARCHAR2);

  PROCEDURE change_weapon(p_char_id     IN NUMBER
                         ,p_new_weap_id IN NUMBER);

  PROCEDURE lvl_up_charachter(p_char_id IN NUMBER); --kéne lvl itt már?

  PROCEDURE add_charachter(p_player_id  IN NUMBER
                          ,p_char_name  IN VARCHAR2
                          ,p_char_class IN VARCHAR2
                          ,p_weapon_id  IN NUMBER);

END pkg_charachter;
/
CREATE OR REPLACE PACKAGE BODY pkg_charachter IS

  FUNCTION get_weapon_of_char(p_char_id NUMBER) RETURN ty_char_details IS
    lo_char ty_char_details;
  BEGIN
    BEGIN
      SELECT ty_char_details(c.id,
                             c.weapon_id,
                             NULL,
                             c.charachter_name,
                             c.charachter_level)
        INTO lo_char
        FROM charachter c
       WHERE c.id = p_char_id;
      RETURN lo_char;
    
    EXCEPTION
      WHEN OTHERS THEN
        RAISE gv_champ_stat_error_exc;
      
    END;
  END get_weapon_of_char;

  PROCEDURE delete_charachter(p_char_id        IN NUMBER
                             ,p_result_message OUT VARCHAR2) IS
    lv_char_name VARCHAR2(250 CHAR);
  BEGIN
    SELECT c.charachter_name
      INTO lv_char_name
      FROM charachter c
     WHERE c.id = p_char_id;
    UPDATE charachter c SET c.dml_flag = 'D' WHERE c.id = p_char_id;
    p_result_message := 'Charachter: ' || lv_char_name ||
                        ' successfully deleted';
    COMMIT;
  END delete_charachter;

  PROCEDURE change_weapon(p_char_id     IN NUMBER
                         ,p_new_weap_id IN NUMBER) IS
  BEGIN
    --check existing weapon nem kell, mert listából tudna a felhasználó választani
    UPDATE charachter c
       SET c.weapon_id = p_new_weap_id
     WHERE c.id = p_char_id;
     COMMIT;
  END change_weapon;

  PROCEDURE lvl_up_charachter(p_char_id IN NUMBER) IS
    lv_curr_lvl NUMBER;
  BEGIN
  
    SELECT c.charachter_level
      INTO lv_curr_lvl
      FROM charachter c
     WHERE c.id = p_char_id;
  
    UPDATE charachter c
       SET c.charachter_level =
           (lv_curr_lvl + 1)
     WHERE c.id = p_char_id;
    COMMIT;
  END lvl_up_charachter;

  PROCEDURE add_charachter(p_player_id  IN NUMBER
                          ,p_char_name  IN VARCHAR2
                          ,p_char_class IN VARCHAR2
                          ,p_weapon_id  IN NUMBER) IS
    lv_char_id NUMBER;
  BEGIN
  
    BEGIN
    
      SELECT c.id
        INTO lv_char_id
        FROM charachter c
       WHERE c.player_id = p_player_id
         AND c.charachter_name = p_char_name;
    
      IF SQL%FOUND
      THEN
        RAISE gv_char_exists_exc;
      END IF;
    
    EXCEPTION
      WHEN no_data_found THEN
      
        INSERT INTO charachter
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
          ,version)
        VALUES
          (NULL
          ,p_char_name
          ,p_player_id
          ,p_char_class
          ,p_weapon_id
          ,1
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,1);
          COMMIT;
    END;
  
  END add_charachter;

END pkg_charachter;
/
