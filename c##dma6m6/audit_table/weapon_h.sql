Create table weapon_h(
       id number ,
       weapon_name varchar2(40 char),
       weapon_type varchar2(20 char),
       damage number(3,1),
       damage_type varchar2(40 char),
       attack_speed  number(2,1),
       creation_time  date,
       creator_user   varchar2(250 char),
       mod_user       varchar2(250 char),
       mod_time       date,
       dml_flag	     char(1),
       version	       number
);
