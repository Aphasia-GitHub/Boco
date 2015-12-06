create or replace function GetRegionIdByOrgName(wangyou_orgname string)
  return number is
  Result    number(38);
  Regionstr varchar2(128);
begin
  Regionstr := regexp_substr(wangyou_orgname, '[^电信分公司市(]+');
  Result    := null;
  if Regionstr = '全省' then
    Result := -1;
  else
    for regionid in (select region_id
                       from c_region_city
                      where (city_name = Regionstr or
                            city_name = Regionstr || '市' or
                            city_name = Regionstr || '县')
                        and region_name not like '%\%') loop
      Result := regionid.region_id;
    end loop;
  end if;
  return(Result);
end GetRegionIdByOrgName;
