Create or replace view vw_player_match_details as
SELECT p.player_name
      ,COUNT(pm.id) AS total_matches
      ,COUNT(CASE
               WHEN pm.result_of_match = 'W' THEN
                1
             END) AS matches_won
      ,listagg(DISTINCT CASE
                 WHEN pm.result_of_match = 'W' THEN
                  c.charachter_name
               END,
               ', ') within GROUP(ORDER BY c.charachter_name) AS winner_charachters
  FROM player p
  left JOIN player_match pm
    ON p.id = pm.player_id
  left JOIN charachter c
    ON pm.charachter_id = c.id
 WHERE p.dml_flag <> 'D'
 GROUP BY p.player_name
         ,p.id
 ORDER BY matches_won   DESC
         ,total_matches DESC;

