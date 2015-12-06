create or replace function GetMscid(region_name string,vendor_id number,omc_id number)
  RETURN varchar2 is
  Mscname varchar2(64);
begin

  if vendor_id=7 then
    if region_name like '����%' then
       Mscname:='WHMsce2';
    elsif region_name like '����%' then
       Mscname:='WHMSCe2';
    elsif region_name like '��ɽ%' then
       Mscname:='WHMsce4';
    elsif region_name like '��ɽ%' then
       Mscname:='WHMsce1';
    elsif region_name like 'ͭ��%' then
       Mscname:='WHMsce1';
    elsif region_name like '�ߺ�%' then
       Mscname:='WHMsce1';
    elsif region_name like '����%' then
       Mscname:='WHMsce4';
    else
       Mscname:='';
    end if;
  else
    if omc_id=2100001 then
      Mscname:='hf1omp';
    elsif omc_id=2100005 then
      Mscname:='hf2omp';
    elsif omc_id=2100002 then
      Mscname:='hf3omp';
    elsif omc_id=2100004 then
      Mscname:='hf5omp';
    elsif omc_id=2100003 then
      Mscname:='hf6omp';
    elsif omc_id=2100006 then
      Mscname:='hf8omp';
    elsif omc_id=2100007 then
      Mscname:='hf9omp';
    else
       Mscname:='';
     end if;
  end if;

 return Mscname;

   exception
  when others then
   return 0;
end GetMscid;
