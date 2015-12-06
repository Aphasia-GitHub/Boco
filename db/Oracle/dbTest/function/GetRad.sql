create or replace function GetRad(angle numeric) return number is
  Result number;
begin
  Result := angle * acos(-1)/180.0;
  return(Result);
end GetRad;
