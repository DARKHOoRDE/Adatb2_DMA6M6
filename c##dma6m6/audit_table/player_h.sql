Create Table player_h(
       id number,
       player_name varchar2(250 char),
       email varchar2(250 char),
       birth_date date,
       creation_time  date,
       creator_user   varchar2(250 char),
       mod_user       varchar2(250 char),
       mod_time       date,
       dml_flag	     char(1),
       version	       number
);
