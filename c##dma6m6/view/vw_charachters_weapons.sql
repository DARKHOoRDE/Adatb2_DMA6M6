Create or replace view vw_charachters_weapons as
       select c.charachter_name,c.charachter_class,w.weapon_name,w.weapon_type,w.damage,w.damage_type,w.attack_speed
        from charachter c join weapon w on c.weapon_id = w.id where c.dml_flag <> 'D';
