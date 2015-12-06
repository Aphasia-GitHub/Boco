create or replace function GetComplainDealCategory(dealInfo in string)
  return string
  is
  Result   varchar2(128);
  v_temp_str varchar2(512);
  v_exist number(10):=0;
begin
  v_temp_str :=nvl(replace(regexp_substr(dealInfo,'已(处理|解决)_[^；,，:。： ]+', 1),'其他','其它'),'已处理_其它类');
  Result    := '';
/*  for resultscategories in (select resultscategories from rnop1.c_latest_results
                    where complain_result = temp_str ) loop
    Result := resultscategories.resultscategories;
  end loop;*/
  select count(1) into v_exist from c_latest_results where complain_result = v_temp_str;
  if(v_exist>0) then
    select min(resultscategories) into Result from c_latest_results where complain_result = v_temp_str group by complain_result;
  else
    Result:=substr(v_temp_str,0,instr(v_temp_str,'_')) ||'其它类';
    end if;
  return(Result);
end GetComplainDealCategory;
