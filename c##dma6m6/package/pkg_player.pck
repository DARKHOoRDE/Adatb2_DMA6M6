CREATE OR REPLACE PACKAGE pkg_player IS

  --variables

  gv_player_duplicate_exc EXCEPTION;
  PRAGMA EXCEPTION_INIT(gv_player_duplicate_exc, -20001);

  --functions

  FUNCTION get_charachters(p_pl_id NUMBER) RETURN ty_char_select_l;

  FUNCTION get_matches_of_player(p_player_id NUMBER)
    RETURN ty_matches_of_player_l;

  PROCEDURE add_player(p_name  IN VARCHAR2
                      ,p_email IN VARCHAR2
                      ,p_birth IN DATE);

  PROCEDURE update_player_details(p_pl_id         IN NUMBER
                                 ,p_pl_name       IN VARCHAR2 DEFAULT NULL
                                 ,p_pl_email      IN VARCHAR2 DEFAULT NULL
                                 ,p_pl_birt       IN DATE DEFAULT NULL
                                 ,p_updated_cells OUT VARCHAR2);

END pkg_player;
/
CREATE OR REPLACE PACKAGE BODY pkg_player IS

  FUNCTION get_charachters(p_pl_id NUMBER) RETURN ty_char_select_l IS
    lt_charachters ty_char_select_l;
  BEGIN
  
    SELECT ty_charachter_select(id              => c.id,
                                charachter_name => c.charachter_name)
      BULK COLLECT
      INTO lt_charachters
      FROM charachter c
     WHERE c.player_id = p_pl_id
       AND c.dml_flag <> 'D';
  
    RETURN lt_charachters;
  END get_charachters;

  FUNCTION get_matches_of_player(p_player_id NUMBER)
    RETURN ty_matches_of_player_l IS
    lt_matches ty_matches_of_player_l;
  BEGIN
  
    --programban saját match history-t kérhet csak le, vagy akár max api-val másét, de mindenképp létezõt
    SELECT ty_matches_of_player(player1_name    => p1.player_name,
                                champ1_name     => c1.charachter_name,
                                weapon1_name    => w1.weapon_name,
                                player2_name    => p2.player_name,
                                champ2_name     => c2.charachter_name,
                                weapon2_name    => w1.weapon_name,
                                time_of_match   => mh.time_of_match,
                                result_of_match => CASE
                                                     WHEN pm1.result_of_match = 'W' THEN
                                                      'Win'
                                                     ELSE
                                                      'Lose'
                                                   END)
      BULK COLLECT
      INTO lt_matches
      FROM match_history mh
      JOIN player_match pm1
        ON mh.id = pm1.match_id
      JOIN player_match pm2
        ON mh.id = pm2.match_id
       AND pm1.player_id <> pm2.player_id
      JOIN player p1
        ON pm1.player_id = p1.id
      JOIN player p2
        ON pm2.player_id = p2.id
      JOIN charachter c1
        ON pm1.charachter_id = c1.id
      JOIN charachter c2
        ON pm2.charachter_id = c2.id
      JOIN weapon w1
        ON pm1.weapon_id = w1.id
      JOIN weapon w2
        ON pm2.weapon_id = w2.id
     WHERE p1.id = p_player_id;
  
    RETURN lt_matches;
  
  END get_matches_of_player;

  PROCEDURE add_player(p_name  IN VARCHAR2
                      ,p_email IN VARCHAR2
                      ,p_birth IN DATE) IS
  
    lv_exist_id NUMBER;
  BEGIN
  
    BEGIN
    
      SELECT p.id
        INTO lv_exist_id
        FROM player p
       WHERE upper(p.player_name) = upper(p_name);
    
      IF SQL%FOUND
      THEN
        RAISE gv_player_duplicate_exc;
      END IF;
    
    EXCEPTION
      WHEN no_data_found THEN
        INSERT INTO player
          (id
          ,player_name
          ,email
          ,birth_date
          ,creation_time
          ,creator_user
          ,mod_user
          ,mod_time
          ,version)
        VALUES
          (NULL
          ,p_name
          ,p_email
          ,p_birth
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,1);
        COMMIT;
    END;
  
  END add_player;

  PROCEDURE update_player_details(p_pl_id         IN NUMBER
                                 ,p_pl_name       IN VARCHAR2 DEFAULT NULL
                                 ,p_pl_email      IN VARCHAR2 DEFAULT NULL
                                 ,p_pl_birt       IN DATE DEFAULT NULL
                                 ,p_updated_cells OUT VARCHAR2) IS
  
    lv_updt       VARCHAR2(4000);
    lv_old_player player%ROWTYPE;
    lv_cnt        NUMBER DEFAULT 0;
  BEGIN
  
    lv_updt := 'UPDATE player p SET p.player_name = :1,
                                    p.email       = :2,
                                    p.birth_date  = :3
                                WHERE p.id = :4';
    BEGIN
      --felsõbb programban nem lehet hiba id-nál
      SELECT * INTO lv_old_player FROM player p WHERE p.id = p_pl_id;
    
      IF p_pl_name IS NOT NULL
      THEN
        lv_old_player.player_name := p_pl_name;
        p_updated_cells           := 'Name ';
        lv_cnt                    := 1;
      END IF;
      IF p_pl_email IS NOT NULL
      THEN
        lv_old_player.email := p_pl_email;
        p_updated_cells     := p_updated_cells || ' Email ';
        lv_cnt              := lv_cnt + 1;
      END IF;
      IF p_pl_birt IS NOT NULL
      THEN
        lv_old_player.birth_date := p_pl_birt;
        p_updated_cells          := p_updated_cells || ' Birth Date ';
        lv_cnt                   := lv_cnt + 1;
      END IF;
    
      IF lv_cnt > 0
      THEN
        p_updated_cells := p_updated_cells || ' Updated ';
      END IF;
      EXECUTE IMMEDIATE lv_updt
        USING lv_old_player.player_name, lv_old_player.email, lv_old_player.birth_date, p_pl_id;
    
      COMMIT;
    EXCEPTION
      WHEN dup_val_on_index THEN
        RAISE gv_player_duplicate_exc;
      
    END;
  END update_player_details;

END pkg_player;
/
