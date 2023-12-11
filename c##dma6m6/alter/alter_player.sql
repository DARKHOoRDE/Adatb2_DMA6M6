Alter table player add constraint uk_player_playername unique(player_name);

comment on table player is 'Table of players';
comment on column player.id is 'Identify player';
comment on column player.player_name is 'Player Name';
comment on column player.email is 'Email of player';
comment on column player.birth_date is 'Birthdate of player';
comment on column player.creation_time is 'Player Creation Time';
comment on column player.creator_user is 'Player Creator';
comment on column player.mod_user is 'Last modified by';
comment on column player.mod_time is 'Time of last modification';
comment on column player.version is 'Number of changes made on Player';
