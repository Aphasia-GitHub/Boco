create or replace function GetComplainDealCategory(dealInfo in string)
  return string
  is
  Result   varchar2(128);
  v_temp_str varchar2(512);
  v_exist number(10):=0;
begin
  v_temp_str :=nvl(replace(regexp_substr(dealInfo,'��(����|���)_[^��,��:���� ]+', 1),'����','����'),'�Ѵ���_������');
  Result    := '';
/*  for resultscategories in (select resultscategories from rnop1.c_latest_results
                    where complain_result = temp_str ) loop
    Result := resultscategories.resultscategories;
  end loop;*/
  select count(1) into v_exist from c_latest_results where complain_result = v_temp_str;
  if(v_exist>0) then
    select min(resultscategories) into Result from c_latest_results where complain_result = v_temp_str group by complain_result;
  else
    Result:=substr(v_temp_str,0,instr(v_temp_str,'_')) ||'������';
    end if;
  return(Result);
end GetComplainDealCategory;
