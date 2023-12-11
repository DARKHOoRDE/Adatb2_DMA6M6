Create or replace view vw_players_charachters as
       select  p.player_name,
               listagg(c.charachter_name,', ') within group(order by c.charachter_name) as Charachter
                from player p join charachter c on p.id = c.player_id where c.dml_flag <> 'D' group by p.player_name;
