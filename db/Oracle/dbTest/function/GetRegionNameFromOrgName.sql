create or replace function GetRegionNameFromOrgName(wangyou_orgname string)
  return varchar2 is
  Result    varchar2(38);
  --Regionstr varchar2(128);
  regionArr varchar_array;
begin
    Result    := null;

  select distinct  replace(region_name,'ÊÐ','') bulk collect into regionArr from c_region_city where region_name not like '%\%';
  for i IN 1..regionArr.count LOOP
    if instr(wangyou_orgname,regionArr(i),1,1)>0 then
      Result :=regionArr(i);
      end if;
    end loop;

  return(Result);
end GetRegionNameFromOrgName;
