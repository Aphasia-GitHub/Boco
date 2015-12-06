create or replace function GetDistance
(lonA string,latA string,lonB string,latB string) 
  return number is
 
  MLonA numeric(38,16);
  MLatA numeric(38,16);
  MLonB numeric(38,16);
  MLatB numeric(38,16);
  R numeric(38,16);
  C numeric(38,16);
begin
  if nvl(lonA,0)=0 or nvl(latA,0)=0 or nvl(lonB,0)=0 or nvl(latB,0)=0 then
    return (-1);
  end if;
  dbms_output.put_line(nvl(lonA,0));
  MLonA := cast(LonA as numeric);
	MLatA := cast(LatA as numeric);
	MLonB := cast(LonB as numeric);
	MLatB := cast(LatB as numeric);
  R := 6371000.004;
  C := Sin(GetRad(LatA)) * Sin(GetRad(LatB)) + Cos(GetRad(LatA)) * Cos(GetRad(LatB)) * Cos(GetRad(MLonA - MLonB));
	if C > 1 then C:=1; end if;
	if C < -1 then C:=-1; end if;
  dbms_output.put_line(R);
  dbms_output.put_line(C); 
 return (R * Acos(C)); 
end GetDistance;
