CREATE OR REPLACE PACKAGE pkg_match IS

  gv_invalid_input_exc EXCEPTION;
  PRAGMA EXCEPTION_INIT(gv_invalid_input_exc, -20004);

  PROCEDURE add_match_link(p_pl_id         IN NUMBER
                          ,p_winner_id     in number
                          ,p_match_id      IN NUMBER
                          ,p_champ_details IN ty_char_details);

  FUNCTION insert_match RETURN NUMBER;

  PROCEDURE fight(p_player1_id IN NUMBER
                 ,p_player2_id IN NUMBER
                 ,p_champ1_id  IN NUMBER
                 ,p_champ2_id  IN NUMBER);

END pkg_match;
/
CREATE OR REPLACE PACKAGE BODY pkg_match IS

  PROCEDURE add_match_link(p_pl_id         IN NUMBER
                          ,p_winner_id     IN NUMBER
                          ,p_match_id      IN NUMBER
                          ,p_champ_details IN ty_char_details) IS
  
    lv_result CHAR(1);
  BEGIN
  
    IF p_pl_id = p_winner_id
    THEN
      lv_result := 'W';
    ELSE
      lv_result := 'L';
    END IF;
  
    INSERT INTO player_match
      (id
      ,player_id
      ,match_id
      ,charachter_id
      ,weapon_id
      ,result_of_match)
    VALUES
      (NULL
      ,p_pl_id
      ,p_match_id
      ,p_champ_details.char_id
      ,p_champ_details.weapon_id
      ,lv_result);
  
  END add_match_link;

  FUNCTION insert_match RETURN NUMBER IS
  
    lv_match_id NUMBER;
  BEGIN
    INSERT INTO match_history
      (id
      ,time_of_match)
    VALUES
      (NULL
      ,SYSDATE);
    lv_match_id := seq_match.currval;
    RETURN lv_match_id;
  END insert_match;

  PROCEDURE fight(p_player1_id IN NUMBER
                 ,p_player2_id IN NUMBER
                 ,p_champ1_id  IN NUMBER
                 ,p_champ2_id  IN NUMBER) IS
  
    lo_champ1_details  ty_char_details;
    lo_champ2_details  ty_char_details;
    lv_overall_dmg_pl1 NUMBER(5, 1);
    lv_overall_dmg_pl2 NUMBER(5, 1);
    lv_winner_id       NUMBER;
    lv_match_id        NUMBER;
  BEGIN
  
    BEGIN
    
      lo_champ1_details := pkg_charachter.get_weapon_of_char(p_char_id => p_champ1_id);
      pkg_weapon.get_weapon_stat(p_details     => lo_champ1_details,
                                 p_overall_dmg => lv_overall_dmg_pl1);
    
      lo_champ2_details := pkg_charachter.get_weapon_of_char(p_char_id => p_champ2_id);
      pkg_weapon.get_weapon_stat(p_details     => lo_champ2_details,
                                 p_overall_dmg => lv_overall_dmg_pl2);
    
      IF lv_overall_dmg_pl1 > lv_overall_dmg_pl2
      THEN
        lv_winner_id := p_player1_id;
        pkg_charachter.lvl_up_charachter(p_char_id => lo_champ1_details.char_id);
      ELSE
        --if draw then challenger wins
        lv_winner_id := p_player2_id;
        pkg_charachter.lvl_up_charachter(p_char_id => lo_champ2_details.char_id);
      END IF;
    
      lv_match_id := insert_match;
    
      add_match_link(p_pl_id         => p_player1_id,
                     p_winner_id     => lv_winner_id,
                     p_match_id      => lv_match_id,
                     p_champ_details => lo_champ1_details);
    
      add_match_link(p_pl_id         => p_player2_id,
                     p_winner_id     => lv_winner_id,
                     p_match_id      => lv_match_id,
                     p_champ_details => lo_champ2_details);
    
      COMMIT;
    END;
  
  END fight;

END pkg_match;
/
