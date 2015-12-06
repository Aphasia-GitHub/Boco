create or replace function GetCellWorkfreq(Carrier283 number,
                                           Carrier201 number,
                                           Carrier242 number,
                                           Carrier160 number,
                                           Carrier37  number,
                                           Carrier78  number,
                                           Carrier119 number,
                                           Carrier1019 number)
  RETURN VARCHAR2 is
  Result VARCHAR2(32);
begin
  Result :='';
  if Carrier283 <> 0 then
    Result := Result || '283/';
  end if;
  if Carrier201 <> 0 then
    Result := Result || '201/';
  end if;
  if Carrier242 <> 0 then
    Result := Result || '242/';
  end if;
  if Carrier160 <> 0 then
    Result := Result || '160/';
  end if;
  if Carrier37 <> 0 then
    Result := Result || '37/';
  end if;
  if Carrier78 <> 0 then
    Result := Result || '78/';
  end if;
 if Carrier119 <> 0 then
    Result := Result || '119/';
  end if;
 if Carrier1019 <> 0 then
    Result := Result || '1019/';
  end if;
 return(rtrim(Result,'/'));
end GetCellWorkfreq;
