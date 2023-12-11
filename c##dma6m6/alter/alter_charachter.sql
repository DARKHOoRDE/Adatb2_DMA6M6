Alter table charachter add constraint fk_charachter_player foreign key(player_id) references player(id);
Alter table charachter add constraint fk_charachter_weapon foreign key(weapon_id) references weapon(id);
Alter table charachter add constraint uk_name unique(charachter_name,player_id);   
Alter table charachter add constraint ch_class Check (charachter_class IN ('Wizard','Warrior','Archer'));
Alter table charachter modify(charachter_class not null);
Alter table charachter modify(charachter_name not null);

Comment on table charachter is 'Charachters';
comment on column charachter.id is 'Charachter ID';     
comment on column charachter.charachter_name is 'Charachter Name';
comment on column charachter.player_id is 'Identifies player';
comment on column charachter.charachter_class is 'Charachter Class';
comment on column charachter.weapon_id is 'Identifies Weapon';
comment on column charachter.charachter_level is 'Level of Charachter';
comment on column charachter.creation_time is 'Charachter Creation Time';
comment on column charachter.creator_user is 'Charachter Creator';
comment on column charachter.mod_user is 'Last modified by';
comment on column charachter.mod_time is 'Time of last modification';
comment on column charachter.version is 'Number of changes made on charachter';




