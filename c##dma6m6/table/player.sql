Create table player(
       id number primary key,
       player_name varchar2(250 char) not null,
       email varchar2(250 char) not null,
       birth_date date not null,
       creation_time  date,
       creator_user   varchar2(250 char),
       mod_user       varchar2(250 char),
       mod_time       date,
       dml_flag       char(1),
       version        number
)tablespace users;



