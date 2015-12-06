create or replace function GetRegionIdByOrgName(wangyou_orgname string)
  return number is
  Result    number(38);
  Regionstr varchar2(128);
begin
  Regionstr := regexp_substr(wangyou_orgname, '[^���ŷֹ�˾��(]+');
  Result    := null;
  if Regionstr = 'ȫʡ' then
    Result := -1;
  else
    for regionid in (select region_id
                       from c_region_city
                      where (city_name = Regionstr or
                            city_name = Regionstr || '��' or
                            city_name = Regionstr || '��')
                        and region_name not like '%\%') loop
      Result := regionid.region_id;
    end loop;
  end if;
  return(Result);
end GetRegionIdByOrgName;
