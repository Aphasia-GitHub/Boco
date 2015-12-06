create or replace function GetResolveData(Unstation_no string)
  return DATE is
  Result DATE;
  ReturnStr DATE;
  SelectCount number;
begin
  Result :=null;
  ReturnStr :=null;
  SelectCount:=0;

  select count(*) into SelectCount from c_tco_pro_cell_tmp where project_id=Unstation_no and project_id!='нч' and rownum=1;
  if SelectCount>=1 then
    select online_date into ReturnStr from c_tco_pro_cell_tmp where project_id=Unstation_no and project_id!='нч' and rownum=1;
    Result:=ReturnStr;
    return(Result);
  end if;

  select count(*) into SelectCount from c_tco_pro_repeater_tmp where Repeater_No=Unstation_no and rownum=1;
  if SelectCount>=1 then
    select use_time into ReturnStr from c_tco_pro_repeater_tmp where Repeater_No=Unstation_no and rownum=1;
    Result:=ReturnStr;
    return(Result);
  end if;

  select count(*) into SelectCount from c_tco_pro_indoors_tmp where indds_code=Unstation_no and rownum=1;
  if SelectCount>=1 then
    select Open_Time into ReturnStr from c_tco_pro_indoors_tmp where indds_code=Unstation_no and rownum=1;
    Result:=ReturnStr;
    return(Result);
  end if;

  return(Result);
end GetResolveData;
