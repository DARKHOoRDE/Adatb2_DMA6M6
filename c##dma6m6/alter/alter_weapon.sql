Alter table weapon add constraint ch_weapon_type Check (weapon_type IN ('Staff','Sword','Magic Book','Axe','Bow','CrossBow'));
Alter table weapon add constraint ch_damage_type Check (damage_type IN ('Magic','Physical'));
Alter table weapon modify(weapon_type not null);
Alter table weapon modify(damage_type not null);
Alter table weapon modify(weapon_name not null);
Alter table weapon modify(damage not null);
Alter table weapon modify(attack_speed not null);

Comment on table weapon is 'Weapons';
Comment on column weapon.id is 'Weapon ID';
Comment on column weapon.weapon_name is 'Weapon Name';
Comment on column weapon.weapon_type is 'Type of weapon';
Comment on column weapon.damage is 'Damage of weapon';
Comment on column weapon.damage_type is 'Type of Damage';
Comment on column weapon.attack_speed is 'Number of attacks in 1 s';
comment on column weapon.creation_time is 'Weapon Creation Time';
comment on column weapon.creator_user is 'Weapon Creator';
comment on column weapon.mod_user is 'Last modified by';
comment on column weapon.mod_time is 'Time of last modification';
comment on column weapon.version is 'Number of changes made on Weapon';

