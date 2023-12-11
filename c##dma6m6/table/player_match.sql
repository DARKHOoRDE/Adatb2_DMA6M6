Create table player_match(
       id number primary key,
       player_id number not null,
       match_id number not null,
       charachter_id number,
       weapon_id number,
       result_of_match char(1)
);
