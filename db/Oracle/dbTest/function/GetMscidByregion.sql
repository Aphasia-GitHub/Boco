create or replace function GetMscidByregion(region_name string)
  RETURN varchar2 is
  Mscname varchar2(64);
begin

  if region_name='安庆' then
       Mscname:='WHMsce2';
  elsif region_name='蚌埠' then
       Mscname:='hf3omp';
  elsif region_name='巢湖' then
       Mscname:='hf2omp';
  elsif region_name='池州' then
       Mscname:='WHMSCe2';
  elsif region_name='滁州' then
       Mscname:='hf2omp';
  elsif region_name='阜阳' then
       Mscname:='hf5omp';
  elsif region_name='合肥' then
       Mscname:='hf1omp';
  elsif region_name='淮北' then
       Mscname:='hf3omp';
  elsif region_name='淮南' then
       Mscname:='hf6omp';
  elsif region_name='黄山' then
       Mscname:='WHMsce4';
  elsif region_name='六安' then
       Mscname:='hf6omp';
  elsif region_name='马鞍山' then
       Mscname:='WHMsce1';
  elsif region_name='宿州' then
       Mscname:='hf3omp';
  elsif region_name='铜陵' then
       Mscname:='WHMsce1';
  elsif region_name='芜湖' then
       Mscname:='WHMsce1';
  elsif region_name='宣城' then
       Mscname:='WHMsce4';
  elsif region_name='亳州' then
       Mscname:='hf5omp';
  else
         Mscname:='';
  end if;
 return Mscname;

   exception
  when others then
   return 0;
end GetMscidByregion;
