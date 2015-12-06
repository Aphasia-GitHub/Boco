create or replace function GetBtsbordersector(intid long)
  RETURN VARCHAR2 is
  Result VARCHAR2(32);
begin
  Result := null;
  FOR bs IN (SELECT SECTOR_BORDER_TYPE
               FROM C_TCO_PRO_CELL a
              WHERE a.related_btsid = intid
                and SECTOR_BORDER_TYPE != '否') LOOP
                if bs.SECTOR_BORDER_TYPE is null then
                  return('否');
                end if;
    if trim(bs.SECTOR_BORDER_TYPE) = '省内/省际' then
      return('省内/省际');
    end if;
    if trim(bs.SECTOR_BORDER_TYPE) = '省内' and Result = '省外' then
      return('省内/省际');
    end if;
    if trim(bs.SECTOR_BORDER_TYPE) = '省外' and Result = '省内' then
      return('省内/省际');
    end if;
    Result := bs.SECTOR_BORDER_TYPE;
  END LOOP;
  if Result is null then
    return('否');
  end if;
  return(Result);
end GetBtsbordersector;
