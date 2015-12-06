create or replace function GetregionidByWang(wangyou_orgname string,Splitstr string) return number is
  Result number(38);
  Regionstr varchar2(128);
begin
  --Regionstr:=replace(wangyou_orgname,'分公司','');
  --Regionstr:=replace(Regionstr,'市公司','');
  if instr(wangyou_orgname,'马鞍山',1,1)>0 then
    Regionstr:=substr(wangyou_orgname,1,3);
  else
    Regionstr:=substr(wangyou_orgname,1,2);
  end if;

  --Regionstr:=replace(wangyou_orgname,'分公司','');
  Result:=null;
  for regionid in(select region_id from c_region_city where (city_name=Regionstr or city_name=Regionstr||'市' or city_name = Regionstr||'县') and region_name  not like '%\%') loop
    Result:=regionid.region_id;
   end loop;
  return(Result);
end GetregionidByWang;
