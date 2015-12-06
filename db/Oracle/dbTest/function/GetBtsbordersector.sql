create or replace function GetBtsbordersector(intid long)
  RETURN VARCHAR2 is
  Result VARCHAR2(32);
begin
  Result := null;
  FOR bs IN (SELECT SECTOR_BORDER_TYPE
               FROM C_TCO_PRO_CELL a
              WHERE a.related_btsid = intid
                and SECTOR_BORDER_TYPE != '��') LOOP
                if bs.SECTOR_BORDER_TYPE is null then
                  return('��');
                end if;
    if trim(bs.SECTOR_BORDER_TYPE) = 'ʡ��/ʡ��' then
      return('ʡ��/ʡ��');
    end if;
    if trim(bs.SECTOR_BORDER_TYPE) = 'ʡ��' and Result = 'ʡ��' then
      return('ʡ��/ʡ��');
    end if;
    if trim(bs.SECTOR_BORDER_TYPE) = 'ʡ��' and Result = 'ʡ��' then
      return('ʡ��/ʡ��');
    end if;
    Result := bs.SECTOR_BORDER_TYPE;
  END LOOP;
  if Result is null then
    return('��');
  end if;
  return(Result);
end GetBtsbordersector;
