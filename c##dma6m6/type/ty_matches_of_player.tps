create or replace type ty_matches_of_player as object
(
 player1_name varchar2(250 char),
       champ1_name varchar2(250 char),
       weapon1_name varchar2(250 char),
       player2_name varchar2(250 char),
       champ2_name varchar2(250 char),
       weapon2_name varchar2(250 char),
       time_of_match date,
       result_of_match varchar2(250 char)
);
/
