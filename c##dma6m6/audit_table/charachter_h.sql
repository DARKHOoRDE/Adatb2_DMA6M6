Create table charachter_h(
              id number ,
       charachter_name varchar2(250 char),
       player_id number ,
       charachter_class varchar2(40 char),
       weapon_id number,
       charachter_level number not null,
       creation_time  date ,
       creator_user   varchar2(250 char) ,
       mod_user       varchar2(250 char),
       mod_time       date,
       dml_flag	     char(1),
       version	       number
);
