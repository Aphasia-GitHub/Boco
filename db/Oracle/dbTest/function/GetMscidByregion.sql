create or replace function GetMscidByregion(region_name string)
  RETURN varchar2 is
  Mscname varchar2(64);
begin

  if region_name='����' then
       Mscname:='WHMsce2';
  elsif region_name='����' then
       Mscname:='hf3omp';
  elsif region_name='����' then
       Mscname:='hf2omp';
  elsif region_name='����' then
       Mscname:='WHMSCe2';
  elsif region_name='����' then
       Mscname:='hf2omp';
  elsif region_name='����' then
       Mscname:='hf5omp';
  elsif region_name='�Ϸ�' then
       Mscname:='hf1omp';
  elsif region_name='����' then
       Mscname:='hf3omp';
  elsif region_name='����' then
       Mscname:='hf6omp';
  elsif region_name='��ɽ' then
       Mscname:='WHMsce4';
  elsif region_name='����' then
       Mscname:='hf6omp';
  elsif region_name='��ɽ' then
       Mscname:='WHMsce1';
  elsif region_name='����' then
       Mscname:='hf3omp';
  elsif region_name='ͭ��' then
       Mscname:='WHMsce1';
  elsif region_name='�ߺ�' then
       Mscname:='WHMsce1';
  elsif region_name='����' then
       Mscname:='WHMsce4';
  elsif region_name='����' then
       Mscname:='hf5omp';
  else
         Mscname:='';
  end if;
 return Mscname;

   exception
  when others then
   return 0;
end GetMscidByregion;
