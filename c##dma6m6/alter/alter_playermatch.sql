Alter table player_match add constraint fk_playermatch_player foreign key(player_id) references player(id);
Alter table player_match add constraint fk_playermatch_match foreign key(match_id) references match_history(id);

comment on table player_match is 'Table of Player-match';
comment on column player_match.player_id is 'Identifies player';
comment on column player_match.match_id is 'Identifies match';
comment on column player_match.charachter_id is 'Identifies charachter';
comment on column player_match.weapon_id is 'Identifies weapon';
