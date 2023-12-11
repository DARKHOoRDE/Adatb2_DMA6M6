PL/SQL Developer Test script 3.0
8
begin
  -- Call the procedure
  pkg_player.update_player_details(p_pl_id => :p_pl_id,
                                   p_pl_name => :p_pl_name,
                                   p_pl_email => :p_pl_email,
                                   p_pl_birt => :p_pl_birt,
                                   p_updated_cells => :p_updated_cells);
end;
5
p_pl_id
1
3
4
p_pl_name
1
USSrr
5
p_pl_email
1
Ussrr@mail.com
5
p_pl_birt
1
2001. 01. 01.
12
p_updated_cells
1
Name  Email  Birth Date  Updated 
5
0
